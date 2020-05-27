<?php


namespace app\w2\controller;


use app\admin\controller\Base;

class Books extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('book b')
                ->join('book_type t', 'b.type_id=t.type_id', 'left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function bookDel()
    {
        $id = input('post.book_id');  //得到前台传来的参数book_id
        //db('book')->where('book_id',$id)->delete();
        //db('book')->where('book_id','=',$id)->delete();
        db('book')->delete($id);
        return $this->success('删除成功！');
    }

    public function type()
    {
        if (request()->isAjax()) {  //判断当前请求是否为ajax请求
            $list = db('book_type')->select(); //select * from book_type
            return $this->show($list); //不分页的
        } else {
            return view();
        }
    }

    public function typeDel()
    {
        $id = input('post.id');
        $find = db('book')->where('type_id', $id)->find();
        if ($find) {
            return $this->error("该类别下有图书，不能删除！");
        } else {
            db('book_type')->delete($id);
            return $this->success('删除成功！');
        }
    }

    public function typeForm()
    {
        if(request()->isPost()){
            $data=input('post.');
            //var_dump($data);
            $name=$data['type_name'];
            $find=db('book_type')->where('type_name',$name)->find();
            if($find)
                return $this->error("该类别已经存在，不能添加！");
            else {
                db('book_type')->insert($data);
                return $this->success("保存成功");
            }
        }
        else
            return view();
    }

    public function add()
    {
        $data=['type_name'=>'游戏类'];
        db('book_type')->insert($data);

    }
    
}