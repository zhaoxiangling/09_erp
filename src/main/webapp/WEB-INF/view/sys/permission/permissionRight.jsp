<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>权限管理--列表</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" id="searchFrm">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
	  <legend>查询条件</legend>
	</fieldset>
	  <div class="layui-form-item">
	    <div class="layui-inline">
	      <label class="layui-form-label">权限名称</label>
	      <div class="layui-input-inline">
	        <input type="text" name="name" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	     <div class="layui-inline">
	      <label class="layui-form-label">权限编码</label>
	      <div class="layui-input-inline">
	        <input type="text" name="percode" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline" style="text-align: center;">
	      <a href="javascript:void(0)" class="layui-btn search_btn" >查询</a>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	  </div>
	  
</form>
	<table id="permissionList" lay-filter="permissionList"></table>
	<!--table工具条-->
	<script type="text/html" id="permissionListTableBar">
<shiro:hasPermission name="permission:create">
		<a class="layui-btn  layui-btn-warm" lay-event="add">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="permission:batchdelete">
		<a class="layui-btn  layui-btn-denger " lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
	</script>
	<!--操作-->
	<script type="text/html" id="permissionListBar">
<shiro:hasPermission name="permission:update">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="permission:delete">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</shiro:hasPermission>
	</script>

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
var tableIns;
layui.use(['form','layer','laydate','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;
    //权限列表
     tableIns = table.render({
        elem: '#permissionList',
        url : '${ctx}/permission/loadAllPermission.action',
        cellMinWidth : 95,
        page : true,
        height : "full-160",
        toolbar:"#permissionListTableBar",
        defaultToolbar: ['filter', 'print'],
        limits : [10,15,20,25],
        id : "permissionListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', align:"center"},
            {field: 'pid', title: '父级权限ID', align:"center"},
            {field: 'name', title: '权限名称',align:'center'},
            {field: 'percode', title: '权限编码',align:'center'},
            {field: 'available', title: '是否有效', align:'center',templet:function(d){
            	return d.available==1?'<font color=blue>有效</font>':'<font color=red>无效</font>';
            }},
            {field: 'ordernum', title: '排序码', align:'center'},
            {title: '操作', width:170, templet:'#permissionListBar',fixed:"right",align:"center"}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
    	var params=$("#searchFrm").serialize();
        //搜索
    	tableIns.reload({
    		url:'${ctx}/permission/loadAllPermission.action?'+params
    	})
    });
    
    //监控表格头的添加和批量删除事件
    table.on("toolbar(permissionList)",function(obj){
    	switch(obj.event){
    		case "add":
    			addPermission();
    			break;
    		case "batchDel":
    			batchDel();
    			break;
    	}
    })

    //添加权限
    function addPermission(){
        var index = layui.layer.open({
            title : "添加权限",
            type : 2,
            area:["700px",'450px'],
            content : "${ctx}/permission/toAddPermission.action",
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回权限列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
        //让弹出层默认最大化
        //layui.layer.full(index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(index);
        })
    }
    //批量删除
    function batchDel(){
        var checkStatus = table.checkStatus('permissionListTable'),
            data = checkStatus.data;
        var permissionIds="";
        if(data.length > 0) {
            for (var i in data) {
            	if(i==0){
            		permissionIds+="ids="+data[i].id;
            	}else{
            		permissionIds+="&ids="+data[i].id;
            	}
            }
            layer.confirm('确定删除选中的权限？', {icon: 3, title: '提示信息'}, function (index) {
                 $.get("${ctx}/permission/deletePermissionBatch.action?"+permissionIds,function(data){
                	 tableIns.reload();
                     layer.close(index);
                 })
            })
        }else{
            layer.msg("请选择需要删除的权限");
        }
    }

    //列表操作
    table.on('tool(permissionList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
            updatePermission(data);
        } else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此权限？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx}/permission/deletePermission.action",{
                     id : data.id  
                 },function(data){
                    tableIns.reload();
                    layer.close(index);
                 })
            });
        } else if(layEvent === 'look'){ //预览
            layer.alert("此功能需要前台展示，实际开发中传入对应的必要参数进行权限内容页面访问")
        }
    });
    
    //修改
    function updatePermission(data){
    	var index = layui.layer.open({
            title : "修改权限",
            type : 2,
            area:["700px",'450px'],
            content : "${ctx}/permission/toUpdatePermission.action?id="+data.id,
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回权限列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            }
        })
        //让弹出层默认最大化
        //layui.layer.full(index);
        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
        $(window).on("resize",function(){
            layui.layer.full(index);
        })
    }

})
</script>
</body>
</html>