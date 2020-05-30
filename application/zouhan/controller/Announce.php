<?php


namespace app\zouhan\controller;


use think\Db;

class Announce extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $id=session('user_id');
            $where['message_id']=['<>',0];
            $where['message_to']=session('user_id');
            $where['type']=0;
            if ($key) {
                $where['manger_name|content']=['like','%' . $key . '%'];
            }
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('message m')
                ->join('property_manger p','p.manger_id=m.message_from')
                ->where($where)
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
    public function announceForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $mangerVillage=db('manger_village')->where('manger_id',session('user_id'))->find();
            $owner=db('owner')->where('owner_village',$mangerVillage['village_id'])->field('owner_id')->select();
            // var_dump($owner);
            $count=count($owner);

            //  var_dump($data);
            $result=db("manger_message")->where('manger_message_id',$data['manger_message_id'])->find();
            if(!$result){
                $data['manger_id']=session('user_id');
                $data['ctime']=time();
                db('manger_message')->insert($data);
                $data['message_from']=$data['manger_id'];
                unset($data['manger_id']);
                $data['village_id']=$mangerVillage['village_id'];
                $data['type']=0;
                $data['status']=0;
                for ($i=0;$i<$count;$i++){
                    $data['message_to']=$owner[$i]['owner_id'];
                    db('message')->insert($data);
                }
                return $this->success('添加成功！');
            }else{
                $data['ctime']=time();
                //  var_dump($data);
                db('manger_message')->update($data);
                db('message')->where('manger_message_id',$data['manger_message_id'])
                    ->update(['content'=>$data['content'],'ctime'=>$data['ctime']]);
                return $this->success('编辑成功！');
            }
        } else {
            $list = db('owner')->select();
            $this->assign('list', $list);
            return view();
        }
    }

    /**
     * 取得用户最大Id值
     * @return mixed
     */
    public function announceMaxId(){
        if($this->request->isAjax()){
            $num = Db::query("select max(manger_message_id) from manger_message");
            return $num[0]['max(manger_message_id)'];
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
        db('manger_message')->delete(input('post.manger_message_id'));
        db('message')->where('manger_message_id',input('post.manger_message_id'))->delete();
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
    public function announceStatus()
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