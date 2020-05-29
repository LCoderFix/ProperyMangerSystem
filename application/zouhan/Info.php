<?php


namespace app\wdq\controller;


use app\admin\controller\Base;

class Info extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $id=session('user_id');
            if ($key) {
                $where['owner_name|owner_location|owner_id']=['like','%' . $key . '%'];
            }
            $manger_village=db('manger_village')->where('manger_id',$id)->find();
            $where['owner_certification']=1;
            $where['owner_village']=$manger_village['village_id'];
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
    public function infoForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            //  var_dump($data);
            $result=db("owner")->where('owner_id',$data['owner_id'])->find();
            if(!$result){
                return $this->success('添加成功！');
            }else{
                //  var_dump($data);
                $owner=db('owner')->where('owner_id',$data['owner_id'])->find();
                db('owner')->where('owner_id',$data['owner_id'])
                    ->update(['owner_balance'=>$owner['owner_balance']+$data['owner_balance']]);
                return $this->success('充值成功！');
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
    public function announceMaxId(){
        if($this->request->isAjax()){
            $num = Db::query("select max(manger_message_id) from manger_message");
            return $num[0]['max(manger_message_id)'];
        }
    }

    /**
     * 删除公告
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function msgDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        db('manger_message')->delete(input('post.manger_message_id'));
        db('message')->where('manger_message_id',input('post.manger_message_id'))->delete();
        return $this->success('删除成功!');
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