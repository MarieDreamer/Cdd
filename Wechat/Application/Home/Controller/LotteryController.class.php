<?php

namespace Home\Controller;

use Think\Controller;

class LotteryController extends Controller
{
    static $LOTTERY_MODEL='Lottery';
    static $ORDER_MODEL='Order';
    //获取福彩单号接口
    public function get(){
        $szUrl = "http://www.bwlc.net/bulletin/trax.html?page=1";
        $UserAgent = 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.0.04506; .NET CLR 3.5.21022; .NET CLR 1.0.3705; .NET CLR 1.1.4322)';
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $szUrl);
        curl_setopt($curl, CURLOPT_HEADER, 0);  //0表示不输出Header，1表示输出
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_ENCODING, '');
        curl_setopt($curl, CURLOPT_USERAGENT, $UserAgent);
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
        $data = curl_exec($curl); 
        preg_match_all('/<tr.*>\n.*\n.*\n.*\n.*<\/tr>/',$data,$arr);
        // echo $data;  //网页源代码
        // var_dump($arr); //正则截取后的字符串
        // exit;
        try{
            $sudo=D(self::$LOTTERY_MODEL)->get($arr);
            if($sudo){
                D(self::$ORDER_MODEL)->Settlement($sudo);//免单结算
            }
            $ajaxReturnData['status']=1;
            $ajaxReturnData['message']='操作成功';
        }catch(\Exception $e){
            $ajaxReturnData['status']=0;
            $ajaxReturnData['message']='操作失败'.$e->getMessage();
        }
        $this->ajaxReturn($ajaxReturnData);
        //echo curl_errno($curl); //返回0时表示程序执行成功 如何从curl_errno返回值获取错误信息
        exit();
    }
    //免单查询页面列表接口
    public function lists(){
        try{
            $results=D(self::$LOTTERY_MODEL)->lists();
            foreach ($results as $key => $value) {
                $results[$key]['award_number']=str_replace(',', '', $results[$key]['award_number']);
                $results[$key]['last_number']=substr($results[$key]['award_number'],19,1);
            }
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