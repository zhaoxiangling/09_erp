<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib  prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>商品管理</title>
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
			      <label class="layui-form-label" >商品名称:</label>
			      <div class="layui-input-inline">
			        <input type="text" name="goodsname"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label"  >供应商:</label>
			      <div class="layui-input-inline">
			        <input type="text" name="providername"  autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label"  >开始时间:</label>
			      <div class="layui-input-inline">
			        <input type="tel" name="startDate" id="startDate" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			      <label class="layui-form-label"  >结束时间:</label>
			      <div class="layui-input-inline">
			        <input type="tel" name="endDate" id="endDate" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			    <div class="layui-inline">
			        <a class="layui-btn search_btn" >查询</a>
					<button type="reset" class="layui-btn layui-btn-warm">清空</button>
			    </div>
			  </div>
		</form>
		<table id="inportList" lay-filter="inportList"></table>
		<script type="text/html" id="tableToolBar">
			<a class="layui-btn layui-btn layui-btn" lay-event="add">添加</a>
			<a class="layui-btn layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
		</script>
		<!--操作-->
		<script type="text/html" id="inportListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
	<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
</body>
<script type="text/javascript">
var tableIns;
layui.use(['form','layer','table','laydate'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate=layui.laydate,
        table = layui.table;

    laydate.render({
    	elem:'#startDate'
    })
    laydate.render({
    	elem:'#endDate'
    })
    
    
    //商品列表
     tableIns = table.render({
        elem: '#inportList',
        url : '${ctx }/inport/loadInport.action',
        cellMinWidth : 95,
        page : true,
        height : "full-200",
        limits : [10,15,20,25],
        limit : 10,
        toolbar: '#tableToolBar',
        defaultToolbar: ['filter'],
        id : "inportListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: '进货ID', minWidth:100, align:"center"},
            {field: 'goodsname', title: '商品名称', minWidth:100, align:"center"},
            {field: 'providername', title: '供应商名称', minWidth:100, align:"center"},
            {field: 'size', title: '商品规格', minWidth:100, align:"center"},
            {field: 'inporttime', title: '进货时间', minWidth:100, align:"center"},
            {field: 'number', title: '进货数据', minWidth:100, align:"center"},
            {field: 'inportprice', title: '进货价格', minWidth:100, align:"center"},
            {field: 'paytype', title: '支持类型', minWidth:100, align:"center"},
            {field: 'remark', title: '备注', minWidth:100, align:"center"},
            {field: 'operateperson', title: '操作员', minWidth:100, align:"center"},
            {title: '操作', minWidth:175, templet:'#inportListBar',fixed:"right",align:"center"}
        ]]
    });

  //监听头工具栏事件
    table.on('toolbar(inportList)', function(obj){
        switch(obj.event){
	            case 'add':
	            	toAddInport();
            	break;
            	case 'batchDel':
           		 batchDelete();
                break;
        };
    });
    //查询
    $(".search_btn").on("click",function(){
    	var params=$("#searchForm").serialize();
    	table.reload('inportListTable', {
    		  url: '${ctx }/inport/loadInport.action?'+params
    	});
    });
   
    //添加商品
   function toAddInport(){
        var index = layui.layer.open({
            title : "添加商品进货",
            type : 2,//ifream层
            area:["700px","500px"],
            content : "${ctx }/inport/toAddInport.action",
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回商品列表', '.layui-layer-setwin .layui-layer-close', {
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
    //修改商品
    function updateInport(data){
    	var index = layui.layer.open({
            title : "修改商品进货",
            type : 2,
            area:["700px","500px"],
            content : "${ctx }/inport/toUpdateInport.action?id="+data.id,
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回商品列表', '.layui-layer-setwin .layui-layer-close', {
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
    table.on('tool(inportList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
        	updateInport(data);//data主当前点击的行
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删【'+data.inportname+'】商品吗？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx }/inport/deleteInport.action",{
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
    function batchDelete(){
    	//得到当前表格里面的checkbox的选中对象集合
        var checkStatus = table.checkStatus('inportListTable'),//选中状态
            data = checkStatus.data;//选中的对象集
            var ids="a=1";
        if(data.length > 0) {
            for (var i in data) {
            	ids+="&ids="+data[i].id;
            }
            layer.confirm('确定删除选中的商品？', {icon: 3, title: '提示信息'}, function (index) {
                 $.post("${ctx }/inport/batchDeleteInport.action?"+ids,function(data){
                	 //刷新table
                     tableIns.reload();
                 	 //关闭提示框
                	layer.close(index);
                })
            })
        }else{
            layer.msg("请选择需要删除的商品进货信息");
        }
    }
})
//供inportLeft.jsp调用的方法
 function reloadTable(id){
	tableIns.reload({
		  where: { //设定异步数据接口的额外参数，任意设
		    providerid: id
		  }
		  ,page: {
		    curr: 1 //重新从第 1 页开始
		  }
		});
    }
</script>
</html>