<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class CollectionController extends Controller{

    static $COLLECTION_MODEL='collection';
    static $COUPON_MODEL='coupon';
    static $CATEGORY_MODEL='category';
    static $COMMODITY_MODEL='commodity';
    static $WECHAT_USER_MODEL='WechatUser';
    
    public function __construct(){
        parent::__construct();
    }

    //添加收藏
    public function adds_do(){
        try{
            D(self::$COLLECTION_MODEL)->adds();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    // 显示收藏
    public function lists(){
        try{
            $lists = D(self::$COLLECTION_MODEL)->lists();

            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['lists']=$lists;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    // 删除
    public function de_do(){
        try{
            D(self::$COLLECTION_MODEL)->de_do();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

}
