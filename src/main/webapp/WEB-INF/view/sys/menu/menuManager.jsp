<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜单管理</title>
</head>
<frameset cols="200,*" border="2" frameborder="yes">
	<frame src="${ctx }/menu/toMenuLeft.action" name="left">
	<frame src="${ctx }/menu/toMenuRight.action" name="right">
</frameset>
</html>