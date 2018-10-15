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
                        <h2><div  class="col-sm-2"></div>提现审核</h2>
                        
                        <div class="form-group">
                            <label class="col-sm-2 control-label">审核状态修改：</label>
                            <div class="col-sm-8">
                                <select class="form-control department" name="name" id="review"/>
                                        <option id="pass" value ="1">通过</option>
                                        <option id="fail" value ="2">不通过</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group" id="note" style="display:none;">
                            <label class="col-sm-2 control-label">审核备注：</label>
                            <div class="col-sm-8">
                                <input id="note_content" type="text" size="30" name="class1" size="80" minlength="6" maxlength="60" class="form-control"/>
                            </div>
                        </div>

                        <script>
                            var fail = document.getElementById('fail');
                            var pass = document.getElementById('pass');

                            fail.onclick = function(){
                                $('#note').show();
                            }
                            pass.onclick = function(){
                                $('#note').hide();
                            }
                        </script>
                        
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-3">
                                <input type="hidden" id='id' value="<?php echo I('param.id');?>">
                                <button class="btn btn-primary" type="button" id="adds">提交</button>
                                <a href="/Refund/lists"><button class="btn btn-white" type="button">取消</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/Js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript">
    $(document).on('click','#adds',function(){
        var id=$('#id').val();
        var note=$('#note_content').val();
        var status=$('#review option:selected').val();
        
        $.ajax({
            url:'/Refund/review_do', 
            data:{
                "id":id,
                "note":note,
                "status":status
            },
            type:'post',
            dataType:"json",
            success:function(data){
                if(data.status){
                    alert('编辑成功');
                    window.location="/Refund/lists";
                }else{
                    alert(data.message)
                }
            }
        });
    })
</script>
</body>
</html>