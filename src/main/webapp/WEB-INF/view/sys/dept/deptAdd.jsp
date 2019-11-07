<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>部门管理--添加</title>
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
<form class="layui-form" id="deptFrm">
	<div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">父级部门</label>
      <div class="layui-input-inline">
        <div id="pid" name="pid" class="select-tree layui-form-select"></div>
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">排序码</label>
      <div class="layui-input-inline">
        <input type="text" name="ordernum" lay-verify="required" value="${deptVo.ordernum }" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">部门名称</label>
    <div class="layui-input-block">
      <input type="text" name="name" lay-verify="required" placeholder="请输入部门名称" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">部门地址</label>
    <div class="layui-input-block">
      <input type="text" name="loc" lay-verify="required" placeholder="请输入部门地址" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">部门备注</label>
    <div class="layui-input-block">
      <textarea name="remark"  autocomplete="off" class="layui-textarea"></textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">是否展开</label>
      <div class="layui-input-inline">
      	 <input type="radio" name="open" value="1" title="是" >
     	 <input type="radio" name="open" value="0" title="否" checked="">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">是否父节点</label>
      <div class="layui-input-inline">
      	 <input type="radio" name="parent" value="1" title="是" >
     	 <input type="radio" name="parent" value="0" title="否" checked="">
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
		<button class="layui-btn" lay-submit="" lay-filter="addDept">提交</button>
		<button type="reset" class="layui-btn layui-btn-warm">重置</button>
	</div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">

$(document).ready(function () {
   $.post("${ctx}/dept/loadDeptLeftTree.action?available=1",function(zNodes){
	   initSelectTree("pid", zNodes,false);
	    $(".layui-nav-item a").bind("click", function () {
	        if (!$(this).parent().hasClass("layui-nav-itemed") && !$(this).parent().parent().hasClass("layui-nav-child")) {
	            $(".layui-nav-tree").find(".layui-nav-itemed").removeClass("layui-nav-itemed")
	        }
	    });
   })
});




layui.use(['form','layer','jquery'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;
        
      //监听提交
        form.on('submit(addDept)', function(data){
            var data=$("#deptFrm").serialize();
            //使用ajax提交
             $.ajax({
                url:'${ctx}/dept/addDept.action',
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
                  	//刷新左边的部门树
                    window.parent.parent.left.initTree();
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