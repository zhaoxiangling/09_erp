<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>菜单管理--列表</title>
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
	      <label class="layui-form-label">菜单名称</label>
	      <div class="layui-input-inline">
	        <input type="text" name="name" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline" style="text-align: center;">
	      <a href="javascript:void(0)" class="layui-btn search_btn" >查询</a>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	  </div>
	  
</form>
	<table id="menuList" lay-filter="menuList"></table>
	<!--table工具条-->
	<script type="text/html" id="menuListTableBar">
<shiro:hasPermission name="menu:create">
		<a class="layui-btn  layui-btn-warm" lay-event="add">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="menu:batchdelete">
		<a class="layui-btn  layui-btn-denger " lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
	</script>
	<!--操作-->
	<script type="text/html" id="menuListBar">
<shiro:hasPermission name="menu:update">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="menu:delete">
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
    //菜单列表
     tableIns = table.render({
        elem: '#menuList',
        url : '${ctx}/menu/loadAllMenu.action',
        cellMinWidth : 95,
        page : true,
        height : "full-160",
        toolbar:"#menuListTableBar",
        defaultToolbar: ['filter', 'print'],
        limits : [10,15,20,25],
        id : "menuListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', align:"center"},
            {field: 'pid', title: '父级菜单ID', align:"center"},
            {field: 'name', title: '菜单名称',align:'center'},
            {field: 'icon', title: '菜单图标', align:'center',templet:function(d){
            	return "<div class='layui-icon'>"+d.icon+"</div>"
            }},
            {field: 'href', title: '菜单地址',width:150, align:'center'},
            {field: 'open', title: '是否展开', align:'center',templet:function(d){
            	return d.open==1?'<font color=blue>展开</font>':'<font color=red>不展开</font>';
            }},
            {field: 'parent', title: '是否父菜单', align:'center',templet:function(d){
            	return d.parent==1?'<font color=blue>是</font>':'<font color=red>否</font>';
            }},
            {field: 'available', title: '是否有效', align:'center',templet:function(d){
            	return d.available==1?'<font color=blue>有效</font>':'<font color=red>无效</font>';
            }},
            {field: 'ordernum', title: '排序码', align:'center'},
            {title: '操作', width:170, templet:'#menuListBar',fixed:"right",align:"center"}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
    	var params=$("#searchFrm").serialize();
        //搜索
    	tableIns.reload({
    		url:'${ctx}/menu/loadAllMenu.action?'+params
    	})
    });
    
    //监控表格头的添加和批量删除事件
    table.on("toolbar(menuList)",function(obj){
    	switch(obj.event){
    		case "add":
    			addMenu();
    			break;
    		case "batchDel":
    			batchDel();
    			break;
    	}
    })

    //添加菜单
    function addMenu(){
        var index = layui.layer.open({
            title : "添加菜单",
            type : 2,
            area:["700px",'550px'],
            content : "${ctx}/menu/toAddMenu.action",
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回菜单列表', '.layui-layer-setwin .layui-layer-close', {
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
        var checkStatus = table.checkStatus('menuListTable'),
            data = checkStatus.data;
        var menuIds="";
        if(data.length > 0) {
            for (var i in data) {
            	if(i==0){
            		menuIds+="ids="+data[i].id;
            	}else{
            		menuIds+="&ids="+data[i].id;
            	}
            }
            layer.confirm('确定删除选中的菜单？', {icon: 3, title: '提示信息'}, function (index) {
                 $.get("${ctx}/menu/deleteMenuBatch.action?"+menuIds,function(data){
                	 tableIns.reload();
                     window.parent.left.initTree();//刷新左边的树
                     layer.close(index);
                 })
            })
        }else{
            layer.msg("请选择需要删除的菜单");
        }
    }

    //列表操作
    table.on('tool(menuList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
            updateMenu(data);
        } else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此菜单？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx}/menu/deleteMenu.action",{
                     id : data.id  
                 },function(data){
                    tableIns.reload();
                    window.parent.left.initTree();//刷新左边的树
                    layer.close(index);
                 })
            });
        } else if(layEvent === 'look'){ //预览
            layer.alert("此功能需要前台展示，实际开发中传入对应的必要参数进行菜单内容页面访问")
        }
    });
    
    //修改
    function updateMenu(data){
    	var index = layui.layer.open({
            title : "修改菜单",
            type : 2,
            area:["700px",'550px'],
            content : "${ctx}/menu/toUpdateMenu.action?id="+data.id,
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回菜单列表', '.layui-layer-setwin .layui-layer-close', {
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