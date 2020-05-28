<?php


namespace app\ljd\controller;


use app\admin\controller\Base;

class Log extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
            $where = 'p.id!=0';
            if ($key) {
                $where .= " and (p.manger_name like '%" . $key . "%'";
                $where .= " or p.title like '%" . $key . "%')";
            }
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('property_sys_log p')
                ->where($where)
                ->order('p.id')
                ->paginate($limit)  //分页
                ->toArray(); //转换为数组
            //  var_dump($list);
            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function logForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            db('property_sys_log')->update($data);
            return $this->success('用户编辑成功！');
        } else {
          /*  //添加此代码的目的为防止用户编辑时显示用户密码
            $this->assign('new', input('param.user_id'));

            $list = db('sys_role')->select();
            $this->assign('list', $list);
            return view('log_form');*/
            $list = db('property_sys_log')->select();
            $this->assign('list', $list);
            return view();
        }
    }
    /**
     * 删除日志
     */
    public function logDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        db('property_sys_log')->delete(input('post.id/a'));
        return $this->success('删除成功!');
    }
}