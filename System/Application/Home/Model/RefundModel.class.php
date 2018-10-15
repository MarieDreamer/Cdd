<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class RefundModel extends CommonMAbstract {

    static $WECHAT_USER = 'wechat_user';

    //退款申请页面显示
    public function lists(){
        extract(generateRequestParamVars());
        if(!$status){
            $count=$this->count();
        }else{
            $conditions=array();        
            $conditions['status']=$status;
            $count=$this->where($conditions)->count();
        }

        if(!$numPerPage=I('param.numPerPage')){
            $numPerPage=C('NUM_PER_PAGE');
        }

        $page=new \Think\Page($count,$numPerPage);
        $paging=$page->show();

        if(!$status){
            $results=$this->order('create_time desc')->limit($page->firstRow.','.$page->listRows)->select();
        }else{
            $conditions=array();        
            $conditions['status']=$status;
            $results=$this->where($conditions)->order('create_time desc')->limit($page->firstRow.','.$page->listRows)->select();
        }

        foreach ($results as $key => $value) {
            $result=D('WechatUser')->where($conditions)->find($results[$key]['user_id']);
            $results[$key]['user_id']=$result['nickname'];
            $str = '';
            switch ($results[$key]['status']) {
                case 0:
                    $str='待审核';
                    break;
                case 1:
                    $str='通过';
                    break;
                case 2:
                    $str='未通过';
                    break;
            }
            $results[$key]['status_name']=$str;
            if($results[$key]['review_time'] == 0){
                $results[$key]['review_time'] = '';
            }else{
                $results[$key]['review_time'] = date('Y-m-d H:i:s',$results[$key]['review_time']);
            }
        }

        return array($paging,$results);
    } 

    public function review(){
        extract(generateRequestParamVars());
//        $conditions = [];
//        $conditions['id'] = $id;
//        $data = [];
//        $data['status'] = $status;
//        if($status == 2){
//            $data['note'] = $note;
//        }
//        $data['review_time'] = time();
//        if($this->where($conditions)->save($data)===false){
//            throw new \Exception(L('OPERATION_FAILED'));
//        }

        //退款操作
//        if($status == 1){

            require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Api.php';
            require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Data.php';
            require_once C('APPLICATION_DIR') . '/Home/Libs/WechatPay/lib/WxPay.Config.php';
            require_once C('APPLICATION_DIR') . '/Home/Libs/WxPayPubHelper.php';
            $refund = $this->find($id);
            $user_id = $refund['user_id'];
            $wechat_user = D(self::$WECHAT_USER)->find($user_id);
            $openid = $wechat_user['openid'];
            $trade_no = $refund['refund_number'];

            $data = array(
                'mch_appid' => \WxPayConfig::APPID,
                'mchid'     => \WxPayConfig::MCHID,
                'nonce_str' => \WxPayApi::getNonceStr(),
                'partner_trade_no' => $trade_no, //商户订单号，需要唯一
                'openid'    => $openid,
                'check_name'=> 'NO_CHECK', //OPTION_CHECK不强制校验真实姓名, FORCE_CHECK：强制 NO_CHECK：
                'amount'    => 100,
                'desc'      => '商户退款',
                'spbill_create_ip' => '59.110.142.107'
            );
            $sign = new \WxPayDataBase();
            $data['sign'] = $sign->makeSigns($data);
            $xmldata = \Common_util_pub::arrayToXml($data);
            $url = 'https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers';

            //发送post请求
//            $res = curl_post_ssl($url,'merchantid=1495735442');
//            $res = \Common_util_pub::postXmlCurl($xmldata,$url);
            $res = postXmlCurl($xmldata,$url);

            if(!$res){
                return array('status'=>1, 'msg'=>"Can't connect the server" );
            }

            return \Common_util_pub::xmlToArray($res);

//        }



    }

}