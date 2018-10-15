<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class UserController extends Controller{

    static $WECHAT_USER_MODEL='WechatUser';
    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    //用户个人信息管理 列表页
    public function lists(){
        validateUnLoginRedirect();
        list($paging, $results) = D(self::$WECHAT_USER_MODEL)->lists_user();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }
}