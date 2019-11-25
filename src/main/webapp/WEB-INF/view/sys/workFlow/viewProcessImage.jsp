<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	div{
		border:2px solid red;
		padding: 4px;
	}
</style>
</head>

<body>
	<img alt="流程图" src="${ctx }/workFlow/viewProcessImage.action?deploymentId=${workFlowVo.deploymentId}">
	
	<div style="position: absolute;left: ${c.x}px;top: ${c.y }px;width: ${c.width }px;height: ${c.height }px"></div>
</body>
</html>