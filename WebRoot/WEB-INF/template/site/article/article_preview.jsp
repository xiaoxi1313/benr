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
  <link rel="shortcut icon" type="image/x-icon" href="<%=UrlHelper.getHomeUrl()%>favicon.ico" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/util.carousel.css">
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/util.animate.css" />
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/jquery.utilcarousel.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
	  $("#nav").addClass("nav-xs");
	  //$(document.body).removeClass("modal-open");
  })
  </script>
  </head>
<body class="" >
  <%@include file="../head.jsp" %>
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <section class="scrollable padder"> 
                          <section class="vbox">
                          <div class="wrapper dk p-b-none clearfix ">
                                          <a class="pull-left m-r-sm" data-toggle="class" href="#"><i class="fa fa-star-o fa-lg text"></i><i class="fa fa-star text-warning fa-lg text-active"></i></a>
                                          <h4 class="m-n"> <s:property value="article.title" /><span class="badge bg-warning m-l-xs">未读</span></h4>
                                        </div>
                                        <div>
                                          <div class="block clearfix wrapper b-b">
                                            <a class="thumb-xs inline" href="#">
                                            	<s:if test="#session.user.icon == null || #session.user.icon==''">
								            		<img class="img-circle " src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" >
								            	</s:if>
								            	<s:else>
								            		<img class="img-circle " src="<s:property value='#session.user.icon' />" >
								            	</s:else>
								            </a>
                                            <span class="inline m-l-xs"> <s:property value="#session.user.userName" /></span>
                                            <em class="text-xs m-l-sm">发表于 <span class="text-danger"><%=TimeUtil.format(new Date(), TimeUtil.FORMAT_DATE_ONLY) %></span></em>
                                          </div>
                                          <div class="post-container wrapper b-b titleimg">
              								<img  src="<s:property value='article.titleImage' />">
              							  </div>
                                          <div class="post-container wrapper b-b">
                                          	
                                            <s:property value="article.content" escape="false" />
                                          </div>
                                        </div>
                                        <div class="wrapper">
                                          <div>
                                          	<s:iterator value="tagList" id="tag" status="u">
                                          		<a class="label label-info tag"><s:property value="name" /></a>
                                          	</s:iterator>
                  						  <div>
                                        </div>
                                    </section>
                  </section>
            
            </section> 
</body>
</html>