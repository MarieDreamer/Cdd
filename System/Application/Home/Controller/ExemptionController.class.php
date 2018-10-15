<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class ExemptionController extends Controller{


    // static $Photo_Album='PhotoAlbum';
    static $COUPON_MODEL='coupon';
    static $WECHAT_USER_MODEL='WechatUser';
    static $ORDER_MODEL='Order';
    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    public function lists(){
        validateUnLoginRedirect();
    	list($paging, $results) = D(self::$ORDER_MODEL)->free_get();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }
    
}

    