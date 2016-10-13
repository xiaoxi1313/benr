<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%@page import="com.newvery.utils.TimeUtil"%>
<!DOCTYPE html>
<html lang="en" class="app topadmineditpost">
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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/typehead/typehead.css" type="text/css" />
  <link href="<%=UrlHelper.getHomeUrl()%>resources/common/css/uploadify.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/validform_style.css" type="text/css" />
  
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
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/file-input/bootstrap-filestyle.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/markdown/epiceditor.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/typehead/typeahead.bundle.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script language="javascript"  src="<%=UrlHelper.getHomeUrl()%>resources/common/js/swfobject.js"></script>
  <script language="javascript"  src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.uploadify.v2.1.0.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/Validform_v5.3.2_min.js"></script>
  
<script type="text/javascript">
$(document).ready(function(){
	$('#subc').hide();
	$('#hotTagDiv').hide();
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

	showParent();
	
	$('#fileInput').uploadify({   
 		'uploader': '<%=UrlHelper.getHomeUrl()%>resources/common/js/swf/uploadify.swf',
        'script': 'uploadifyAction!uploadFile.action',   //指定服务端处理类的入口
        'folder': 'uploadFile',   
 		'cancelImg': '<%=UrlHelper.getHomeUrl()%>resources/common/images/cancel.png',
        'fileDataName': 'fileInput', //和input的name属性值保持一致就好，Struts2就能处理了   
        'queueID': 'fileQueue',   
        'auto': false,//是否选取文件后自动上传   
        'multi': true,//是否支持多文件上传
        'simUploadLimit' : 5,//每次最大上传文件数   
        'buttonText': 'Browse Files',//按钮上的文字   
        'displayData': 'percentage',//有speed和percentage两种，一个显示速度，一个显示完成百分比    
        'onComplete': function (event, queueID, fileObj, response, data){  
        	var img = "<img alt='...' src='viewImg.action?imageUrl=" + response + "' />";
        	var hidden = "<input type='hidden' name='imgUrl' value='" + response + "'/>";
         	$("#result").append(img);
         	$("#result").append(hidden);
         	$("#result").append("<br/>");
            // setInterval("showResult()",2000);//两秒后删除显示的上传成功结果   
         }  
	});   
	
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
	
	/******* 添加标签 *******/
	$('#addTagButton').click(function(){
		$('#addTagForm').submit();
	});
	
	$('#addTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加标签成功！");
				var tag = '<a class="label label-info tag">' + d.tag.name + '<button type="button" class="close" onclick="deleteTag('+d.tag.id+')" data-dismiss="alert">×</button></a>';
				var hidden = '<input type="hidden" name="tagIds" value="' + d.tag.id + '" />';
				$('#tagDiv').after(tag);
				$("#result").append(hidden);
				$('#addTagDiv').hide();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addTagForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}    	
	});
	/******* 添加标签 *******/
	
	/******* 添加热门标签 *******/
	$('#addHotTagButton').click(function(){
		$('#addHotTagForm').submit();
	});
	
	$('#addHotTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加热门标签成功！");
				var tag = '<a class="label bg-hot tag">' + d.tag.name + '<button type="button" class="close" onclick="deleteTag('+d.tag.id+')" data-dismiss="alert">×</button></a>';
				var hidden = '<input type="hidden" id="' + d.tag.id + '" name="tagIds" value="' + d.tag.id + '" />';
				$('#hotTagDiv').after(tag);
				$("#result").append(hidden);
				$('#addHotTagDiv').hide();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addTagHotForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}    	
	});
	/******* 添加热门标签 *******/
});

function showParent() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getParentCategoryList.action',
		date : 'id=' + 0,
		success : function(d) {
			$('#parentCategoryList').empty();
			//var option = "<li class=\"active\"><a href=\"#\"><input value=\"-1\" type=\"radio\" name=\"d-s-r\" checked=\"checked\">请选择...</a></li>";
			var option = "";
			
			$.each(d.categoryList, function(i, item){
				option += "<li class=\"\"><a href=\"javacription:void(0)\" onclick=\"showChildren('"+ item.id +"')\"><input name=\"article.parentCategoryId\" class=\"parentCategory\" type=\"radio\" value=\"" + item.id + "\" name=\"parentCategory\">" + item.name +"</a></li>";
			});
			
			$('#parentCategoryList').append(option);
		},
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

function showChildren(parentId) {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getCategoryListByParentId.action?parentCategoryId=' + parentId,
		success : function(d) {
			if (d.categoryList != '') {
				$('#subc').show();
				$('#childCategoryList').empty();
				var option ="";
				
				$.each(d.categoryList, function(i, item){
					option += "<li class=\"\"><a href=\"#\"><input type=\"radio\" value=\"" + item.id + "\" name=\"article.childCategoryId\">" + item.name +"</a></li>";
				});
				
				if (parentId == '' || parentId == undefined) {
					option += "<li class=\"active\"><a href=\"#\"><input value=\"-1\" type=\"radio\" name=\"d-s-r\" checked=\"checked\">无子分类</a></li>";
				}
				$('#childCategoryList').append(option);
			}
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

function saveArticle() {
	$('#articleContent').val($('#editor').html());
	$('#articleForm').attr('action', 'article_save.action');
	$('#articleForm').submit();
}

function showArticle() {
	location.href = "article_show.action";
}

function showResult(){//删除显示的上传成功结果   
	$("#result").html("");   
}

function deleteTag(divId) {
	$('#' + divId).remove();
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
                  <section class="row m-b-md col-md-9">
                  <div class="row">
                    <div class="col-sm-6">
                      <h3 class="m-b-xs text-black">编辑资讯</h3>
                      <small>您可以在此撰写或编辑资讯。</small>
                    </div>
                    </div>
                  </section>
                  <section class="col-md-9 row">
                  <form id="articleForm" method="post" action="">
                  <section class="panel panel-default">
                  <header class="panel-heading">编辑选项</header>
                  <div class="panel-body">
                  
                  <div class="row wrapper selectrow">
                   <div class="m-b-xs prename">
                   <span class="selectname midname">当前日期</span>
                   <input class="form-control" name="article.modifyTime" size="16" type="text" readonly value='<%=TimeUtil.format(new Date(), TimeUtil.FORMAT_NORMAL) %>' />
                   
                   </div>
                   </div>
                   
                  <div class="row wrapper selectrow">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">类别</span>
                  
                  <div class="btn-group m-r">
                  <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                  <span class="dropdown-label">请选择</span> 
                  <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu dropdown-select" id="parentCategoryList">
                  </ul>
                  </div>
                 
                  <div class="btn-group m-r" id="subc">
                  <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                  <span class="dropdown-label">请选择</span> 
                  <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu dropdown-select" id="childCategoryList">
                  </ul>
                  </div>
                  </div>
                  </div>
                  
                  <div class="row wrapper selectrow" style="padding-bottom: 10px;">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">标题</span>
                                    
                  <div class="btn-group m-r titleinput">
                  <input type="text" name="article.title" class="form-control" />
                  </div>
                                    
                  </div>
                  </div>              


                  </div>
                  </section>
                  <section class="panel panel-default list-show">
                  <header class="panel-heading">
                  编辑文章
                  </header>

                                  <div class="panel-body">
                                  <!-- <a href="#modal-upload-media" class="btn btn-success" data-toggle="modal"><i class="fa fa-picture-o"></i> 上传图片</a> -->
                                  
                                  <input type="file" name="fileInput" id="fileInput" />  &nbsp;&nbsp;&nbsp;&nbsp; 
									  <a href="javascript:$('#fileInput').uploadifyUpload();"  >开始上传</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
									  <a href="javascript:$('#fileInput').uploadifyClearQueue();"  >取消上传队列</a> <br>  <br> 
									  <div id="result"></div><!--显示结果-->   
									  <div id="fileQueue"></div>  
									  
									  
                                    <div class="btn-toolbar m-b-sm m-t-sm btn-editor" data-role="editor-toolbar" data-target="#editor">
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="Font"><i class="fa fa-font"></i><b class="caret"></b></a>
                                          <ul class="dropdown-menu">
                                          </ul>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="字体大小"><i class="fa fa-text-height"></i>&nbsp;<b class="caret"></b></a>
                                          <ul class="dropdown-menu">
                                          <li><a data-edit="fontSize 5"><font size="5">巨大</font></a></li>
                                          <li><a data-edit="fontSize 3"><font size="3">正常</font></a></li>
                                          <li><a data-edit="fontSize 1"><font size="1">小</font></a></li>
                                          </ul>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="bold" title="加粗 (Ctrl/Cmd+B)"><i class="fa fa-bold"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="italic" title="斜体 (Ctrl/Cmd+I)"><i class="fa fa-italic"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="strikethrough" title="中划线"><i class="fa fa-strikethrough"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="fa fa-underline"></i></a>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="insertunorderedlist" title="点列"><i class="fa fa-list-ul"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="数字列"><i class="fa fa-list-ol"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="outdent" title="减少缩进 (Shift+Tab)"><i class="fa fa-dedent"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="indent" title="缩进 (Tab)"><i class="fa fa-indent"></i></a>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="justifyleft" title="左对齐 (Ctrl/Cmd+L)"><i class="fa fa-align-left"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="justifycenter" title="居中 (Ctrl/Cmd+E)"><i class="fa fa-align-center"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="justifyright" title="右对齐 (Ctrl/Cmd+R)"><i class="fa fa-align-right"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="justifyfull" title="左右对齐 (Ctrl/Cmd+J)"><i class="fa fa-align-justify"></i></a>
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="超链接"><i class="fa fa-link"></i></a>
                                        <div class="dropdown-menu">
                                          <div class="input-group m-l-xs m-r-xs">
                                            <input class="form-control input-sm" placeholder="URL" type="text" data-edit="createLink"/>
                                            <div class="input-group-btn">
                                              <button class="btn btn-default btn-sm" type="button">添加</button>
                                            </div>
                                          </div>
                                        </div>
                                        <a class="btn btn-default btn-sm" data-edit="unlink" title="移除超链接"><i class="fa fa-cut"></i></a>
                                      </div>
                                      
                                      <div class="btn-group hide">
                                        <a class="btn btn-default btn-sm" title="插入图片 (或拖拽)" id="pictureBtn"><i class="fa fa-picture-o"></i></a>
                                        <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" />
                                      </div>
                                      <div class="btn-group">
                                        <a class="btn btn-default btn-sm" data-edit="undo" title="撤销 (Ctrl/Cmd+Z)"><i class="fa fa-undo"></i></a>
                                        <a class="btn btn-default btn-sm" data-edit="redo" title="重做 (Ctrl/Cmd+Y)"><i class="fa fa-repeat"></i></a>
                                      </div>
                                    </div>
                                    <div id="editor" class="form-control" style="overflow:scroll;height:100%;min-height:400px;;">
                                      
                                    </div>
                                    <input type="hidden" name="article.content" id="articleContent" value="1323"/>
                                  </div>
                                  
                     </section>
                     </form> 
                  </section>
                     
                   <section class="scrollable col-md-3 siderbar">
                   <ul class="list-group gutter list-group-lg list-group-sp sortable m-b-none">
                   
                   <li class="list-group-item col-md-12 sortable p-t-none savepanel" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   发布                    
                   </header>
                   <div class="panel-body">
                   <a href="javascript:void(0)" onclick="showArticle()" class="btn btn-success">客户模式预览</a>
                   <a href="javascript:void(0)" onclick="saveArticle()" class="btn btn-success">发布</a>
                   </div></div>
                   </li> 
                     
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    标签管理                    
                    </header>
                    <div class="panel-body tagform">
	                    <div id="tagDiv" class="tagtitle" style="margin-top: 0;">
	                    	新增标签<button href="#modal-add-tag" data-toggle="modal" class="btn btn-sm btn-default add-btn">
	                    			<i class="fa fa-plus text"></i>
	                    			</button>
	                    </div>
                    	<div id="hotTagDiv" class="tagtitle">
                    		热门标签<button href="#modal-add-hot-tag" data-toggle="modal" class="btn btn-sm btn-default add-btn">
                    				<i class="fa fa-plus text"></i>
                    			  </button>
                    	</div> 
                    
                    </div>
                    </div>
                    </li> 
                                    

                                           
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none title-pic">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    标题图片                    
                    </header>
                                                            
                    <div class="panel-body item">
                    <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p1.jpg" class="thumb-o"/></a>
                    <div class="hover-content">
                    <div class="overlay"></div>
                    <div class="link-contianer">
                    	<a href="#modal-media" data-toggle="modal" >更改图片</a>
                        </div>
                        </div>
                    </div>
                    
                    <div class="panel-body item text-center hidden">  
                      <a href="#modal-form" class="btn btn-success add-pic-btn" data-toggle="upload-img"><i class="fa fa-picture-o"></i> 添加标题图片</a>
                     </div> 
                                                                               
                    </div>
                    </li>
                    </ul>    
                    </section>      
                                                     
                </section>
              </section>
            </section>
            

          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
 
 <form id="addTagForm" class="form-horizontal" method="post" action="article_addTag.action">
 <div class="modal fade" id="modal-add-tag" style="display: none;" aria-hidden="true">
     <div class="modal-dialog" id="addTagDiv">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">添加新标签</h3>
         <small>您可以在此添加新的热门标签。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
                                      <div class="form-group">
                                      <label class="col-sm-2 control-label tagselectname">请输入标签</label>
                                      <div class="col-sm-9">
                                      <input type="text" name="tag.name" class="form-control" datatype="s2-16" errormsg="名字至少5个字符,最多16个字符！" />
                                      <input type="hidden" name="tag.hot" value="0" />
                                      <div class="Validform_checktip">在此输入标签，已有的标签会联想显示。库中没有的标签会自动生成新的。连续输入多个标签请用中文顿号(、)分隔。</div>
                                      </div>
                                      </div>
                                                                         
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
              <div class="checkbox m-t-lg">
                 <input type="button" id="addTagButton" value="确定" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..." />
              </div>
              </form>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>
 </form>
 <form id="addHotTagForm" class="form-horizontal" method="post" action="article_addTag.action">
 <div class="modal fade" id="modal-add-hot-tag" style="display: none;" aria-hidden="true" id="addHotTagDiv">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">添加热门标签</h3>
         <small>您可以在此添加新的标签。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
               <form class="form-horizontal" method="get">
                                      <div class="form-group">
                                      <label class="col-sm-2 control-label tagselectname" style="width: 10em;">请输入热门标签</label>
                                      <div class="col-sm-9">
                                      <input type="text" name="tag.name" class="form-control" datatype="s2-16" errormsg="名字至少5个字符,最多16个字符！" />
                                      <input type="hidden" name="tag.hot" value="1" />
                                      <div class="Validform_checktip">在此输入热门标签，已有的标签会联想显示。库中没有的标签会自动生成新的。连续输入多个标签请用中文顿号(、)分隔。</div>
                                      </div>
                                      </div>
                                                                         
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
              <div class="checkbox m-t-lg">
              	<input type="button" id="addHotTagButton" value="确定" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..." />
              </div>
              </form>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>
   </form>
   
   <div class="modal fade" id="modal-media" style="display: none;" aria-hidden="true">
       <div class="modal-dialog" style="min-width: 80%;">
         <div class="modal-content">
         <div class="modal-header p-b-lg">
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
           <h3 class="m-t-none">设置标题特征图片</h3>
           <small>您可以在此设置文章的标题特征图片。</small>
           <div class="col-sm-3 pull-right">
                <div class="input-group">
                     <input type="text" class="input-sm form-control" placeholder="搜索">
                     <span class="input-group-btn">
                     <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                     </span>
                 </div>
            </div>
         </div>
           <div class="modal-body">
             <div class="row">
               <div class="col-sm-12">
                 <form class="form-horizontal picgrid" method="get">
  
                  <div class="row row-sm">
                  <div class="btn-group no-padder" data-toggle="buttons">
                  
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                    <label class="btn no-padder active">
  
                      <div class="thumbnail">
                        <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p1.jpg" alt=""></a>
                        <small class="medianame">图片名字.jpg</small>
                      </div>
                      
                      <input type="radio" name="options" id="option1"><i class="fa fa-check text-active"></i>
                       </label>
                     </div>
                     
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                    <label class="btn no-padder"> 
  
                      <div class="thumbnail">
                        <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p2.jpg" alt=""></a>
                        <small class="medianame">图片名字.jpg</small>
                      </div>
                      <input type="radio" name="options" id="option2"><i class="fa fa-check text-active"></i>
                    </label>
                    </div>
                    
                    <div class="clearfix visible-xs"></div>
                    
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                         <label class="btn no-padder"> 
                    
                          <div class="thumbnail">
                                          <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p3.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option3"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p4.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option4"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="clearfix visible-xs"></div>
                    
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p5.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option5"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p6.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option6"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="clearfix visible-xs"></div>
                    
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p7.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option7"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                      <label class="btn no-padder"> 
                    
                                        <div class="thumbnail">
                                          <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p8.jpg" alt=""></a>
                                          <small class="medianame">图片名字.jpg</small>
                                        </div>
                                        <input type="radio" name="options" id="option8"><i class="fa fa-check text-active"></i>
                                      </label>
                                      </div>
                                      
                    <div class="clearfix visible-xs"></div>
                    
                                                          
                  </div>
                  <div>
                    <div class="btn-group m-r">
                      <button type="button" class="btn btn-default"><i class="i i-arrow-left4"></i></button>
                      <button type="button" class="btn btn-default"><i class="i i-arrow-right4"></i></button>
                    </div>
                    已显示 <strong>8</strong> 张图片，共25张图片
                  </div>
                  </div>

                                                                           
                 <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                   <button type="submit" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="确定中..."><strong>确定</strong></button>
                </div>
                </form>
                
               </div>
               
             </div>          
           </div>
         </div><!-- /.modal-content -->
       </div><!-- /.modal-dialog -->
     </div>
   
   <div class="modal fade" id="modal-upload-media" style="display: none;" aria-hidden="true">
          <div class="modal-dialog" style="min-width: 80%;">
            <div class="modal-content">
            <div class="modal-header p-b-lg">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3 class="m-t-none">插入图片</h3>
              <small>您可以在此上传图片或从媒体库中选择图片并插入到文章中。</small>
              <div class="col-sm-3 pull-right">
                   <div class="input-group">
                        <input type="text" class="input-sm form-control" placeholder="搜索">
                        <span class="input-group-btn">
                        <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                    
               </div>
                
            </div>
            
             <!--</div>-->
              <div class="modal-body no-padder mediacontainer">
              <div class="panel-heading bg-light">
              <ul class="nav nav-tabs nav-justified">
                <li class="active"><a href="#upload-normal" data-toggle="tab"><i class="fa fa-upload text-muted"></i> 上传新图片</a></li>
                <li class=""><a href="#media-normal" data-toggle="tab"><i class="fa fa-picture-o text-muted"></i> 从媒体库中选择</a></li>
               </ul>
               </div>
               <div class="panel-body" >
              <div class="tab-content" style="border-top: 0;">
                <div class="tab-pane fade active in" id="upload-normal">
                  <div class="col-sm-12">
                    <form class="form-horizontal picgrid" method="get">
     

                       <div class="col-sm-12">
                         <div class="dropfile visible-lg" >
                           <small style="margin: 150px 0;">请将头像图片拖拽至此</small>
                         </div>
                       
                     </div>

                    
                   </form>
                   </div>
                  </div>
                <div class="tab-pane fade " id="media-normal">
                                  <div class="col-sm-12">
                                    <form class="form-horizontal picgrid" method="get">
                                      
                                                      <div class="row row-sm">
                                                      <div class="btn-group no-padder" data-toggle="buttons">
                                                      
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                        <label class="btn no-padder active">
                                      
                                                          <div class="thumbnail">
                                                            <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p1.jpg" alt=""></a>
                                                            <small class="medianame">图片名字.jpg</small>
                                                          </div>
                                                          
                                                          <input type="radio" name="options" id="option1"><i class="fa fa-check text-active"></i>
                                                           </label>
                                                         </div>
                                                         
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                        <label class="btn no-padder"> 
                                      
                                                          <div class="thumbnail">
                                                            <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p2.jpg" alt=""></a>
                                                            <small class="medianame">图片名字.jpg</small>
                                                          </div>
                                                          <input type="radio" name="options" id="option2"><i class="fa fa-check text-active"></i>
                                                        </label>
                                                        </div>
                                                        
                                                        <div class="clearfix visible-xs"></div>
                                                        
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                             <label class="btn no-padder"> 
                                                        
                                                              <div class="thumbnail">
                                                                              <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p3.jpg" alt=""></a>
                                                                              <small class="medianame">图片名字.jpg</small>
                                                                            </div>
                                                                            <input type="radio" name="options" id="option3"><i class="fa fa-check text-active"></i>
                                                                          </label>
                                                                          </div>
                                                                          
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                                          <label class="btn no-padder"> 
                                                        
                                                                            <div class="thumbnail">
                                                                              <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p4.jpg" alt=""></a>
                                                                              <small class="medianame">图片名字.jpg</small>
                                                                            </div>
                                                                            <input type="radio" name="options" id="option4"><i class="fa fa-check text-active"></i>
                                                                          </label>
                                                                          </div>
                                                                          
                                                        <div class="clearfix visible-xs"></div>
                                                        
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                                          <label class="btn no-padder"> 
                                                        
                                                                            <div class="thumbnail">
                                                                              <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p5.jpg" alt=""></a>
                                                                              <small class="medianame">图片名字.jpg</small>
                                                                            </div>
                                                                            <input type="radio" name="options" id="option5"><i class="fa fa-check text-active"></i>
                                                                          </label>
                                                                          </div>
                                                                          
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                                          <label class="btn no-padder"> 
                                                        
                                                                            <div class="thumbnail">
                                                                              <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p6.jpg" alt=""></a>
                                                                              <small class="medianame">图片名字.jpg</small>
                                                                            </div>
                                                                            <input type="radio" name="options" id="option6"><i class="fa fa-check text-active"></i>
                                                                          </label>
                                                                          </div>
                                                                          
                                                        <div class="clearfix visible-xs"></div>
                                                        
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                                          <label class="btn no-padder"> 
                                                        
                                                                            <div class="thumbnail">
                                                                              <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p7.jpg" alt=""></a>
                                                                              <small class="medianame">图片名字.jpg</small>
                                                                            </div>
                                                                            <input type="radio" name="options" id="option7"><i class="fa fa-check text-active"></i>
                                                                          </label>
                                                                          </div>
                                                                          
                                                        <div class="col-xs-6 col-sm-4 col-md-3 mediapics">
                                                                          <label class="btn no-padder"> 
                                                        
                                                                            <div class="thumbnail">
                                                                              <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p8.jpg" alt=""></a>
                                                                              <small class="medianame">图片名字.jpg</small>
                                                                            </div>
                                                                            <input type="radio" name="options" id="option8"><i class="fa fa-check text-active"></i>
                                                                          </label>
                                                                          </div>
                                                                          
                                                        <div class="clearfix visible-xs"></div>
                                                        
                                                                                              
                                                      </div>
                                                      <div>
                                                        <div class="btn-group m-r">
                                                          <button type="button" class="btn btn-default"><i class="i i-arrow-left4"></i></button>
                                                          <button type="button" class="btn btn-default"><i class="i i-arrow-right4"></i></button>
                                                        </div>
                                                        已显示 <strong>8</strong> 张图片，共25张图片
                                                      </div>
                                                      </div>
                                    
                                                                                                               
                                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                                     <div class="mediainfo pull-left" style="width: 90%;">
                                                     <div class="pull-left">您选中了<small><a href="<%=UrlHelper.getHomeUrl()%>resources/common/images/p6.jpg">p6.jpg</a></small>。图片原始尺寸<span class="size">400x300</span>像素。</div>
                                                     <div class="pull-left">使用图片尺寸<div class="btn-group dropup m-r m-l-sm">
                                                     	                    <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                                                     	                      <span class="dropdown-label">原始尺寸<span class="size">（400x300）</span></span> 
                                                     	                      <span class="caret"></span>
                                                     	                    </button>
                                                     	                    <ul class="dropdown-menu dropdown-select">
                                                     	                        <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">原始尺寸<span class="size">（400x300）</span></a></li>
                                                     	                        <li class=""><a href="#"><input type="radio" name="d-s-r">中等尺寸<span class="size">（200x100）</span></a></li>
                                                     	                        <li class=""><a href="#"><input type="radio" name="d-s-r">小尺寸<span class="size">（50x25）</span></a></li>
                                                     	                    </ul>
                                                     	                  </div></div>
                                                     <div class="pull-left"><span class="urltitle">图片URL</span><input type="text" data-type="url" data-required="true" class="form-control" value="http://www.benranshujuku.com/images/p6.jpg"></div>
                                                     </div>
                                                    <div class="checkbox m-t-lg pull-right">
                                                       <button type="submit" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" data-loading-text="插入中..."><strong>插入</strong></button>
                                                    </div>
                                                    </form>
                                   </div>
                                  </div>
                </div>  
                </div>          
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div>
   
 
</body>
</html>