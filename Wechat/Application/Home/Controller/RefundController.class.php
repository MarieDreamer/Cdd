<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class RefundController extends Controller{
	static $REFUND_MODEL='refund';

    public function __construct(){
        parent::__construct();
    }

    public function addRefund(){
        try{
            D(self::$REFUND_MODEL)->addRefund();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败：'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function checkRefund(){
        try{
            $result = D(self::$REFUND_MODEL)->checkRefund();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['result']=$result;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败：'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
}