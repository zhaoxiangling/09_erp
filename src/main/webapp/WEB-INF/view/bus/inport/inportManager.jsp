<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<!-- 使用frameset不能使用body -->
<frameset cols="200,*" border="1" frameborder="yes">
	<frame name="left"  src="${ctx }/inport/toInportLeft.action">
	<frame name="main"  src="${ctx }/inport/toInportRight.action">
</frameset>

</html>