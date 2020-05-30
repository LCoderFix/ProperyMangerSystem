<?php


namespace app\ljd\controller;


use app\admin\controller\Base;
use think\Db;
use think\db\Query;

class Villages extends Base
{

    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            //select book_name,type_name from book left join book_type on book.type_id=book_type.type_id
            $list = db('village v')
                ->join('manger_village m', 'v.village_id=m.village_id','left')
                ->join('property_manger p','p.manger_id=m.manger_id','left')
                ->field('v.*,p.manger_name,p.manger_id')
                ->order('v.village_id')
                ->paginate($limit)  //分页
                ->toArray(); //转换为数组
            return $this->showList($list);
        } else {
            return view();
        }
    }

    /**
     * 小区新增、编辑页面
     */
    public function villageForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $result=db("village")->where('village_id',$data['village_id'])->find();
            if(!$result){
              //  $mangerVillage['manger_id']=$data['manger_id'];
              //  $mangerVillage['village_id']=$data['village_id'];
              //  $exist=db('manger_village')->where('manger_id',date(['manger_id']));

              //  db('manger_village')->insert($mangerVillage);
                db('village')->insert($data);
                return $this->success('添加成功！');
            }else{
                db('village')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            $list = db('property_manger')->select();
            /*for ($i=0;$i<count($list);$i++){
                $exist=db('manger_village')->where('manger_id',$list[$i]['manger_id'])->find();
                if($exist){
                    unset($list[$i]);
                }
            }*/
            $this->assign('list', $list);
            return view();
        }
    }

    /**
     * 取得小区最大ID
     * @return mixed
     */
    public function villageMaxID()
    {
        if ($this->request->isAjax()) {
            $num = Db::query("select max(village_id) from village");
            return $num[0]['max(village_id)'];
        }
    }
    /**
     * 小区删除
     */
    public function villageDel()
    {
        $id = input('post.village_id');
        $mangerVillage=db('manger_village')->where('village_id',$id)->find();
        db('village')->delete($id);
        $where['manger_id']=$mangerVillage['manger_id'];
        $where['village_id']=$mangerVillage['village_id'];
        db('manger_village')->where($where)->delete();
        return $this->success("删除成功！");

    }

}