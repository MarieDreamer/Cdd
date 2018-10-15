<?php

namespace Home\Model;

use Home\Abstracts\CommonMAbstract;

class UserAddressModel extends CommonMAbstract
{
	//地址列表页
    public function address_lists(){
        extract(generateRequestParamVars());
        $conditions = array();
        if($userid){
            $conditions['userid'] = $userid;
        }
        if($is_default == 1){
            $conditions['is_default'] = $is_default;
        }
        if($id){
            $conditions['id'] = $id;
        }
        $conditions['status_delete'] = 1;
        if($results=$this->where($conditions)->select()===false){
            
            throw new \Exception('OPERATION_FAILED');
        }
        $results=$this->where($conditions)->select();
        return $results;
    }

    //新增地址
    public function adds_do(){
        extract(generateRequestParamVars());
        $conditions = array();
        $conditions['userid'] = $userid;//用户id
        $data=array();
        $data['userid'] = $userid;
        $data['consignee']=$consignee;//收货人
        $data['mobile']=$mobile;//手机号码
        $data['region']=$region;//所在地区
        $data['address']=$address;//详细地址
        $data['is_default']=$is_default;//详细地址
        $data['status_delete']=1;
        $data['create_time']=time();
        if($is_default==1){
        	$sudo=$this->where($conditions)->select();//查询到该用户所有地址将默认地址字段改为0
        	foreach ($sudo as $key => $value) {
    			$condition=array();
    			$condition['id']=$value['id'];
    			$data1['is_default']=0;
    			$this->where($condition)->save($data1);
    		}
        }
        if($results=$this->where($conditions)->add($data)===false){
        	echo $this->_sql();
            throw new \Exception('OPERATION_FAILED');
        }
    }
    //修改详细地址
    public function edit_do(){
    	extract(generateRequestParamVars());
    	$conditions=array();
    	$conditions['id'] = $id;
    	if($results=$this->where($conditions)->find()===false){
        	echo $this->_sql();
            throw new \Exception('OPERATION_FAILED');
        }
        if($edit){
        	$data=array();
	        $data['userid'] = $userid;
	        $data['consignee']=$consignee;//收货人
	        $data['mobile']=$mobile;//手机号码
	        $data['region']=$region;//所在地区
	        $data['address']=$address;//详细地址
	        $data['is_default']=$is_default;//详细地址
			$data['create_time']=time();
			if($is_default==1){
				$cdit=array();
				$cdit['userid']=$userid;
	        	$sudo=$this->where($cdit)->select();
	        	foreach ($sudo as $key => $value) {
	    			$condition=array();
	    			$condition['id']=$value['id'];
	    			$data1['is_default']=0;
	    			$this->where($condition)->save($data1);
	    		}
	        }
			if($rs=$this->where($conditions)->save($data)===false){
	        	echo $this->_sql();
	            throw new \Exception('OPERATION_FAILED');
	        }
        }
        $results=$this->where($conditions)->find();
        return $results;
    }
    //删除地址
    public function delete_do(){
    	extract(generateRequestParamVars());
    	$conditions=array();
    	$conditions['id'] = $id;
        $data=array();
        $data['status_delete'] = 0;
		if($rs=$this->where($conditions)->save($data)===false){
        	echo $this->_sql();
            throw new \Exception('OPERATION_FAILED');
        }
    }
    //确认订单详情页获取地址接口
    public function get(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['id'] = $id;
        if($results=$this->where($conditions)->find()===false){
            throw new \Exception('OPERATION_FAILED');
        }
        $results=$this->where($conditions)->find();
        return $results;
    }
    
}