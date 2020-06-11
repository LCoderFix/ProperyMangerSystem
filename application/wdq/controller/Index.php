<?php

namespace app\wdq\controller;

use think\Db;

class Index extends Base
{
    public function index()
    {
        return view();
    }

    public function console()
    {
        return view();
    }

    public function menu()
    {
        $data = db('sys_menu')
            ->where('visible',1)
            ->order('sort')
            ->select();
        foreach ($data as $key=>$val) {
            if(!in_array($val['menu_id'],$this->userMenus)){
                unset($data[$key]);
            }
        }

        //声明数组
        $menus = array();
        foreach ($data as $key=>$val){
            if($val['parent_id']==0){
                $val['icon'] = "layui-icon ".$val['icon'];
                $val['href'] = "javascript:;";
                    $menus[] = $val;
            }
        }
        foreach ($menus as $k=>$v){
            foreach ($data as $kk=>$vv){
                if($v['menu_id']==$vv['parent_id']){
                        $menus[$k]['subMenus'][] = $vv;
                }
            }
        }
        var_dump($menus);

        return json($menus);
    }

    /**
     * 清除缓存
     */
    public function clear() {
        if (delete_dir_file(CACHE_PATH) && delete_dir_file(TEMP_PATH)) {
            return $this->success('清除缓存成功');
        } else {
            return $this->error('清除缓存失败');
        }
    }

    /**
     * 主题设置
     */
    public function theme(){
        return view();
    }

    /**
     * 退出系统
     */
    public function logout(){
        session(null);
        $this->redirect('admin/login/index');
    }
}