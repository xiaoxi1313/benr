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
  <meta name="viewport" content="width=device-width, initial-scale=1, maxi】mum-scale=1" /> 
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

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
   
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.cookie.js" charset="UTF-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#subc').hide();
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
	
	$("#parentCategoryList").change(function(){
		showChildren($(this).val());
	});

	showParent();
	
	var st = $.cookie('showType');
	if(st != undefined) {
		changeList(st);
	} else {
		changeList(2);
	}
	
	$(".chosen").chosen();
	
	$(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			searchf();
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
	

function showParent() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getParentCategoryList.action',
		date : 'id=' + 0,
		success : function(d) {
			$('#parentCategoryList').empty();
			var option = "<option value='-1'>全部分类</option>";
			$.each(d.categoryList, function(i, item){
				option += "<option value='" + item.id+"'>" + item.name + "</option>";
			});
			
			$('#parentCategoryList').append(option);
			$('#parentCategoryList').prop('disabled', false).trigger("chosen:updated");
			$("#parentCategoryList").change();
		},
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

function showChildren(parentId) {
	//if(parentId > 0) {
		$.ajax({
			type : 'POST',
			dataType:'json',
			url : 'article_getCategoryListByParentId.action?parentCategoryId=' + parentId,
			success : function(d) {
				$('#childCategoryList').empty();
				var option ="";
				if (d.categoryList != '') {
					$('#subc').show();
					option +="<option value='-1'>全部子类</option>";
					$.each(d.categoryList, function(i, item){
						option += "<option value='" + item.id+"' " + ( item.id == $('#childCategoryList').attr('val') ? "selected" : '')+">" + item.name + "</option>";
					});
				} else {
					option += "<option value='-1'>全部子类</option>";
				}
				
				$('#childCategoryList').append(option);
				$('#childCategoryList').prop('disabled', false).trigger("chosen:updated");
			} ,
			error : function(msg, testStatus, e) {
				alert(e);
			}
		});
	//}
	
}

function searchf() {
	setAttr();
	
	$('#searchForm').attr("action", "index.action");
	$('#searchForm').submit();
}

function setAttr() {
	$('#queryArticleParentCategoryId').val($("#parentCategoryList").val());
	$('#queryArticleChildCategoryId').val($("#childCategoryList").val());
	if ($("#articleUserId").val() != "") {
		$('#queryArticleUserId').val($("#articleUserId").val());
	}
	
	if ($("#articleStatus").val() != "") {
		$('#queryArticleStatus').val($("#articleStatus").val());
	}
	
	$('#queryBeginDate').val($('#articleBeginDate').val());
	$('#queryEndDate').val($('#articleEndDate').val());
}

//下方带标题的搜索
function searchAddTitle() {
	$('#articleTitle').val($('#articleTitleFrom').val());
	searchFrom();
}

// 排序查询
function orderBySearch(id) {
	if ($("#orderById").val() == "") {
		$("#orderById").val("1");
	}
	
	if ($("#orderById").val() == "1") {	// 正序
		$("#orderById").val(id);
		$("#oderByCondition").val("asc");
	} else {
		$("#orderById").val(id);
		$("#oderByCondition").val("desc");
	}
	searchf();
}

// 保存查询条件
function saveQuery() {
	if ($('#queryName').val() == '') {
		alert("请输入预制名称！");
		return false;
	}
	
	setAttr();
	
	$('#queryConditionName').val($('#queryName').val());
	$('#searchForm').attr("action", "saveQuery.action");
	
	$.post('saveQuery.action?'+$('#searchForm').serialize(),function(d){
		if(d.errorCode == 0) {
			alert("添加预制成功！");
			$(".modal").find(".close").click();
			window.location.reload();
			return true;
		}
	},"json");
}

//切换网格、列表显示
function changeList(type) {
	if (type == 1) {		//列表
		$('#listDiv').show();
		$('#gridDiv').hide();
		
	} 
	
	else if (type == 2) {	// 网格
		$('#listDiv').hide();
		$('#gridDiv').show();
	}
	$(".ty").removeClass("active");
	$(".ty"+type).addClass("active");
	$.cookie("showType",type);
}

//批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	} else if ($("input[name='batchOperator']:checked").val() == "2") {
		var aIds = '';
		$('input:checkbox[name="articleIds"]:checked').each(function() //multiple checkbox的name  
		   {  
				aIds += $(this).val()+",";
		   }); 
		if(aIds == ''){
			alert("请选择操作记录！");
			return ;
		}
		aIds = aIds.substring(0,aIds.length-1);
		window.location.href="batchExportArticl.action?artIds="+aIds;
	} else {
		var idxs = "";
		$('input[name="articleIds"]:checked').each(function(index,d){
			if(index == 0) {
				idxs += $(this).val();
			} else {
				idxs = idxs + "," + $(this).val();
			}
		});
		var url = "batchDeleteAjax.action?articleIds=" + idxs;

		$.getJSON(url,function(data){
			if (data.errorCode == 0) {
				alert("操作成功！");
				location.reload();
			}
		});
	}
}

//删除查询条件
function deleteQuery(id, obj) {
	$.post("deleteQuery.action?queryCondition.id=" + id,
		function (data, textStatus) {
			if (data.errorCode == 0) {
				alert("删除成功！");
				$(obj).parent().remove();
			}
		}, "json");
}

//点击预制，设置查询条件 
function setQuery(parentCategoryId, childCategoryId, userId, beginDate, endDate, status) {
	$('#articleBeginDate').val(beginDate);
	$('#articleEndDate').val(endDate);
	$('#queryArticleUserId').val(userId);
	
	$("#articleUserId").val(userId);
	if(userId > 0) {
		$('#articleUserId').prop('disabled', false).trigger("chosen:updated");
	}
	$('#queryArticleStatus').val(status);
	$("#articleStatus").val(status);
	$('#articleStatus').prop('disabled', false).trigger("chosen:updated");
	
	$('#queryArticleChildCategoryId').val(childCategoryId);
	$('#childCategoryList').attr('val',childCategoryId);
	
	if(parentCategoryId > 0) {
		$('#queryArticleParentCategoryId').val(parentCategoryId);
		$("#parentCategoryList").val(parentCategoryId);
		$('#parentCategoryList').prop('disabled', false).trigger("chosen:updated");
		$("#parentCategoryList").change();
	}
}

//删除文章
function deleteArticle(id, obj) {
	
	if (confirm("是否将此资讯放入回收站？")) {
		$.post("index_deleteArticle.action?article.id=" + id,
			function (data, textStatus) {
				if (data.errorCode == 0) {
					//$(obj).parent().parent().parent().remove();
					location.reload();
				}
		}, "json");
	}
}
</script>
</head>
<body class="" >
		<%@include file="head.jsp" %>
  
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <section class="scrollable padder">              
                  <section class="row m-b-md col-md-9">
                  <div class="row">
                    <div class="col-sm-6">
                      <h3 class="m-b-xs text-black">我的主页</h3>
                      <small>请使用收看筛选工具查找符合您要求的文章</small>
                    </div>
                    </div>
                  </section>
                  <section class="col-md-9 row">
                  
                  <section class="panel panel-default">
                  <header class="panel-heading">资讯筛选</header>
                  <div class="panel-body">
                  <div class="row wrapper selectrow">
                  <div class="m-b-xs prename">
                  <span class="selectname">类别</span>
                  
                  <div class="btn-group m-r">
                  <select id="parentCategoryList" class="chosen" val="<s:property value="article.parentCategoryId" />">
                   	<option value="-1">全部分类</option>
                  </select>
                  </div>
                 
                  <div class="btn-group m-r" id="subc">
                  
                  <select id="childCategoryList" class="chosen" val="<s:property value="article.childCategoryId" />">
                   	<option value="-1">请选择</option>
                  </select>
                  
                  </div>
                  
                  </div>
                  </div>
                  
                  <div class="row wrapper selectrow">
                   <div class="m-b-xs prename">
                   <span class="selectname">录入者</span>
                   
                   <div class="btn-group m-r">
                   
                   
                   
                   <select id="articleUserId" name="articleUserId" class="chosen">
                   	<option value="-1">请选择</option>
                   	<s:iterator value="userList" id="user" status="u">
                   		<option	<s:if test="article.userId == id">selected="selected"</s:if> value="<s:property value='id' />"><s:property value="userName" /></option>
                   	</s:iterator>
                   </select>
                   
                   </div>
                   </div>
                   </div>
                  
                  <div class="row wrapper selectrow">
                   <div class="m-b-xs prename col-md-12 no-padder">
                   <span class="selectname">时间段</span>
                   <div class="col-md-5 f-left btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="" readonly="" name="beginDate" id="articleBeginDate" value="<s:property value='beginDate' />">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                   <div class="col-md-5 f-left btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="" readonly="" name="endDate" id="articleEndDate" value="<s:property value='endDate' />">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                   </div>
                   </div>
                 
                 <!-- 
                 <div class="row wrapper selectrow">
	                  <div class="m-b-xs prename">
		                  <span class="selectname">状态</span>
		                  <div class="btn-group m-r">
			                  <select id="articleStatus" name="articleStatus" class="chosen">
			                  	<option value="-1">请选择</option>
			                  	<option value="99"	<s:if test="article.status == 99">selected="selected"</s:if>>未读</option>
			                  	<option value="3"	<s:if test="article.status == 3">selected="selected"</s:if>>已读未标注</option>
			                  	<option value="4"	<s:if test="article.status == 4">selected="selected"</s:if>>已读已标注</option>
			                  </select>
		                  </div>
	                  </div>
                  </div>
                   --> 
                  
                  <div class="row wrapper selectrow b-b" style="padding-bottom: 10px;">
                   <div class="m-b-xs prename">
                   <span class="selectname">预制</span>
                   
                   <div class="btn-group m-r">
                   <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                   <span class="dropdown-label">请选择</span> 
                   <span class="caret"></span>
                   </button>
                   <ul class="dropdown-menu dropdown-select">
                   <s:iterator value="queryConditionList" id="queryCondition" status="u">
                   		<li class=""><a href="javascript:void(0)" onclick="setQuery(<s:property value='parentCategoryId' />, <s:property value='childCategoryId' />, <s:property value='queryUserId' />, '<s:property value='beginDateStr' />', '<s:property value='endDateStr' />', '<s:property value='status' />')"><input type="radio" name="d-s-r"><s:property value="name" /></a><a href="javascript:void(0)" onclick="deleteQuery(<s:property value='id' />, this)" class="close preclose"><i class="i i-cancel"></i></a></li>
                   </s:iterator>
                   </ul>

                    <button class="btn btn-s-md btn-success btn-preset" style="margin-left: 15px;" data-toggle="modal" href="#modal-add-preset">
                    <i class="fa fa-plus text"></i>
                    <span class="text">设置当前选择为预制</span>
                    </button>
                    </div>
                   
                   </div>
                   </div>

                  <div class="row wrapper selectrow search-btn">
                  
                  <a href="javascript:void(0)" onclick="searchf()" class="btn btn-s-md btn-primary">开始搜索</a>
                  <a href="index.action?menuUrl=index" class="btn btn-s-md btn-primary">重置</a>
                  </div>

                  </div>
                  </section>
                  <section class="panel panel-default list-show">
                  <header class="panel-heading">资讯列表
                  </header>
                  <div class="row wrapper">
	                  <div class="col-sm-3 m-b-xs">
		                  <div class="btn-group">
		                      <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
		                                     <span class="dropdown-label">批量操作</span> 
		                                     <span class="caret"></span>
		                                     </button>
		                                     <ul class="dropdown-menu dropdown-select">
		                                     <li class=""><a href="#"><input type="radio" name="batchOperator" value="1">删除</a></li>
		                                     </ul>
		                  	</div>
	                                      <button class="btn btn-sm btn-default" onclick="batchOperate()">应用</button>                
	                    </div>
                                    <div class="col-sm-6 text-center m-b-xs">
                                      <div class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-sm btn-default ty2 ty" onclick="changeList(2)" data-toggle="tooltip" data-placement="top" title="" data-original-title="网格显示">
                                          <input type="radio" name="options" id="option1"><i class="i i-grid2"></i>
                                        </label>
                                        <label class="btn btn-sm btn-default active ty1 ty active" onclick="changeList(1)" data-toggle="tooltip" data-placement="top" title="" data-original-title="列表显示">
                                          <input type="radio" name="options" id="option2" ><i class="fa fa-list-ul"></i>
                                        </label>
                                      </div>
                                      
                                      <div class="btn-group m-l-sm" data-toggle="buttons">
                                        <label class="btn btn-sm btn-default <s:if test="article.status == 0">active</s:if>" onclick='location="index.action?menuUrl=index&article.status=0"' data-toggle="tooltip" data-placement="top" title="" data-original-title="全部">
                                          <input type="radio" name="options"><i class="fa fa-sun-o"></i>
                                        </label>
                                        <label class="btn btn-sm btn-default <s:if test="article.status == 99">active</s:if>" onclick='location="index.action?menuUrl=index&article.status=99"' data-toggle="tooltip" data-placement="top" title="" data-original-title="未读">
                                          <input type="radio" name="options"><i class="fa fa-star-o"></i>
                                        </label>
                                        <label class="btn btn-sm btn-default <s:if test="article.status == 3">active</s:if>" onclick='location="index.action?menuUrl=index&article.status=3"' data-toggle="tooltip" data-placement="top" title="" data-original-title="已读未批注">
                                          <input type="radio" name="options"><i class="fa fa-star-half-full"></i>
                                        </label>
                                        <label class="btn btn-sm btn-default <s:if test="article.status == 4">active</s:if>" onclick='location="index.action?menuUrl=index&article.status=4"' data-toggle="tooltip" data-placement="top" title="" data-original-title="已读已批注">
                                          <input type="radio" name="options" id="post-option4" ><i class="fa fa-star"></i>
                                        </label>
                                      </div>
                                      
                                      <div class="btn-group m-l-sm" data-toggle="buttons">
                                        <label class="btn btn-sm btn-default <s:if test="page.numPerPage==40">active</s:if>" onclick='location="<s:property value="queryString"/>&page.numPerPage=40"' data-toggle="tooltip" data-placement="top" title="" data-original-title="显示40篇">
                                            <input type="radio" name="options" id="number-option1">40
                                        </label>
                                        <label class="btn btn-sm btn-default <s:if test="page.numPerPage==60">active</s:if>" onclick='location="<s:property value="queryString"/>&page.numPerPage=60"' data-toggle="tooltip" data-placement="top" title="" data-original-title="显示60篇">
                                            <input type="radio" name="options" id="number-option2">60
                                        </label>
                                        <label class="btn btn-sm btn-default <s:if test="page.numPerPage==80">active</s:if>" onclick='location="<s:property value="queryString"/>&page.numPerPage=80"' data-toggle="tooltip" data-placement="top" title="" data-original-title="显示80篇">
                                            <input type="radio" name="options" id="number-option3">80
                                        </label>
                                    </div>
                                    
                                    </div>
                                    
                                    <div class="col-sm-3">
                                      <form id="searchForm" method="post" action="index.action">
                                      <div class="input-group">
                                        <input type="text" class="input-sm form-control" id="articleTitleFrom" name="article.title" value="<s:property value='article.title' />" placeholder="搜索">
                                        <span class="input-group-btn">
                                          <button class="btn btn-sm btn-default" onclick="searchAddTitle"><i class="fa fa-search"></i></button>
                                        </span>
                                      </div>
                                      <input type="hidden" name="queryCondition.name" id="queryConditionName"  />
					                  <input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
					                  <input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
                                      <input type="hidden" name="article.parentCategoryId" id="queryArticleParentCategoryId" />
                                      <input type="hidden" name="article.childCategoryId" id="queryArticleChildCategoryId" />
                                      <input type="hidden" name="article.userId" id="queryArticleUserId" />
                                      <input type="hidden" name="beginDate" id="queryBeginDate"/>
                                      <input type="hidden" name="endDate" id="queryEndDate"/>
                                      <input type="hidden" name="article.status" id="queryArticleStatus"/>
                                      </form>
                                      
                                    </div>
                     </div>
                                  
                                  <form id="batchOperateForm" method="post" action="batchDelete.action">
                                  <!-- 列表 -->
                                  <div class="table-responsive">	
                                    <table class="table table-striped b-t b-light" id="listDiv">
                                      <thead>
                                        <tr>
                                          <th class="list-choose"><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox"><i></i></label></th>
                                          <th id="id" class="th-sortable active list-id" orderfield="id" orderCond="asc" data-toggle="class" style="width:70px;">ID
                                            <span class="th-sort">
                                              <i class="fa fa-sort-down text"></i>
                                              <i class="fa fa-sort-up text-active"></i>
                                              <i class="fa fa-sort"></i>
                                            </span>
                                          </th>
                                          <th class="list-title">标题</th>
                                          <th class="th-sortable list-time" data-toggle="class" orderfield="createTime" orderCond="asc">时间
                                          <span class="th-sort">
                                            <i class="fa fa-sort-down text"></i>
                                            <i class="fa fa-sort-up text-active"></i>
                                            <i class="fa fa-sort"></i>
                                          </span>
                                          </th>
                                          <th class="th-sortable list-1cat" data-toggle="class" orderfield="parentCategoryId" orderCond="asc">
                                          	一级类别
                                          	<span class="th-sort">
	                                            <i class="fa fa-sort-down text"></i>
	                                            <i class="fa fa-sort-up text-active"></i>
	                                            <i class="fa fa-sort"></i>
	                                        </span>	
                                          </th>
                                          <th class="th-sortable list-2cat" data-toggle="class" orderfield="childCategoryId" orderCond="asc">
                                          	二级类别
                                          	<span class="th-sort">
	                                            <i class="fa fa-sort-down text"></i>
	                                            <i class="fa fa-sort-up text-active"></i>
	                                            <i class="fa fa-sort"></i>
	                                        </span>	
                                          </th>
                                          <th class="th-sortable list-state" data-toggle="class" orderfield="status" orderCond="asc">
                                          	状态
                                          	<span class="th-sort">
	                                            <i class="fa fa-sort-down text"></i>
	                                            <i class="fa fa-sort-up text-active"></i>
	                                            <i class="fa fa-sort"></i>
	                                        </span>	
                                          </th>
                                          <th class="th-sortable list-writer" data-toggle="class" orderfield="userId" orderCond="asc">
                                          	录入员
                                          	<span class="th-sort">
	                                            <i class="fa fa-sort-down text"></i>
	                                            <i class="fa fa-sort-up text-active"></i>
	                                            <i class="fa fa-sort"></i>
	                                        </span>	
                                          </th>
                                          <th style="min-width: 70px;">编辑</th>
                                        </tr>
                                      </thead>
                                      <tbody>
                                      <s:if test="articleList == null || articleList.size() == 0">
                                      <tr>
                                      	<td colspan="10" class="noresult">
                                      		<h5>抱歉，找不到相关的文章，请换个关键词试试看</h5>
                                      	</td>
                                      </tr>
                                      </s:if>
                                      <s:iterator value="articleList" id="article" status="u">
                                      	<tr>
                                          <td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="articleIds" value="<s:property value='id' />"><i></i></label></td>
                                          <td><s:property value="id" /></td>
                                          <td><a class="row-title" href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a></td>
                                          <td><s:date name="#article.createTime" format="yyyy-MM-dd" /></td>
                                          <td><s:property value="parentCategory.name" /></td>
                                          <td><s:property value="childCategory.name" /></td>
                                          <td><s:property value="statusName" /></td>
                                          <td><s:property value="user.userName" /></td>
                                          <td><div class="btn-group open">
                                              <a href="article_edit.action?article.id=<s:property value='id' />" target="_blank" class="iconbtn"><i class="fa fa-pencil"></i></a>
                                              <a href="javascript:void(0)" onclick="deleteArticle(<s:property value='id' />, this)" class="iconbtn"><i class="fa fa-trash-o"></i></a></div>
                                              </td>
                                        </tr>
                                      </s:iterator>
                                      </tbody>
                                    </table>
                                  </div>
                                  <!-- 列表 -->
                                  
                                  <!-- 网格 -->
								<div class="panel-body p-b-none" id="gridDiv" style="display:none">
									<div class="col-sm-12 text-right text-left-xs no-padder">

										<div class="btn-group">
											<button
												class="btn btn-sm  btn-default dropdown-toggle p-r-lg"
												data-toggle="dropdown">
												<span class="dropdown-label">按发布时间排序</span> <span
													class="caret"></span>
											</button>
											<ul
												class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
												<li data-sort-by="postedtime" class="sort active"><a
													href="#"><input type="radio" checked="" name="d-s-r">按发布时间排序</a>
												</li>
												<li data-sort-by="posttitlename" class="sort"><a
													href="#"><input type="radio" name="d-s-r">按文章名排序</a>
												</li>
											</ul>
										</div>
									</div>

									<div class="block-fl m-t-sm" id="container" >
									<s:if test="articleList == null || articleList.size() == 0">
                                      		<h5  class="noresult">抱歉，找不到相关的文章，请换个关键词试试看</h5>
                                    </s:if>
									<s:iterator value="articleList" id="article" status="u">
										<div class="item col-sm-6 col-md-3 post" >
											<section class="panel b-a">
												<div class="clearfix text-center m-b-sm title-pic">
													<div class="picframe">
														<a href="#"><img class="thumb-o" src="<s:property value='titleImage' />">
														</a>
														<div class="hover-content">
															<div class="overlay"></div>
															<div class="link-contianer">
																<a href="article_show.action?article.id=<s:property value='id' />" target="_blank">查看详情</a>
															</div>
														</div>
													</div>
													<div class="infopart b-b m-b-sm">
														<div class="h5 m-t m-b-xs posttitlename">
															<a href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a>
														</div>
														<div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
														
													</div> 
													<div class="posttags">
														<div class="padder">
															<s:iterator value="#article.hot3TagList" id="tg">
                                                                  <span class="label label-info tag" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="#tg.tooltip" />"><s:property value="#tg.name" /></span>
                                                            </s:iterator>
                                                           </div>
													</div>
													<!-- <s:if test="summary.length() > 40">
													<div class="text-left abs-text"><s:property value="summary.substring(0,40)" />...</div>
													</s:if>
													<s:else>
													<div class="text-left abs-text"><s:property value="summary" /></div>
													</s:else>
													 -->

												</div>
												<div class="clearfix panel-footer">
													<a class="m-l-xs" href="#"><label
														class="i-checks m-b-none"><input type="checkbox" name="articleIds" value="<s:property value='id' />"><i></i>
													</label>
													</a>
                                                    <a href="javascript:void(0)" onclick="deleteArticle(<s:property value='id' />, this)" class="pull-right m-l-sm"><i class="i i-trashcan text-muted"></i></a> 
													<a class="pull-right" href="article_edit.action?article.id=<s:property value='id' />" target="_blank"><i
														class="i i-pencil2 text-muted"></i>
													</a>
												</div>
											</section>

										</div>
									</s:iterator>

									</div>
								</div>
								<!-- 网格 -->
                                <footer class="panel-footer">
                                    <pages:pages page="page" params="params"/>
                                </footer>
                                </form>
                     </section>
                  </section>
                     
                   <section class="scrollable col-md-3 siderbar">
                   <ul class="list-group gutter list-group-lg list-group-sp sortable m-b-none">  
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    标签状态                    
                    </header>
                    <div class="panel-body tagform">
                    <div class="tagtitle" style="margin-top: 0;">新增标签<a href="tag_manage.action" target="_blank" class="btn btn-sm btn-default add-btn">
                    <i class="fa fa-plus text"></i></a></div>
                    <s:iterator value="tagList" id="tag" status="u">
                    	<a class="label label-info tag" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="tooltip" />"><s:property value="name" /></a>
                    </s:iterator>
                    <div class="tagtitle">最新热门标签</div>
                    <s:iterator value="hotTagList" id="hotTag" status="u">                        
                        <a class="label bg-hot tag"><s:property value="content" escape="false"/></a>
                    </s:iterator>   
                    <div class="tagtitle">最新趋势标签</div>
                    <s:iterator value="trendTagList" id="trendTag" status="u">                        
                        <a class="label bg-dark tag"><s:property value="content" escape="false"/></a>
                    </s:iterator> 
                    </div>
                    </li> 
                                    
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    录入员                    
                    </header>
                    <s:iterator value="luryList" id="user" status="u">
                    	<article class="b-b">
		                    <div class="panel-body">
		                    	<span class="pull-left thumb-sm avatar">
		                    		<s:if test="icon == null || icon==''">
					            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" class="img-circle">
					            	</s:if>
					            	<s:else>
					            		<img src="<%=UrlHelper.getHomeUrl()%><s:property value='icon' />" class="img-circle">
					            	</s:else>
		                    	</span>
		                    	<div class="media-body">
			                    	<div class="pull-right me<%=UrlHelper.getHomeUrl()%>resources/common/images/text-center text-muted">
			                    		<a href="article_list.action?article.userId=<s:property value='id' />" target="_blank" class="btn btn-default btn-rounded"><i class="fa fa-list-alt"></i></a>
			                    	</div>
			                    	<a href="#" class="h5"><s:property value="userName" /></a>
			                    	<small class="block">资料更新至 <s:date name="#user.modifyTime" format="yyyy-MM-dd"/></small>
			                    </div>
		                    </div>
	                    </article>
                    </s:iterator>
                    
                    </div>
                    </li>
                                           
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                    <div class="panel panel-default portlet-item m-b-none">
                    <header class="panel-heading">
                    <ul class="nav nav-pills pull-right">
                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                    </ul>
                    我的项目                    
                    </header>
                    <s:iterator value="childFavoriteList" id="favorite" status="u">
                    	<div class="panel-body project t-t">
	                    	<a href="favorite_list.action?parentFavorite.id=0&childFavorite.id=<s:property value='id' />" target="_blank">
	                    	<s:property value="name" /></a> 
	                    	<span class="badge bg-primary"><s:property value="articleNum" /></span>
	                    </div>
                    </s:iterator>   
                    
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
  
  <div class="modal fade" id="modal-add-preset" style="display: none;">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">设置当前选择为预制</h3>
          <small>您可以在此设置当前的选择作为预制。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">预制名称</label>
                                     <div class="col-sm-9">
                                     <input type="text" name="queryName" id="queryName" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请输入您为预制定的独有的名称。</span>
                                     </div>
                                    </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                
                                                <button class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" onclick="$('#modal-add-preset').find('.close').click();"><strong>取消</strong></button>
                                                
                                                <button onclick="saveQuery()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                   
                                                </div>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
</body>
</html>