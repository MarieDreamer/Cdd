<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class RefundController extends Controller{

    static $REFUND_MODEL='refund';
    
    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    //退款申请页面显示
    public function lists(){
        extract(generateRequestParamVars());
        validateUnLoginRedirect();
        // checkAccess('refund','view');
        list($paging, $results) = D(self::$REFUND_MODEL)->lists();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }
    

    //类目删除
    // public function dele_do(){
    //     try{
    //         // echo "123";
    //         // validateUnLoginRedirect();
    //         checkAjaxAccess('refund','delete');
    //         D(self::$REFUND_MODEL)->dele();
    //         $ajaxReturnData['status']=1;
    //         $ajaxReturnData['message']='操作成功';
    //     }catch(\Exception $e){
    //         $ajaxReturnData['status']=0;
    //         $ajaxReturnData['message']='操作失败'.$e->getMessage();
    //     }
    //     $this->ajaxReturn($ajaxReturnData);
    // }

    //审核页面
    public function review(){
        // validateUnLoginRedirect();
        // checkAccess('refund','review');
        $result=D(self::$REFUND_MODEL)->getResultByConditions(array('id'=>I('get.id')));
        $this->assign('result',$result);
        $this->display();
    }


    //审核
    public function review_do(){
        try{
            // validateUnLoginRedirect();
            // checkAjaxAccess('refund','review');
            $ajaxReturnData['data'] = D(self::$REFUND_MODEL)->review();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

//    public function test()
//    {
//        $result = '1';
//        if(!$user=$result){
//            $ajaxReturnData['status']='没有user';
//        }else{
//            $ajaxReturnData['status']='有user';
//        }
//        $this->ajaxReturn($ajaxReturnData);
//    }

}

    