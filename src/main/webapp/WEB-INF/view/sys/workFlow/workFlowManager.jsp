<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>流程管理</title>
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
            <label class="layui-form-label" >流程名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="deploymentName"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <a class="layui-btn search_btn" >查询</a>
        <button type="reset" class="layui-btn layui-btn-warm">清空</button>
        </div>
    </div>
</form>
<table id="deploymentList" lay-filter="deploymentList"></table>
<table id="processDefinitionList" lay-filter="processDefinitionList"></table>
<!--表格工具条-->
<script type="text/html" id="deploymentTableToolBar">
	<a class="layui-btn layui-btn layui-btn" lay-event="add">添加</a>
	<a class="layui-btn layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
</script>
<!--操作-->
<script type="text/html" id="deploymentListBar">
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">查看流程图</a>
</script>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
    var tableDeploymentIns;
    var tableprocessDefinitionIns;
    layui.use(['form','layer','table','laydate','laytpl'],function(){
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            laydate=layui.laydate,
            laytpl = layui.laytpl,
            table = layui.table;
        //流程部署列表
        tableDeploymentIns = table.render({
            elem: '#deploymentList',
            url : '${ctx }/workFlow/loadAllDeployment.action',
            cellMinWidth : 95,
            toolbar: '#deploymentTableToolBar',
            page : true,
            height : "full-350",
            limits : [5,10,15,20],
            defaultToolbar: ['filter'],
            limit : 5,
            id : "deploymentListTable",
            cols : [[
                {type: "checkbox", fixed:"left", width:50},
                {field: 'id', title: '部署ID', minWidth:100, align:"center"},
                {field: 'name', title: '部署名称', minWidth:100, align:"center"},
                {field: 'deploymentTime', title: '部署时间', minWidth:100, align:"center"},
                {title: '操作', minWidth:175, templet:'#deploymentListBar',fixed:"right",align:"center"}
            ]]
        });
      //流程定义列表
        tableprocessDefinitionIns = table.render({
            elem: '#processDefinitionList',
            url : '${ctx }/workFlow/loadAllProcessDefinition.action',
            cellMinWidth : 95,
            page : true,
            height : "full-380",
            limits : [5,10,15,20],
            limit : 5,
            id : "processDefinitionListTable",
            cols : [[
                {field: 'id', title: '流程定义ID', minWidth:100, align:"center"},
                {field: 'name', title: '流程定义名称', minWidth:100, align:"center"},
                {field: 'key', title: '流程定义KEY', minWidth:100, align:"center"},
                {field: 'version', title: '流程定义版本', minWidth:100, align:"center"},
                {field: 'deploymentId', title: '部署ID', minWidth:100, align:"center"},
                {field: 'resourceName', title: '资源文件名[bpmn]', minWidth:100, align:"center"},
                {field: 'diagramResourceName', title: '资源文件名[png]', minWidth:100, align:"center"}
            ]]
        });

        //查询
        $(".search_btn").on("click",function(){
            var params=$("#searchForm").serialize();
            table.reload('deploymentListTable', {
                url: '${ctx }/workFlow/loadAllDeployment.action?'+params
            });
            table.reload('processDefinitionListTable', {
                url: '${ctx }/workFlow/loadAllProcessDefinition.action?'+params
            });
        });
        //监听头工具栏事件
        table.on('toolbar(workFlowList)', function(obj){
            switch(obj.event){
	            case 'add':
	               	toAddWorkFlow();
                	break;
                case 'batchDel':
                	batchDelete();
                    break;
            };
        });

        //打开  添加流程的弹出层
        function toAddWorkFlow(){
            var index = layui.layer.open({
                title : "添加流程",
                type : 2,//ifream层
                area:["800px","500px"],
                content : "${ctx }/workFlow/toAddWorkFlow.action",
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回流程列表', '.layui-layer-setwin .layui-layer-close', {
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
        table.on('tool(workFlowList)', function(obj){
            var layEvent = obj.event,
                data = obj.data;
             if(layEvent === 'del'){ //删除
                layer.confirm('确定删【'+data.name+'】流程吗？',{icon:3, title:'提示信息'},function(index){
                    $.post("${ctx}/workFlow/deleteWorkFlow.action",{
                        id : data.id  //将需要删除的id作为参数传入
                    },function(data){
                        //刷新table
                        tableIns.reload();
                        //关闭提示框
                        layer.close(index);
                    })
                });
            }else if(layEvent==="toSelectPermisison"){
            	//传入流程对象
            	openSelectPermisison(data);
            }
        });
        //批量删除
        function batchDelete(){
            //得到当前表格里面的checkbox的选中对象集合
            var checkStatus = table.checkStatus('workFlowListTable'),//选中状态
                data = checkStatus.data;//选中的对象集
            var ids="a=1";
            if(data.length > 0) {
                for (var i in data) {
                    ids+="&ids="+data[i].id;
                }
                layer.confirm('确定删除选中的流程？', {icon: 3, title: '提示信息'}, function (index) {
                    $.post("${ctx}/workFlow/batchDeleteWorkFlow.action?"+ids,function(data){
                        //刷新table
                        tableIns.reload();
                        //关闭提示框
                        layer.close(index);
                    })
                })
            }else{
                layer.msg("请选择需要删除的流程");
            }
        }
    })
    
</script>
</html>