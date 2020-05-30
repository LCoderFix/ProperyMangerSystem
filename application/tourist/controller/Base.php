<?php

/**
 * 控制器基类
 */

namespace app\tourist\controller;

use think\Controller;

class Base extends Controller
{
    protected $userMenus, $menuId;

    protected function _initialize()
    {
        //判断是否登录
        if (!session('user_id')) {
            $this->redirect('admin/login/index');
        }
        define('MODULE_NAME', 'admin');
        define('CONTROLLER_NAME', 'index');
        define('ACTION_NAME', 'menu');
       // var_dump(MODULE_NAME.CONTROLLER_NAME.ACTION_NAME);
        //权限管理
        //当前操作权限ID
        //if (session('user_id') != 1) {
            $info = db('sys_menu')->where('url', '/'.MODULE_NAME . '/' . CONTROLLER_NAME . '/' . ACTION_NAME)->find();
            $this->menuId = $info['menu_id'];
            //当前用户权限
            if (!cache('role_menu_' . '17')) {
             //   var_dump('1111');

                $menus = db('sys_role')
                    ->where('role_id', '17')
                    ->value('menus');

                cache('role_menu_' . '17', $menus);
            }
            $menus = cache('role_menu_' . '17');
            $this->userMenus = explode(',', $menus);

            /*if ($this->menuId) {
                if (!in_array($this->menuId, $this->userMenus)) {
                    $this->error('您无此操作权限');
                }
            }*/
        //}
    }

    /**
     * 返回数据,一般用于不带分页的单条数据
     * @param $code 状态
     * @param $msg 提示信息
     * @param $data 要返回的数据
     * @return array
     */
    public static function show($data, $code = 0, $msg = '')
    {
        $res = ['code' => $code];
        $res['msg'] = $msg;
        $res['data'] = $data;
        return $res;
    }

    /**
     * 返回数据，一般用于带分页的多条数据对象
     * @param  [type]  $data     [description]
     * @param integer $code [description]
     * @param string $msg [description]
     * @return mixed
     */
    public static function showList($data, $code = 0, $msg = '')
    {
        $res['code'] = $code;
        $res['msg'] = $msg;
        if (!empty($data['total'])) {
            $res['count'] = $data['total'];
        } else {
            $res['count'] = 0;
        }
        $res['data'] = $data['data'];
        return $res;
    }

}
