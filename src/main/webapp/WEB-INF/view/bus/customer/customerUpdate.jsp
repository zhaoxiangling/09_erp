<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改客户</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" method="post" id="frm">
	  <div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">客户名称</label>
		      <div class="layui-input-inline">
		      <input type="hidden" name="id" value="${customer.id }">
		        <input type="text" name="customername" value="${customer.customername }" lay-verify="required" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">公司电话</label>
		      <div class="layui-input-inline">
		        <input type="text" name="telephone"  value="${customer.telephone }"  placeholder="公司电话" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">邮编</label>
		      <div class="layui-input-inline">
		        <input type="tel" name="zip" value="${customer.zip }" placeholder="邮编" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		 </div>
		<div class="layui-form-item">
			<label class="layui-form-label">公司地址</label>
			<div class="layui-input-block">
				<input type="text" name="address" value="${customer.address }" lay-verify="title" autocomplete="off"
					placeholder="请输入公司地址" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">联系人</label>
				<div class="layui-input-inline">
					<input type="text" name="connectionperson" value="${customer.connectionperson }" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">联系人电话</label>
				<div class="layui-input-inline">
					<input type="text" name="phone" value="${customer.phone }" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-inline">
					<input type="text" name="email" value="${customer.email }"  lay-verify="email" autocomplete="off"
						class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">开户银行</label>
				<div class="layui-input-inline">
					<input type="text" name="bank" value="${customer.bank }" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">帐号</label>
				<div class="layui-input-inline">
					<input type="text" name="account" value="${customer.account }" lay-verify="number"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">传真</label>
				<div class="layui-input-inline">
					<input type="text" name="fax" value="${customer.fax }" lay-verify="number"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			 <label class="layui-form-label">是否有效</label>
			    <div class="layui-input-block">
			      <input type="radio" name="available" value="1" title="是" ${customer.available==1?'checked':'' }>
			      <input type="radio" name="available" value="0" title="否" ${customer.available==0?'checked':'' }>
			    </div>
		</div>
	  <div class="layui-form-item" style="text-align: center;">
	      <button class="layui-btn" lay-submit="" lay-filter="updateCustomer">提交</button>
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
	  form.on('submit(updateCustomer)', function(data){
		 var data=$("#frm").serialize();
	    //使用ajax提交
	    $.ajax({
		    url:'${ctx }/customer/updateCustomer.action',
		    type:'POST',
		    async:true,    //或false,是否异步
		    data:data,
		    timeout:5000,    //超时时间
		    dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
		    success:function(data){
		    	layer.msg(data.msg);
				  //关闭修改的弹出层
				var addIndex = parent.layer.getFrameIndex(window.name);
				window.parent.layer.close(addIndex); 
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