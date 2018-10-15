<?php

namespace Home\Controller;

use Think\Controller;
use Think\Model;


class OrderController extends Controller
{

    static $COUPON_MODEL = 'coupon';
    static $ORDER_MODEL = 'order';
    static $WECHAT_USER_MODEL = 'WechatUser';
    static $ORDER_DETAILS = 'order_details';
    static $CART_MODEL = 'cart';
    static $NOTIFY_TEST = 'notify_test';

    public function __construct()
    {
        // validateUnLoginRedirect();
        parent::__construct();
    }

    public function orderlists()
    {
        try {
            $order = D(self::$ORDER_MODEL)->orderlists();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message'] = '操作成功';
            $ajaxReturnData['data'] = $order;
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function addOrder()
    {
        $model = new Model();
        $model->startTrans();
        $flag = false;
        try {
            $order_number = D(self::$ORDER_MODEL)->addOrder();//订单添加并返回订单编号
            D(self::$CART_MODEL)->delCartInArray();//购物车删除
            D(self::$COUPON_MODEL)->changeStatus();//优惠券状态修改
            D(self::$ORDER_DETAILS)->addOrderDetails();//订单详情表添加
            $ajaxReturnData['data'] = $order_number;
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message'] = '操作成功';
            $flag = true;
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
            $flag = false;
        }
        if ($flag) {
            $model->commit();
        } else {
            $model->rollback();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //微信支付
    public function getPrepay()
    {
        extract(generateRequestParamVars());
        $user = D(self::$WECHAT_USER_MODEL)->find($user_id);
        $openid = $user['openid'];

        require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Api.php';
        require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Notify.php';
        require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Data.php';
        require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/example/log.php';
        require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/example/WxPay.NativePay.php';
        require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/example/WxPay.JsApiPay.php';

        $notify = new \NativePay();
        $input = new \WxPayUnifiedOrder();
        $sign = new \WxPayDataBase();
        $input->SetBody("购买商品");
        $input->SetAttach("attach");
        $input->SetOpenid($openid);
//        $input->SetOut_trade_no(\WxPayConfig::MCHID . date("YmdHis"));
        $input->SetOut_trade_no($product_id);
        $input->SetTotal_fee($total_fee * 100);
        $input->SetTime_start(date("YmdHis", time()));
        $input->SetTime_expire(date("YmdHis", time() + 600));
        $input->SetNotify_url("https://wechat.cdd.jianfengweb.com/Order/getNotify");
        $input->SetGoods_tag("goods_tag");
        $input->SetTrade_type("JSAPI");
//        $input->SetProduct_id($product_id);
        $result = $notify->GetPayUrl($input);

        $sign_array = array();
        $sign_array['appId'] = $result['appid'];
        $sign_array['nonceStr'] = $result['nonce_str'];
        $sign_array['package'] = 'prepay_id=' . $result['prepay_id'];
        $sign_array['signType'] = 'MD5';
        $sign_array['timeStamp'] = floor($result['startTimeStamp'] / 1000);

        $sign_two = $sign->MakeSigns($sign_array);
        $result['paySign'] = $sign_two;

        $ajaxReturnData['data'] = $result;
        $this->ajaxReturn($ajaxReturnData);
    }

    //接受微信支付通知
    public function getNotify()
    {
        $xmlData = file_get_contents('php://input');
        libxml_disable_entity_loader(true);
        $data = json_decode(json_encode(simplexml_load_string($xmlData, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
        ksort($data);
        $buff = '';
        foreach ($data as $k => $v) {
            if ($k != 'sign') {
                $buff .= $k . '=' . $v . '&';
            }
        }

        $save = [];
        foreach ($data as $k => $v) {
            $save['key'] = $k . '';
            $save['value'] = $v . '';
            D(self::$NOTIFY_TEST)->add($save);
        }

        $stringSignTemp = $buff . 'key=1d8r14jiu58fs12qsd824j1o52d8r14c';//key为证书密钥
        $sign = strtoupper(md5($stringSignTemp));

        $conditions = [];
        $conditions['order_number'] = $data['out_trade_no'];
        $order = D(self::$ORDER_MODEL)->where($conditions)->find();

        //判断算出的签名和通知信息的签名是否一致
        if ($order && $sign == $data['sign'] && $order['total_price']*100 == $data['total_fee']) {
            $test = [];
            $test['key'] = '校验是否成功';
            $test['value'] = 'yes';
            D(self::$NOTIFY_TEST)->add($test);

            $order_data = [];
            $order_data['shop_status'] = 1;
            D(self::$ORDER_MODEL)->where($conditions)->save($order_data);

            //处理完成之后，告诉微信成功结果
            echo '<xml>
                    <return_code><![CDATA[SUCCESS]]></return_code>
                    <return_msg><![CDATA[OK]]></return_msg>
                  </xml>';
            exit();
        }else{
            echo '<xml>
                    <return_code><![CDATA[FAIL]]></return_code>
                    <return_msg><![CDATA[FAIL]]></return_msg>
                  </xml>';
            exit();
        }
    }

    //查询支付订单
    public function findOrder()
    {
        try{
            extract(generateRequestParamVars());
            require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Api.php';
            $input = new \WxPayOrderQuery();
            $input->SetOut_trade_no($order_number); // 设置好要查询的订单
            $order = \WxPayApi::orderQuery($input); // 进行查询

            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message'] = '操作成功';
            $ajaxReturnData['data'] = $order;
        }catch (\Exception $e){
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //用户订单列表页获取接口
    public function lists()
    {
        try {
            $results = D(self::$ORDER_MODEL)->lists();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['data'] = $results;
            $ajaxReturnData['message'] = '操作成功';
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //订单详细页面获取接口
    public function get()
    {
        try {
            $results = D(self::$ORDER_MODEL)->get();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['data'] = $results;
            $ajaxReturnData['message'] = '操作成功';
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //猜奖单双接口
    public function guess_do()
    {
        try {
            $results = D(self::$ORDER_MODEL)->guess_do();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['data'] = $results;
            $ajaxReturnData['message'] = '操作成功';
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //我的免单列表页
    public function myquery()
    {
        try {
            $result = D(self::$ORDER_MODEL)->myquery();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['data'] = $result;
            $ajaxReturnData['message'] = '操作成功';
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //获取竞猜期号
    public function get_term_number()
    {
        try {
            $results = D(self::$ORDER_MODEL)->get_term_number();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['data'] = $results;
            $ajaxReturnData['message'] = '操作成功';
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
    //用户认收货接口
    public function confirm_order(){
        try{
            D(self::$ORDER_MODEL)->confirm_order();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
    //取消订单接口
    public function cancel_order(){
        try{
            D(self::$ORDER_MODEL)->cancel_order();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
    //订单免单详情
    public function is_free()
    {
        try {
            $results = D(self::$ORDER_MODEL)->is_free();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['data'] = $results;
            $ajaxReturnData['message'] = '操作成功';
        } catch (\Exception $e) {
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败' . $e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
}