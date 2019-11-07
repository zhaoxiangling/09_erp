<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加供应商</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" method="post" id="frm">
	  <div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">供应商名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="providername" lay-verify="required" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">公司电话</label>
		      <div class="layui-input-inline">
		        <input type="text" name="telephone"   placeholder="公司电话" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">邮编</label>
		      <div class="layui-input-inline">
		        <input type="tel" name="zip" placeholder="邮编" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		 </div>
		<div class="layui-form-item">
			<label class="layui-form-label">公司地址</label>
			<div class="layui-input-block">
				<input type="text" name="address" lay-verify="title" autocomplete="off"
					placeholder="请输入公司地址" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">联系人</label>
				<div class="layui-input-inline">
					<input type="text" name="connectionperson" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">联系人电话</label>
				<div class="layui-input-inline">
					<input type="text" name="phone" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-inline">
					<input type="text" name="email"  lay-verify="email" autocomplete="off"
						class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">开户银行</label>
				<div class="layui-input-inline">
					<input type="text" name="bank" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">帐号</label>
				<div class="layui-input-inline">
					<input type="text" name="account" lay-verify="number"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">传真</label>
				<div class="layui-input-inline">
					<input type="text" name="fax" lay-verify="number"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			 <label class="layui-form-label">是否有效</label>
			    <div class="layui-input-block">
			      <input type="radio" name="available" value="1" title="是" checked="">
			      <input type="radio" name="available" value="0" title="否">
			    </div>
		</div>
	  <div class="layui-form-item" style="text-align: center;">
	      <button class="layui-btn" lay-submit="" lay-filter="addProvider">提交</button>
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
	  form.on('submit(addProvider)', function(data){
		 var data=$("#frm").serialize();
	    //使用ajax提交
	    $.ajax({
		    url:'${ctx }/provider/addProvider.action',
		    type:'POST',
		    async:true,    //或false,是否异步
		    data:data,
		    timeout:5000,    //超时时间
		    dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
		    success:function(data){
		    	//关闭弹出层
		    	layer.confirm('是否继续添加?', {
		    	  icon: 3, title:'提示',
				  btn: ['是', '否'] //可以无限个按钮
				}, function(index, layero){
				  //继续添加
				  layer.close(index);
				  //重置表单
				  $("#frm")[0].reset();
				  
				}, function(index){
				  //否
				  layer.close(index);
				  //关闭添加的弹出层
				  var addIndex = parent.layer.getFrameIndex(window.name);
				  window.parent.layer.close(addIndex); 
				});
		    	//刷新父页面的table
				window.parent.tableIns.reload();
		    },
		    error:function(xhr,textStatus){
		        console.log('错误')
		        console.log(xhr)
		        console.log(textStatus)
		    }
		})
	    return false;
	  });
	});
</script>
</html>