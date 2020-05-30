<?php


namespace app\zouhan\controller;


use app\zouhan\controller\Base;
use think\Db;
class Feedback extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $id=session('user_id');
            $where['message_id']=['<>',0];
            if ($key) {
                $where['message_from|content']=['like','%' . $key . '%'];
            }
            $where['message_to']=$id;
            $where['type']=1;
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('message m')
                ->join('owner o','o.owner_id=m.message_from')
                ->where($where)
                ->field('m.*,o.owner_name,o.owner_tel,o.owner_location')
                ->order('m.message_id')
                ->paginate($limit)  //分页
                ->toArray(); //转换为数组
            return $this->showList($list);
        } else {
            return view();
        }
    }
    /**
     * 用户新增、编辑页面
     */
    public function feedbackForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $result=db("message")->where('message_id',$data['message_id'])->find();
            if(!$result){
                $owner=db('owner')->find(session('user_id'));
                $data['message_from']=$owner['owner_id'];
                $data['village_id']=$owner['owner_village'];
                $data['type']=1;
                $data['status']=0;
                $data['ctime']=time();
                db('message')->insert($data);
                return $this->success('反馈成功！');
            }else{
                $data['ctime']=time();
                //  var_dump($data);
                db('message')->where('message_id',$data['message_id'])->update(['content'=>$data['content'],'ctime'=>time(),'message_to'=>$data['message_to']]);
                return $this->success('编辑成功！');
            }
        } else {
            $owner=db('owner')->find(session('user_id'));
           // $manger=db('manger_village')->where('village_id',$owner['owner_village'])->find();
            $where['village_id']=$owner['owner_village'];
            $list = db('manger_village m')
                ->join('property_manger p','p.manger_id=m.manger_id')
                ->where($where)
                ->select();
            $this->assign('list', $list);
            return view();
        }
    }

    /**
     * 取得用户最大Id值
     * @return mixed
     */
    public function feedbackMaxId(){
        if($this->request->isAjax()){
            $num = Db::query("select max(message_id) from message");
            return $num[0]['max(message_id)'];
        }
    }

    /**
     * 删除公告
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function msgDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        db('message')->delete(input('post.message_id'));
        return $this->success('删除成功!');
    }
    /**
     * 重置密码
     */

    public function resetPwd()
    {
        //var_dump(input('post.manger_id'));
        db('owner')->where('owner_id', input('post.owner_id'))->update(['owner_password' => md5("1")]);
        return $this->success('重置密码成功，新密码为1!');
    }
    //更新用户权限
    public function feedbackStatus()
    {
        $status = input('post.status');
        // var_dump($status.input('post.manger_id'));
        if (db('message')->where('message_id', input('post.message_id'))->update(['status' => $status]) !== false) {
            return $this->success('设置成功!');
        } else {
            return $this->error('设置失败!');
        }
    }
}