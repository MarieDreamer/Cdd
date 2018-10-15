<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class CouponController extends Controller{

	static $COUPON_MODEL='coupon';
    static $WECHAT_USER_MODEL='WechatUser';

    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    public function orderlists(){
        try{
            $order = D(self::$COUPON_MODEL)->orderlists();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$order;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function lists(){
        try{
            $data = D(self::$COUPON_MODEL)->lists();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$data;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
}