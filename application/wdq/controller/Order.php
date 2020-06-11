<?php


namespace app\wdq\controller;


use app\wdq\controller\Base;
use think\Db;

class Order extends Base
{
    public function index(){
        if (request()->isAjax()) {
            $get = $this->request->get();
            $key = $get['key'] ?? '';
            $limit = $get['limit'] ?? 10;
            $id=session('user_id');
            if ($key) {
                $where['owner_name']=['like','%' . $key . '%'];
            }
            $manger_village=db('manger_village')->where('manger_id',$id)->find();
            $where['owner_village']=$manger_village['village_id'];
           // $where['order.status']=0;
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('t_order')
                ->join('owner o','o.owner_id=t_order.owner_id')
                ->join('park p','p.id=t_order.park_id')
                ->join('garage g','g.id=p.garage_id')
                ->field('t_order.*,o.owner_name,o.owner_village,g.name')
                ->where($where)
                ->order('t_order.id')
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
    public function ownerForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            //  var_dump($data);
            $result=db("owner")->where('owner_id',$data['owner_id'])->find();
            if(!$result){
                db('owner')->insert($data);
                return $this->success('添加成功！');
            }else{
                db('owner')->update($data);
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
    public function orderDel()
    {
        //参数后加/a是因为前面批量删除时会传来数组，如[1,2]
        $data = input('post.');
       // var_dump($data['data']['status']);
        if($data['data']['status']=='1'){
            return $this->error('预订已完成，请勿重复点击!');
        }else{
            db('t_order')->where('id',$data['data']['id'])->update(['status'=>1,'endtime'=>time()]);
            db('park')->where('id',$data['data']['park_id'])->update(['status'=>0]);
            return $this->success('订单已完成!');
        }


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
    public function userPermission()
    {
        $status = input('post.status');
        // var_dump($status.input('post.manger_id'));
        if (db('property_manger')->where('manger_id', input('post.manger_id'))->update(['manger_permission' => $status]) !== false) {
            return $this->success('设置成功!');
        } else {
            return $this->error('设置失败!');
        }
    }

}