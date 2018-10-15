<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class CartModel extends CommonMAbstract {

    static $COMMODITY_MODEL='commodity';

	public function addCart(){
		extract(generateRequestParamVars());
		$conditions = [];
		$conditions['good_id'] = $good_id;
		$conditions['user_id'] = $user_id;
		$conditions['status_delete'] = 1;
		$same = $this->where($conditions)->find();
		if($same){
			$data = [];
			$same['good_num']+=$good_num;
			$data['good_num'] = $same['good_num'];
			$this->where($conditions)->save($data);
		}else{
			$data = [];
			$data['user_id'] = $user_id;
			$data['good_id'] = $good_id;
			$data['good_num'] = $good_num;
			$data['create_time'] = time();

			if($this->add($data) === false){
				throw new \Exception("OPERATION_FAILED");
			}
		}
		
	}

	public function getCart(){
		extract(generateRequestParamVars());
		$conditions = [];
		$conditions['user_id'] = $user_id;
		$conditions['status_delete'] = 1;
		$data = $this->where($conditions)->order('create_time desc')->select();
		for($i=0; $i<count($data); $i++){
			$conditions = [];
			$conditions['id'] = $data[$i]['good_id'];
			$good_detail = D(self::$COMMODITY_MODEL)->where($conditions)->find();
			$data[$i]['good_name'] = $good_detail['shop_name'];
			$data[$i]['good_img'] = json_decode($good_detail['shop_index_image'])[0];
			$data[$i]['member_goods_price'] = $good_detail['shop_price'];
		}
		return $data;
	}

	public function delCart(){
		extract(generateRequestParamVars());
		$conditions = [];
		$conditions['id'] = $id;
		$conditions['status_delete'] = 1;
		$data=[];
		$data['status_delete'] = 0;
		if($this->where($conditions)->save($data) === false){
			throw new \Exception("OPERATION_FAILED");
		}
		
	}

    public function delCartInArray()
    {
        extract(generateRequestParamVars());
        $cartList = json_decode($cartList);
        for($i = 0; $i < count($cartList); $i ++){
            $conditions = [];
            $conditions['id'] = $cartList[$i]->id;
            $data = [];
            $data['status_delete'] = 0;
            if($this->where($conditions)->save($data) === false){
                throw new \Exception('购物车表出错');
            }
        }
	}
	
}
