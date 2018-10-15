<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class OrderController extends Controller{

    static $ORDER_MODEL='order';

    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    public function lists(){
       validateUnLoginRedirect();
//        checkAccess('order','view');
        list($paging, $results) = D(self::$ORDER_MODEL)->lists();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }

    public function detail(){
       validateUnLoginRedirect();
//        checkAccess('order','view');

        $order_detail = D(self::$ORDER_MODEL)->detail();

        $this->assign('order_detail', $order_detail);
        $this->display();
    }

    public function changeStatus()
    {
        validateUnLoginRedirect();
        try{
            D(self::$ORDER_MODEL)->changeStatus();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message'] = '操作成功';
        }catch (\Exception $e){
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败';
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function editAddress()
    {
        validateUnLoginRedirect();
        try{
            D(self::$ORDER_MODEL)->editAddress();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message'] = '操作成功';
        }catch (\Exception $e){
            $ajaxReturnData['status'] = 0;
            $ajaxReturnData['message'] = '操作失败';
        }
        $this->ajaxReturn($ajaxReturnData);
    }

}

    