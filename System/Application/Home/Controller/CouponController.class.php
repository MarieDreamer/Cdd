<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class CouponController extends Controller{


    // static $Photo_Album='PhotoAlbum';
    static $COUPON_MODEL='coupon';
    static $WECHAT_USER_MODEL='WechatUser';
    
    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    

    //优惠券管理页面显示
    public function lists(){
        extract(generateRequestParamVars());
        validateUnLoginRedirect();
        checkAccess('coupon','view');
        list($paging, $results) = D(self::$COUPON_MODEL)->lists();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }
    

    //优惠券删除
    public function dele_do(){
        try{
            // echo "123";
            validateUnLoginRedirect();
            checkAjaxAccess('coupon','delete');
            D(self::$COUPON_MODEL)->dele();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //修改优惠券显示
    public function raedit(){
        validateUnLoginRedirect();
        checkAccess('coupon','edit');
        $result=D(self::$COUPON_MODEL)->getResultByConditions(array('id'=>I('get.id')));
        $result['content']=json_decode($result['content'],true);
        $this->assign('result',$result);
        $this->display();
    }


    //修改优惠券
    public function raedit_do(){
        try{
            // echo "123123132";
            validateUnLoginRedirect();
            checkAjaxAccess('coupon','raedit');
            D(self::$COUPON_MODEL)->raedit();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //添加优惠券页显示
    public function adds(){
        validateUnLoginRedirect();
        checkAccess('coupon','adds');
        $this->display();
    }
    //添加优惠券
    public function adds_do(){
        try{
            validateUnLoginRedirect();
            checkAjaxAccess('coupon','add');
            D(self::$COUPON_MODEL)->adds();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    

}

    