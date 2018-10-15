<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">    
    <title>后台</title>
    <link href="/Css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="/Css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="/Css/animate.min.css" rel="stylesheet">
    <link href="/Css/style.min.css?v=4.0.0" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/Css/webuploader.css">
    <link rel="stylesheet" type="text/css" href="/Css/diyUpload.css">
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div class="form-horizontal m-t" id="commentForm">
                        <h2><div  class="col-sm-2"></div>订单详情</h2>
                        <div id="order_id" style="display: none;"><?php echo ($order_detail[0]['id']); ?></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">订单编号</label>
                            <div class="col-sm-8">
                                <?php echo ($order_detail[0]['order_number']); ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-8">
                                <?php echo ($order_detail[0]['user_name']); ?>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">收货地址</label>
                            <div class="col-sm-4">
                                <input id="address_region" disabled="disabled" style="width: 250px;" value="<?php echo ($order_detail[0]['address_region']); ?>">
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-success edit">修改</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">收货详细地址</label>
                            <div class="col-sm-4">
                                <input id="address_address" disabled="disabled" style="width: 250px;" value="<?php echo ($order_detail[0]['address_address']); ?>">
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-success edit">修改</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">收货人</label>
                            <div class="col-sm-4">
                                <input id="address_consignee" disabled="disabled" style="width: 250px;" value="<?php echo ($order_detail[0]['address_consignee']); ?>">
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-success edit">修改</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">收货人联系方式</label>
                            <div class="col-sm-4">
                                <input id="address_mobile" disabled="disabled" style="width: 250px;" value="<?php echo ($order_detail[0]['address_mobile']); ?>">
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-success edit">修改</button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">配送方式</label>
                            <div class="col-sm-8">
                                <?php echo ($order_detail[0]['shipping_name']); ?>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">优惠券使用</label>
                            <div class="col-sm-8">
                                <?php echo ($order_detail[0]['coupon_id']); ?>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">买家留言</label>
                            <div class="col-sm-8">
                                <?php echo ($order_detail[0]['user_note']); ?>
                            </div>
                        </div>

                        <?php if(is_array($order_detail[1])): $i = 0; $__LIST__ = $order_detail[1];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><div style="border:2px solid #eee;padding: 20px;border-radius: 10px;margin-bottom: 10px;">
                                
                                <div class="form-group">
                                    <img src="<?php echo ($vo['shop_image']); ?>">
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">商品名称</label>
                                    <div class="col-sm-8">
                                        <?php echo ($vo['shop_name']); ?>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">商品价格</label>
                                    <div class="col-sm-8">
                                        <?php echo ($vo['shop_num']); ?>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">商品数量</label>
                                    <div class="col-sm-8">
                                        <?php echo ($vo['num']); ?>
                                    </div>
                                </div>
                            </div><?php endforeach; endif; else: echo "" ;endif; ?>

                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-3">
                                <a href="/Order/lists"><button class="btn btn-white" type="button">返回</button></a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/Js/jquery.min.js?v=2.1.4"></script>
<script>
    $(document).on('click','.edit',function () {
        $(this).parent().prev().children("input").attr("disabled",false);
        $(this).attr("class","btn btn-primary save");
        $(this).text('保存');
    })

    $(document).on('click','.save',function () {
        $(this).parent().prev().children("input").attr("disabled",true);
        $(this).attr("class","btn btn-success edit");
        $(this).text('修改');

        var order_id = $('#order_id').text();
        var key = $(this).parent().prev().children("input").attr("id");
        var value = $(this).parent().prev().children("input").val();

        $.ajax({
            url:'/Order/editAddress',
            data:{
                "order_id":order_id,
                "key":key,
                "value":value
            },
            type:'post',
            dataType:"json",
            success:function(data){
                console.log('success')
            },
        });

    })
</script>
</body>
</html>