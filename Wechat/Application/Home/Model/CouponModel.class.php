<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class CouponModel extends CommonMAbstract {

	public function lists(){
		extract(generateRequestParamVars());
		$conditions = [];
		$conditions['user_id'] = $user_id;
		$conditions['status_delete'] = 1;
		if($status == 0 || $status == 1 || $status == 2){
            $conditions['status'] = $status;
        }
	    $lists = $this->where($conditions)->select();
        for($i = 0 ; $i < count($lists); $i ++){
        	$lists[$i]['effective_end_date'] = date('Y-m-d', $lists[$i]['effective_end_date']);
        }
	    return $lists;
	}

    //优惠券改为已使用
    public function changeStatus()
    {
        extract(generateRequestParamVars());
        $conditions = [];
        $conditions['id'] = $coupon_id;
        $data = [];
        $data['status'] = 1;
        if($this->where($conditions)->save($data) === false){
            throw new \Exception('优惠券出错');
        }
	}


	
}


