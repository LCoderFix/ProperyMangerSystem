<?php


namespace app\j1\controller;

use app\admin\controller\Base;

class Books extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('book b')
                ->join('book_type t', 'b.type_id=t.type_id', 'left')
                ->order('b.type_id')
                ->paginate($limit)  //分页
                ->toArray(); //转换为数组
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
        return $this->success("删除成功！");

    }

    /**
     * 图书新增、编辑页面
     */
    public function bookForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['book_id'] == null) {
                db('book')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('book_type')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            $list=db('book_type')->select();

            $this->assign('list',$list);
            return view();
        }
    }


    public function type()
    {
        if (request()->isAjax()) {
            $list = db('book_type')->select();
            return $this->show($list);
        } else {
            return view(); //助手函数，加载视图
        }
    }

    public function typeForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['type_id'] == null) {
                $find = db('book_type')->where('type_name', $data['type_name'])->find();
                if ($find)
                    return $this->error("图书类别已存在，添加失败！");
                else {
                    db('book_type')->insert($data);
                    return $this->success('添加成功！');
                }
            } else {
                db('book_type')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            return view();
        }
    }


    public function typeDel()
    {
        $id = input('post.type_id');
        $find = db('book')->where('type_id', '=', $id)->find();
        if ($find) {
            return $this->error("该类别下有图书，不能删除！");
        } else {
            db('book_type')->where('type_id', '=', $id)->delete();
            return $this->success('类别删除成功!');
        }
    }


}