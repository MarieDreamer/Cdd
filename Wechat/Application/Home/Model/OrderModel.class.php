<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class OrderModel extends CommonMAbstract {

	public function orderlists(){
		extract(generateRequestParamVars());
		$conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
//         $conditions['user_id']=$userid;
		$order = $this->where($conditions)->order('id')->select();

		foreach ($order as $key => $value) {
			// echo $order[$key]['shop_id'];
            $conditions=array();
            $conditions['id']=$order[$key]['shop_id'];
            $result=D('Commodity')->where($conditions)->find();
            // var_dump($result);
            $name=$result['shop_name'];
            // echo $name;
            $order[$key]['shop_id']=$name;
        }

        foreach ($order as $key => $value) {
			// echo $order[$key]['shop_id'];
            $conditions=array();
            $conditions['id']=$order[$key]['user_id'];
            $result=D('WechatUser')->where($conditions)->find();
            // var_dump($result);
            $name=$result['nickname'];
            // echo $name;
            $order[$key]['user_id']=$name;
        }

		// var_dump($classification);
		return $order;
	}

    public function addOrder()
    {
        extract(generateRequestParamVars());
        //订单表添加
        $data = [];
        $data['user_id'] = $user_id;
        $data['order_number'] =rand(10,100) .''. time() .''. rand(10,100);

        $address = json_decode($address);
        $data['address_consignee'] = $address->consignee;
        $data['address_region'] = $address->region;
        $data['address_mobile'] = $address->mobile;
        $data['address_address'] = $address->address;

        $data['shipping_name'] = $shipping_name;
        if($coupon_id != 'undefined')
            $data['coupon_id'] = $coupon_id;
        else
            $data['coupon_id'] = 0;
        $data['user_note'] = $user_note;
        $data['total_num'] = $total_num;
        $data['total_price'] = $total_price;
        $data['create_time'] = time();
        $data['status_delete'] = 1;
        $data['is_free'] = 0;
        $data['shop_status'] = 0;//0待付款1待发货2待收货

        if($this->add($data) === false){
            throw new \Exception('订单表出错');
        }
        return $data['order_number'];
    }

	//用户订单列表页获取接口
    public function lists(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['user_id']=$userid;
        if($type_status=='WAITPAY'){
            $conditions['shop_status']=0;
        }
        if($type_status=='WAITSEND'){
            $conditions['shop_status']=1;
        }
        if($type_status=='WAITRECEIVE'){
            $conditions['shop_status']=2;
        }
        if($type_status=='WAITCCOMMENT'){
            $conditions['shop_status']=3;
        }
        $results=$this->where($conditions)->order('create_time desc')->select();//获取订单信息
        foreach ($results as $key => $value) {
            $condition=array();
            $condition['order_id']=$results[$key]['id'];
            //取出订单中的商品详细信息
            $sam=D('OrderDetails')->where($condition)->select();
            foreach ($sam as $k => $v) {
                $cdt=array();
                $cdt['id']=$sam[$k]['shop_id'];
                //通过商品详细信息表中的商品id来获取商品名称，价格，主图信息
                $tail=D('Commodity')->where($cdt)->find();
                if(!$tail){
                    throw new \Exception(L('OPERATION_FAILED'));
                }
            //整合数据
                $sam[$k]['shop_name']=$tail['shop_name'];
                $sam[$k]['Unit_Price']=$tail['shop_price'];
                $sam[$k]['shop_index_image']=json_decode($tail['shop_index_image']);
            }
            $results[$key]['shop']=$sam;
        }
        return $results;
    }
    //订单详细页面获取接口
    public function get(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['id']=$id;
        $results=$this->where($conditions)->find();//获取订单信息

        $condition=array();
        $condition['order_id']=$results['id'];
        //取出订单中的商品详细信息
        $sam=D('OrderDetails')->where($condition)->select();
        foreach ($sam as $k => $v) {
            $cdt=array();
            $cdt['id']=$sam[$k]['shop_id'];
            //通过商品详细信息表中的商品id来获取商品名称，价格，主图信息
            $tail=D('Commodity')->where($cdt)->find();
            if(!$tail){
                throw new \Exception(L('OPERATION_FAILED'));
            }
        //整合数据
            $sam[$k]['shop_name']=$tail['shop_name'];
            $sam[$k]['Unit_Price']=$tail['shop_price'];
            $sam[$k]['shop_index_image']=json_decode($tail['shop_index_image']);
        }
        //取优惠券折扣金额
        $cdt2=array();
        $cdt2['id']=$results['coupon_id'];
        $coupon=D('Coupon')->where($cdt2)->find();
        $results['coupon_bonus']=$coupon['bonus'];
        $results['shop']=$sam;
        $results['create_time']=date("Y-m-d H:i",$results['create_time']);
        return $results;
    }
    //猜奖单双接口
    public function guess_do(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['id']=$id;//订单id
        $results=$this->where($conditions)->find();
        if($results['guess_status']==0){
            $data=array();
            $data['guess_status']=1;
            if($dan==1){
                $data['guess_content']=1;
            }
            if($shuang==1){
                $data['guess_content']=2;
            }
            //取数据库id最大即为最新期号
            $number=D('Lottery')->order('term_number desc')->find();
            $time=time();
            //当前时间离下一期开奖只剩两分钟时（与上一期开奖时间相差小于3分钟）竞猜下下期
            if($time-strtotime($number['opening_time'])<180){
                $data['guess_term_number']=$number['term_number']+2;//期号
                if($this->where($conditions)->save($data)===false){
                   throw new \Exception(L('OPERATION_FAILED'));
                }
                $text=array();
                $text['data']='猜奖成功';
                $text['guess_term_number']=$data['guess_term_number'];
                return $text;
            }
            //否则竞猜下一期
            else{
                $data['guess_term_number']=$number['term_number']+1;//期号
                if($this->where($conditions)->save($data)===false){
                   throw new \Exception(L('OPERATION_FAILED'));
                }
                $text=array();
                $text['data']='猜奖成功';
                $text['guess_term_number']=$data['guess_term_number'];
                return $text;
            }
        }else{
            $text=array();
            $text['data']='请勿重复猜奖';
            return $text;
        }
    }
	//我的免单列表页
    public function myquery(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['user_id']=$userid;
        $conditions['guess_status']=1;//已猜奖的才会显示在免单列表中
        if($type_status=='ing'){
            $conditions['is_free']=0;
        }
        if($type_status=='success'){
            $conditions['is_free']=1;
        }
        if($type_status=='fail'){
            $conditions['is_free']=2;
        }
        $results=$this->where($conditions)->select();
        foreach ($results as $key => $value) {
            $cod=array();
            $cod['term_number']=$results[$key]['guess_term_number'];
            $result=D('lottery')->where($cod)->find();
            if($result){
                $results[$key]['award_number']=str_replace(',', '', $result['award_number']);
                $results[$key]['last_number']=substr($results[$key]['award_number'],19,1);
            }
        }
        if(!$results){
            throw new \Exception(L('OPERATION_FAILED'));
        }
        return $results;
    }
    //获取竞猜期号
    public function get_term_number(){
        $number=D('Lottery')->order('term_number desc')->find();
        $time=time();
        //当前时间离下一期开奖只剩两分钟时（与上一期开奖时间相差小于3分钟）竞猜下下期
        if((($time-strtotime($number['opening_time']))/300)%5>3){
            $data=array();
            $data['guess_term_number']=$number['term_number']+ceil(($time-strtotime($number['opening_time']))/300)+1;
            return $data;
        }
        //否则竞猜下一期
        else{
            $data=array();
            $data['guess_term_number']=$number['term_number']+ceil(($time-strtotime($number['opening_time']))/300);
            return $data;
        }
    }
    //免单结算
    public function Settlement($sudo){
        foreach ($sudo as $key => $value) {
           $conditions=array();
           $conditions['guess_term_number']=$sudo[$key]['term_number'];
           $sudo[$key]['award_number']=str_replace(',', '', $sudo[$key]['award_number']);
           $sudo[$key]['last_number']=substr($sudo[$key]['award_number'],19,1);
           if($sudo[$key]['last_number']%2==0){
                $joc=2;//彩票尾数为双
           }else{
                $joc=1;//彩票尾数为单
           }
           //调取该期号所有猜奖用户数据
           $user_order=$this->where($conditions)->select();
           foreach ($user_order as $key => $value) {
                //该用户猜奖结果与实际结果一致 进行结算
               if($user_order[$key]['guess_content']==$joc){
                    $data=array();
                    $data['is_free']=1; //免单字段 结算为1（恭喜免单）
                    $this->where($conditions)->save($data); 
                    //退款至我的余额
                    $condition=array();
                    $condition['id']=$user_order[$key]['user_id'];
                    $data_wechat_user=array();
                    //查询该用户余额
                    $results=D('WechatUser')->where($condition)->find();
                    //该用户余额=该用户原有余额+该笔订单总金额
                    $data_wechat_user['balance']=$results['balance']+$user_order[$key]['total_price'];
                    if($re=D('WechatUser')->where($conditions)->save($data_wechat_user)===false){
                        throw new \Exception(L('OPERATION_FAILED'));
                    }
               }else{
                    $data=array();
                    $data['is_free']=2; //免单字段 结算为2（未免单）
                    $this->where($conditions)->save($data);
               }
           }  
        }
    }
    //用户确认收货
    public function confirm_order(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['id']=$id;
        $results=$this->where($conditions)->find();//获取订单信息
        $data=array();
        $data['shop_status']=3;
        if($results=$this->where($conditions)->save($data)===false){
            throw new \Exception(L('OPERATION_FAILED'));
        }
    }
    //用户取消订单
    public function cancel_order(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['id']=$id;
        $results=$this->where($conditions)->find();//获取订单信息
        $data=array();
        $data['shop_status']=4;
        if($results=$this->where($conditions)->save($data)===false){
            throw new \Exception(L('OPERATION_FAILED'));
        }
    }
    //用户订单内免单查询页面page/cue/cue 所需数据
    public function is_free(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['id']=$id;
        if($results=$this->where($conditions)->find()===false){
            throw new \Exception(L('OPERATION_FAILED'));
        }
        $results=$this->where($conditions)->find();
        $condition=array();
        $condition['term_number']=$results['guess_term_number'];
        $result=D('Lottery')->where($condition)->find();
        $results['term_number']=$result['term_number'];
        $results['award_number']=str_replace(',', '', $result['award_number']);
        $results['last_number']=substr($results['award_number'],19,1);
        return $results;
    }
}


