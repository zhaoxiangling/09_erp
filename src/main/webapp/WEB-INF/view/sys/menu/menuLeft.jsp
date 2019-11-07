<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜单管理--菜单树</title>
<link rel="stylesheet" href="${ctx }/resources/zTree/css/metroStyle/metroStyle.css"/>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core.js"></script>
</head>
<body>
	<div id="treeMenus" class="ztree"></div>

	<script type="text/javascript">
		function zTreeOnClick(event, treeId, treeNode) {
			window.parent.right.tableIns.reload({
				url:'${ctx}/menu/loadAllMenu.action?id='+treeNode.id
			})
		}
		var setting = {
			data : {
				simpleData : {
					enable : true
				}
			},
			callback : {
				onClick : zTreeOnClick
			}
		};
		$(document).ready(function() {
			initTree();
		});
		function initTree() {
			//使用ajaxt去请求菜单的json
			$.post("${ctx}/menu/loadMenuLeftTree.action",
					function(zNodes) {
						$.fn.zTree.init($("#treeMenus"), setting, zNodes);
					});
		}
	</script>
</body>
</html>