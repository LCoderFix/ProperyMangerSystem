<?php


namespace app\wdq\controller;


class Check extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $id=session('user_id');
            $manger_village=db('manger_village')->where('manger_id',$id)->find();
            $where['owner_village']=$manger_village['village_id'];
            $where['owner_request']=1;
            $where['owner_certification']=0;

            if ($key) {
                $where['owner_name|owner_location|owner_id']=['like','%' . $key . '%'];
            }
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('owner')
                ->where($where)
                ->order('owner.owner_id')
                ->paginate($limit)  //分页
                ->toArray(); //转换为数组
            return $this->showList($list);
        } else {
            return view();
        }
    }
    /**
     * 用户新增、编辑页面
     */
    public function ownerForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            //  var_dump($data);
            $result=db("owner")->where('owner_id',$data['owner_id'])->find();
            if(!$result){
                db('owner')->insert($data);
                return $this->success('添加成功！');
            }else{
                db('owner')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            $list = db('owner')->select();
            $this->assign('list', $list);
            return view();
        }
    }

    /**
     * 取得用户最大Id值
     * @return mixed
     */
    public function ownerMaxId(){
        if($this->request->isAjax()){
            $num = Db::query("select max(owner_id) from owner");
            return $num[0]['max(owner_id)'];
        }
    }

    /**
     * 删除用户
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function checkDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        if (request()->isPost()) {
            $data = input('post.');
         //   var_dump($data);
            db('owner')->where('owner_id',$data['data']['owner_id'])->update(['owner_request'=>$data['data']['owner_request']]);
            return $this->success('操作成功！');
        }
      //  db('owner')->update();
      //  return $this->success('删除成功!');
    }
    /**
     * 重置密码
     */

    public function resetPwd()
    {
        //var_dump(input('post.manger_id'));
        db('owner')->where('owner_id', input('post.owner_id'))->update(['owner_password' => md5("1")]);
        return $this->success('重置密码成功，新密码为1!');
    }
    //更新用户权限
    public function userCertification()
    {
        $status = input('post.status');
        // var_dump($status.input('post.manger_id'));
        if (db('owner')->where('owner_id', input('post.owner_id'))->update(['owner_certification' => $status,'ctime'=>time()]) !== false) {
            $manger=db('manger_village')->where('manger_id',session('user_id'))->find();
            $village=db('village')->where('village_id',$manger['village_id'])->find();
            db('village')->where('village_id',$village['village_id'])->update(['village_households_num'=>$village['village_households_num']+1]);
            return $this->success('设置成功!');
        } else {
            return $this->error('设置失败!');
        }
    }
}