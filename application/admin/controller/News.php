<?php


namespace app\admin\controller;


class News extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
            $type_id = $get['type'] ?? 0;


            $where = '1=1 ';
            if ($key) {
                $where .= "and (title like '%" . $key . "%')";
            }
            if ($type_id > 0) {
                $where .= " and (t.type_id=" . $type_id . ")";
            }

            $list = db('news')->alias('n')
                ->join('news_type t', 'n.type_id = t.type_id', 'left')
                ->field('n.*,t.type_name')
                ->where($where)
                ->order('create_time desc')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            $list = db('news_type')->select();
            $this->assign('list', $list);
            return view();
        }

    }

    public function topNews()
    {
        $list = db('news')->alias('n')
            ->join('news_type t', 'n.type_id = t.type_id', 'left')
            ->field('n.*,t.type_name')
            ->order('create_time desc')
            ->paginate(5)
            ->toArray();
        return $this->showList($list);
    }

    public function viewNews()
    {
        $content = db('news')
            ->where('news_id', input('get.news_id'))
            ->value('content');
        $this->assign('content', $content);
        return view();
    }

    public function newsForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $data['create_time'] = strtotime($data['create_time']);
            if ($data['news_id'] == null) {
                //$data['user_id'] = session('userid');
                //增加strict(false)是因为前台会多会一个参数过来
                db('news')->strict(false)->insert($data);
                return $this->success('新闻添加成功！', 'index');
            } else {
                db('news')->update($data);
                return $this->success('新闻编辑成功！', 'index');
            }
        } else {
            //注意此处的参数news_id传递是通过url传递过来的
            $news_id = input('param.news_id');
            $data = null;
            if ($news_id) {
                $data = db('news')->where('news_id=' . $news_id)->find();
            }
            $this->assign("content", $data["content"]);
            $this->assign('data', json_encode($data, true));
            $list = db('news_type')->select();
            $this->assign('list', $list);
            return view('news_form');
        }
    }

    public function newsDel()
    {
        db('news')->delete(input('post.news_id'));
        return $this->success('删除成功!');
    }

}