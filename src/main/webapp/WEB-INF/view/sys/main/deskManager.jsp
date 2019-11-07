<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>首页--系统工作台</title>
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
	<blockquote class="layui-elem-quote layui-bg-green">
		<div id="nowTime"></div>
	</blockquote>
	<div class="layui-row layui-col-space10">
		<div class="layui-col-lg6 layui-col-md6">
			<blockquote class="layui-elem-quote title">系统公告 <i class="layui-icon layui-red">&#xe756;</i>
				<span style="float: right;">
					<a href="#">
						更多>>
					</a>
				</span>
			</blockquote>
			<table class="layui-table mag0" lay-skin="line">
				<colgroup>
					<col>
					<col width="110">
				</colgroup>
				<tbody class="hot_news"></tbody>
			</table>
		</div>
		<div class="layui-col-lg6 layui-col-md6">
			<blockquote class="layui-elem-quote title">库存预警 <i class="layui-icon layui-red">&#xe6c9;</i>
			<span style="float: right;">
					<a href="#">
						更多>>
					</a>
				</span>
			</blockquote>
			<table class="layui-table mag0" lay-skin="line">
				<tbody class="hot_yujing">
				<tr>
					<td>旺旺雪饼1</td>
					<td align="center">10[包]</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">进货</button>
					</td>
				</tr>
				<tr>
					<td>旺旺雪饼2</td>
					<td align="center">10[包]</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">进货</button>
					</td>
				</tr>
				<tr>
					<td>旺旺雪饼3</td>
					<td align="center">10[包]</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">进货</button>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- 审批相关 -->
	<div class="layui-row layui-col-space10">
		<div class="layui-col-lg6 layui-col-md6">
			<blockquote class="layui-elem-quote title">我的待办任务 <i class="layui-icon layui-red">&#xe66f;</i>
			<span style="float: right;">
					<a href="#">
						更多>>
					</a>
				</span>
			</blockquote>
			<table class="layui-table mag0" lay-skin="line">
				<tr>
					<td>张三的请假单</td>
					<td align="center">5天</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">审批</button>
					</td>
				</tr>
				<tr>
					<td>李四的请假单</td>
					<td align="center">5天</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">审批</button>
					</td>
				</tr>
				<tr>
					<td>张三的报销单</td>
					<td align="center">500[rmb]</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">审批</button>
					</td>
				</tr>
			</table>
		</div>
		<div class="layui-col-lg6 layui-col-md6">
			<blockquote class="layui-elem-quote title">我的申请任务 <i class="layui-icon layui-red">&#xe770;</i>
			<span style="float: right;">
					<a href="#">
						更多>>
					</a>
				</span>
			</blockquote>
			<table class="layui-table mag0" lay-skin="line">
				<tbody class="hot_yujing">
				<tr>
					<td>我的2018年9月12日请假单</td>
					<td align="center">5</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">查看审批进度</button>
					</td>
				</tr>
				<tr>
					<td>我的2018年9月13日报销单</td>
					<td align="center">100[RMB]</td>
					<td align="center">
						 <button class="layui-btn layui-btn-danger layui-btn-sm">查看审批进度</button>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="${ctx }/resources/layui/layui.js"></script>
<script type="text/javascript">
//获取系统时间
var newDate = '';
getLangDate();
//值小于10时，在前面补0
function dateFilter(date){
    if(date < 10){return "0"+date;}
    return date;
}
function getLangDate(){
    var dateObj = new Date(); //表示当前系统时间的Date对象
    var year = dateObj.getFullYear(); //当前系统时间的完整年份值
    var month = dateObj.getMonth()+1; //当前系统时间的月份值
    var date = dateObj.getDate(); //当前系统时间的月份中的日
    var day = dateObj.getDay(); //当前系统时间中的星期值
    var weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
    var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
    var hour = dateObj.getHours(); //当前系统时间的小时值
    var minute = dateObj.getMinutes(); //当前系统时间的分钟值
    var second = dateObj.getSeconds(); //当前系统时间的秒钟值
    var timeValue = "" +((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午" ); //当前时间属于上午、晚上还是下午
    newDate = dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+" "+dateFilter(hour)+":"+dateFilter(minute)+":"+dateFilter(second);
    document.getElementById("nowTime").innerHTML = "亲爱的${user.name}，"+timeValue+"好！ 欢迎使用尚学堂库存管理系统。当前时间为： "+newDate+"　"+week;
    setTimeout("getLangDate()",1000);
}

layui.use(['form','element','layer','jquery'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        element = layui.element;
        $ = layui.jquery;
    //上次登录时间【此处应该从接口获取，实际使用中请自行更换】
    $(".loginTime").html(newDate.split("日")[0]+"日</br>"+newDate.split("日")[1]);
    //icon动画
    $(".panel a").hover(function(){
        $(this).find(".layui-anim").addClass("layui-anim-scaleSpring");
    },function(){
        $(this).find(".layui-anim").removeClass("layui-anim-scaleSpring");
    })
    $(".panel a").click(function(){
        parent.addTab($(this));
    })
    //最新公告列表
    $.post("${ctx }/notice/loadAllNotices.action?page=1&limit=4",function(data){
        var hotNewsHtml = '';
        for(var i=0;i<data.data.length;i++){
            hotNewsHtml += '<tr>'
                +'<td align="left"><a href="javascript:;"> '+data.data[i].title+'</a></td>'
                +'<td>'+data.data[i].createtime.substr(0,11)+'</td>'
                +'<td align="center"><button class="layui-btn layui-btn-danger layui-btn-sm" onclick="show('+data.data[i].id+')" >查看</button></td>'
                +'</tr>';
        }
        $(".hot_news").html(hotNewsHtml);
    },"json");
});
//查看最新公告
function show(id){
	var index = layui.layer.open({
        title : "查看公告",
        type : 2,
        area:["800px","500px"],
        content : "${ctx }/notice/showNotice.action?id="+id
    })
    //layui.layer.full(index);
    //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
    $(window).on("resize",function(){
        layui.layer.full(index);
    })
}
</script>
</body>

</html>