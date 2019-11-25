<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>待办任务管理</title>
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
    <div class="layui-form-item" style="text-align: right;">
        <a class="layui-btn search_btn" >刷新</a>
    </div>
<table id="taskList" lay-filter="taskList"></table>
<!--操作-->
<script type="text/html" id="taskListBar">
    <a class="layui-btn layui-btn-xs" lay-event="toDoTask">办理任务</a>
    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="viewProcessByTaskId">查看流程图</a>
</script>
<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
    var tableIns;
    layui.use(['form','layer','table','jquery'],function(){
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery,
            table = layui.table;
        //待办任务列表
        tableIns = table.render({
            elem: '#taskList',
            url : '${ctx }/workFlow/loadCurrentUserTask.action',
            cellMinWidth : 95,
            page : true,
            height : "full-220",
            limits : [10,15,20,25],
            defaultToolbar: ['filter'],
            limit : 10,
            id : "taskListTable",
            cols : [[
                {type: "checkbox", fixed:"left", width:50},
                {field: 'id', title: '任务ID', minWidth:100, align:"center"},
                {field: 'name', title: '待办任务名称', minWidth:100, align:"center"},
                {field: 'createTime', title: '创建时间', minWidth:100, align:"center"},
                {field: 'assignee', title: '办理人',  align:'center'},
                {title: '操作', minWidth:175, templet:'#taskListBar',fixed:"right",align:"center"}
            ]]
        });
        //刷新
        $(".search_btn").on("click",function(){
            tableIns.reload();
        });
        //列表操作
        table.on('tool(taskList)', function(obj){
            var layEvent = obj.event,
                data = obj.data;
            if(layEvent === 'toDoTask'){ //编辑
                openDoTask(data);//data主当前点击的行
            }else if(layEvent==="viewProcessByTaskId"){
            	viewProcessByTaskId(data);
            }
        });
      //修改待办任务
        function openDoTask(data){
            var index = layui.layer.open({
                title : "修改待办任务",
                type : 2,
                area:["800px","600px"],
                content : "${ctx }/workFlow/toDoTask.action?taskId="+data.id,//传入任务ID
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回待办任务列表', '.layui-layer-setwin .layui-layer-close', {
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
      //查看流程图
        function viewProcessByTaskId(data){
            var index = layui.layer.open({
                title : "审批流程进度图",
                type : 2,
                area:["500px","600px"],
                content : "${ctx }/workFlow/toViewProcessByTaskId.action?taskId="+data.id,
                success : function(layero, index){
                    setTimeout(function(){
                        layui.layer.tips('点击此处返回待办任务列表', '.layui-layer-setwin .layui-layer-close', {
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