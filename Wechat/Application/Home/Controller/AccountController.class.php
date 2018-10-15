<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class AccountController extends Controller{
	static $ACCOUNT_MODEL='account';
    static $WECHAT_USER_MODEL='WechatUser';

    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    public function getUserAccount(){
        try{
            extract(generateRequestParamVars());
            $data = D(self::$ACCOUNT_MODEL)->getUserAccount();
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