<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>权限管理</title>
</head>
<frameset cols="200,*" border="2" frameborder="yes">
	<frame src="${ctx }/permission/toPermissionLeft.action" name="left">
	<frame src="${ctx }/permission/toPermissionRight.action" name="right">
</frameset>
</html>