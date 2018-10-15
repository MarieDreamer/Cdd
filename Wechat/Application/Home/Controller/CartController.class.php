<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class CartController extends Controller{

    static $COMMODITY_MODEL='commodity';
    static $CART_MODEL='cart';

    public function __construct(){
        parent::__construct();
    }

    public function addCart(){
        $model = new Model();
        $model->startTrans();
        $flag = false;
        try{
            D(self::$CART_MODEL)->addCart();
            D(self::$COMMODITY_MODEL)->minusNum();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message']='操作成功';
            $flag = true;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败：'.$e->getMessage();
            $flag = false;
        }
        if($flag){
            $model->commit();
        }else{
            $model->rollback();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function getCart(){
        try{
            $data = D(self::$CART_MODEL)->getCart();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$data;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败：'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    public function delCart(){
        $model = new Model();
        $model->startTrans();
        $flag=false;
        try{
            D(self::$CART_MODEL)->delCart();
            D(self::$COMMODITY_MODEL)->addNum();
            $data = D(self::$CART_MODEL)->getCart();
            $ajaxReturnData['status'] = 1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$data;
            $flag=true;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败：'.$e->getMessage();
            $flag=false;
        }
        if($flag){
            $model->commit();
        }else{
            $model->rollback();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
}