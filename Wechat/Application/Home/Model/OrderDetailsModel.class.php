<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class OrderDetailsModel extends CommonMAbstract {

    static $ORDER_MODEL = 'order';

    public function addOrderDetails()
    {
        extract(generateRequestParamVars());
        $shop = json_decode($shop);
        $order_id = D(self::$ORDER_MODEL)->getLastInsID();
        for($i=0;$i<count($shop);$i++){
            $data = [];
            $data['order_id'] = $order_id;
            $data['shop_id'] = (int)$shop[$i][0];
            $data['num'] = (int)$shop[$i][1];
            $data['create_time'] = time();
            $data['status_delete'] = 1;

            if($this->add($data) === false){
                throw new \Exception('订单详情表出错');
            }
        }
    }
}


