<?php

namespace Home\Model;

use Home\Abstracts\CommonMAbstract;

class WechatUserModel extends CommonMAbstract
{
    public function adds_do($open_id)
    {
        $data = array();
        $data['openid'] = $open_id['openid'];
        $data['status_delete'] = 1;
        $data['create_time'] = time();
        $data['login_time'] = time();
        if (!$user = $this->add($data)) {
            // echo $this->_sql();
            throw new \Exception('OPERATION_FAILED');
        }
        return $user;
    }

    public function login_do($userid)
    {
        $conditions = array();
        $conditions['id'] = $userid;
        $data = array();
        $data['login_time'] = time();
        if($user=$this->where($conditions)->save($data)===false){
            throw new \Exception('OPERATION_FAILED');
        }
    }

    public function save_do()
    {
        extract(generateRequestParamVars());
        $conditions = array();
        $conditions['id'] = $id;
        $data = array();
        $data['nickname']=$nickname;
        $data['imageurl']=$imageurl;
        $data['gender']=$gender;
        $data['province']=$province;
        $data['city']=$city;
        $data['country']=$country;
        if($user=$this->where($conditions)->save($data)===false){
            // echo $this->_sql();
            throw new \Exception('OPERATION_FAILED');
        }
    }

    public function setting_list(){
        extract(generateRequestParamVars());
        $conditions = array();
        $conditions['id'] = $id;
        if($results=$this->where($conditions)->find()===false){
            
            throw new \Exception('OPERATION_FAILED');
        }
        $results=$this->where($conditions)->find();
        return $results;
    }
    public function getBalance(){
        extract(generateRequestParamVars());
        $conditions = [];
        $conditions['id'] = $user_id;
        $conditions['status_delete'] = 1;
        $balance = $this->where($conditions)->select()[0]['balance'];
        return $balance;
    }

}