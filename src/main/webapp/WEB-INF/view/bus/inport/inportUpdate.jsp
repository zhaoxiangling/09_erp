<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改商品进货</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css"
	media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css"
	media="all" />

</head>
<body class="childrenBody">
	<form class="layui-form" method="post" id="frm" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">选择供应商</label>
				<div class="layui-input-inline">
					<select name="providerid" lay-filter="providerid" id="providerid">
						<option value="0">--请选择供应商--</option>
						<c:forEach var="sn" items="${providers }">
							<option value="${sn.id }">${sn.providername }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">商品名称</label>
				<div class="layui-input-inline">
					<select name="goodsid"  id="goodsid" lay-filter="goodsid">
						
					</select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">进货数量</label>
				<div class="layui-input-inline">
					<input type="text" name="number" lay-verify="required|number" value="${inport.number }" placeholder="数量"
						autocomplete="off" class="layui-input">
						<input type="hidden" name="operateperson" value="${user.name }">
						<input type="hidden" name="id" value="${inport.id }">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">进货价格</label>
				<div class="layui-input-inline">
					<input type="tel" name="inportprice" placeholder="进货价格"  value="${inport.inportprice }" lay-verify="required|number" autocomplete="off"
						class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">支持类型</label>
				<div class="layui-input-block">
					<input type="radio" name="paytype" value="微信" title="微信" ${inport.paytype=='微信'?'checked':'' }> <input
						type="radio" name="paytype" value="支付宝" title="支付宝" ${inport.paytype=='支付宝'?'checked':'' }>
					<input type="radio" name="paytype" value="银联" title="银联" ${inport.paytype=='银联'?'checked':'' }>
				</div>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">进货备注</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入进货备注" name="remark"
					class="layui-textarea">${inport.remark }</textarea>
			</div>
		</div>
		<div class="layui-form-item" style="text-align: center;">
			<button class="layui-btn" lay-submit="" lay-filter="addInport">提交</button>
			<button type="reset" class="layui-btn layui-btn-warm">重置</button>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
	layui.use([ 'form', 'jquery', 'layer' ], function() {
		var form = layui.form;
		var $ = layui.jquery;
		//如果父页面有layer就使用父页的  没有就自己导入
		var layer = parent.layer === undefined ? layui.layer : top.layer;
		//监听提交
		form.on('submit(addInport)', function(data) {
			var data = $("#frm").serialize();
			//使用ajax提交
			$.ajax({
				url : '${ctx }/inport/addInport.action',
				type : 'POST',
				async : true, //或false,是否异步
				data : data,
				timeout : 5000, //超时时间
				dataType : 'json', //返回的数据格式：json/xml/html/script/jsonp/text
				success : function(data) {
					//关闭弹出层
					//关闭添加的弹出层
					var addIndex = parent.layer.getFrameIndex(window.name);
					window.parent.layer.close(addIndex);
					//刷新父页面的table
					window.parent.tableIns.reload();
				},
				error : function(xhr, textStatus) {
				}
			})
			return false;
		});
		//供应商的改变事件
		form.on("select(providerid)",function(obj){
			initGoodsName(obj.value);
		});
		$("#providerid").val('${inport.providerid}');
		
		form.render("select");
		
		function initGoodsName(providerid){
			var url="${ctx}/goods/loadGoodsByProviderId.action"
			$.post(url,{providerid:providerid},function(json){
				var html="";
				for (var i = 0; i < json.length; i++) {
					var goodsObj = json[i];
					html+="<option value="+goodsObj.id+">"+(goodsObj.goodsname+"["+goodsObj.size+"]")+"</option>"
				}
				$("#goodsid").html(html);
				form.render("select");
			})
		}
		initGoodsName("${inport.providerid}");
	});
</script>
</html>