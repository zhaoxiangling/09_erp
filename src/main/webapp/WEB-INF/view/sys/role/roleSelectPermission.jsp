<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>角色管理-分配权限</title>
<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
<link rel="stylesheet" href="${ctx }/resources/zTree/css/metroStyle/metroStyle.css"/>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.excheck.min.js"></script>

</head>

<body class="childrenBody">
	<div id="treeMenus" class="ztree"></div>
	<div style="text-align: center;">
		<a class="layui-btn search_btn" >确定保存</a>
	</div>
	 <script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
	<script type="text/javascript">
		var setting = {
			data : {
				simpleData : {
					enable : true
				}
			},
			check:{
				enable: true
			}
		};
		$(document).ready(function() {
			initTree();
			$(".search_btn").click(function(){
				//得到角色Id
				var roleId=${roleVo.id};
				//得到树对象
				var treeObj = $.fn.zTree.getZTreeObj("treeMenus");
				var nodes = treeObj.getCheckedNodes(true);
				var data="id="+roleId;
				for(var i=0;i<nodes.length; i++){
					data+="&ids="+nodes[i].id;
				}
				//得到选中的节点
				 $.ajax({
	                url:'${ctx}/role/saveRolePermission.action',
	                type:'POST',
	                async:true,    //或false,是否异步
	                data:data,
	                timeout:5000,    //超时时间
	                dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
	                success:function(data){
	                	window.parent.layer.msg(data.msg);
	                },
	               	 error:function(xhr,textStatus){
	                }
	            })  
			})
			
			
		});
		function initTree() {
			//使用ajaxt去请求权限的json
			$.post("${ctx}/role/loadRolePermission.action?id=${roleVo.id}",
					function(zNodes) {
						$.fn.zTree.init($("#treeMenus"), setting, zNodes);
					});
		}
	</script>
</body>
</html>