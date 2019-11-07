<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>部门管理--列表</title>
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
	      <label class="layui-form-label">部门名称</label>
	      <div class="layui-input-inline">
	        <input type="text" name="name" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">部门地址</label>
	      <div class="layui-input-inline">
	        <input type="text" name="loc"   autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">部门备注</label>
	      <div class="layui-input-inline">
	        <input type="text" name="remark"   autocomplete="off" class="layui-input">
	      </div>
	    </div>
	  </div>
	  <div class="layui-form-item" style="text-align: center;">
	      <a href="javascript:void(0)" class="layui-btn search_btn" >查询</a>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	   
</form>
	<table id="deptList" lay-filter="deptList"></table>
	<!--table工具条-->
	
	<script type="text/html" id="deptListTableBar">
<shiro:hasPermission name="dept:create">
		<a class="layui-btn  layui-btn-warm" lay-event="add">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="dept:batchdelete">
		<a class="layui-btn  layui-btn-denger " lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
	</script>
	<!--操作-->
	<script type="text/html" id="deptListBar">
<shiro:hasPermission name="dept:update">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="dept:delete">
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
    //部门列表
     tableIns = table.render({
        elem: '#deptList',
        url : '${ctx}/dept/loadAllDept.action',
        cellMinWidth : 95,
        page : true,
        height : "full-160",
        toolbar:"#deptListTableBar",
        defaultToolbar: ['filter', 'print'],
        limits : [10,15,20,25],
        id : "deptListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', align:"center"},
            {field: 'pid', title: '父级部门ID', align:"center"},
            {field: 'name', title: '部门名称',align:'center'},
            {field: 'loc', title: '部门地址', align:'center'},
            {field: 'remark', title: '部门备注', align:'center'},
            {field: 'open', title: '是否展开', align:'center',templet:function(d){
            	return d.open==1?'<font color=blue>展开</font>':'<font color=red>不展开</font>';
            }},
            {field: 'parent', title: '是否父部门', align:'center',templet:function(d){
            	return d.parent==1?'<font color=blue>是</font>':'<font color=red>否</font>';
            }},
            {field: 'available', title: '是否有效', align:'center',templet:function(d){
            	return d.available==1?'<font color=blue>有效</font>':'<font color=red>无效</font>';
            }},
            {field: 'ordernum', title: '排序码', align:'center'},
            {title: '操作', width:170, templet:'#deptListBar',fixed:"right",align:"center"}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
    	var params=$("#searchFrm").serialize();
        //搜索
    	tableIns.reload({
    		url:'${ctx}/dept/loadAllDept.action?'+params
    	})
    });
    
    //监控表格头的添加和批量删除事件
    table.on("toolbar(deptList)",function(obj){
    	switch(obj.event){
    		case "add":
    			addDept();
    			break;
    		case "batchDel":
    			batchDel();
    			break;
    	}
    })

    //添加部门
    function addDept(){
        var index = layui.layer.open({
            title : "添加部门",
            type : 2,
            area:["700px",'550px'],
            content : "${ctx}/dept/toAddDept.action",
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回部门列表', '.layui-layer-setwin .layui-layer-close', {
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
        var checkStatus = table.checkStatus('deptListTable'),
            data = checkStatus.data;
        var deptIds="";
        if(data.length > 0) {
            for (var i in data) {
            	if(i==0){
            		deptIds+="ids="+data[i].id;
            	}else{
            		deptIds+="&ids="+data[i].id;
            	}
            }
            layer.confirm('确定删除选中的部门？', {icon: 3, title: '提示信息'}, function (index) {
                 $.get("${ctx}/dept/deleteDeptBatch.action?"+deptIds,function(data){
                	 tableIns.reload();
                     window.parent.left.initTree();//刷新左边的树
                     layer.close(index);
                 })
            })
        }else{
            layer.msg("请选择需要删除的部门");
        }
    }

    //列表操作
    table.on('tool(deptList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
            updateDept(data);
        } else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此部门？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx}/dept/deleteDept.action",{
                     id : data.id  
                 },function(data){
                    tableIns.reload();
                    window.parent.left.initTree();//刷新左边的树
                    layer.close(index);
                 })
            });
        } else if(layEvent === 'look'){ //预览
            layer.alert("此功能需要前台展示，实际开发中传入对应的必要参数进行部门内容页面访问")
        }
    });
    
    //修改
    function updateDept(data){
    	var index = layui.layer.open({
            title : "修改部门",
            type : 2,
            area:["700px",'550px'],
            content : "${ctx}/dept/toUpdateDept.action?id="+data.id,
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回部门列表', '.layui-layer-setwin .layui-layer-close', {
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