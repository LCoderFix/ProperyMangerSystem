<?php


namespace app\w1\controller;


use app\admin\controller\Base;

class Books extends Base
{
    /**
     * 图书列表
     */
    public function index()
    {
        if (request()->isAjax()) {  //当前请求是ajax请求
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10; //input('get.limit')
            $list = db('book')
                ->join('book_type','book.type_id=book_type.type_id','left')
                ->paginate($limit)  //分页，每页记录
                ->toArray();
            return $this->showList($list);  //调用分页方法
        }else {
            return view();
        }
    }

    public function bookDel()
    {
        $id=input('post.id');
        db('book')->delete($id);
        return $this->success("删除成功");
    }

    /**
     * 图书新增、编辑
     */
    public function bookForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['book_id'] == null) {
                db('book')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('book')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            $list=db('book_type')->select();
            $this->assign('list',$list);
            return view();
        }
    }

    /**
     * 图书类别
     */
    public function type()
    {
        if (request()->isAjax()) {  //当前请求是ajax请求
            //db是数据库表访问的助手函数
            //select * from book_type;
            $list = db('book_type')->select();
            return $this->show($list);
        }else {
            return view();
        }
    }

    public function  typeDel()
    {

        $id = input('post.type_id');
        /*db('book_type')->delete($id);  //delete from book_type where type_id=$id
        //db('book_type')->where('type_id', $id)->delete();
        return $this->success('删除成功!');*/
        $sub = db('news')->where("type_id", $id)->find();
        if ($sub) {
            return $this->error('该类别有新闻，删除失败!');
        } else {
            db('news_type')->delete($id);
            return $this->success('删除成功!');
        }
    }

    public function typeForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            db('book_type')->insert($data);
            return $this->success('添加成功！');
            /*if ($data['type_id'] == null) {
                db('news_type')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('news_type')->update($data);
                return $this->success('编辑成功！');
            }*/
        } else {
            return view();
        }
    }

}