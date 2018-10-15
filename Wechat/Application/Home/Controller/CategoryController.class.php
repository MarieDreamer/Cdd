<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class CategoryController extends Controller{
	static $CANTEGORY_MODEL='category';
    static $WECHAT_USER_MODEL='WechatUser';

    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    //获取分类
    public function categorylist(){
        try{
            $classification = D(self::$CANTEGORY_MODEL)->categorylist();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$classification;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function getCategory(){
        try{
            $data = D(self::$CANTEGORY_MODEL)->getCategory();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$data;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function getFatherCate(){
        try{
            $data = D(self::$CANTEGORY_MODEL)->getFatherCate();
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