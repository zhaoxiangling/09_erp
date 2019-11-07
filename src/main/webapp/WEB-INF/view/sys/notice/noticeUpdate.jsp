<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>修改公告列表</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" id="noticeFrm" action="">
		<div class="layui-form-item">
		    <label class="layui-form-label">公告标题</label>
		    <div class="layui-input-block">
		      <input type="hidden" name="id" value="${notice.id }">
		      <input type="text" name="title" lay-verify="title" value="${notice.title }" autocomplete="off" placeholder="请输入标题" class="layui-input">
		    </div>
  		</div>
  		<div class="layui-form-item">
		    <label class="layui-form-label">公告内容</label>
		    <div class="layui-input-block">
		    	 <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="content">${notice.content }</textarea>
		    </div>
  		</div>
  		 <div class="layui-form-item">
		    <div class="layui-input-block" style="text-align: center;">
		      <a href="javascript:void(0)" class="layui-btn" lay-submit="" lay-filter="doSubmit">提交</a>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  </div>
	</form>

<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
<script type="text/javascript">
layui.use(['form','layer','jquery','layedit'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        layedit = layui.layedit;
    	
    //创建一个编辑器
    var editIndex = layedit.build('content');
    //监控提交事件
    form.on("submit(doSubmit)",function(){
    	//同步富文本和普通的textarea里面的数据
    	layedit.sync(editIndex);
    	var params=$("#noticeFrm").serialize();
    	//使用ajax提交
    	$.post("${ctx}/notice/updateNotice.action?"+params,function(data){
    		layer.msg(data.msg);
    		//刷新父页面的表格
    		window.parent.tableIns.reload();
    		//关闭当前的弹出层
    		var index=window.parent.layer.getFrameIndex(window.name);
    		window.parent.layer.close(index);
    	})
    	return false;
    });
    
})
</script>

</body>
</html>