<?php

namespace Home\Model;

use Home\Abstracts\CommonMAbstract;

class LotteryModel extends CommonMAbstract
{
    //获取福彩单号接口
    public function get($arr){
        $count=0;
        $sudo=array();
        foreach ($arr as $key => $value) {
            foreach ($value as $k => $v) {
                $v=$this->DeleteHtml($v);
                preg_match_all('/<td>.*<\/td>/',$v,$v);
                $data=array();
                $data['term_number']=substr($v[0][0],4,6);
                if($data['term_number']!=null){//当期号不为空的时候进行查找
                    $results=$this->where($data)->find();
                    if($results==null){//当数据库中无该期号记录时进行添加数据操作
                        $data['award_number']=substr($v[0][0],19,29);
                        $data['opening_time']=substr($v[0][0],57,15);
                        $data['status_delete']=1;
                        $sudo[$count]['term_number']=$data['term_number'];
                        $sudo[$count]['award_number']=$data['award_number'];
                        $sudo[$count]['opening_time']=$data['opening_time'];
                        $count++;
                        $sudo['count']=$count;
                        if($red=$this->add($data)===false){
                            throw new \Exception('OPERATION_FAILED');
                        }
                    }
                }
            }
        }
        return $sudo;
    }
    function DeleteHtml($str)
    {
        $str = trim($str); //清除字符串两边的空格
        $str = preg_replace("/\t/","",$str); //使用正则表达式替换内容，如：空格，换行，并将替换为空。
        $str = preg_replace("/\r\n/","",$str); 
        $str = preg_replace("/\r/","",$str); 
        $str = preg_replace("/\n/","",$str); 
        $str = preg_replace("/ /","",$str);
        $str = preg_replace("/  /","",$str);  //匹配html中的空格
        return trim($str); //返回字符串
    }
    //免单查询页面列表接口
    public function lists(){
        if($results=$this->find()===false){
            throw new \Exception('OPERATION_FAILED');
        }
        $results=$this->order('term_number desc')->limit(20)->select();
        return $results;
    }
}