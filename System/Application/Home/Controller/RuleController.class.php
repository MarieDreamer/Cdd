<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class RuleController extends Controller{

    static $RULE_MODEL='rule';
    
    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    

    //规则管理页面显示
    public function lists(){
        extract(generateRequestParamVars());
        validateUnLoginRedirect();
        checkAccess('commodity','view');
        list($paging, $results) = D(self::$RULE_MODEL)->lists();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }


    //规则删除
    public function dele_do(){
        try{
            // echo "123";
            validateUnLoginRedirect();
            checkAjaxAccess('commodity','delete');
            D(self::$RULE_MODEL)->dele();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    //修改规则页面显示
    public function raedit(){
        validateUnLoginRedirect();
        checkAccess('category','edit');
        $result=D(self::$RULE_MODEL)->getResultByConditions(array('id'=>I('get.id')));
        // var_dump($category);
        $this->assign('category',$category);
        $this->assign('result',$result);
        $this->display();
    }


    //修改规则
    public function raedit_do(){
        try{
            // echo "123123132";
            checkAjaxAccess('commodity','raedit');
            D(self::$RULE_MODEL)->raedit();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }



    //添加规则页面显示
    public function adds(){
        validateUnLoginRedirect();
        checkAccess('category','adds');
        $category=D(self::$RULE_MODEL)->get();
        // var_dump($category);
        $this->assign('category',$category);
        $this->display();
    }
    //添加规则
    public function adds_do(){
        try{
            validateUnLoginRedirect();
            D(self::$RULE_MODEL)->adds();
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
    }

    
}

    