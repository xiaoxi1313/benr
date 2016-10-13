<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%@page import="com.newvery.utils.TimeUtil"%>
<!DOCTYPE html>
<html lang="en" class="app topadminhome">
<head>  
  <meta charset="utf-8" />
  <title>本然数据库</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
  <link rel="shortcut icon" type="image/x-icon" href="<%=UrlHelper.getHomeUrl()%>favicon.ico">
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <!--[if lt IE 9]>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/html5shiv.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/respond.min.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/excanvas.js"></script>
  <![endif]-->  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#batchDiv').hide();
	
	$(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			$('#logForm').submit();
		}
	});
	
	if($("#orderById").val() != '') {
		$(".th-sortable").each(function(){
			if($(this).attr('orderfield') == $("#orderById").val()) {
				$(this).attr('orderCond',$("#oderByCondition").val());
				
				if($("#oderByCondition").val() == 'desc') {
					$(this).addClass("active");
				}
			}
			
		});
	}
});
function reload() {
	location.reload();
}
</script>
</head>
<body class="" >
<%@include file="../head.jsp" %>

	<section id="content">
          <section class="hbox stretch">
          <section>
       <section class="vbox"> 
            <section class="scrollable padder">
              <div class="m-b-md">
              <div class="row">
                <div class="col-sm-6">
                <h3 class="m-b-none">用户登陆记录</h3>
                <small>您可以查看所有用户的登录情况。</small>
              </div>
              </div>
              </div>

              <section class="panel panel-default">
                <header class="panel-heading">
                  访问记录
                </header>
                <div class="row wrapper">
                <div class="col-sm-5 m-b-xs">
                <div class="btn-group">
                <button type="button" class="btn btn-sm btn-default" title="Refresh" onclick="reload()"><i class="fa fa-refresh"></i></button>
                <!-- <button type="button" class="btn btn-sm btn-default" title="Remove"><i class="fa fa-trash-o"></i></button> -->
                   </div>               
                  </div>
                  
                  <div class="col-sm-3 pull-right-lg">
                    <div class="input-group">
                      <input type="text" class="input-sm form-control" name="userLog.user.userName" value="<s:property value='userLog.user.userName'/>" placeholder="搜索" />
                      <span class="input-group-btn">
                      <button class="btn btn-sm btn-default" type="submit"><i class="fa fa-search"></i></button>
                      </span>
                    </div>
                  </div>
                </div>
                <input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
				<input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
                <div class="table-responsive userlog">
                  <table class="table table-striped b-t b-light">
                    <thead>
                      <tr>
                        <!-- <th width="20"><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox"><i></i></label></th> -->
                        <th>用户ID</th>
                        <th class="th-sortable" data-toggle="class" orderfield="b.userName" orderCond="asc">用户名
                          <span class="th-sort">
                            <i class="fa fa-sort-down text"></i>
                            <i class="fa fa-sort-up text-active"></i>
                            <i class="fa fa-sort"></i>
                          </span>
                        </th>
                        <th class="th-sortable" data-toggle="class" orderfield="a.createdate" orderCond="asc">登录时间
                        <span class="th-sort">
                          <i class="fa fa-sort-down text"></i>
                          <i class="fa fa-sort-up text-active"></i>
                          <i class="fa fa-sort"></i>
                        </span></th>
                        <th class="th-sortable" data-toggle="class" orderfield="a.ip" orderCond="asc">IP地址
                        <span class="th-sort">
                          <i class="fa fa-sort-down text"></i>
                          <i class="fa fa-sort-up text-active"></i>
                          <i class="fa fa-sort"></i>
                        </span></th>
                        <th>浏览器</th>
                        <th>权限</th>
                      </tr>
                    </thead>
                    <tbody>
                    <s:iterator value="logList" id="log" status="u">
                      <tr>
                        <!-- <td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="post[]"><i></i></label></td> -->
                        <td><s:property value="user.id" /></td>
                        <td><s:property value="user.userName" /></td>
                        <td><s:date name="#log.createdate" format="yyyy-MM-dd" />&nbsp;<span><s:date name="#log.createdate" format="HH:mm:ss" /></span></td>
                        <td><s:property value="ip" /></td>
                        <td><s:property value="browser" /></td>
                        <td><s:property value="user.role.name" /></td>
                      </tr>
                    </s:iterator>
                    </tbody>
                  </table>
                </div>
                <footer class="panel-footer">
                  <pages:pages page="page" params="params"/>
                </footer>
              </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
         </section>
          </section>


 
</body>
</html>