<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%
//response.sendRedirect(UrlHelper.getHomeUrl() + "login.action");
%>
<!DOCTYPE html>
<html lang="en" class="login-user ">
<head>  
  <meta charset="utf-8" />
  <title>本然创启™ 创新源数据库</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
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
</head>
<body class="" >
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp m-b-lg">    
    <div class="container aside-xl">
      <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/iraslogo.png" class="m-r-sm imgcenter p-t-lg p-b-hg" alt="">
      <!--<a class="navbar-brand block" href="index.html">本然创启™ 创新源数据库</a> -->
      <section class="m-b-lg login-form">
        <!--<header class="wrapper text-center">
          <strong>欢迎登陆</strong>
        </header>-->
        <form id="loginForm" action="<%=UrlHelper.getHomeUrl()%>login.action" method="post">
          <div class="m-b-lg">
            <div class="form-group">
              <input type="text" id="userName" name="user.userName" placeholder="用户名" class="form-control">
            </div>
            <div class="form-group">
               <input type="password" id="password" name="user.password" placeholder="密码" class="form-control">
            </div>
         </div>
          <button type="button" id="logbtn1" class="btn btn-md btn-success btn-block m-t-lg">登陆</button>
          <div class="text-center m-t m-b-lg"><a class="lightera" href="forgot_step1.action"><small>忘记密码?</small></a></div>
          <!--<p class="text-muted text-center"><small>没有账号?</small></p>
          <a href="signup.html" class="btn btn-lg btn-default btn-block">申请成为会员</a>-->
        </form>
      </section>
      
    </div>
  </section>
  <!-- footer -->
  <footer id="footer">
  <div class="line line-dashed m-t-lg m-b-md"></div>
    <div class="text-center padder m-t-sm">
    <div class="m-b-md">
    <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/login-smalllogo.png" class="imgcenter m-r-sm " style="margin:0 auto;" alt="">
    </div>
      <p>
        <small>Powered by <a class="lightera" href="http://www.imaghost.net">Imaghost</a><br>&copy; 2014 本然信息技术有限公司版权所有  沪ICP备14042390号-1</small>
      </p>
    </div>
  </footer>
  <!-- / footer -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
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
</body>
</html>