<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class AccountModel extends CommonMAbstract {

	public function getUserAccount(){
		extract(generateRequestParamVars());
		$conditions = [];
		$conditions['user_id'] = $user_id;
		$data = $this->where($conditions)->order('create_time desc')->select();
		for($i = 0 ; $i < count($data); $i ++){
			$data[$i]['create_time'] = date('Y-m-d H:i:s', $data[$i]['create_time']);
			if($data[$i]['money']>0){
				$data[$i]['money'] = '+' . $data[$i]['money'];
			}
		}
		return $data;
	}
	
}
