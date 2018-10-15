<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class RefundModel extends CommonMAbstract {

	public function addRefund(){
		extract(generateRequestParamVars());
		if(!$user_id || !$money){
			throw new \Exception('参数出错');
		}
		$data = [];
		$data['user_id'] = $user_id;
		$data['money'] = $money;
		$data['status'] = 0;
		$data['create_time'] = time();
		$data['review_time'] = 0;
		if($this->add($data)===false){
			throw new \Exception(L('OPERATION_FAILED'));
		}
	}

	public function checkRefund(){
		extract(generateRequestParamVars());
		if(!user_id){
			throw new \Exception('参数出错');
		}
		$conditions = [];
		$conditions['user_id'] = $user_id;
		$conditions['status'] = 0;
		$result = $this->where($conditions)->find();
		return $result;
	}
	
}
