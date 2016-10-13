<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
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
	$('#nextStep').click(function(){
		$('#forgotForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#forgotForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("找回密码的方法已发送到您的邮箱，请于30分钟内进行密码重置！");
				location.href = "index.action";
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#forgotForm').submit();
				} else {
					$('#email').val('');
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
});
</script>
</head>
<body class="" >
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp">    
    <div class="container aside-xl">
      <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/logo.jpg" class="m-r-sm imgcenter" alt="scale">
      <a class="navbar-brand block" href="index.html">本然数据库</a>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>忘记密码了？请在下方输入您注册时提供的邮箱地址</strong>
        </header>
        <form id="forgotForm" action="forgot_step2.action" method="post">
          <div class="list-group">
            <div class="list-group-item">
              <input type="email" id="email" name="email" placeholder="邮箱" class="form-control no-border">
            </div>
            </div>
          <button type="button" id="nextStep" class="btn btn-lg btn-primary btn-block">下一步</button>
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