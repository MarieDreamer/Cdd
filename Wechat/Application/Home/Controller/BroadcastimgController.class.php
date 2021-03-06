<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class BroadcastimgController extends Controller{

    static $BROADCASTIMG_MODEL='broadcastimg';
    static $COUPON_MODEL='coupon';
    static $CATEGORY_MODEL='category';
    static $COMMODITY_MODEL='commodity';
    static $WECHAT_USER_MODEL='WechatUser';
    
    public function __construct(){
        parent::__construct();
    }

    //搜索
    public function commoditysearchlist(){
        try{
            $commoditysearchlist = D(self::$COMMODITY_MODEL)->commoditysearchlist();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$commoditysearchlist;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //热卖显示
    public function index(){
        try{
            $results = D(self::$BROADCASTIMG_MODEL)->index();

            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$results;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
        
        
    }

    public function getLists(){
        try{
            $data = D(self::$COMMODITY_MODEL)->getLists();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$data;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function getDetail(){
        try{
            $data = D(self::$COMMODITY_MODEL)->getDetail();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$data;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败,'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

}
