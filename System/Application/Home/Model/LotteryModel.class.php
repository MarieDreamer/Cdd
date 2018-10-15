<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class LotteryModel extends CommonMAbstract {
    
        public function lists(){
            extract(generateRequestParamVars());
            $conditions=array();
            //0是删除 1是显示
            $conditions['status_delete']=1;

            if(!$conditions){
                $count=$this->count();
            }else{
                $count=$this->where($conditions)->count();
            }

            if(!$numPerPage=I('param.numPerPage')){
                $numPerPage=C('NUM_PER_PAGE');
            }

            $page=new \Think\Page($count,$numPerPage);
            $paging=$page->show();

            
            if(!$conditions){
                $results=$this->limit($page->firstRow.','.$page->listRows)->select();
            }else{
                $results=$this->where($conditions)->limit($page->firstRow.','.$page->listRows)->select();
            }
            
            return array($paging,$results);
        }

}