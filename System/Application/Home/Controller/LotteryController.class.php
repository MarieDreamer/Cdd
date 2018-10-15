<?php
namespace Home\Controller;
use Think\Controller;
use Think\Model;

class LotteryController extends Controller{


    static $LOTTERY_MODEL='Lottery';
    
    public function __construct(){
        // validateUnLoginRedirect();
        parent::__construct();
    }

    //彩票信息展示 列表页
    public function lists(){
        validateUnLoginRedirect();
        list($paging, $results) = D(self::$LOTTERY_MODEL)->lists();
        $this->assign('paging', $paging);
        $this->assign('results', $results);
        $this->display();
    }

}

    