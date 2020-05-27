<?php


namespace app\admin\controller;

use think\Cache;
use think\Controller;
use think\captcha\Captcha;

class Login extends Controller
{
    public function _initialize()
    {
        if (session('user_id')) {
            $this->redirect('admin/index/index');
        }
    }

    public function index()
    {
        if (request()->isAjax()) {
            $data = input('post.');
            /*if(!captcha_check($data['code'])){
                return $this->error('验证码错误');
            }*/
            $user = db('sys_user')->where('username', $data['username'])->find();
            if ($user) {
                if ($user['status'] == 1 && $user['password'] == md5($data['password'])) {
                    session('username', $user['username']);
                    session('realname', $user['realname']);
                    session('user_id', $user['user_id']);
                    session('role_id', $user['role_id']);
                    db('sys_user')->where('user_id', $user['user_id'])->update(['login_time' => time()]);
                    return $this->success('登录成功!', url('admin/index/index')); //信息正确
                } else {
                    return $this->error('用户名或者密码错误，重新输入!'); //密码错误
                }
            } else {
                return $this->error('用户不存在!'); //用户不存在
            }
        } else {
            return view();
        }
    }

    public function forgetPwd()
    {
        return view('forget_pwd');
    }

    public function register()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $user = db('sys_user')->where('username', $data['username'])->find();
            if ($user) {
                return $this->error('该用户名已经注册!');
            } else {
                $email = db('sys_user')->where('email', $data['email'])->find();
                if ($email) {
                    return $this->error('该邮箱已经注册!');
                } else {
                    $data['username'] = $data['username'];
                    $data['role_id'] = 2;
                    $data['password'] = md5($data['password']);
                    db('sys_user')->insert($data);
                    return $this->success('注册成功!', 'index');
                }
            }
        } else {
            return view();
        }

    }

}