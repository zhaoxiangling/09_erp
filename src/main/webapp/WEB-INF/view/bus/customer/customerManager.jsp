<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib  prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>客户管理</title>
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
			      <label class="layui-form-label" >客户名称:</label>
			      <div class="layui-input-inline">
			        <input type="text" name="customername"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label"  >客户电话:</label>
			      <div class="layui-input-inline">
			        <input type="text" name="phone"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label" >联系人:</label>
			      <div class="layui-input-inline">
			        <input type="tel" name="connectionperson" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			  </div>
			   <div class="layui-form-item" style="text-align: center;">
			      	 <a class="layui-btn search_btn" >查询</a>
					 <button type="reset" class="layui-btn layui-btn-warm">清空</button>
			    </div>
		</form>
		<table id="customerList" lay-filter="customerList"></table>
		<script type="text/html" id="tableToolBar">
<shiro:hasPermission name="customer:create">
			<a class="layui-btn layui-btn layui-btn" lay-event="add">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="customer:batchdelete">
			<a class="layui-btn layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
		</script>
		<!--操作-->
		<script type="text/html" id="customerListBar">
<shiro:hasPermission name="customer:update">
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="customer:delete">
			<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</shiro:hasPermission>
	</script>
	<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
var tableIns;
layui.use(['form','layer','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table;

    //客户列表
     tableIns = table.render({
        elem: '#customerList',
        url : '${ctx }/customer/loadCustomers.action',
        cellMinWidth : 95,
        page : true,
        height : "full-200",
        limits : [10,15,20,25],
        limit : 10,
        toolbar: '#tableToolBar',
        defaultToolbar: ['filter'],
        id : "customerListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: '客户ID', minWidth:100, align:"center"},
            {field: 'customername', title: '客户名称', minWidth:100, align:"center"},
            {field: 'zip', title: '客户邮编', minWidth:100, align:"center"},
            {field: 'address', title: '客户地址', minWidth:100, align:"center"},
            {field: 'telephone', title: '客户电话', minWidth:100, align:"center"},
            {field: 'connectionperson', title: '联系人', minWidth:100, align:"center"},
            {field: 'phone', title: '联系人电话', minWidth:100, align:"center"},
            {field: 'bank', title: '开户行', minWidth:100, align:"center"},
            {field: 'account', title: '账户', minWidth:100, align:"center"},
            {field: 'email', title: '邮编', minWidth:100, align:"center"},
            {field: 'fax', title: '传真', minWidth:100, align:"center"},
            {field: 'available', title: '是否可用',  align:'center',templet:function(d){
                return d.available ==1 ? "<font color=blue>可用</font>" : "<font color=red>不可用</font>";
            }},
            {title: '操作', minWidth:175, templet:'#customerListBar',fixed:"right",align:"center"}
        ]]
    });

     //监听头工具栏事件
     table.on('toolbar(customerList)', function(obj){
         switch(obj.event){
	            case 'add':
	            	toAddCustomer();
             	break;
             	case 'batchDel':
            		 batchDelete();
                 break;
         };
     });
    //查询
    $(".search_btn").on("click",function(){
    	var params=$("#searchForm").serialize();
    	table.reload('customerListTable', {
    		  url: '${ctx }/customer/loadCustomers.action?'+params
    	});
    });
   
    //添加客户
    function toAddCustomer(){
        var index = layui.layer.open({
            title : "添加客户",
            type : 2,//ifream层
            area:["800px","520px"],
            content : "${ctx }/customer/toAddCustomer.action",
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回客户列表', '.layui-layer-setwin .layui-layer-close', {
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
    //修改客户
    function updateCustomer(data){
    	var index = layui.layer.open({
            title : "修改客户",
            type : 2,
            area:["800px","520px"],
            content : "${ctx }/customer/toUpdateCustomer.action?id="+data.id,
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回客户列表', '.layui-layer-setwin .layui-layer-close', {
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
    table.on('tool(customerList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
        	updateCustomer(data);//data主当前点击的行
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删【'+data.customername+'】客户吗？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx }/customer/deleteCustomer.action",{
                     id : data.id  //将需要删除的id作为参数传入
                 },function(data){
                	 //刷新table
                    tableIns.reload();
                	 //关闭提示框
                    layer.close(index);
                 })
            });
        }
    });
    //批量删除
   function  batchDelete(){
    	//得到当前表格里面的checkbox的选中对象集合
        var checkStatus = table.checkStatus('customerListTable'),//选中状态
            data = checkStatus.data;//选中的对象集
            var ids="a=1";
        if(data.length > 0) {
            for (var i in data) {
            	ids+="&ids="+data[i].id;
            }
            layer.confirm('确定删除选中的客户？', {icon: 3, title: '提示信息'}, function (index) {
                 $.post("${ctx }/customer/batchDeleteCustomer.action?"+ids,function(data){
                	 //刷新table
                     tableIns.reload();
                 	 //关闭提示框
                	layer.close(index);
                })
            })
        }else{
            layer.msg("请选择需要删除的客户");
        }
    }
})
</script>
</html>