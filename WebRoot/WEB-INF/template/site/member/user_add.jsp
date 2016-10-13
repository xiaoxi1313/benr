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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/datepicker.css" type="text/css" />
<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/slider/slider.css" type="text/css" />
<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/typehead/typehead.css" type="text/css" />
<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/validform_style.css" type="text/css" />

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

  <!-- datepicker -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datepicker.js"></script>
  <!-- slider -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slider/bootstrap-slider.js"></script>
  <!-- file input -->  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/file-input/bootstrap-filestyle.min.js"></script>
  <!-- wysiwyg -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>
  <!-- markdown -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/markdown/epiceditor.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/markdown/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/typehead/typeahead.bundle.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/typehead/demo.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/Validform_v5.3.2_min.js"></script>
<style>
.Validform_checktip{margin:4px 0;}
.Validform_wrong {
    background: url("<%=UrlHelper.getHomeUrl()%>resources/common/images/error.png") no-repeat scroll left center rgba(0, 0, 0, 0);
    color: red;
    padding-left: 20px;
    white-space: nowrap;
}
.Validform_checktip {
    color: #999;
    font-size: 12px;
    height: 20px;
    line-height: 20px;
    margin-left: 8px;
    overflow: hidden;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('.form-horizontal').Validform({
		tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
			if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				var objtip=o.obj.siblings(".Validform_checktip");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}else{
				var objtip=o.obj.find("#msgdemo");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}
		},
		ajaxPost:false
	});
});
</script>
</head>
<body class="" >
        <!-- /.aside -->
        <section id="content">
          <section class="vbox">
            <section class="scrollable padder">
              <div class="m-b-md">
                <div class="row">
                  <div class="col-sm-6">
                  <h3 class="m-b-none">系统管理 &nbsp;&frasl;&nbsp; 用户管理 &nbsp;&frasl;&nbsp; 添加新用户</h3>
                  <small>请输入必填项来添加新用户</small>
                </div>
                </div>
              </div>
              <section class="panel panel-default">
                                     <header class="panel-heading font-bold">
                                     请填写用户资料
                                     </header>
                                     <div class="panel-body">
                                     <form class="form-horizontal" method="post" action="user_save.action">
                                     <div class="form-group">
                                     <label class="col-sm-2 control-label">用户名<span class="redstar"> *</span></label>
                                     <div class="col-sm-10">
                                     <input type="text"  name="user.userName" datatype="s4-16" errormsg="昵称至少4个字符,最多16个字符！"  class="form-control">
                                     <div class="Validform_checktip">此项为必填，请使用英文字母和数字作为用户名，用户名不能和已有用户重复，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-2 control-label">密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-10">
                                     <input type="password" name="user.password" class="form-control" datatype="*6-15" errormsg="密码范围在6~15位之间！">
                                     <div class="Validform_checktip">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                      <label class="col-sm-2 control-label">重复密码<span class="redstar"> *</span></label>
                                      <div class="col-sm-10">
                                      <input type="password" name="password2" class="form-control" datatype="*" recheck="user.password" errormsg="您两次输入的账号密码不一致！">
                                      <div class="Validform_checktip">此项为必填，请再次输入密码。</div>
                                      </div>
                                     </div>
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">电子邮箱<span class="redstar"> *</span></label>
                                        <div class="col-sm-10">
                                        <input type="text" name="user.email" class="form-control" datatype="e" errormsg="请输入正确格式的Email！">
                                                    <div class="Validform_checktip">此项为必填。</div>
                                                  </div>
                                                </div>
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
              
                                                <div class="form-group">
                                                  <label class="col-sm-2 control-label">用户权限<span class="redstar"> *</span></label>
                                                  
                                                  <div class="btn-group col-sm-10">
                                                  <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                                                  <span class="dropdown-label">请选择用户权限</span> 
                                                  <span class="caret"></span>
                                                  </button>
                                                  <ul class="dropdown-menu dropdown-select">
                                                  <s:iterator value="roleList" id="role" status="u">
                                                  	<li class=""><a href="#"><input type="radio" name="roleId" value="<s:property value='id'/>"><s:property value="name"/></a></li>
                                                  </s:iterator>
                                                  </ul>
                                                  </div>                                   
                                                </div>
                                        
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-2 control-label">上传头像</label>
                                                  <div class="col-sm-10">
                                                    <div class="dropfile visible-lg">
                                                      <small>请将头像图片拖拽至此</small>
                                                    </div>
                                                  </div>
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <div class="col-sm-4 col-sm-offset-2">
                                                  <button type="submit" class="btn btn-primary">保存</button>
                                                  <a href="javascript:history.go(-1);" class="btn btn-default">取消</a>
                                                  </div>
                                                </div>
                                              </form>
                                            </div>
                                          </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
</body>
</html>