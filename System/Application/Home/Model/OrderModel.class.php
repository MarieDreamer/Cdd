<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class OrderModel extends CommonMAbstract {

    static $ORDER_DETAILS = 'order_details';
    static $COMMODITY_MODEL = 'commodity';
    static $WECHAT_USER = 'wechat_user';
    
    //免单管理列表页
    public function free_get(){
        extract(generateRequestParamVars());
        $conditions=array();
        //0是删除 1是显示

        if(!$conditions){
            $count=$this->count();
        }else{
            $count=$this->where($conditions)->count();
        }

        if(!$numPerPage=I('param.numPerPage')){
            $numPerPage=C('NUM_PER_PAGE');
        }

        $page=new \Think\Page($count,$numPerPage);
        $paging=$page->show();

        
        if(!$conditions){
            $results=$this->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
        }else{
            $results=$this->where($conditions)->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
        }
        //用用户id调取用户昵称
        foreach ($results  as $key => $value) {
            $cod=array();
            $cod['id']=$results[$key]['user_id'];
            $nick=D('WechatUser')->where($cod)->find();
            $results[$key]['nickname']=$nick['nickname'];
        }
        return array($paging,$results);
    }

    public function lists(){
        extract(generateRequestParamVars());

        $count=$this->count();

        if(!$numPerPage=I('param.numPerPage')){
            $numPerPage=C('NUM_PER_PAGE');
        }

        $page=new \Think\Page($count,$numPerPage);
        $paging=$page->show();

        $results=$this->order('create_time desc')->limit($page->firstRow.','.$page->listRows)->select();

        foreach ($results as $key => $value) {
            $result=D('WechatUser')->find($results[$key]['user_id']);
            $results[$key]['nickname']=$result['nickname'];
            if($results[$key]['shop_status'] == 0){
                $str = '待支付';
            }else if($results[$key]['shop_status'] == 1){
                $str = '待发货';
            }else if($results[$key]['shop_status'] == 2){
                $str = '待收货';
            }else if($results[$key]['shop_status'] == 3){
                $str = '已完成';
            }
            $results[$key]['shop_status_str']=$str;

            if($results[$key]['review_time'] == 0){
                $results[$key]['review_time'] = '';
            }else{
                $results[$key]['review_time'] = date('Y-m-d H:i:s',$results[$key]['review_time']);
            }
        }

        return array($paging,$results);
    }

    public function detail()
    {
        extract(generateRequestParamVars());
        $order = $this->find($order_id);
        $user = D(self::$WECHAT_USER)->find($order['user_id']);
        $order['user_name'] = $user['nickname'];
        if($order['coupon_id'] == 0) {
            $order['coupon_id'] = '未使用';
        }

        $conditions = [];
        $conditions['order_id'] = $order_id;
        $detail = D(self::$ORDER_DETAILS)->where($conditions)->select();
        for($i = 0; $i <count($detail); $i ++){
            $shop = D(self::$COMMODITY_MODEL)->find($detail[$i]['shop_id']);
            $detail[$i]['shop_name'] = $shop['shop_name'];
            $detail[$i]['shop_num'] = $shop['shop_num'];
            $detail[$i]['shop_image'] = json_decode($shop['shop_index_image'])[0];

        }
        $order_detail = [];
        $order_detail[0] = $order;
        $order_detail[1] = $detail;
        return $order_detail;
    }

    //修改物流（订单）状态
    public function changeStatus()
    {
        extract(generateRequestParamVars());
        $conditions = [];
        $conditions['id'] = $id;
        $data = [];
        $data['shop_status'] = $status;
        if($this->where($conditions)->save($data) === false){
            throw new \Exception("OPERATION_FAILED");
        }
    }

    public function editAddress()
    {
        extract(generateRequestParamVars());
        $conditions = [];
        $conditions['id'] = (int)$order_id;
        $data = [];
        $data[$key] = $value;
        if($this->where($conditions)->save($data) === false){
            throw new \Exception("OPERATION_FAILED");
        }
    }
}