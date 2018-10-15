<?php
function clientSignin()
{
    //自动登录
    if (!session('client_id')) {
        try {
            D('Client')->signin();
        } catch (\Exception $e) {
            print_r($e);
            exit('我们碰到了一些问题,请退出重新访问我们!');
            //validateClientUnLoginRedirect();//throw new \Exception('登录失败');
        }
    }
}

/*
 * 已登录 无需执行登录操作
 */
function validateClientIsLoginRedirect($url = '')
{
    if (session('client_id')) {
        if (!$url) {
            $url = '/Home/Hairdresser/lists';
        }
        redirect($url);
        exit();
    }
}

function validateClientIsLoginRedirectAjax($url = '')
{
    if (session('client_id')) {
        if (!$url) {
            $url = '/Home/Hairdresser/lists';
        }
        $ajaxReturn['status_login'] = 1;
        $ajaxReturn['client_id'] = session('client_id');
        $ajaxReturn['redirect_url'] = $url;
        ajaxReturnJsonp($ajaxReturn);
    }
}

/*
 * 未登录 需要登录才能操作
 */
function validateClientUnLoginRedirect($url = '')
{
    if (!session('client_id')) {
        if (!$url) {
            $url = '/Client/signin';
        }
        redirect($url);
    }
}

function validateClientUnLoginRedirectAjax($url = '')
{
    if (!session('client_id')) {
        if (!$url) {
            $url = '/Client/signin';
        }
        $ajaxReturn['status_login'] = 0;
        $ajaxReturn['client_id'] = '';
        $ajaxReturn['redirect_url'] = $url;
        ajaxReturnJsonp($ajaxReturn);
    }
}



function GetWechatOpenId($js_code)
{
    if (!$js_code) {
        throw new \Exception('code参数为null！');
    }

    $url=C('WECHAT_GET_OPEN_ID');
    $wechat_data=C('WECHAT_XCX_DATA');
    $param=array();
    $param[]='appid='.$wechat_data['appid'];
    $param[]='secret='.$wechat_data['appsecret'];
    $param[]='js_code='.$js_code;
    $param[]='grant_type=authorization_code';

    $params=join('&',$param);

    $url=$url.'?'.$params;
    $curl=new \Home\Common\Curl();
    $result=$curl->go($url,'post');

    $result=json_decode($result,true);
    // if($result[0]!='1000'){
    //     //throw new \Exception('系统繁忙，请稍后再试！');
    //     $message=C('SMS_RETURN_MESSAGE');
    //     throw new \Exception($message[$result[0]]);
    // }
    return $result;
}