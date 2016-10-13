<%@page import="com.newvery.utils.TimeUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app topuserindex">
<head>
<meta charset="utf-8" />
<title>本然数据库</title>
<meta name="description"
	content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
	<link rel="shortcut icon" type="image/x-icon" href="<%=UrlHelper.getHomeUrl()%>favicon.ico">
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css"
	type="text/css" />
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
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<!-- wysiwyg -->
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>

	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.cookie.js" charset="UTF-8"></script>
	
	<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
	<link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
	  
	<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
<script>
$(document).ready(function(){
	$('#batchDiv').html('');
	$('#subc').hide();
	showParent();
	$('#gridDiv').hide();
	
	$('.form_date').datetimepicker({
		language : 'zh-CN',
		format : 'yyyy-mm-dd',
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		todayHighlight : 1,
		startView : 2,
		minView : 2,
		forceParse : 0
	});

	var st = $.cookie('showType');
	if(st != undefined) {
		changeList(st);
	}else{
		changeList(2);
	}
	
	var $container = $('#container').isotope({
		getSortData : {
			posttitlename : '.posttitlename',
			postedtime : '.postedtime'
		}
	});

	$(".text-left-xs .dropdown-select li").click(function() {
		var sortData = $(this).data("sort-by");
		$container.isotope({
			sortBy : sortData,
			sortAscending : false
		});
	});

	$("#filters button").click(function() {
		var fitlerData = $(this).data("filter");
		$container.isotope({
			filter : fitlerData
		});

	});
	
	$(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			searchForm();
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
	
	//$('#profileavatar').preimage();
	$('#modifyUserInfoForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
		},
		success:function(d) {
			if(d.errorCode==0){
				alert('操作成功');
			}else{
				alert(d.errorMessage);
			}
		}    	
	});
	
	$("#content").show();
	
	//$(".uselect").change();
});

function showParent() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getParentCategoryList.action?groupId=<s:property value="#session.user.userGroup.id" />',
		date : 'id=' + 0,
		success : function(d) {
			$('#parentCategoryList').empty();
			var option = "<option value='-1'>选择一级分类</option>";
			$.each(d.categoryList, function(i, item){
				option += "<option value='" + item.id+"' " + (item.id==$('#parentCategoryList').attr('val') ? "selected":"")+">"+ item.name +"</option>";
			});
			
			$('#parentCategoryList').append(option);
			$('#parentCategoryList').chosen();
			
			if($('#parentCategoryList').attr('val') != undefined) {
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

function showChildren(obj) {
	parentId = $(obj).val();
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getCategoryListByParentId.action?groupId=0&parentCategoryId=' + parentId,
		success : function(d) {
			var o = $(obj).parent().parent().parent().find("select[name='childCategoryId']");
			$(o).html("<option value='-1'>选择二级分类</option>");
			
			var option ="";
			if (d.categoryList != '') {
				$.each(d.categoryList, function(i, item){
					option += "<option value='" + item.id+"' " + (item.id==$(o).attr('val') ? "selected":"")+">"+ item.name +"</option>";
				});
			} 
			
			$(o).append(option);
			$(o).chosen();
			$(o).prop('disabled', false).trigger("chosen:updated");
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}
	
function logout() {
	if (confirm("确定退出吗？")) {
		location.href = "logout.action";
	}
}

function listByFavorite(id) {
	location.href = "user_index.action?favorite.id=" + id;
}

function searchF() {
	$('#searchForm').submit();
}

function searchByName() {
	$('#queryArticleTitle').val($('#articleTitle').val());
	searchF();
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
		$(".sorttime").click();
	} else {
		$('#listDiv').show();
		$('#gridDiv').hide();
	}
	$(".ty").removeClass("active");
	$(".ty"+type).addClass("active");
	$.cookie("showType",type);
}


//---------------------------------------------------------

// 根据标题搜索
function searchTitle() {
	$('#articleTitle').val($('#articleTitleSearch').val());
	$('#searchForm').submit();
}

function addcategory1(obj) {
	var o = $(".selectcategory").clone();
	$(o).removeClass("selectcategory");
	
	
	$(o).find(".op").html('<a href="javascript:void(0);" onclick="deletecategory(this);" class="btn btn-sm btn-default del-btn"><i class="fa fa-trash-o text"></i></a>');
	t = $('<div>').append($(o)).html();
	$(".selectcategory").after(t);
	
	$(".selectcategory").next().find(".chosen-container").remove();
	$(".selectcategory").parent().find("select").chosen();
	$(".selectcategory").parent().find("select").prop('disabled', false).trigger("chosen:updated");
	
	return false;
}

function deletecategory(obj) {
	$(obj).parent().parent().remove();
}

function addurow(obj) {
	if($(".uclone").parent().find('tr').length < 10) {
		var o = $(".uclone").clone();
		$(o).removeClass("uclone");
		
		
		$(o).find(".uop").html('<a href="javascript:void(0);" onclick="deleteurow(this);" class="btn btn-sm btn-default del-btn"><i class="fa fa-trash-o text"></i></a>');
		t = $('<div>').append($(o)).html();
		$(".uclone").after(t);
		$(".uclone").next().find(".chosen-container").remove();
		$(".uclone").parent().find("select").chosen();
		$(".uclone").parent().find("select").prop('disabled', false).trigger("chosen:updated");
		
		return false;
	}
}

function deleteurow(obj) {
	$(obj).parent().parent().remove();
}

function addtgg(obj) {
	
	var o = $(".clonetg").clone();
	$(o).removeClass("clonetg");
	
	$(o).find(".op2").html('<a href="javascript:void(0);" onclick="deletetgg(this);" class="btn btn-sm btn-default del-btn"><i class="fa fa-trash-o text"></i></a>');
	t = $('<div>').append($(o)).html();
	$(".clonetg").after(t);
	
	$(".clonetg").next().find(".chosen-container").remove();
	$(".clonetg").parent().find("select").chosen();
	$(".clonetg").parent().find("select").prop('disabled', false).trigger("chosen:updated");
}
function deletetgg(obj) {
	$(obj).parent().parent().remove();
}
function updateUserCategory() {
	
	var q = '';
	$('#modal-shortcut').find("select[name='childCategoryId']").each(function(){
		q += '&cid=' + $(this).val();
	})
	
	$.getJSON('category_updateUserCategory.action?' + q,function(d){
		if(d.errorCode == 0) {
			alert("操作成功！");
			$(".modal").find(".close").click();
			location.reload();
		} else {
			alert(d.errorMessage);
		}
	})
}

</script>
</head>
<body class="">
	<%@include file="head.jsp" %>
                <section id="content">
                    <section class="hbox stretch">

                        <section class="panel-default userfav">

                            <section class="hbox stretch">
                                <section>
                                    <section class="vbox">
                                        <section class="scrollable padder">
                                            <section class="row m-b-md col-md-9">
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <h3 class="m-b-xs text-black">最新资讯</h3>
                                                        <small>请使用收看筛选工具查找符合您要求的资讯</small>
                                                    </div>
                                                </div>
                                            </section>
                                            <section class="col-md-9 row">
												<form id="searchForm" method="post" action="user_index.action">
                                                <section class="panel panel-default">
                                                    <header class="panel-heading">资讯筛选</header>
                                                    <div class="panel-body">
                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname">类别</span>

                                                                <table>
                                                                    <tbody>
                                                                        <tr class="m-b-md block selectcategory">
                                                                            <td>
                                                                                <div class="btn-group m-r">
                                                                                    <select class="" name="parentCategoryId" id="parentCategoryList" onchange="showChildren(this);">
                                                                                    </select>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div class="btn-group m-r">
                                                                                    <select class="chosen-select" name="childCategoryId">
                                                                                    	<option value="-1">选择二级分类</option>
                                                                                    </select>
                                                                                </div>
                                                                            </td>

                                                                            <td class="op">
                                                                                <a class="btn btn-sm btn-default plus-btn" onclick="addcategory1(this);return false;">
                                                                                    <i class="fa fa-plus text"></i>
                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                        

                                                                    </tbody>
                                                                </table>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel-body p-t-none p-b-none">
                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname">时间段</span>
                                                                <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                                                                    <input class="form-control" size="16" type="text" value="<s:property value='beginDate' />" name="beginDate" readonly>
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                </div>
                                                                <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                                                                    <input class="form-control" size="16" type="text" value="<s:property value='endDate' />" name="endDate" readonly>
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="panel-body">
                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname">标签</span>

                                                                <table>
                                                                    <tbody>
                                                                        <tr class="m-b-sm block pull-left m-r-sm clonetg">
                                                                            <td>
                                                                                <div class="btn-group m-r">
                                                                                    <select class="chosen-select" name="tagId">
                                                                                    	<option value="-1">请选择</option>
                                                                                    	<s:iterator value="leastTagList">
                                                                                        <option value="<s:property value="id" />"><s:property value="name" /></option>
                                                                                        </s:iterator>
                                                                                    </select>
                                                                                </div>
                                                                            </td>

                                                                            <td class="op2">
                                                                                <a href="javascript:void(0);" onclick="addtgg(this);" class="btn btn-sm btn-default plus-btn">
                                                                                    <i class="fa fa-plus text"></i>
                                                                                </a>
                                                                            </td>

                                                                        </tr>

                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>


                                                        <div class="row wrapper selectrow search-btn">
                                                            <a href="javascript:$('#searchForm').submit();" class="btn btn-s-md btn-primary" >开始搜索</a>
                                                            <a href="#" class="btn btn-s-md btn-primary">重置</a>
                                                        </div>
														<input type="hidden" id="articleTitle" name="article.title" value="<s:property value='article.title' />"/>
														
                                                    </div>
                                                </section>
                                                </form>
                                                <!-- 列表 -->
                                                
                                                <section class="panel panel-default list-show">
                                                    <header class="panel-heading">
                                                        资讯列表
                                                    </header>
                                                    <div class="row wrapper b-b">
                                                        <div class="col-sm-3 m-b-xs">
                                                            <div class="btn-group">

                                                            </div>
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
                                                            <div class="input-group">
                                                                <input type="text" id="articleTitleSearch" value="<s:property value='article.title' />" class="input-sm form-control" placeholder="标题搜索">
                                                                <span class="input-group-btn">
                                                         <button class="btn btn-sm btn-default" type="button" onclick="searchTitle()"><i class="fa fa-search"></i></button>
                                                       </span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="wrapper">
                                                    	<a href="#modal-shortcut" class="btn btn-success btn-preset m-r-sm" data-toggle="modal"><i class="fa fa-cog p-r-xs"></i>设置分类快捷键</a>
                                                        <s:iterator value="fast3CategoryList">
                                                        	<a href="?parentCategoryId=<s:property value="id" /><%=request.getParameter("userSelectDateType")!= null ? "&userSelectDateType="+request.getParameter("userSelectDateType") : ""%>" class="btn btn-default btn-preset m-r-sm" data-toggle="modal"><i class="fa fa-thumb-tack p-r-xs"></i><s:property value="name" /></a>
                                                        </s:iterator>
                                                    </div>

                                                    <section class="panel panel-default m-b-none" >
                                                        <s:if test="userSelectDateType > 0">
                                                        <header class="panel-heading bg-light b-b-none">
                                                            <ul class="nav nav-justified b-b-none nav-tabs">
                                                                <li<s:if test="userSelectDateType==1"> class="active"</s:if>>
                                                                	<a href="?userSelectDateType=1<%=request.getParameter("beginDate")== null&&request.getParameter("parentCategoryId") != null ? "&parentCategoryId="+request.getParameter("parentCategoryId") : ""%>&page.numPerPage=<s:property value="page.numPerPage"/>"><i class="fa fa-clock-o p-r-xs"></i><%=TimeUtil.format(new Date(), "yyyy.MM.dd")%></a>
                                                                </li>
                                                                <li<s:if test="userSelectDateType==2"> class="active"</s:if>>
                                                                	<a href="?userSelectDateType=2<%=request.getParameter("beginDate")== null&&request.getParameter("parentCategoryId") != null ? "&parentCategoryId="+request.getParameter("parentCategoryId") : ""%>&page.numPerPage=<s:property value="page.numPerPage"/>"><i class="fa fa-clock-o p-r-xs"></i><%=TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -1), "yyyy.MM.dd")%></a>
                                                                </li>
                                                                <li<s:if test="userSelectDateType==3"> class="active"</s:if>>
                                                                	<a href="?userSelectDateType=3<%=request.getParameter("beginDate")== null&&request.getParameter("parentCategoryId") != null ? "&parentCategoryId="+request.getParameter("parentCategoryId") : ""%>&page.numPerPage=<s:property value="page.numPerPage"/>"><i class="fa fa-clock-o p-r-xs"></i><%=TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -2), "yyyy.MM.dd")%></a>
                                                                </li>
                                                                <li<s:if test="userSelectDateType==4"> class="active"</s:if>>
                                                                	<a href="?userSelectDateType=4<%=request.getParameter("beginDate")== null&&request.getParameter("parentCategoryId") != null ? "&parentCategoryId="+request.getParameter("parentCategoryId") : ""%>&page.numPerPage=<s:property value="page.numPerPage"/>"><i class="fa fa-clock-o p-r-xs"></i>更早</a>
                                                                </li>
                                                            </ul>
                                                        </header>
                                                        </s:if>

                                                        <div class="tab-content"  id="listDiv">

                                                            <!-- 列表 -->
                                                            <div class="tab-pane active">
                                                                <div class="table-responsive active">
                                                                    <table class="table table-striped b-t b-light m-b-none">
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="list-title">标题</th>
                                                                                <th class="list-tag">标签</th>
                                                                                <th class="th-sortable" data-toggle="class">时间
                                                                                    <span class="th-sort"><i class="fa fa-sort-down text"></i><i class="fa fa-sort-up text-active"></i><i class="fa fa-sort"></i></span>
                                                                                </th>
                                                                                <th class="th-sortable list-1cat" data-toggle="class">一级类别<span class="th-sort"><i class="fa fa-sort-down text"></i>
	                                   												<i class="fa fa-sort-up text-active"></i>
	                                  												<i class="fa fa-sort"></i>
	             																	</span>
                                                                                </th>
                                                                                <th class="th-sortable list-2cat" data-toggle="class">二级类别<span class="th-sort"><i class="fa fa-sort-down text"></i>
	                                   												<i class="fa fa-sort-up text-active"></i>
	                                   												<i class="fa fa-sort"></i>
	             																	</span>
                                                                                </th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                        	<s:iterator value="articleList" id="article" status="u">
                                                                        		<tr>
	                                                                                <td><a class="row-title" href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a>
	                                                                                </td>
	                                                                                <td>
	                                                                                	<s:iterator value="#article.hot3TagList">
	                                                                                	<a class="label label-info tag" href="article_forTag.action?tag.id=<s:property value="id" />"><s:property value="name" /></a>
	                                                                                	</s:iterator>
	                                                                                </td>
	                                                                                <td><s:date name="#article.createTime" format="yyyy-MM-dd" /></td>
	                                                                                <td><s:property value="parentCategory.name" /></td>
	                                                                                <td><s:property value="childCategory.name" /></td>
                                                                            	</tr>
                                                                        	</s:iterator>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
															
                                                        </div>
                                                        <!-- 列表 -->
                                                        
                                                        <!-- 网格 -->
															<div class="panel-body p-b-none" id="gridDiv" >
																<div class="col-sm-12 text-right text-left-xs no-padder">
							
																	<div class="btn-group">
																		<button class="btn btn-sm  btn-default dropdown-toggle p-r-lg" data-toggle="dropdown">
																			<span class="dropdown-label">按发布时间排序</span> <span class="caret"></span>
																		</button>
																		<ul class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
																			<li data-sort-by="postedtime" class="sort active sorttime">
																				<a href="#"><input type="radio" checked="" name="d-s-r">按发布时间排序</a>
																			</li>
																			<li data-sort-by="posttitlename" class="sort">
																				<a href="#"><input type="radio" name="d-s-r">按文章名排序</a>
																			</li>
																		</ul>
																	</div>
																</div>
							
																<div class="block-fl m-t-sm" id="container" >
																<s:if test="articleList == null || articleList.size() == 0">
							                                      		<h5  class="noresult">抱歉，找不到相关的文章，请换个关键词试试看</h5>
							                                    </s:if>
																<s:iterator value="articleList" id="article" status="u">
																	<div class="item col-sm-6 col-md-4 post" >
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
																				<div class="infopart m-b-sm">
																					<div class="h5 m-t m-b-xs posttitlename">
																						<a href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a>
																					</div>
			                                                           <div class="col-md-12 tagzone b-t b-b m-t-sm">
			                                                           		<s:iterator value="#article.hot3TagList" id="t">
			                                                           			<a class="label label-info tag" href="article_forTag.action?tag.id=<s:property value="id" />" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="tooltip" />"><s:property value="name" /></a>
			                                                           		</s:iterator>
																		</div> 
																					<div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
																					<div class="label bg-success m-b-xs ">一级分类：<span><s:property value="parentCategory.name" /></span></div>
			                                                             <div class="clear m-b-xs"></div>
			                                                             <div class="label bg-success m-b-xs text-center lt">二级分类：<span><s:property value="childCategory.name" /></span></div>
																				</div> 
																				<!-- <div class="posttags">
																					<div class="padder">
																						<s:iterator value="#article.hot3TagList" id="tg">
							                                                                  <span class="label label-info tag" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="#tg.tooltip" />"><s:property value="#tg.name" /></span>
							                                                                  </s:iterator>
							                                                           </div>
																				</div> -->
																				
							
																			</div>
																			
																		</section>
							
																	</div>
																</s:iterator>
							
																</div>
															</div>
															<!-- 网格 -->
                                                    </section>
                                                    
                                
                                                    
                                                    <footer class="panel-footer">
					                                    	<pages:pages page="page" params="params"/>
					                                </footer>
                                                </section>
                                            </section>
                                            
                                            
                                            

                                            <section class="scrollable col-md-3 siderbar">
                                                <ul class="list-group gutter list-group-lg list-group-sp sortable m-b-none">
                                                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                                                        <div class="panel panel-default portlet-item m-b-none">
                                                            <header class="panel-heading">
                                                                <ul class="nav nav-pills pull-right">
                                                                    <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a>
                                                                    </li>
                                                                </ul>
                                                                标签状态
                                                            </header>
                                                            <div class="panel-body tagform">
                                                                <div class="tagtitle" style="margin-top: 0;">新增标签</div>
                                                                <s:iterator value="leastTagList">
                                                                <a href="article_forTag.action?tag.id=<s:property value="id" />" class="label label-info tag" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="tooltip" />" title="<s:property value="tooltip" />" target="_blank">
                                                                <s:property value="name" />
                                                                </a>
                                                                </s:iterator>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </section>


                                        </section>
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
</body>

<div class="modal fade" id="modal-shortcut" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">设置分类快捷键</h3>
                    <small>您可以在此设置10个分类的快捷键，可以通过它们快速索引对应分类的资讯。</small>
                </div>
                <div class="modal-body wrapper-lg">
                    <div class="row">
                        <div class="col-sm-12">
                        	<form class="form-horizontal" method="get">
                                <div class="form-group">

                                    <div class="col-sm-12">
                                        <table>
                                            <tbody>
                                            	<!-- <s:if test="customerUserCategoryList.size() == #u.index+1">last-cat</s:if> -->
                                                <s:iterator value="customerUserCategoryList" status="u" id="usc">
                                                <tr class="m-b-md block <s:if test="#u.index == 0">uclone</s:if>">
                                                    <td>
                                                        <div class="btn-group m-r">
                                                            <select class="chosen-select uselect" name="childCategoryId">
                                                            	<option value="0">请选择</option>
                                                            	<s:iterator value="userCategoryList" >
                                                                <option value="<s:property value="id" />" <s:if test="id == #usc.parentCategoryId">selected</s:if>><s:property value="name" /></option>
                                                                </s:iterator>
                                                            </select>
                                                            <input type="hidden" name="childCategoryId" value="-1"/>
                                                        </div>
                                                    </td>
                                                    <!-- <td>
                                                        <div class="btn-group m-r">
                                                            <select class="chosen-select" name="childCategoryId" val="<s:property value="categoryId" />">
                                                                <option value="-1">请选择</option>
                                                            </select>
                                                        </div>
                                                    </td> -->
                                                    <td class="uop">
                                                    	<s:if test="#u.index > 0">
	                                                    	<a type="button" href="javascript:void(0);" class="btn btn-sm btn-default del-btn" onclick="deleteurow(this);">
	                                                            <i class="fa fa-trash-o text"></i>
	                                                    	</a>
                                                    	</s:if>
                                                    	<s:else>
                                                        	<a href="javascript:void(0);" class="btn btn-sm btn-default plus-btn" onclick="addurow(this);">
                                                            	<i class="fa fa-plus text"></i>
                                                        	</a>
                                                        </s:else>
                                                    </td>
                                                </tr>
                                                </s:iterator>
                                            </tbody>
                                        </table><span class="help-block m-b-none">点击“+”按钮可增加快捷键，最多可使用10个快捷键。</span>
                                    </div>
                                </div>

                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="checkbox m-t-lg">
                                    <a onclick="updateUserCategory();" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>保存</strong></a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

</html>