<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <!--[if lt IE 9]>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/html5shiv.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/respond.min.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/excanvas.js"></script>
  <![endif]-->  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js" charset="UTF-8"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js" charset="UTF-8"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.tooltip.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.spline.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.pie.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.resize.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.grow.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
<script type="text/javascript">
  $('.form_date').datetimepicker({
      language: 'zh-CN',
      format: 'yyyy-mm-dd',
      weekStart: 1,
      todayBtn: 1,
      autoclose: 1,
      todayHighlight: 1,
      startView: 2,
      minView: 2,
      forceParse: 0
  });
$(document).ready(function(){
		$("#iframe").load(function(){
			var mainheight = $(this).contents().find("body").height()+30;
			$(this).height(mainheight);
		});
});

function menuOnclick(url) {
	$('#iframe').attr('src', url);
}

function logout() {
	if (confirm("确定退出吗？")) {
		location.href = "logout.action";
	}
}
</script>
</head>
<body class="" >
<section class="vbox">
    <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
      <div class="navbar-header aside-md dk">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="fa fa-bars"></i>
        </a>
        <a href="index.html" class="navbar-brand">
          <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/logo.jpg" class="m-r-sm" alt="scale">
          <span class="hidden-nav-xs">本然数据库</span>
        </a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user">
          <i class="fa fa-cog"></i>
        </a>
      </div>
      
      <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" role="search">
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-btn">
              <button type="submit" class="btn btn-sm bg-white b-white btn-icon"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border" placeholder="请搜索...">            
          </div>
        </div>
      </form>
      <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <span class="thumb-sm avatar pull-left">
              <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a0.png" alt="...">
            </span>
            <s:property value="#session.user.userName"/> <b class="caret"></b>
          </a>
          <ul class="dropdown-menu animated fadeInRight">            
            <li>
              <span class="arrow top"></span>
              <a href="#">个人资料设置</a>
            </li>
            <li class="divider"></li>
            <li>
              <a href="javascript:void(0)" onclick="logout()" data-toggle="ajaxModal" >登出</a>
            </li>
          </ul>
        </li>
      </ul>      
    </header>
    <section>
      <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black aside-md hidden-print hidden-xs nav-xs" id="nav">          
          <section class="vbox">
            <section class="w-f scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                <div class="clearfix wrapper dk nav-user hidden-xs">
                  <div class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <span class="thumb avatar pull-left m-r">                        
                        <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a0.png" class="dker" alt="...">
                        <i class="on md b-black"></i>
                      </span>
                      <span class="hidden-nav-xs clear">
                        <span class="block m-t-xs">
                          <strong class="font-bold text-lt">张小帅</strong> 
                          <b class="caret"></b>
                        </span>
                        <span class="text-muted text-xs block">高级研究员</span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">                      
                      <li>
                        <span class="arrow top hidden-nav-xs"></span>
                        <a href="#">个人资料设置</a>
                      </li>
                      <li class="divider"></li>
                      <li>
                        <a href="modal.lockme.html" data-toggle="ajaxModal" >登出</a>
                      </li>
                    </ul>
                  </div>
                </div>                


                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">主菜单</div>
                  <ul class="nav nav-main" data-ride="collapse">
                    <li class="active">
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-stack icon">
                        </i>
                        <span class="font-bold">我的项目</span>
                      </a>
                      <ul class="nav dk">
                        <li >
                          <a href="javascript:void(0)" onclick="menuOnclick('user_allMember.action')"  class="auto">                                               
                            <i class="i i-dot"></i>

                            <span>查看全部成员</span>
                          </a>
                        </li>
                        <li >
                          <a href="javascript:void(0)" onclick="menuOnclick('favorite_list.action')" class="auto">                                                         
                            <i class="i i-dot"></i>

                            <span>收藏夹</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li>
                      <a href="#" class="auto">
                        <i class="i i-docs icon">
                        </i>
                        <span class="font-bold">全部项目</span>
                      </a>
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-lab icon">
                        </i>
                        <span class="font-bold">系统管理</span>
                      </a>
                      <ul class="nav dk">
                        <li >
                          <a href="javascript:void(0)" onclick="menuOnclick('category_manage.action')" class="auto">                                                      
                            <i class="i i-dot"></i>

                            <span>分类管理</span>
                          </a>
                        </li>
                        <li >
                          <a href="javascript:void(0)" onclick="menuOnclick('tag_manage.action')" class="auto">                                                                              
                            <i class="i i-dot"></i>

                            <span>标签管理</span>
                          </a>
                        </li>
                        <li >
                          <a href="javascript:void(0)" onclick="menuOnclick('user_list.action')" class="auto">                                                               
                            <i class="i i-dot"></i>

                            <span>用户管理</span>
                          </a>
                        </li>
                    </ul>
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-statistics icon">
                        </i>
                        <span class="font-bold">数据分析</span>
                      </a>
                      <ul class="nav dk">
                        <li >
                          <a href="javascript:void(0)" onclick="menuOnclick('chart_init.action')" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>数据分析</span>
                          </a>
                        </li>
                        <li >
                          <a href="chart-compare.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>数据比较</span>
                          </a>
                        </li>
                        <li >
                          <a href="master.html" class="auto">                                                        
                            <i class="i i-dot"></i>

                            <span>热点分布</span>
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li >
                      <a href="javascript:void(0)" onclick="menuOnclick('user_log.action')" class="auto">
                        <i class="i i-grid2 icon">
                        </i>
                        <span class="font-bold">用户登录记录</span>
                      </a>
                      </li>
                  </ul>
                  <div class="line dk hidden-nav-xs"></div>
                 
                  </ul>
                </nav>
                <!-- / nav -->
              </div>
            </section>
            
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <a href="modal.lockme.html" data-toggle="ajaxModal" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
                <i class="i i-logout"></i>
              </a>
              <a href="#nav" data-toggle="class:nav-xs" class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
                <i class="i i-circleleft text"></i>
                <i class="i i-circleright text-active"></i>
              </a>
            </footer>
          </section>
        </aside>
        <!-- /.aside -->
        
        <iframe id="iframe" name="iframe" width = "100%" height="100%" src="index.action" frameborder="0"></iframe>
  
</body>
</html>