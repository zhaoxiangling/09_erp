<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>角色管理</title>
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
<fieldset class="layui-elem-field layui-field-title">
    <legend>查询条件</legend>
</fieldset>
<form class="layui-form" id="searchForm" method="post">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" >角色名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="name"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" >角色备注:</label>
            <div class="layui-input-inline">
                <input type="text" name="remark"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
        <a class="layui-btn search_btn" >查询</a>
        <button type="reset" class="layui-btn layui-btn-warm">清空</button>
    </div>
</form>
<table id="roleList" lay-filter="roleList"></table>
<!--表格工具条-->
<script type="text/html" id="tableToolBar">
<shiro:hasPermission name="role:create">
	<a class="layui-btn layui-btn layui-btn" lay-event="add">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="role:batchdelete">
	<a class="layui-btn layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
</script>
<!--操作-->
<script type="text/html" id="roleListBar">
<shiro:hasPermission name="role:update">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="role:delete">
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="role:selectPermission">
    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="toSelectPermisison">分配权限</a>
</shiro:hasPermission>
</script>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
    var tableIns;
    layui.use(['form','layer','table','laydate','laytpl'],function(){
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            laydate=layui.laydate,
            laytpl = layui.laytpl,
            table = layui.table;
        laydate.render({
        	elem:"#startDate"
        })
         laydate.render({
        	elem:"#endDate"
        })
        //角色列表
        tableIns = table.render({
            elem: '#roleList',
            url : '${ctx }/role/loadAllRoles.action',
            cellMinWidth : 95,
            toolbar: '#tableToolBar',
            page : true,
            height : "full-220",
            limits : [10,15,20,25],
            defaultToolbar: ['filter'],
            limit : 10,
            id : "roleListTable",
            cols : [[
                {type: "checkbox", fixed:"left", width:50},
                {field: 'id', title: '角色ID', minWidth:100, align:"center"},
                {field: 'name', title: '角色名称', minWidth:100, align:"center"},
                {field: 'remark', title: '角色备注', minWidth:100, align:"center"},
                {field: 'available', title: '是否有效',  align:'center',templet:function(d){
                	return d.available==1?'<font color=blue>有效</font>':'<font color=red>无效</font>';
                }},
                {title: '操作', minWidth:175, templet:'#roleListBar',fixed:"right",align:"center"}
            ]]
        });

        //查询
        $(".search_btn").on("click",function(){
            var params=$("#searchForm").serialize();
            table.reload('roleListTable', {
                url: '${ctx }/role/loadAllRoles.action?'+params
            });
        });
        //监听头工具栏事件
        table.on('toolbar(roleList)', function(obj){
            switch(obj.event){
	            case 'add':
	               	toAddRole();
                	break;
                case 'batchDel':
                	batchDelete();
                    break;
            };
        });

        //打开  添加角色的弹出层
        function toAddRole(){
            var index = layui.layer.open({
                title : "添加角色",
                type : 2,//ifream层
                area:["800px","500px"],
                content : "${ctx }/role/toAddRole.action",
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    },500)
                }
            })
            //layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize",function(){
                layui.layer.full(index);
            })
        }
        //修改角色
        function updateRole(data){
            var index = layui.layer.open({
                title : "修改角色",
                type : 2,
                area:["800px","500px"],
                content : "${ctx }/role/toUpdateRole.action?id="+data.id,
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    },500)
                }
            })
            //layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize",function(){
                layui.layer.full(index);
            })
        }
        //列表操作
        table.on('tool(roleList)', function(obj){
            var layEvent = obj.event,
                data = obj.data;
            if(layEvent === 'edit'){ //编辑
                updateRole(data);//data主当前点击的行
            }else if(layEvent === 'del'){ //删除
                layer.confirm('确定删【'+data.name+'】角色吗？',{icon:3, title:'提示信息'},function(index){
                    $.post("${ctx}/role/deleteRole.action",{
                        id : data.id  //将需要删除的id作为参数传入
                    },function(data){
                        //刷新table
                        tableIns.reload();
                        //关闭提示框
                        layer.close(index);
                    })
                });
            }else if(layEvent==="toSelectPermisison"){
            	//传入角色对象
            	openSelectPermisison(data);
            }
        });
        //批量删除
        function batchDelete(){
            //得到当前表格里面的checkbox的选中对象集合
            var checkStatus = table.checkStatus('roleListTable'),//选中状态
                data = checkStatus.data;//选中的对象集
            var ids="a=1";
            if(data.length > 0) {
                for (var i in data) {
                    ids+="&ids="+data[i].id;
                }
                layer.confirm('确定删除选中的角色？', {icon: 3, title: '提示信息'}, function (index) {
                    $.post("${ctx}/role/batchDeleteRole.action?"+ids,function(data){
                        //刷新table
                        tableIns.reload();
                        //关闭提示框
                        layer.close(index);
                    })
                })
            }else{
                layer.msg("请选择需要删除的角色");
            }
        }
        //打开分配权限的弹出层
        function openSelectPermisison(data){
        	var index = layui.layer.open({
                title : "分配["+data.name+"]角色的权限",
                type : 2,
                area:["400px","500px"],
                content : "${ctx }/role/toSelectPermission.action?id="+data.id,
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    },500)
                }
            })
            //layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize",function(){
                layui.layer.full(index);
            })
        }
    })
    
</script>
</html>