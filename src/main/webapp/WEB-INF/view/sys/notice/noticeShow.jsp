<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>查看公告</title>
	<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
<h2 align="center">
${notice.title }
</h2>
<hr>
<div style="text-align: right;">
	发布时间:<fmt:formatDate value="${notice.createtime }" pattern="yyyy-MM-dd"/>
	发布人:${notice.opername }
</div>
<hr>
<div>
	${notice.content }
</div>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
    layui.use(['form','jquery','layer','layedit'],function(){
        var form=layui.form;
        var $=layui.jquery;
        var layedit=layui.layedit;
        //如果父页面有layer就使用父页的  没有就自己导入
        var layer = parent.layer === undefined ? layui.layer : top.layer;
    });
</script>
</html>