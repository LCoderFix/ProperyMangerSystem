<?php


namespace app\admin\controller;


class NewsType extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $list = db('news_type')->select();
            return $this->show($list);
        } else {
            return view();
        }
    }

    public function typeForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['type_id'] == null) {
                db('news_type')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('news_type')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            return view('type_form');
        }
    }

    public function typeDel()
    {
        $id = input('post.type_id');
        $sub = db('news')->where("type_id", $id)->find();
        if ($sub) {
            return $this->error('该类别有新闻，删除失败!');
        } else {
            db('news_type')->delete($id);
            return $this->success('删除成功!');
        }

    }
}
