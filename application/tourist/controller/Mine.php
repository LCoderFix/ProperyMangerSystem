<?php


namespace app\tourist\controller;


class Mine extends Base
{
    public function userInfo()
    {
        if (request()->isPost()) {
            $data = input('post.');
            db('sys_user')->strict(false)->update($data);
            return $this->success('用户信息更新成功！');

        } else {
            $user_id=session('user_id');
            $data = db('sys_user')->where('user_id=' . $user_id)->find();
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
        $user = db('sys_user')->where('user_id', session("user_id"))->find();
        if($user['password'] != md5($data['oldPsw'])){
            return $this->error('原密码错误!');
        }else{
            $data['user_id']=(string)(session("user_id"));
            $data['password']=md5($data['newPsw']);
            //注意要删除前台确认新密码的name属性和删除数据中的oldPassword的值，
            //因为加了的话会传到后台来而数据库没有此字段，会造成更新失败。
            /*unset($data['oldPsw']);
            unset($data['newPsw']);
            if (db('sys_user')->update($data)!==false) {*/

            //strict  关闭严格检查字段名  https://www.kancloud.cn/manual/thinkphp5/162902
            if (db('sys_user')->strict(false)->update($data)!==false){  //
                return $this->success('密码修改成功！');
            } else {
                return $this->error('密码修改失败!');
            }
        }
    }
}