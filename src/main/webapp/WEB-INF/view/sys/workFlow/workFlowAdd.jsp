<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>部署流程</title>
	<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form" method="post" id="frm">
	<div class="layui-form-item">
		<label class="layui-form-label">流程名称</label>
		<div class="layui-input-block">
			<input type="text" name="deploymentName" lay-verify="required" autocomplete="off"
				   placeholder="请输入流程名称" id="deploymentName" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">流程图文件</label>
		<div class="layui-input-block">
			<div class="layui-upload">
			  <button type="button" class="layui-btn layui-btn-normal" id="uploadProcess">请选择流程图文件</button>
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="text-align: center;">
		<a class="layui-btn" href="javascript:void(0)" lay-submit="" id="addWorkFlow"  lay-filter="addWorkFlow">提交</a >
		<button type="reset" class="layui-btn layui-btn-warm">重置</button>
	</div>
	
</form>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
    layui.use(['form','jquery','layer','upload'],function(){
        var form=layui.form;
        var $=layui.jquery;
        //如果父页面有layer就使用父页的  没有就自己导入
        var layer = parent.layer === undefined ? layui.layer : top.layer;
        var upload=layui.upload;
        //选完文件后不自动上传
        upload.render({
          elem: '#uploadProcess'
          ,url: '${ctx}/workFlow/addWorkFlow.action'
          ,auto: false
          ,accept:'file'//选择上传文件
          ,acceptMime:'application/zip'//打开文件选择框默认显示压缩文件
          ,exts: 'zip'//校验类型
          ,field:'mf'
          ,data:{
        	  deploymentName:function(){
        		  return $('#deploymentName').val();
        	  }
          }
          ,bindAction: '#addWorkFlow'
          ,done: function(data){
        	  layer.msg(data.msg);
              //关闭部署的弹出层
              var addIndex = parent.layer.getFrameIndex(window.name);
              window.parent.layer.close(addIndex);
              //刷新父页面的table
              window.parent.tableDeploymentIns.reload();
              window.parent.tableprocessDefinitionIns.reload();
          }
        ,error:function(){
        	layer.msg('部署失败');
            //关闭部署的弹出层
            var addIndex = parent.layer.getFrameIndex(window.name);
            window.parent.layer.close(addIndex);
        }
        });
    });
</script>
</html>