<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class RuleController extends Controller{

    static $RULE_MODEL='rule';
    
    public function __construct(){
        parent::__construct();
    }


    //热卖显示
    public function ruledisplay(){
        try{
            $rule = D(self::$RULE_MODEL)->ruledisplay();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
            $ajaxReturnData['data']=$rule;
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
        
    }

    

}
