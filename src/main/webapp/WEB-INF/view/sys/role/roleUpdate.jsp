<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>修改角色</title>
	<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form" method="post" id="frm">
	<div class="layui-form-item">
		<label class="layui-form-label">角色名称</label>
		<div class="layui-input-block">
			<input type="hidden" name="id" value="${roleVo.id }">
			<input  type="text" name="name" lay-verify="required" value="${roleVo.name }" autocomplete="off"
				   placeholder="请输入角色标题" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">角色备注</label>
		<div class="layui-input-block">
			<textarea placeholder="请输入角色内容" name="remark"  class="layui-textarea">${roleVo.remark }</textarea>
		</div>
	</div>
	<div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">是否有效</label>
      <div class="layui-input-inline">
      	 <input type="radio" name="available" value="1" title="是" ${roleVo.available==1?'checked':'' } >
     	 <input type="radio" name="available" value="0" title="否"  ${roleVo.available==0?'checked':'' } >
      </div>
    </div>
  </div>
	<div class="layui-form-item" style="text-align: center;">
		<a class="layui-btn" href="javascript:void(0)" lay-submit="" lay-filter="updateRole">提交</a >
		<button type="reset" class="layui-btn layui-btn-warm">重置</button>
	</div>
	
</form>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
    layui.use(['form','jquery','layer'],function(){
        var form=layui.form;
        var $=layui.jquery;
        //如果父页面有layer就使用父页的  没有就自己导入
        var layer = parent.layer === undefined ? layui.layer : top.layer;
        //监听提交
        form.on('submit(updateRole)', function(data){
            var data=$("#frm").serialize();
            //使用ajax提交
            $.ajax({
                url:'${ctx}/role/updateRole.action',
                type:'POST',
                async:true,    //或false,是否异步
                data:data,
                timeout:5000,    //超时时间
                dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
                success:function(data){
                	layer.msg(data.msg);
                    //关闭修改的弹出层
                    var updateIndex = parent.layer.getFrameIndex(window.name);
                    window.parent.layer.close(updateIndex);
                    //刷新父页面的table
                    window.parent.tableIns.reload();
                },
                error:function(xhr,textStatus){
                }
            })
            return false;
        });
    });
</script>
</html>