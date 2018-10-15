<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class WechatUserModel extends CommonMAbstract {
    //获取role表
    public function get(){
        // extract(generateRequestParamVars());
        $conditions=array();
        $conditions['status_delete']=1;//屏蔽逻辑删除
        $results=$this->where($conditions)->select();
        return $results;
    }
    
    //详细内容修改
    public function edits(){
        extract(generatePostParamVars());
        //正整数正则
        $shuziyz='/^\d+$/';
        if(preg_match($shuziyz, $id) && $content){
            $yzsz=1;
        }
        if($yzsz==1){
        $conditions=array();
        $conditions['id']=$id;
        $data=array();
        $data['content']=$content;
        if($this->where($conditions)->save($data)===false){
           throw new \Exception(L('OPERATION_FAILED'));
        }
        }else{
                throw new \Exception(L('非法数据！'));
            }
    }

    public function dele(){
            extract(generateGetParamVars());
            if(!$id){
                throw new \Exception(L('MISSING_PARAMETER')); ;
            }
            $conditions['id']=intval($id);
            if(!$result=$this->where($conditions)->find()){
                throw new \Exception(L('NO_DATA'));
            }
            $conditions=array();
            $conditions['id']=$id;
            $data=array();
            $data['status_delete']=0;
            if($this->where($conditions)->save($data)===false){
               throw new \Exception(L('OPERATION_FAILED'));
            }
    }      

        // public function lists(){

        //     extract(generateRequestParamVars());

        //     $conditions=array();
        //     // var_dump(array());
        //     $conditions['status_delete']=1;
        //     $results=$this->where($conditions)->select();
        //     echo $this->_sql();
        //     var_dump($results);
        //     // echo($results);
        //     return $results;
        // }

        //微信用户管理页面显示
        public function lists(){
            extract(generateRequestParamVars());
            $conditions=array();
            //0是删除 1是显示
            if($class){
                $conditions['class']=$class;
            }
            $conditions['status_delete']=1;

            if(!$conditions){
                // echo "122212";
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
                $results=$this->order('create_time desc')->limit($page->firstRow.','.$page->listRows)->select();
            }else{
                $results=$this->where($conditions)->order('create_time desc')->limit($page->firstRow.','.$page->listRows)->select();
            }
            
            foreach ($results as $key => $value) {
               foreach ($value as $k => $v) {
               }
            }
            $value1=$value['content'];
            $value1=json_decode(($value1),true);
            foreach ($value1 as $k1 => $v1) {
                foreach ($v1 as $k2 => $v2) {
                }
            }
            // var_dump($results);
            return array($paging,$results);
        }

    
        //修改相册
        public function raedit(){
        extract(generateRequestParamVars());

        //正整数正则
        $shuziyz='/^\d+$/';
        // if($class1 && $content && preg_match($shuziyz, $id)){
        //     $yzsz=1;
        // }
        // if($yzsz==1){
        $data=array();
        $data['album_class']=$album_class;
        $data['name']=$name;
        $data['index_photo']=$index_photo;
        $data['person_num']=$person_num;
        $data['photo_num']=$photo_num;
        $data['status_delete']=1;
        echo "id=";
        echo $id;
        echo "&";
        echo "album_class=";    
        echo $album_class;
        echo "&";
        echo "index_photo=";
        echo $index_photo;
        echo "&";
        echo "person_num=";
        echo $person_num;
        echo "&";
        echo "photo_num=";
        echo $photo_num;
        echo "&";
        echo "status_delete=";
        echo $status_delete;
        echo "&";
        $conditions=array();
        $conditions['id']=$id;
        if(!$this->where($conditions)->save($data)){
            // echo "************";
            // echo $this->_sql();
            throw new \Exception(L('OPERATION_FAILED'));
        }
        // }else{
        //         throw new \Exception(L('， 输入了非法数据！'));
        //     }

    }

    //添加相册
    public function adds(){
        extract(generateRequestParamVars());
        
        
        $data['user_id']=$user_id;
        $data['other_user_id']=$other_user_id;
        $data['album_class']=$album_class;
        $data['name']=$name;
        $data['index_photo']=$index_photo;
        $data['person_num']=$person_num;
        $data['photo_num']=$photo_num;
        $data['create_time']=time();
        $data['status_delete']=1;
        if(!$this->add($data)){
            throw new \Exception(L('OPERATION_FAILED'));
        }
        

    }

    //用户个人信息管理 列表页
    public function lists_user(){

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