<?php


namespace app\wdq\controller;


use app\wdq\controller\Base;
use think\Db;

class Park extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $id=session('user_id');
            if ($key) {
                $where['id']=['like','%' . $key . '%'];
            }
            $manger_village=db('manger_village')->where('manger_id',$id)->find();
            $where['village_id']=$manger_village['village_id'];
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('park')
                ->where($where)
                ->order('id')
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
    public function parkForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            //  var_dump($data);
            $result=db("park")->where('id',$data['id'])->find();
            if(!$result){
                $village=db('manger_village')->where('manger_id',session('user_id'))->find();
                $data['village_id']=$village['village_id'];
                db('park')->insert($data);
                $manger=db('manger_village')->where('manger_id',session('user_id'))->find();
                $village=db('village')->where('village_id',$manger['village_id'])->find();
                db('village')->where('village_id',$village['village_id'])->update(['village_parking_num'=>$village['village_parking_num']+1]);
                return $this->success('添加成功！');
            }else{
                db('park')->update($data);
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
    public function ownerMaxId(){
        if($this->request->isAjax()){
            $num = Db::query("select max(owner_id) from owner");
            return $num[0]['max(owner_id)'];
        }
    }

    /**
     * 删除用户
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function parkDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        db('park')->delete(input('post.id/a'));
        $manger=db('manger_village')->where('manger_id',session('user_id'))->find();
        $village=db('village')->where('village_id',$manger['village_id'])->find();
        db('village')->where('village_id',$village['village_id'])->update(['village_parking_num'=>$village['village_parking_num']-count(input('post.id/a'))]);
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
    //更新车位状态
    public function parkStatus()
    {
        $status = input('post.status');
        // var_dump($status.input('post.manger_id'));
        if (db('park')->where('id', input('post.id'))->update(['status' => $status]) !== false) {
            return $this->success('设置成功!');
        } else {
            return $this->error('设置失败!');
        }
    }

}