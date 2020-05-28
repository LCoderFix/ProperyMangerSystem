<?php


namespace app\ljd\controller;


use app\admin\controller\Base;
use think\Db;

class User extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $where = 'p.manger_id!=0';
            if ($key) {
                $where .= " and (p.manger_name like '%" . $key . "%'";
                $where .= " or p.manger_address like '%" . $key . "%')";
            }
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('property_manger p')
                ->join('manger_village m', 'p.manger_id=m.manger_id','left')
                ->join('village v','m.village_id=v.village_id','left')
                ->field('p.*,v.*,m.manger_village_id')
                ->where($where)
                ->order('p.manger_id')
                ->paginate($limit)  //分页
                ->toArray(); //转换为数组
          //  var_dump($list);
            return $this->showList($list);
        } else {
            return view();
        }
    }
    /**
     * 用户新增、编辑页面
     */
    public function userForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
          //  var_dump($data);
            $result=db("property_manger")->where('manger_id',$data['manger_id'])->find();
            if(!$result){
                $mangerVillage['manger_village_id']=$data['manger_village_id'];
                $mangerVillage['manger_id']=$data['manger_id'];
                $mangerVillage['village_id']=$data['village_id'];
                unset($data['village_id']);
                unset($data['manger_village_id']);
                db('manger_village')->insert($mangerVillage);
                db('property_manger')->insert($data);
                return $this->success('添加成功！');
            }else{
                $mangerVillage['manger_village_id']=$data['manger_village_id'];
                $mangerVillage['manger_id']=$data['manger_id'];
                $mangerVillage['village_id']=$data['village_id'];
               // var_dump($mangerVillage);
                unset($data['village_id']);
                unset($data['manger_village_id']);
               // var_dump();
                $exist=db('manger_village')->where('manger_village_id',$mangerVillage['manger_village_id'])->find();
                if(!$exist){
                    unset($mangerVillage['manger_village_id']);
                    db('manger_village')->insert($mangerVillage);
                }else{
                    $sql='update manger_village set village_id='.$mangerVillage['village_id']. ' where manger_village_id='.$mangerVillage['manger_village_id'];
                    Db::execute($sql);
                }
            //    db('manger_village')->update($mangerVillage);
                db('property_manger')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            $list = db('village')->select();
            $this->assign('list', $list);
            return view();
        }
    }

    /**
     * 取得用户最大Id值
     * @return mixed
     */
    public function userMaxId(){
        if($this->request->isAjax()){
            $num = Db::query("select max(manger_id) from property_manger");
            return $num[0]['max(manger_id)'];
        }
    }

    /**
     * 删除用户
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function userDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        db('property_manger')->delete(input('post.manger_id/a'));
        db('manger_village')->delete(input('post.manger_village_id/a'));
        return $this->success('删除成功!');
    }
    /**
     * 重置密码
     */

    public function resetPwd()
    {
        //var_dump(input('post.manger_id'));
        db('property_manger')->where('manger_id', input('post.manger_id'))->update(['manger_password' => md5("1")]);
        return $this->success('重置密码成功，新密码为1!');
    }
    //更新用户权限
    public function userPermission()
    {
        $status = input('post.status');
       // var_dump($status.input('post.manger_id'));
        if (db('property_manger')->where('manger_id', input('post.manger_id'))->update(['manger_permission' => $status]) !== false) {
            return $this->success('设置成功!');
        } else {
            return $this->error('设置失败!');
        }
    }


}