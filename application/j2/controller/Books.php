<?php


namespace app\j2\controller;


use app\admin\controller\Base;

class Books extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();  //获得前台传来的参数
            $limit = $get['limit'] ?? 10;  //读取前台传来的limit，如何没有默认为10
            //select book.book_name,book_type.type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('book b')  //b表示book表的别名
            ->join('book_type t', 'b.type_id=t.type_id', 'left')
                ->order('type_name')
                ->paginate($limit) //分页
                ->toArray();  //转换为数组
            return $this->showList($list);
        } else {
            return view();
        }
    }

    /**
     * 图书删除
     */
    public function bookDel()
    {
        $id = input('post.book_id');
        db('book')->delete($id);
        return $this->success('图书删除成功!');
    }

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
            $list = db('book_type')->select();
            $this->assign('list', $list);  //将后台的值传递到前台
            return view();
        }
    }

    public function type()
    {
        if (request()->isAjax()) {
            $list = db('book_type')->select();  //select * from book_type
            return $this->show($list);
        } else {
            return view();
        }
    }

    /**
     * 图书类型删除
     */
    public function typeDel()
    {
        $id = input('post.type_id');
        $find = db('book')->where('type_id', '=', $id)->find();
        if ($find)
            return $this->error('该类别下有图书，删除失败！');
        else {
            db('book_type')->delete($id);
            return $this->success('图书删除成功!');
        }
    }

    public function typeForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['type_id'] == null) {
                db('book_type')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('book_type')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            return view('type_form');
        }
    }


    /*public function add()
    {
        $book = [
            'type_id' => 3,
            'book_name' => '我编写的书'
        ];
        db('book')->insert($book);
    }*/

}