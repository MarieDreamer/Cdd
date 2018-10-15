<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class CategoryModel extends CommonMAbstract {

	public function categorylist(){
		extract(generateRequestParamVars());
		$conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
        $conditions['pid']=0;
		$classification = $this->where($conditions)->order('id')->select();

		// var_dump($classification);
		return $classification;
	}

	public function getCategory(){
		$conditions = [];
		$conditions['pid'] = 0;
		$conditions['status_delete'] = 1;
		$data = $this->where($conditions)->select();
		for($i=0;$i<count($data);$i++){
			$conditions = [];
			$conditions['pid'] = $data[$i]['id'];
			$data[$i]['child'] = $this->where($conditions)->select();
		}
		return $data;
	}

	public function getFatherCate(){
		$conditions = [];
		$conditions['pid'] = 0;
		$conditions['status_delete'] = 1;
		$data = $this->where($conditions)->select();
		return $data;
	}
	
}
