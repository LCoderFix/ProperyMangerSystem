<?php


namespace app\admin\controller;


class Menu extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $list = db('sys_menu')->select();
            return $this->show($list);
        } else {
            return view();
        }
    }

    public function menuForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['menu_id'] == null) {
                db('sys_menu')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('sys_menu')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            $list = db('sys_menu')->where('parent_id', 0)->select();
            $this->assign('list', $list);
            return view('menu_form');
        }
    }

    public function menuDel()
    {
        $id = input('post.menu_id');
        $submenu = db('sys_menu')->where("parent_id", $id)->find();
        if ($submenu) {
            return $this->error('该菜单下有子菜单，删除失败!');
        } else {
            db('sys_menu')->delete($id);
            return $this->success('删除成功!');
        }

    }

}