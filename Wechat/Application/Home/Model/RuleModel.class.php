<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class RuleModel extends CommonMAbstract {

    
	

	public function ruledisplay(){
		extract(generateRequestParamVars());
		$conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
		$rule = $this->where($conditions)->select();

		



		// var_dump($hotlists);
		return $rule;
	}

	
}
