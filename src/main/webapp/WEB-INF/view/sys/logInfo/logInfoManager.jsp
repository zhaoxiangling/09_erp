<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>日志列表</title>
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
	      <label class="layui-form-label">登陆名称:</label>
	      <div class="layui-input-inline">
	        <input type="text" name="loginname" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">登陆IP:</label>
	      <div class="layui-input-inline">
	        <input type="text" name="loginip"   autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">开始时间:</label>
	      <div class="layui-input-inline">
	        <input type="text" name="startTime"  id="startTime" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">结束时间:</label>
	      <div class="layui-input-inline">
	        <input type="text" name="endTime"  id="endTime"  autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <a href="javascript:void(0)" class="layui-btn search_btn layui-btn-normal" >查询</a >
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	  </div>
</form>
	<table id="logInfoList" lay-filter="logInfoList"></table>
	<!--table工具条-->
	<script type="text/html" id="logInfoListTableBar">
<shiro:hasPermission name="info:batchdelete">
		<a class="layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
	</script>
	<!--操作-->
	<script type="text/html" id="logInfoListBar">
<shiro:hasPermission name="info:delete">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</shiro:hasPermission>
	</script>

<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
<script type="text/javascript">
layui.use(['form','layer','laydate','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;
    //渲染时间选择器
    laydate.render({
    	elem:'#startTime'
    });
    laydate.render({
    	elem:'#endTime'
    });
    //日志列表
    var tableIns = table.render({
        elem: '#logInfoList',
        url : '${ctx }/logInfo/loadAllLogInfo.action',
        cellMinWidth : 95,
        page : true,
        height : "full-225",
        limit : 20,
        toolbar:"#logInfoListTableBar",
        defaultToolbar: ['filter', 'print'],
        limits : [10,15,20,25],
        id : "logInfoListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', width:60, align:"center"},
            {field: 'loginname', title: '登陆人', width:350,align:'center'},
            {field: 'loginip', title: '登陆IP', align:'center'},
            {field: 'logintime', title: '登陆时间', align:'center'},
            {title: '操作', width:170, templet:'#logInfoListBar',fixed:"right",align:"center"}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
    	var params=$("#searchFrm").serialize();
        //搜索
    	tableIns.reload({
    		url:'${ctx }/logInfo/loadAllLogInfo.action?'+params
    	})
    });
    
    //监控表格头的添加和批量删除事件
    table.on("toolbar(logInfoList)",function(obj){
    	switch(obj.event){
    		case "batchDel":
    			batchDel();
    			break;
    	}
    })

    //批量删除
    function batchDel(){
        var checkStatus = table.checkStatus('logInfoListTable'),
            data = checkStatus.data,
            logInfoId = "";
        if(data.length > 0) {
            for (var i in data) {
            	if(i==0){
            		logInfoId+="ids="+data[i].id;
            	}else{
                	logInfoId+="&ids="+data[i].id;
            	}
            }
            layer.confirm('确定删除选中的日志？', {icon: 3, title: '提示信息'}, function (index) {
                  $.post("${ctx}/logInfo/deleteBatchLogInfo.action?"+logInfoId,function(data){
                	  	layer.msg(data.msg);
                		tableIns.reload();
                		layer.close(index);
                 }) 
            })
        }else{
            layer.msg("请选择需要删除的日志");
        }
    }

    //列表操作
    table.on('tool(logInfoList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
         if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此日志？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx}/logInfo/deleteLogInfo.action",{
                     id : data.id  //将需要删除的logInfoId作为参数传入
                 },function(data){
                	layer.msg(data.msg);
                    tableIns.reload();
                    layer.close(index);
                 })
            });
        }
    });
})
</script>

</body>
</html>