<?php

namespace Home\Controller;

use Think\Controller;

class UserAddressController extends Controller
{
    static $USER_ADDRESS_MODEL = 'UserAddress';
    //调取用户所有地址列表
    public function address_lists(){
        try{
            $results=D(self::$USER_ADDRESS_MODEL)->address_lists();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['data']=$results;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
    //新增地址
    public function adds_do(){
        try{
            D(self::$USER_ADDRESS_MODEL)->adds_do();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //编辑地址
    public function edit_do(){
        try{
            $results=D(self::$USER_ADDRESS_MODEL)->edit_do();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['data']=$results;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //删除地址
    public function delete_do(){
        try{
            D(self::$USER_ADDRESS_MODEL)->delete_do();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //确认订单详情页获取地址接口
    public function get(){
        try{
            $results=D(self::$USER_ADDRESS_MODEL)->get();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['data']=$results;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }
}