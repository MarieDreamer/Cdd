<?php
namespace Home\Model;
use Home\Abstracts\CommonMAbstract;

class BroadcastimgModel extends CommonMAbstract {
    //获取role表
    public function get(){
        extract(generateRequestParamVars());
        $conditions=array();
        $conditions['status_delete']=1;//屏蔽逻辑删除
        $conditions['pid']=0;
        $results=$this->where($conditions)->select();
        return $results;
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


        //商品管理页面显示
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
                $results=$this->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
            }else{
                $results=$this->where($conditions)->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
            }
            
            return array($paging,$results);
        }

        //火热商品页面显示
        public function hotlists(){
            extract(generateRequestParamVars());
            
            $conditions=array();
            //0是删除 1是显示
            $conditions['status_delete']=1;
            $conditions['hot']=1;
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
                $results=$this->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
            }else{
                $results=$this->where($conditions)->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
            }
            
            
            
            
            //商品类别名称赋予
            foreach ($results as $key => $value) {
                $conditions=array();
                $conditions['id']=$results[$key]['pid'];
                $result=D('Category')->where($conditions)->find();
                $name=$result['name'];
                $results[$key]['pid']=$name;
            }

            foreach ($results as $key => $value) {
                $conditions=array();
                $conditions['id']=$results[$key]['shop_type'];
                
                if($results[$key]['shop_type']==0){
                    $results[$key]['shop_type']="父类";
                }else{
                    $result=D('Category')->where($conditions)->find();
                    $name=$result['name'];
                    $results[$key]['shop_type']=$name;
                }
                // $results[$key]['pid']=$name;
                // var_dump($results[$key]['hot']);
                if($results[$key]['hot']==1){
                    $results[$key]['hot']="撤销火热";
                }else{
                    $results[$key]['hot']="更改为火热";
                }

                
            }

            
            return array($paging,$results);
        }

        //火热商品页面显示
        public function recommendlists(){
            extract(generateRequestParamVars());
            
            $conditions=array();
            //0是删除 1是显示
            $conditions['status_delete']=1;
            $conditions['recommend']=1;
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
                $results=$this->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
            }else{
                $results=$this->where($conditions)->order('id desc')->limit($page->firstRow.','.$page->listRows)->select();
            }
            
            
            //商品类别名称赋予
            foreach ($results as $key => $value) {
                $conditions=array();
                $conditions['id']=$results[$key]['pid'];
                $result=D('Category')->where($conditions)->find();
                $name=$result['name'];
                $results[$key]['pid']=$name;
            }

            foreach ($results as $key => $value) {
                $conditions=array();
                $conditions['id']=$results[$key]['shop_type'];
                
                if($results[$key]['shop_type']==0){
                    $results[$key]['shop_type']="父类";
                }else{
                    $result=D('Category')->where($conditions)->find();
                    $name=$result['name'];
                    $results[$key]['shop_type']=$name;
                }
                // $results[$key]['pid']=$name;
                // var_dump($results[$key]['hot']);
                if($results[$key]['recommend']==1){
                    $results[$key]['recommend']="撤销推荐";
                }else{
                    $results[$key]['recommend']="更改为推荐";
                }
                
            }

            
            return array($paging,$results);
        }

    
        //修改类目
        public function raedit(){
            extract(generateRequestParamVars());
        //正整数正则
        $shuziyz='/^\d+$/';
        if(!$url){
            $url="空";
        }
        if($image_url){
            if(preg_match($shuziyz, $class)){
                $data=array();
                $data['img']=json_encode($image_url);
                $data['url']=$url;
                $data['class']=$class;
                $data['modify_time']=time();
                $conditions=array();
                    $conditions['id']=$id;
                    if(!$this->where($conditions)->save($data)){
                        echo $this->_sql();
                        throw new \Exception(L('OPERATION_FAILED'));
                    }
            }else{
                throw new \Exception(L('数据不合法'));
            }
        }else{
            throw new \Exception(L('缺少数据'));
            }

            
        }

        public function hotchange(){
            extract(generateRequestParamVars());
            //正整数正则
            $shuziyz='/^\d+$/';

            $data=array();
            if($hotzt=="撤销火热"){
                $data['hot']=0;
            }else{
                $data['hot']=1;
            }
            $conditions=array();
            $conditions['id']=$id;
            if(!$this->where($conditions)->save($data)){
                // echo $this->_sql();
                throw new \Exception(L('OPERATION_FAILED'));
            }
        }

        public function recommendchange(){
            extract(generateRequestParamVars());
            //正整数正则
            $shuziyz='/^\d+$/';

            $data=array();
            if($recommendzt=="撤销推荐"){
                $data['recommend']=0;
            }else{
                $data['recommend']=1;
            }
            $conditions=array();
            $conditions['id']=$id;
            if(!$this->where($conditions)->save($data)){
                // echo $this->_sql();
                throw new \Exception(L('OPERATION_FAILED'));
            }
        }

    //添加图片
    public function adds(){
        extract(generateRequestParamVars());
        //正整数正则
        $shuziyz='/^\d+$/';
        if(!$url){
            $url="空";
        }
        if($image_url){
            if(preg_match($shuziyz, $class)){
                $data=array();
                $data['img']=json_encode($image_url);
                $data['url']=$url;
                $data['class']=$class;
                $data['status_delete']=1;
                $data['create_time']=time();
                $data['modify_time']=time();
                if(!$this->add($data)){
                    echo $this->_sql();
                    throw new \Exception(L('OPERATION_FAILED'));
                }
            }else{
                throw new \Exception(L('数据不合法'));
            }
        }else{
            throw new \Exception(L('缺少数据'));
            }
        
    }

    public function photoview(){
            extract(generateRequestParamVars());
            $conditions=array();
            //0是删除 1是显示
            
            $conditions['status_delete']=1;
            $conditions['album_id']=$id;

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
                $conditions=array();
                $conditions['id']=$results[$key]['user_id'];
                $result=D('WechatUser')->where($conditions)->find();
                $nick_name=$result['nickname'];
                $results[$key]['user_id']=$nick_name;
            }

            //相册名字赋给相册id
            foreach ($results as $k => $v) {
                $conditions=array();
                $conditions['id']=$results[$k]['album_id'];
                $result=D('PhotoAlbum')->where($conditions)->find();
                $albumname=$result['name'];
                $results[$k]['album_id']=$albumname;
            }

            return array($paging,$results);
        }

        public function userphotoview(){
            extract(generateRequestParamVars());
            $conditions=array();
            //0是删除 1是显示
            
            $conditions['status_delete']=1;
            $conditions['user_id']=$id;

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
                $conditions=array();
                $conditions['id']=$results[$key]['user_id'];
                $result=D('WechatUser')->where($conditions)->find();
                $nick_name=$result['nickname'];
                $results[$key]['user_id']=$nick_name;
            }

            //相册名字赋给相册id
            foreach ($results as $k => $v) {
                $conditions=array();
                $conditions['id']=$results[$k]['album_id'];
                $result=D('PhotoAlbum')->where($conditions)->find();
                $albumname=$result['name'];
                $results[$k]['album_id']=$albumname;
            }

            return array($paging,$results);
        }

}