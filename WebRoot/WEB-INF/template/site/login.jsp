<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>本然创新研究服务平台</title>
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
  <!-- / footer -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#logbtn1').click(function(){
		$('#loginForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#loginForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				if(d.refererUrl != undefined) {
					location.href = d.refererUrl;
				} else {
					location.href = "main.action";
				}
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#loginForm').submit();
				} else {
					$('#password').val('');
					alert(d.errorMessage);
				}
				
			}
		}    	
	});

	$('#userName').change(function(){
		$('#userName').val($.trim($('#userName').val()));
	});
});
</script>
</head>
<body class="" >
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp">    
    <div class="container aside-xl">
      <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/logo.png" class="m-r-sm imgcenter" alt="scale">
      <div class="navbar-brand block">本然创新研究服务平台</div>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>欢迎登陆</strong>
        </header>
        <form id="loginForm" action="<%=UrlHelper.getHomeUrl()%>login.action" method="post">
          <div class="list-group">
            <div class="list-group-item">
              <input type="text" id="userName" name="user.userName" placeholder="用户名" class="form-control no-border"/>
            </div>
            <div class="list-group-item">
               <input type="password" id="password" name="user.password" placeholder="密码" class="form-control no-border"/>
            </div>
          </div>
          <button type="button" id="logbtn1" class="btn btn-lg btn-primary btn-block">登陆</button>
          <div class="text-center m-t m-b"><a href="forgot_step1.action"><small>忘记密码?</small></a></div>
        </form>
      </section>
    </div>
  </section>
  <!-- footer -->
  <footer id="footer">
    <div class="text-center padder">
      <p>
        <small>Powered by <a href="http://www.imaghost.net">Imaghost</a><br>&copy;2014 本然信息技术有限公司版权所有&nbsp;&nbsp;沪ICP备14042390号-1</small>
      </p>
    </div>
  </footer>
</body>
</html>