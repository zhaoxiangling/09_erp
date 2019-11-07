<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理--添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/resources/zTree/css/metroStyle/metroStyle.css"/>
	<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="${ctx }/resources/zTree/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="${ctx }/resources/zTree/plugin/js/selectTree.js"></script>
	<link rel="stylesheet" href="${ctx }/resources/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/zTree/plugin/css/index.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form" id="userFrm">
	<div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">所在部门</label>
      <div class="layui-input-inline">
        <div id="deptid" name="deptid" class="select-tree layui-form-select"></div>
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">排序码</label>
      <div class="layui-input-inline">
        <input type="text" name="ordernum" lay-verify="required" value="${userVo.ordernum }" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  <div class="layui-form-item">
  <div class="layui-inline">
      <label class="layui-form-label">领导部门</label>
      <div class="layui-input-inline">
        <div id="leaderpid" name="leaderpid" class="select-tree layui-form-select"></div>
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">领导姓名</label>
      <div class="layui-input-inline">
        	<select id="mgr" name="mgr">
        	</select>
      </div>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">用户姓名</label>
      <div class="layui-input-inline">
        <input type="text" name="name" id="name" lay-verify="required"  autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">登陆名称</label>
      <div class="layui-input-inline">
        <input type="text" name="loginname" id="loginname" lay-verify="required" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">用户备注</label>
    <div class="layui-input-block">
      <input type="text" name="remark"  placeholder="请输入用户备注" autocomplete="off" class="layui-input">
    </div>
  </div>
  
   <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">用户地址</label>
      <div class="layui-input-inline">
        <input type="text" name="address"   autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">用户性别</label>
      <div class="layui-input-inline">
      	 <input type="radio" name="sex" value="1" title="男" checked="">
     	 <input type="radio" name="sex" value="0" title="女" >
      </div>
    </div>
  </div>
  <div class="layui-form-item">
	  <div class="layui-inline">
	      <label class="layui-form-label">入职时间</label>
	      <div class="layui-input-inline">
	        <input type="text" name="hiredate" id="hiredate" lay-verify="required"  autocomplete="off" class="layui-input">
	      </div>
	    </div>
    <div class="layui-inline">
      <label class="layui-form-label">是否有效</label>
      <div class="layui-input-inline">
      	 <input type="radio" name="available" value="1" title="是" checked="" >
     	 <input type="radio" name="available" value="0" title="否" >
      </div>
    </div>
  </div>
   <div class="layui-form-item" style="text-align: center;">
		<button class="layui-btn" lay-submit="" lay-filter="addUser">提交</button>
		<button type="reset" class="layui-btn layui-btn-warm">重置</button>
	</div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">

$(document).ready(function () {
   $.post("${ctx}/dept/loadDeptLeftTree.action?available=1",function(zNodes){
	   initSelectTree("deptid", zNodes,false);
	   initSelectTree("leaderpid", zNodes,false);
	    $(".layui-nav-item a").bind("click", function () {
	        if (!$(this).parent().hasClass("layui-nav-itemed") && !$(this).parent().parent().hasClass("layui-nav-child")) {
	            $(".layui-nav-tree").find(".layui-nav-itemed").removeClass("layui-nav-itemed")
	        }
	    });
   })
   
   //给用户名添加失去焦点事件
   $("#name").blur(function(){
	   $.post("${ctx}/user/changeUserNameToPinyin.action",{name:this.value},
			   function(obj){
			var loginname=$("#loginname");
			loginname.val(obj);
	});
   })
   
});

/**
 * 在selectTree.js里面回调的方法
 */
function initLeaderNames(leaderdeptId){
	$.post("${ctx}/user/loadUserByDeptId.action",{deptid:leaderdeptId},function(obj){
			var msg=$("#mgr");
			var html="";
			for(var i=0;i<obj.length;i++){
				html+="<option value="+obj[i].id+" >"+obj[i].name+"</option>";
			}
			msg.html(html);
			form.render("select");
	},"json")
}


var form;
layui.use(['form','layer','jquery','laydate'],function(){
     form = layui.form;
    var  layer = parent.layer === undefined ? layui.layer : top.layer;
    var   $ = layui.jquery;
    var laydate=layui.laydate;
    laydate.render({
    	elem:"#hiredate"
    });
      //监听提交
        form.on('submit(addUser)', function(data){
            var data=$("#userFrm").serialize();
            //使用ajax提交
             $.ajax({
                url:'${ctx}/user/addUser.action',
                type:'POST',
                async:true,    //或false,是否异步
                data:data,
                timeout:5000,    //超时时间
                dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
                success:function(data){
                	layer.msg(data.msg);
                    //关闭添加的弹出层
                    var addIndex = parent.layer.getFrameIndex(window.name);
                    window.parent.layer.close(addIndex);
                    //刷新父页面的table
                    window.parent.tableIns.reload();
                },
               	 error:function(xhr,textStatus){
                }
            }) 
            return false;
        });
})
</script>
</body>
</html>