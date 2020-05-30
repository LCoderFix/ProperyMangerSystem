<?php


namespace app\wdq\controller;


use app\wdq\controller\Base;
use think\Db;

class User extends Base
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
    public function ownerForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
          //  var_dump($data);
            $manger=db('manger_village')->where('manger_id',session('user_id'))->find();
            $result=db("owner")->where('owner_id',$data['owner_id'])->find();
            if(!$result){
                $data['owner_village']=$manger['village_id'];
                $data['owner_password']=md5('1');
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
    public function ownerDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
      //  var_dump(count(input('post.owner_id/a')));
        db('owner')->delete(input('post.owner_id/a'));
        $manger=db('manger_village')->where('manger_id',session('user_id'))->find();
        $village=db('village')->where('village_id',$manger['village_id'])->find();
        db('village')->where('village_id',$village['village_id'])->update(['village_households_num'=>$village['village_households_num']-count(input('post.owner_id/a'))]);
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
    public function userInfo()
    {
        if (request()->isPost()) {
            $data = input('post.');
            db('property_manger')->strict(false)->update($data);
            return $this->success('用户信息更新成功！');

        } else {
            $user_id=session('user_id');
            $data = db('property_manger')->where('manger_id=' . $user_id)->find();
            // var_dump($data['avatar']);
            $this->assign('src', $data['avatar']);
            $this->assign('data', json_encode($data, true));
            return view('user_info');
        }
    }

    public function userPwd()
    {
        if (request()->isPost()) {
            $data = input('post.');
            db('sys_user')->update($data);
            return $this->success('用户信息更新成功！');

        } else {
            return view('user_pwd');
        }
    }
    public function modiPwd(){
        $data=input("post.");
        $user = db('property_manger')->where('manger_id', session("user_id"))->find();
        if($user['manger_password'] != md5($data['oldPsw'])){
            return $this->error('原密码错误!');
        }else{
            $data['manger_id']=(string)(session("user_id"));
            $data['manger_password']=md5($data['newPsw']);
            //注意要删除前台确认新密码的name属性和删除数据中的oldPassword的值，
            //因为加了的话会传到后台来而数据库没有此字段，会造成更新失败。
            /*unset($data['oldPsw']);
            unset($data['newPsw']);
            if (db('sys_user')->update($data)!==false) {*/

            //strict  关闭严格检查字段名  https://www.kancloud.cn/manual/thinkphp5/162902
            if (db('property_manger')->strict(false)->update($data)!==false){  //
                return $this->success('密码修改成功！');
            } else {
                return $this->error('密码修改失败!');
            }
        }
    }

}