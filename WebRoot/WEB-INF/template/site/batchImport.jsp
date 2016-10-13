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


  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/file-input/bootstrap-filestyle.min.js"></script>
</head>
<body class="" >
	<%@include file="head.jsp" %>
  
    <section id="content">
          <section class="vbox">
            <section class="scrollable padder">
              <div class="m-b-md">
              <div class="row">
                <div class="col-sm-6">
                <h3 class="m-b-none">批量导入工具</h3>
                <small>您在此批量导入文章，请注意文章需遵循以下规则设置:<br /><b>1.</b> 文章和标题图片必须名字一致且没有特殊符号并放在同一目录中。<br /><b>2.</b> 标题图片需采用jpg格式。<br /><b>3.</b> 将多篇文章及其对应的标题图片放在一个文件夹内压缩成zip格式。注意zip大小控制在10MB以内。</small>
              </div>
              </div>
              </div>
                              
             <section class="panel panel-default">
             <header class="panel-heading">
              批量导入             
             </header> 
                  
              
              <div class="tab-content">
                  <div class="panel tab-pane active m-b-none">
                  <div class="wrapper">
             <form class="form-horizontal" method="post" action="saveBatch.action" enctype="multipart/form-data">
    		      <div class="m-b-sm">选择您要上传的模板压缩包：</div>
    		      <input type="file" name="zfile" class=" filestyle" data-classButton="btn btn-default" data-classInput="form-control inline v-middle input-s"> 
    		      <input type="submit" value="上传" class="form-control input-s-sm m-t-sm">
             </form> 
             </div>
            </div>
           </div>
           
           <div class="hresult">
           	<p>
           		<s:property value="resultInfo" escapeHtml="false"/>
           	</p>
           </div>
           
              </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
</body>
</html>