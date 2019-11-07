<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加商品</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css"
	media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css"
	media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" method="post" id="frm">
		<div class="layui-form-item">
			<label class="layui-form-label">选择供应商</label>
			<div class="layui-input-inline">
				<select name="providerid" lay-filter="providerid">
					<option value="0">--请选择供应商--</option>
					<c:forEach var="sn" items="${providers }">
						<option value="${sn.id }">${sn.providername }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">商品名称</label>
				<div class="layui-input-inline">
					<input type="text" name="goodsname" lay-verify="required"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">产地</label>
				<div class="layui-input-inline">
					<input type="text" name="produceplace" placeholder="产地"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">规格</label>
				<div class="layui-input-inline">
					<input type="tel" name="size" placeholder="规格" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">包装</label>
				<div class="layui-input-inline">
					<input type="text" name="goodspackage" autocomplete="off"
						class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">生产批号</label>
				<div class="layui-input-inline">
					<input type="text" name="productcode" placeholder="生产批号"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">批准文号</label>
				<div class="layui-input-inline">
					<input type="tel" name="promitcode" placeholder="批准文号"
						autocomplete="off" class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">销售参考价格</label>
				<div class="layui-input-inline">
					<input type="text" name="price" lay-verify="required"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">是否可用</label>
				<div class="layui-input-inline">
					<input type="radio" name="available" value="1" title="是" checked="">
					<input type="radio" name="available" value="0" title="否">
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">库存</label>
				<div class="layui-input-inline">
					<input type="text" name="number" placeholder="库存"
						lay-verify="required|number" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">预警库存</label>
				<div class="layui-input-inline">
					<input type="tel" name="dangernum" placeholder="预警库存"
						lay-verify="required|number" autocomplete="off"
						class="layui-input">
				</div>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">商品描述</label>
			<div class="layui-input-block">
				<textarea placeholder="请输入商品描述" name="description"
					class="layui-textarea"></textarea>
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
			<label class="layui-form-label">商品图片</label>
			<div class="layui-upload">
				<img class="layui-upload-img" width="100px" height="80px" id="goodsimg_img">
				<button type="button" class="layui-btn" id="goodspath">上传图片</button>
				<span id="goodsText"></span>
				<input type="hidden" name="goodsimg" id="goodsimg">
			</div>
		</div>
		<div class="layui-form-item" style="text-align: center;">
			<button class="layui-btn" lay-submit="" lay-filter="addGoods">提交</button>
			<button type="reset" class="layui-btn layui-btn-warm">重置</button>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
	layui.use([ 'form', 'jquery', 'layer', 'upload' ],
					function() {
						var form = layui.form;
						var $ = layui.jquery;
						var upload = layui.upload;
						//如果父页面有layer就使用父页的  没有就自己导入
						var layer = parent.layer === undefined ? layui.layer
								: top.layer;
						//监听提交
						form.on('submit(addGoods)', function(data) {
							var data = $("#frm").serialize();
							//使用ajax提交
							$.ajax({
								url : '${ctx }/goods/addGoods.action',
								type : 'POST',
								async : true, //或false,是否异步
								data : data,
								timeout : 5000, //超时时间
								dataType : 'json', //返回的数据格式：json/xml/html/script/jsonp/text
								success : function(data) {
									//关闭弹出层
									//关闭添加的弹出层
									var addIndex = parent.layer
											.getFrameIndex(window.name);
									window.parent.layer.close(addIndex);
									//刷新父页面的table
									window.parent.tableIns.reload();
								},
								error : function(xhr, textStatus) {
								}
							})
							return false;
						});

						//普通图片上传
						var uploadInst = upload
								.render({
									elem : '#goodspath',
									url : '${ctx}/upload/uploadFile.action',
									accept:'images',
									acceptMime:'image/*',
									field:'mf',
									before : function(obj) {
										//预读本地文件示例，不支持ie8
										obj.preview(function(index, file,
												result) {
											$('#goodsimg_img').attr('src', result); //图片链接（base64）
										});
									},
									done : function(res) {
										//如果上传失败
										if (res.code > 0) {
											return layer.msg('上传失败');
										}
										//上传成功
										$('#goodsimg_img').attr('src', res.data.src); //图片链接（base64）
										$('#goodsimg').val(res.data.src);
									},
									error : function() {
										//演示失败状态，并实现重传
										var goodsText = $('#goodsText');
										goodsText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs goods-reload">重试</a>');
										goodsText.find('.goods-reload').on(
												'click', function() {
													uploadInst.upload();
												});
									}
								});
					});
</script>
</html>