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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/jquery.autocomplete.css" type="text/css" />
  <!--[if lt IE 9]>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/html5shiv.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/respond.min.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/excanvas.js"></script>
  <![endif]-->  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script> 
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
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>ueditor/ueditor.config.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>ueditor/ueditor.all.min.js?t=<%=System.currentTimeMillis()%>>"></script>
  <script type="text/javascript" charset="utf-8" src="<%=UrlHelper.getHomeUrl()%>ueditor/lang/zh-cn/zh-cn.js"></script>
  
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
  
  <style type="text/css">
  .acResults{ z-index: 999999;}
  </style>
  <script type="text/javascript">
    var myEditorImage; 

    var d; 

	function upImage() {     
	
	    d = myEditorImage.getDialog("insertimage"); 
	
	    d.render(); 
	
	    d.open(); 
	
	} 

	myEditorImage= new UE.ui.Editor(); 

    myEditorImage.render('myeditor');  
    myEditorImage.ready(function(){ 

    myEditorImage.setDisabled(); 
    myEditorImage.hide();
    myEditorImage.addListener('beforeInsertImage',function(t, arg){ 
    	$('#uploadTitle').val(arg[0].src);
    	$('#thumb-title').show();
    	$('#addoverlay').show();
    	$('#thumb-title').attr('src',arg[0].src);
    	$('#thumb-title2').attr('src',arg[0].src);
    	$('#upload-img').hide();
    });
    });
    </script>
<script type="text/javascript">
$(document).ready(function(){
	 $("#ac1").autocomplete('tag_listAllTag.action', {
		minChars: 1,
        remoteDataType: 'json',
        processData: function(data) {
			var processed = [];
			if(data.tagList != undefined) {
				for (var i=0; i < data.tagList.length; i++) {
					processed.push([data.tagList[i].name]);
				}
			}
			return processed;
        },
        formatItem: function(row, i, n) {
	   		return row;     
       	},
        onItemSelect: function(item) {
        	//alert(this.value);
        	$('#selflag').val('1');
        	//var terms = split(this.value); 
        	$("#modal-add-tag-new").hide();
        	$("#acblock").css("display", "none");
        },
        onNoMatch:function() {
        	$('#selflag').val('0');
        	$('#tagAlias').val('');
        	$("#modal-add-tag-new").show();
        	$("#acblock").css("display", "block");
        }
 	});
	
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
	
	/******* 添加标签 *******/
	$('#addTagButton').click(function(){
		if($('#selflag').val()!='1'){
			if ($('#ac1').val() == '') {
				alert("请输入标签名！");
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				return ;
			}
			/*if ($('#tagAlias').val() == '') {
				alert("请输入标签别名！");
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				return ;
			}*/
			if ($("input[name='tag.categoryId']:checked").val()==undefined ||$("input[name='tag.categoryId']:checked").val() <= 0) {
				alert("请选择标签分类！");
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				return ;
			}
		}
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
				var tag = '<a class="label label-info tag">' + d.tag.name + '<button type="button" class="close" onclick="deleteTag('+d.tag.id+')" data-dismiss="alert">×</button></a>';
				var hidden = '<input type="hidden" id="' + d.tag.id + 'TagId" name="tagIds" value="' + d.tag.id + '" />';
				$('#tagDiv').after(tag);
				$("#result").append(hidden);
				
				$("#modal-add-tag").find(".close").click();
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				
				$('#ac1').val('');
				$('#tagAlias').val('');
				$('#acblock').hide();
				$('#modal-add-tag-new').hide();
				//$('#addTagDialog').dialog('close'); 
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
				var hidden = '<input type="hidden" id="' + d.tag.id + 'TagId" name="tagIds" value="' + d.tag.id + '" />';
				$('#hotTagDiv').after(tag);
				$('#result').append(hidden);
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
		<s:if test="#session.user.role.name == '录入员'">
		url : 'user_getAssignCategory.action?userId=<s:property value="#session.user.id"/>',
		</s:if>
		<s:else>
		url : 'article_getParentCategoryList.action',
		</s:else>
		date : 'id=' + 0,
		success : function(d) {
			$('#parentCategoryList').empty();
			var option = "<option value='-1'>选择分类</option>";
			$.each(d.categoryList, function(i, item){
				option += "<option value='" + item.id+"' " + (item.id==$('#parentCategoryList').attr('val') ? "selected":"")+">"+ item.name +"</option>";
			});
			
			$('#parentCategoryList').append(option);
			$('#parentCategoryList').chosen();
			
			if($('#parentCategoryList').attr('val') != '') {
				showChildren($('#parentCategoryList').attr('val'));
			}else{
				$("#parentCategoryList").change();
			}
			
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
			var option ="";
			if (d.categoryList != '') {
				$('#subc').show();
				$.each(d.categoryList, function(i, item){
					option += "<option value='" + item.id+"' " + (item.id==$('#childCategoryList').attr('val') ? "selected":"")+">"+ item.name +"</option>";
				});
			} else {
				$('#subc').hide();
				option += "<option value='-1'>无子分类</option>";
			}
			
			$('#childCategoryList').empty();
			$('#childCategoryList').append(option);
			$('#childCategoryList').chosen();
			
			$('#childCategoryList').prop('disabled', false).trigger("chosen:updated");
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

function saveArticle() {
	if(!checkInput()) {
		return ;
	}
	
	preForm();
	$('#articleForm').attr('action', 'article_save.action');
	$('#articleForm').submit();
}

function updateArticle() {
	if(!checkInput()) {
		return ;
	}
	
	preForm();
	$('#articleForm').attr('action', 'article_update.action');
	$('#articleForm').submit();
}

function preForm() {
	/******* 添加文章表单 *******/
	$('#articleForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("操作成功！");
				<s:if test="#session.user.role.id == 1 || #session.user.role.id == 2">
				location.href = "article_show.action?article.id=<s:property value='article.id'/>";
				</s:if>
				<s:else>
				location.href = "article_edit.action?article.id=" + d.article.id;
				</s:else>
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#articleForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 添加文章表单 *******/
}

function checkInput() {
	if ($("#childCategoryList").val() == null || $("#childCategoryList").val()  == "-1") {
		alert("请选择文章分类！");
		return false;
	}
	
	if ($('#articleId').val() == '') {
		alert("请输入文章标题！");
		return false;
	}
	if ($('#articleSummary').val() == '') {
		alert("请输入摘要信息！");
		return false;
	}
	
	if (UE.getEditor('editor').getContent() == '') {
		alert("请输入文章内容！");
		return false;
	}
	
	
	if ($('#uploadTitle').val() == '') {
		alert("请添加标题图片！");
		return false;
	}
	
	return true;
}

function showArticle() {
	location.href = "article_show.action";
}

function showResult(){//删除显示的上传成功结果   
	$("#result").html("");   
}

function deleteTag(tagId) {
	$('#' + tagId + 'TagId').remove();
}

// 预览
function preview() {
	if(!checkInput()) {
		return ;
	}
	$('#articleForm').attr('action', 'article_preview.action');
	$('#articleForm').attr("target", "_blank");
	$('#articleForm').submit();
}
</script>
</head>
<body class="" >
  <%@include file="../head.jsp" %>
        <!-- /.aside -->
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <section class="scrollable padder">              
                  <section class="row m-b-md col-md-9">
                  <div class="row">
                    <div class="col-sm-6">
                      <h3 class="m-b-xs text-black">写文章</h3>
                      <small>您可以在此撰写或编辑文章。</small>
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
                   
                   <s:if test="article != null">
                   		
                   		<span class="selectname midname">
                   			创建日期
                  		</span>
                   		<div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
	                    	<input class="form-control" size="16" name="article.createTime" type="text" value="<s:date name="article.createTime" format="yyyy-MM-dd" />" readonly>
	                    	<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
	                   		<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                    </div>
                   		
                   		<input type="hidden" name="article.id" value="<s:property value='article.id'/> " />
                   </s:if>
                   <s:else>
	                   <span class="selectname midname">
	                   		当前日期
	                   </span>
	                   
	                   <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
	                    	<input class="form-control" size="16" name="article.createTime" type="text" value="<%=TimeUtil.format(new Date(), TimeUtil.FORMAT_DATE_ONLY) %>" readonly>
	                    	<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
	                   		<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                    </div>
	                  <!-- <input class="form-control" name="article.createTime" size="16" type="hidden" readonly="readonly" value='<%=TimeUtil.format(new Date(), TimeUtil.FORMAT_NORMAL) %>' />
	                   <%=TimeUtil.format(new Date(), TimeUtil.FORMAT_NORMAL) %> --> 
                   </s:else>
                   </div>
                   </div>
                   
                  <div class="row wrapper selectrow">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">类别</span>
                  
                  <div class="btn-group m-r">
                  <select id="parentCategoryList" name="article.parentCategoryId" onchange="showChildren(this.value)" val='<s:property value='article.parentCategoryId' />'>
                  
                  </select>
                  </div>
                 
                  <div class="btn-group m-r" id="subc">
                  
                  
                  <select id="childCategoryList" name="article.childCategoryId" val='<s:property value='article.childCategoryId' />'>
                  
                  </select>
                  
                  </div>
                  </div>
                  </div>
                  
                  <div class="row wrapper selectrow" style="padding-bottom: 10px;">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">标题</span>
                                    
                  <div class="btn-group m-r titleinput">
                  	  <input type="text" id="articleId" name="article.title" value="<s:property value='article.title' />" class="form-control" />
                  </div>
                                    
                  </div>
                  </div>
                  
                  <div class="row wrapper selectrow" style="padding-bottom: 10px;">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">源文链接</span>
                                    
                  <div class="btn-group m-r titleinput">
                  	  <input type="text" id="sourceLink" name="article.sourceLink" value="<s:property value='article.sourceLink' />" class="form-control" />
                  </div>
                                    
                  </div>
                  </div>              

				<div class="row wrapper selectrow" style="padding-bottom: 10px;">
                  <div class="m-b-xs prename">
                  <span class="selectname midname">摘要</span>
                                    
                  <div class="btn-group m-r titleinput">
                  	  <textarea  style="width:100%;height:80px;" name="article.summary" id="articleSummary"><s:property value='article.summary' /></textarea>
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
                        <script id="editor" type="text/plain" name="article.content" style="height:500px;">
							<s:property value="article.content" escapeHtml="false"/>
						</script>
                     </div>
                     <script type="text/javascript">
					    //实例化编辑器
					    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
					    $(document).ready(function(){
					    	//alert($('#pb1').width());
						    var ue = new UE.ui.Editor({ initialFrameWidth:$('#pb1').width()});
						    ue.render("editor");
					    })
					    
					    </script>
                     </section>
                     
                     <div id="result" style="display:none">
                     	<s:iterator value="tagList" id="tag" status="u">
	                    	<input type="hidden" id="<s:property value='id'/>TagId" name="tagIds" value="<s:property value='id'/>" />
	                    </s:iterator>
                     </div>
                     <input id="uploadTitle" type="hidden" name="article.titleImage" value="<s:property value='article.titleImage'/>"/> 
                     <input type="hidden" name="insertArticleToken" value="<s:property value='#session.article_token' />" />
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
                   <a href="javascript:void(0)" onclick="preview()" class="btn btn-success">预览</a>
                   <s:if test="article != null">
                   		<a href="javascript:void(0)" onclick="updateArticle()" class="btn btn-success">更新</a>
                   </s:if>
                   <s:else>
                   		<a href="javascript:void(0)" onclick="saveArticle()" class="btn btn-success">发布</a>
                   </s:else>
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
                    <s:iterator value="tagList" id="tag" status="u">
                    	<a class="label label-info tag"><s:property value="name" /><button type="button" class="close" onclick="deleteTag(<s:property value='id' />)" data-dismiss="alert">×</button></a>
                    </s:iterator>
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
                                                            
                    <div class="panel-body item <s:if test="article == null ">hidden</s:if>">
                    <a href="javascript:upImage();"><img src="<s:property value="article.titleImage" />" width="200" class="thumb-o" id="thumb-title2" /></a>
                    <div class="hover-content">
                    	<div class="overlay"></div>
	                    	<div class="link-contianer">
	                    	<a href="javascript:upImage();">更改图片</a>
	                        </div>
                        </div>
                    </div>
                    
                    <div class="panel-body item text-center <s:if test="article != null ">hidden</s:if>">  
                    	<a href="javascript:upImage();">
                    	<img class="thumb-o" src="" id="thumb-title" style="display:none;" width="200">
                    	</a>
                    	<div class="hover-content" id="addoverlay" style="display:none;">
                    	<div class="overlay" ></div>
	                    	<div class="link-contianer">
	                    	<a href="javascript:upImage();">更改图片</a>
	                        </div>
                        </div>
                    </div>
                    
                    	<script id="myeditor"></script>
                    	<s:if test="article == null ">
                      <a href="javascript:upImage();" class="btn btn-success add-pic-btn" id="upload-img"><i class="fa fa-picture-o"></i> 添加标题图片</a>
                      </s:if>
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
     <div class="modal-dialog" id="addTagDialog">
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
                                      <input type="text" id="ac1" name="tag.name" class="form-control" />
                                      <span class="help-block m-b-none" style="display: none;" id="acblock">库中没有该标签，您可以将其作为新标签添加到标签库中，并应用在这篇文章上。</span>
                                      <input type="hidden" name="tag.hot" value="0" />
                                      <input type="hidden" id="selflag" value="0" />
                                      </div>
                                      </div>
                                      <div id="modal-add-tag-new" style="display: none;" aria-hidden="true">
                                       <!-- 
                                       <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">标签别名</label>
                                       <div class="col-sm-9">
                                       <input type="text" id="tagAlias" name="tag.alias" class="form-control">
                                       <span class="help-block m-b-none">此项为必填，请使用小写英文字母作为标签别名，特殊符号仅支持"-"和"_"。</span>
                                       </div>
                                      </div> -->
                                      
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
                                      <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">标签注释</label>
                                       <div class="col-sm-9">
                                       <input type="text" id="tagTooltip" name="tag.tooltip" class="form-control" datatype="s2-16" errormsg="注释至少2个字符,最多16个字符！">
                                       <div class="Validform_checktip">此注释仅在鼠标放置到标签上悬浮时显示。</div>
                                       </div>
                                      </div>
                                      
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
                                        <div class="form-group">
                                        <label class="col-sm-2 control-label tagselectname">选择标签目录</label>
                                       <div class="btn-group col-sm-9">
                                                    <button class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown">
                                                      <span class="dropdown-label">请选择标签分类</span> 
                                                      <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-select">
                                                    	<s:iterator value="tagCategoryList" id="tagCategory" status="u">
															<li class="">
																<a href="#"><input type="radio" name="tag.categoryId" value="<s:property value='id' />"><s:property value="name" /></a>
															</li>
														</s:iterator></ul>
                                                    </div>                                   
                                                  </div></div>
                                     </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
              <div class="checkbox m-t-lg">
                 <input type="button" id="addTagButton" value="确定" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" />
              </div>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>

 <form id="addHotTagForm" class="form-horizontal" method="post" action="article_addTag.action">
 <div class="modal fade" style="display: none;" aria-hidden="true" id="addHotTagDiv">
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
              	<input type="button" id="addHotTagButton" value="确定" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" />
              </div>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>
   </form>
   
 <div class="modal fade" id="modal-editprofile" style="display: none;" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">个人资料设置</h3>
         <small>您可以在此修改您的个人资料。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
             <form class="form-horizontal" method="get">
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">用户名</label>
                                    <div class="col-sm-9 ">
                                    张小帅
                                    </div>
                                    </div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">原密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请输入你原来的密码。</span>
                                     </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                  <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label">新密码<span class="redstar"> *</span></label>
                                    <div class="col-sm-9">
                                    <input type="password" name="password" class="form-control">
                                    <span class="help-block m-b-none">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</span>
                                    </div>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">重复新密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请再次输入密码。</span>
                                     </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">电子邮箱<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="text" class="form-control" value="example@example.com">
                                                   <span class="help-block m-b-none">此项为必填。</span>
                                                 </div>
                                               </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>

                                    <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left">
                                                   <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a0.png" alt="...">
                                                   <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> 
                                                 </span>
                                                 </div>
                                                 
                                                 
                                               </div>
                                               
                                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                               <div class="checkbox m-t-lg">
                                               <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" ><strong>取消</strong></button>
                                               <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存修改</strong></button>
                                               </div>
                                             </form>
                             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div>  
   
  
</body>
</html>