<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理--列表</title>
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
	      <label class="layui-form-label">用户名称</label>
	      <div class="layui-input-inline">
	        <input type="text" name="name" autocomplete="off" class="layui-input">
	      </div>
	    </div>
	    <div class="layui-inline">
	      <label class="layui-form-label">用户地址</label>
	      <div class="layui-input-inline">
	        <input type="text" name="address"   autocomplete="off" class="layui-input">
	      </div>
	    </div>
	  </div>
	  <div class="layui-form-item" style="text-align: center;">
	      <a href="javascript:void(0)" class="layui-btn search_btn" >查询</a>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
	   
</form>
	<table id="userList" lay-filter="userList"></table>
	<!--table工具条-->
	<script type="text/html" id="userListTableBar">
<shiro:hasPermission name="user:create">
		<a class="layui-btn  layui-btn-warm" lay-event="add">添加</a>
</shiro:hasPermission>
<shiro:hasPermission name="user:batchdelete">
		<a class="layui-btn  layui-btn-denger " lay-event="batchDel">批量删除</a>
</shiro:hasPermission>
	</script>
	<!--操作-->
	<script type="text/html" id="userListBar">
<shiro:hasPermission name="user:update">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="user:delete">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
</shiro:hasPermission>
<shiro:hasPermission name="user:resetpwd">
		<a class="layui-btn layui-btn-xs" lay-event="resetPwd">重置密码</a>
</shiro:hasPermission>
<shiro:hasPermission name="user:selectRole">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="toSelectRole">分配角色</a>
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
    //用户列表
     tableIns = table.render({
        elem: '#userList',
        url : '${ctx}/user/loadAllUser.action',
        cellMinWidth : 95,
        page : true,
        height : "full-160",
        toolbar:"#userListTableBar",
        defaultToolbar: ['filter', 'print'],
        limits : [10,15,20,25],
        id : "userListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', align:"center"},
            {field: 'name', title: '用户姓名',align:'center'},
            {field: 'loginname', title: '登陆名',align:'center'},
            {field: 'deptname', title: '所有部门', align:'center'},
            {field: 'leadername', title: '直接领导', align:'center'},
            {field: 'address', title: '用户地址', align:'center'},
            {field: 'remark', title: '用户备注', align:'center'},
            {field: 'sex', title: '性别', align:'center',templet:function(d){
            	return d.sex==1?'<font color=blue>男</font>':'<font color=red>女</font>';
            }},
            {field: 'hiredate', title: '入职时间', align:'center'},
            {field: 'imgpath', title: '是否有效', align:'center',templet:function(d){
            	return "<img width=30px height=30px src="+d.imgpath+" />";
            }},
            {field: 'available', title: '是否可用', align:'center',templet:function(d){
            	return d.available==1?'<font color=blue>可用</font>':'<font color=red>不可用</font>';
            }},
            {field: 'ordernum', title: '排序码', align:'center'},
            {title: '操作', width:280, templet:'#userListBar',fixed:"right",align:"center"}
        ]]
    });

    //搜索
    $(".search_btn").on("click",function(){
    	var params=$("#searchFrm").serialize();
        //搜索
    	tableIns.reload({
    		url:'${ctx}/user/loadAllUser.action?'+params
    	})
    });
    
    //监控表格头的添加和批量删除事件
    table.on("toolbar(userList)",function(obj){
    	switch(obj.event){
    		case "add":
    			addUser();
    			break;
    		case "batchDel":
    			batchDel();
    			break;
    	}
    })

    //添加用户
    function addUser(){
        var index = layui.layer.open({
            title : "添加用户",
            type : 2,
            area:["700px",'550px'],
            content : "${ctx}/user/toAddUser.action",
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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
        var checkStatus = table.checkStatus('userListTable'),
            data = checkStatus.data;
        var userIds="";
        if(data.length > 0) {
            for (var i in data) {
            	if(i==0){
            		userIds+="ids="+data[i].id;
            	}else{
            		userIds+="&ids="+data[i].id;
            	}
            }
            layer.confirm('确定删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
                 $.get("${ctx}/user/deleteUserBatch.action?"+userIds,function(data){
                	 layer.msg(data.msg);
                	 tableIns.reload();
                     layer.close(index);
                 })
            })
        }else{
            layer.msg("请选择需要删除的用户");
        }
    }

    //列表操作
    table.on('tool(userList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;
        if(layEvent === 'edit'){ //编辑
            updateUser(data);
        } else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此用户？',{icon:3, title:'提示信息'},function(index){
                 $.post("${ctx}/user/deleteUser.action",{
                     id : data.id  
                 },function(data){
                	 layer.msg(data.msg);
                    tableIns.reload();
                    layer.close(index);
                 })
            });
        } else if(layEvent === 'resetPwd'){ 
        	layer.confirm('确定重置【'+data.name+'】此用户的密码？',{icon:3, title:'提示信息'},function(index){
                $.post("${ctx}/user/resetPwd.action",{
                    id : data.id  
                },function(data){
                	layer.msg(data.msg);
                   layer.close(index);
                })
           });
        }else if(layEvent==='toSelectRole'){
        	openUserRole(data);
        }
    });
    
    //修改
    function updateUser(data){
    	var index = layui.layer.open({
            title : "修改用户",
            type : 2,
            area:["700px",'550px'],
            content : "${ctx}/user/toUpdateUser.action?id="+data.id,
            success : function(layero, index){
                setTimeout(function(){
                    layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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
    
    //打开分配角色的页面
   function openUserRole(data){
	   var index = layui.layer.open({
           title : "分配【"+data.name+"】的角色",
           type : 2,
           area:["700px",'550px'],
           content : "${ctx}/user/toUserSelectRole.action?id="+data.id,
           success : function(layero, index){
               setTimeout(function(){
                   layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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