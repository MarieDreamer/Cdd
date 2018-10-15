<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class CollectionModel extends CommonMAbstract {

    public function adds(){
        extract(generateRequestParamVars());
        //正整数正则
        $conditions=array();
        $conditions['userid']=$userid;
        $result=D('collection')->where($conditions)->find();
        if($userid && $commodityid){
            $conditions=array();
            $conditions['userid']=$userid;
            $conditions['commodityid']=$commodityid;
            $result=D('collection')->where($conditions)->find();
            if($result[id]){
                throw new \Exception(L('已有收藏'));
                }else{
                    $shuziyz='/^\d+$/';
                    $data=array();
                    $data['userid']=$userid;
                    $data['commodityid']=$commodityid;
                    $data['shop_name']="";
                    $data['shop_index_image']="";
                    $data['shop_price']="";
                    $data['status_delete']=1;
                    $data['create_time']=time();
                    if(!$this->add($data)){
                        // echo $this->_sql();
                    throw new \Exception(L('OPERATION_FAILED'));
                }
            }
        }
    }

    public function lists(){
        extract(generateRequestParamVars());
        $conditions=[];
        //0是删除 1是显示
        $conditions['status_delete']=1;
        $conditions['userid']=$userid;
        $lists = $this->where($conditions)->order('id desc')->select();

        
        foreach ($lists as $key => $value) {
            $conditions=array();
            $conditions['id']=$lists[$key]['commodityid'];
            $result=D('Commodity')->where($conditions)->find();
            $shop_name=$result['shop_name'];
            $lists[$key]['shop_name']=$shop_name;

            $shop_index_image=$result['shop_index_image'];
            $lists[$key]['shop_index_image']=json_decode($shop_index_image);
            $lists[$key]['shop_index_image']=$lists[$key]['shop_index_image'][0];

            $shop_price=$result['shop_price'];
            $lists[$key]['shop_price']=$shop_price;
        }


        // var_dump($hotlists);
        return $lists;
    }

    public function de_do(){
        extract(generateRequestParamVars());
        //正整数正则
        if($commodityid){
                    $data['status_delete']=0;
                    $conditions=array();
                    $conditions['commodityid']=$commodityid;
                    $conditions['userid']=$userid;
                    if(!$this->where($conditions)->save($data)){
                        // echo $this->_sql();
                    throw new \Exception(L('OPERATION_FAILED'));
                }
        }else{
            throw new \Exception(L('缺少数据'));
        }
    }
        
    
}
