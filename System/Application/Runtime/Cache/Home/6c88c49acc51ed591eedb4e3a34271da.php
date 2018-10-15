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
                        <h2><div  class="col-sm-2"></div>添加相册</h2>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户id</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="class1" size="80" minlength="6" maxlength="60" class="form-control"  id="user_id" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">其他用户id</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="class1" size="80" minlength="6" maxlength="60" class="form-control"  id="other_user_id" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">相册类型</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="class1" size="80" minlength="6" maxlength="60" class="form-control"  id="album_class" value="<?php echo $result['album_class'];?>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">相册名字</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="shudu_levels" size="80" minlength="6" maxlength="60" class="form-control"  id="name" value="<?php echo $result['name'];?>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">首页图片</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="shudu_levels" size="80" minlength="6" maxlength="60" class="form-control"  id="index_photo" value="<?php echo $result['index_photo'];?>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户人数</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="shudu_levels" size="80" minlength="6" maxlength="60" class="form-control"  id="person_num" value="<?php echo $result['person_num'];?>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">图片数</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="shudu_levels" size="80" minlength="6" maxlength="60" class="form-control"  id="photo_num" value="<?php echo $result['photo_num'];?>"/>
                            </div>
                        </div>
                        <!-- <div class="form-group">
                            <label class="col-sm-2 control-label">id</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="shudu_levels" size="80" minlength="6" maxlength="60" class="form-control"  id="photo_num" value="<?php echo $result['id'];?>"/>
                            </div>
                        </div> -->
                        <!-- <div class="form-group">
                            <label class="col-sm-2 control-label">相册名字</label>
                            <div class="col-sm-8">
                                <input type="text" size="30" name="shudu_levels" size="80" minlength="6" maxlength="60" class="form-control"  id="shudu_levels" value="<?php echo $result['name'];?>"/>
                            </div>
                        </div> -->
                        
                        
                        
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-3">
                                <input type="hidden" id='id' value="<?php echo I('param.id');?>">
                                <button class="btn btn-primary" type="button" id="adds">提交</button>
                                <a href="/UserTask/lists"><button class="btn btn-white" type="button">取消</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    alert($ajaxReturnData['data'])
    
</script>
<script src="/Js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript">
    $("#adds").click(function(){
    });
    $(document).on('click','#adds',function(){
        var user_id=$('#user_id').val();
        var other_user_id=$('#other_user_id').val();
        var album_class=$('#album_class').val();
        var name=$('#name').val();
        var index_photo=$('#index_photo').val();
        var person_num=$('#person_num').val();
        var photo_num=$('#photo_num').val();
        // console.log(album_class);
        
        $.ajax({
            url:'/PhotoAlbum/adds_do', 
            data:{
                "user_id":user_id,
                "other_user_id":other_user_id,
                "album_class":album_class,
                "name":name,
                "index_photo":index_photo,
                "person_num":person_num,
                "photo_num":photo_num

            },
            type:'post',
            dataType:"json",
            success:function(data){
                if(data.status){
                    alert('添加成功');
                    window.location="/PhotoAlbum/lists";
                }else{
                    alert(data.message)
                }
            }
        });
    })
</script>
</body>
</html>