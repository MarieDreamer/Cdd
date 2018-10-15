<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class BroadcastimgModel extends CommonMAbstract {

    public function index(){
        extract(generateRequestParamVars());
        $conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
        $results = $this->where($conditions)->order('id desc')->select();

        foreach ($results as $key => $value) {
            $results[$key]['img']=json_decode($results[$key]['img']);
            }
            
        return $results;
    }

    //搜索
    public function commoditysearchlist(){
        extract(generateRequestParamVars());
        $conditions=array();
        //0是删除 1是显示
        $conditions['status_delete']=1;
        if($searchname){
            $conditions['shop_name']=array('like','%'.$searchname.'%');
        }
        if($classname){
            $conditions['pid']=$classname;
        }
        // $conditions['album_id']=$album_id;
        if($shopsale==1){
            $order='shop_sale desc';
        }elseif ($shopsale==2) {
            $order='shop_price desc';
        }elseif ($shopsale==3) {
            $order='shop_price';
        }else{
            $order='id desc';
        }
        $count=$this->where($conditions)->count();
        $numPerPage=6;
        $page=new \Think\Page($count,$numPerPage);
        $paging=$page->show();
        $results=$this->where($conditions)->order($order)->limit($page->firstRow.','.$page->listRows)->select();
        // var_dump($results);

        foreach ($results as $key => $value) {
            $conditions=array();
            $conditions['id']=$results[$key]['pid'];
            $result=D('Category')->where($conditions)->find();
            $name=$result['name'];
            $hotlists[$key]['pid']=$name;
        }
        foreach ($results as $key => $value) {
            $conditions=array();
            $conditions['id']=$results[$key]['shop_type'];
            
            if($results[$key]['shop_type']==0){
                $results[$key]['shop_type']="";
            }else{
                $result=D('Category')->where($conditions)->find();
                $name=$result['name'];
                $results[$key]['shop_type']=$name;
            }
            // var_dump(json_decode($results[$key]['shop_index_image']));
            // var_dump(json_decode($results[$key]['shop_index_image'][0]));
            $results[$key]['shop_index_image']=json_decode($results[$key]['shop_index_image']);
            // $results[$key]['shop_index_image']=$results[$key]['shop_index_image'][0]
            $results[$key]['shop_index_image']=($results[$key]['shop_index_image'][0]);
            $results[$key]['shop_image']=json_decode($results[$key]['shop_image']);
        }
        return array($paging,$results);
    }

	public function getLists(){
		extract(generateRequestParamVars());
		$conditions = [];
		// $conditions['status_delete'] = 1;
        //如果有分类
        if($shop_type){
            $conditions['shop_type'] = $shop_type;
        }
        //如果有关键词
        if($key){
            $conditions['shop_name']=array('like','%'.$key.'%');
        }
        //如果有排序
		if($sort == 'shop_sale'){
			$order = 'shop_sale desc';
		}else if($sort == 'shop_price'){
			$order = $sort .' ' .$sort_asc;
		}else if($sort == 'shop_id'){
			$order = 'shop_id desc';
		}else{
			$order = '';
		}
		$data = $this->where($conditions)->order($order)->select();
		return $data;
	}

    public function getDetail(){
        extract(generateRequestParamVars());
        $data = $this->find($id);
        $data['shop_index_image'] = json_decode($data['shop_index_image']);
        $data['shop_image'] = json_decode($data['shop_image']);
        return $data;
    }
	

	public function hotlists(){
		extract(generateRequestParamVars());
		$conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
        $conditions['hot']=1;
		$hotlists = $this->where($conditions)->order('id desc')->select();

		foreach ($hotlists as $key => $value) {
            $conditions=array();
            $conditions['id']=$hotlists[$key]['pid'];
            $result=D('Category')->where($conditions)->find();
            $name=$result['name'];
            $hotlists[$key]['pid']=$name;
        }

        foreach ($hotlists as $key => $value) {
            $conditions=array();
            $conditions['id']=$hotlists[$key]['shop_type'];
            
            if($hotlists[$key]['shop_type']==0){
                $hotlists[$key]['shop_type']="";
            }else{
                $result=D('Category')->where($conditions)->find();
                $name=$result['name'];
                $hotlists[$key]['shop_type']=$name;
            }

            $hotlists[$key]['shop_index_image']=json_decode($hotlists[$key]['shop_index_image']);
            $hotlists[$key]['shop_index_image']=($hotlists[$key]['shop_index_image'][0]);
            $hotlists[$key]['shop_image']=json_decode($hotlists[$key]['shop_image']);
        }



		// var_dump($hotlists);
		return $hotlists;
	}

	public function recommend(){
		extract(generateRequestParamVars());
		$conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
        $conditions['recommend']=1;
		$recommend = $this->where($conditions)->order('id desc')->select();

		
        foreach ($recommend as $key => $value) {
            $conditions=array();
            $conditions['id']=$recommend[$key]['pid'];
            $result=D('Category')->where($conditions)->find();
            $name=$result['name'];
            $recommend[$key]['pid']=$name;
        }

        foreach ($recommend as $key => $value) {
            $conditions=array();
            $conditions['id']=$recommend[$key]['shop_type'];
            
            if($recommend[$key]['shop_type']==0){
                $recommend[$key]['shop_type']="";
            }else{
                $result=D('Category')->where($conditions)->find();
                $name=$result['name'];
                $recommend[$key]['shop_type']=$name;
            }

            $recommend[$key]['shop_index_image']=json_decode($recommend[$key]['shop_index_image']);
            $recommend[$key]['shop_index_image']=($recommend[$key]['shop_index_image'][0]);
            $recommend[$key]['shop_image']=json_decode($recommend[$key]['shop_image']);
        }

		// var_dump($hotlists);
		return $recommend;
	}
}
