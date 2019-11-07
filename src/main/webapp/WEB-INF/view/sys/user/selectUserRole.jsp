<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户管理--分配角色</title>
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
<table id="roleList" lay-filter="roleList"></table>
<br>
  <div class="layui-form-item" style="text-align: center;">
	   <a href="javascript:void(0)" class="layui-btn saveUserRole_btn" >保存</a>
 </div>
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
        //角色列表
        tableIns = table.render({
            elem: '#roleList',
            url : '${ctx }/user/loadUserRoleList.action?id=${userVo.id}',
            cellMinWidth : 95,
            toolbar: '#tableToolBar',
            height : "full-80",
            defaultToolbar: ['filter'],
            id : "roleListTable",
            cols : [[
                {type: "checkbox", fixed:"left", width:50},
                {field: 'id', title: '角色ID', minWidth:100, align:"center"},
                {field: 'name', title: '角色名称', minWidth:100, align:"center"},
                {field: 'remark', title: '角色备注', minWidth:100, align:"center"}
            ]]
        });
        
        //保存用户和角色之间的关系
        $(".saveUserRole_btn").click(function(){
        	//1.得到选中的角色
        	var checkStatus = table.checkStatus('roleListTable'); //roleList 即为基础参数 id 对应的值
        	var data=checkStatus.data;
        	//组装ids
        	var params="id=${userVo.id}";
        	for(var i=0;i<data.length;i++){
        		params+="&ids="+data[i].id;
        	}
        	$.post("${ctx}/user/saveUserRole.action?"+params,function(obj){
        		layer.msg(obj.msg);
        	})

        });
    })
    
</script>
</html>