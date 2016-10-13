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
  <script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"
		charset="UTF-8"></script>
	<!-- Bootstrap -->
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"
		charset="UTF-8"></script>
	<!-- App -->
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
		<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>

	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>

	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js"
		charset="UTF-8"></script>
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js"
		charset="UTF-8"></script>
	<!-- wysiwyg -->
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>

	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
	<script
		src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
	<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.cookie.js" charset="UTF-8"></script>
<script>
$(document).ready(function(){
	$('#batchDiv').hide();
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
	
	$('#profileavatar').preimage();
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
			$("#childSpan").html('请选择');
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
			} else {
				$('#subc').hide();
			}
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
	}
	$(".ty").removeClass("active");
	$(".ty"+type).addClass("active");
	$.cookie("showType",type);
}
</script>
</head>
<body class="">
	<%@include file="head.jsp" %>
		<section>
			<section class="hbox stretch">

				<section id="content">
					<section class="hbox stretch">
						<aside class="aside-md bg-success lt b-r" id="subNav">
							<section class="vbox animated fadeInLeft">
								<section class="scrollable">
									<div
										class="list-group auto list-group-alt no-radius no-borders">
										<ul class="nav">
										<s:iterator value="favoriteList" id="favorite" status="u">
											<li 
							           			<s:if test="id == favorite.id">
							           				class="list-group-item active"
							           			</s:if>
							           			<s:else>
							           				class="list-group-item "
							           			</s:else>
							           		>
												<a href="javascript:void(0)" onclick="listByFavorite(<s:property value='id' />)">
													<i class="fa fa-chevron-right pull-right m-t-sm text-xs icon-muted"></i>
													<span class="thumb-sm pull-left">
													<img src="<s:property value="img" />" alt="...">
													</span><span class="subfavbtn"><s:property value="name" /></span>
												</a>
											</li>
										</s:iterator>
										</ul>
									</div>
								</section>
							</section>
						</aside>

						<section class="panel-default userfav">

							<section class="hbox stretch">
								<section>
									<section class="vbox">
										<section class="scrollable padder">
											<section class="row m-b-md col-md-9">
												<div class="row">
													<div class="col-sm-6">
														<h3 class="m-b-xs text-black"><s:property value="favorite.name" /></h3>
													</div>
												</div>
											</section>
											<section class="col-md-12 row">
											
												<form id="searchForm" method="post" action="user_index.action">
												<section class="panel panel-default">
													<header class="panel-heading">文章筛选</header>
													<div class="panel-body">
														<div class="row wrapper selectrow">
															<div class="m-b-xs prename">
																<span class="selectname">类别</span>
                  
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
												                  <span class="dropdown-label" id="childSpan">请选择</span> 
												                  <span class="caret"></span>
												                  </button>
												                  <ul class="dropdown-menu dropdown-select" id="childCategoryList">
												                  </ul>
												                  </div>
															</div>
														</div>

														<div class="row wrapper selectrow b-b"
															style="padding-bottom: 10px;">
															<div class="m-b-xs prename">
																<span class="selectname">时间段</span>
																<div class="btn-group m-r input-group date form_date"
																	data-date="" data-date-format="" data-link-field=""
																	data-link-format="yyyy-mm-dd">
																	<input class="form-control" size="16" type="text"
																		value="" readonly="" name="beginDate" id="articleBeginDate" value="<s:property value='beginDate' />"> <span
																		class="input-group-addon"><span
																		class="glyphicon glyphicon-remove"></span>
																	</span> <span class="input-group-addon"><span
																		class="glyphicon glyphicon-calendar"></span>
																	</span>
																</div>
																<div class="btn-group m-r input-group date form_date"
																	data-date="" data-date-format="" data-link-field=""
																	data-link-format="yyyy-mm-dd">
																	<input class="form-control" size="16" type="text"
																		value="" readonly="" name="endDate" id="articleEndDate" value="<s:property value='endDate' />"> <span
																		class="input-group-addon"><span
																		class="glyphicon glyphicon-remove"></span>
																	</span> <span class="input-group-addon"><span
																		class="glyphicon glyphicon-calendar"></span>
																	</span>
																</div>
															</div>
														</div>

														<div class="row wrapper selectrow search-btn">
															<a href="javascript:void(0)" onclick="searchF()" class="btn btn-s-md btn-primary">开始搜索</a> 
															<a href="user_index.action" class="btn btn-s-md btn-primary">重置</a>
														</div>

													</div>
												</section>
												<input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
					          			        <input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
					          			        <input type="hidden" name="article.title" id="queryArticleTitle" />
												</form>
												<section class="panel panel-default list-show">
													<header class="panel-heading"> 未读信息列表 </header>
													<div class="row wrapper">
														<div class="col-sm-4 m-b-xs">
															<div class="btn-group" data-toggle="buttons">
					                                        <label class="btn btn-sm btn-default ty ty2" onclick="changeList(2)" data-toggle="tooltip" data-placement="top" title="" data-original-title="网格显示">
					                                          <input type="radio" name="options" id="option1"><i class="i i-grid2"></i>
					                                        </label>
					                                        <label class="btn btn-sm btn-default active ty ty1" onclick="changeList(1)" data-toggle="tooltip" data-placement="top" title="" data-original-title="列表显示">
					                                          <input type="radio" name="options" id="option2" ><i class="fa fa-list-ul"></i>
					                                        </label>
					                                      </div>
														</div>
														<div class="col-sm-3">
															<div class="input-group">
																<input type="text" class="input-sm form-control" id="articleTitle" name="article.title" value="<s:property value='article.title' />" placeholder="搜索"> 
																<span class="input-group-btn">
																	<button class="btn btn-sm btn-default" type="button" onclick="searchByName()">
																		<i class="fa fa-search"></i>
																	</button> 
																</span>
															</div>
														</div>
													</div>
													<div class="table-responsive">
														<table class="table table-striped b-t b-light" id="listDiv">
															<thead>
																<tr>

																	<th>标题</th>
																	<th style="width: 40%;">摘要</th>
																	<th class="th-sortable" data-toggle="class" orderfield="a.createTime" orderCond="asc">时间 <span
																		class="th-sort"> <i
																			class="fa fa-sort-down text"></i> <i
																			class="fa fa-sort-up text-active"></i> <i
																			class="fa fa-sort"></i> </span></th>
																	<th>一级类别</th>
																	<th>二级类别</th>

																</tr>
															</thead>
															<tbody>
																<s:iterator value="articleList" id="article" status="u">
																	<tr>

																		<td><a class="row-title" href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a>
																		</td>
																		<td><s:property value="contentSubStr" escape="false"/></td>
																		<td><s:date name="#article.createTime" format="yyyy-MM-dd" /></td>
																		<td><s:property value="parentCategory.name" /></td>
																		<td><s:property value="childCategory.name" /></td>


																	</tr>
																</s:iterator>
															</tbody>
														</table>
													</div>
													
													
								<!-- 网格 -->
								<div class="block-fl m-t-sm" id="gridDiv">
									<s:iterator value="articleList" id="article" status="u">
										<div class="item col-sm-6 col-md-4 post hulianwang" >
											<section class="panel b-a">
												<div class="clearfix text-center m-b-sm title-pic">
													<div class="picframe">
														<a href="article_show.action?article.id=<s:property value='id' />">
														  <s:if test="#article.titleImage != null">
		                                              		 <img src="<s:property value='#article.titleImage' />" class="thumb-o">
		                                              	  </s:if>
		                                              	  <s:else>
		                                              	  	 <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/placeholder-thumb.png" class="thumb-o">
		                                              	  </s:else>
														</a>
														<div class="hover-content">
															<div class="overlay"></div>
															<div class="link-contianer">
																<a href="article_show.action?article.id=<s:property value='id' />">查看详情</a>
															</div>
														</div>
													</div>
													<div class="infopart b-b m-b-sm">
														<div class="h5 m-t m-b-xs posttitlename">
															<a href="article_show.action?article.id=<s:property value='id' />"><s:property value="title" /></a>
														</div>
														<div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
														<div class="cats m-b-sm">
															<div class="label bg-success m-b-xs">
																一级分类：<span><s:property value="parentCategory.name" /></span>
															</div>
															<div class="part-clear"></div>
															<div class="label bg-info m-b-xs">
																二级分类：<span><s:property value="childCategory.name" /></span>
															</div>
														</div>

													</div>

													<div class="text-left abs-text"><s:property value="summary" /></div>

												</div>
												<div class="clearfix panel-footer">
													<a class="m-l-xs" href="#"><label
														class="i-checks m-b-none"><input type="checkbox" name="articleIds" value="<s:property value='id' />"><i></i>
													</label>
													</a> 
													<a class="pull-right" href="article_edit.action?article.id=<s:property value='id' />" target="_blank"><i
														class="i i-pencil2 text-muted"></i>
													</a>
												</div>
											</section>

										</div>
									</s:iterator>
									</div>
								<!-- 网格 -->
													<footer class="panel-footer">
														<pages:pages page="page" params="params"/>
													</footer>
												</section>
											</section>


										</section>
									</section>
								</section>


							</section>

						</section>

					</section>
					<a href="#" class="hide nav-off-screen-block"
						data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
				</section>
			</section>
		</section>
	</section>
	

	<!-- 用户编辑 -->
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
             <form class="form-horizontal" method="post" id="modifyUserInfoForm" action="updateUserProfile.action" enctype="multipart/form-data">
             	<input type="hidden" name="user.id" value="<s:property value="#session.user.id"/>"/>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">用户名</label>
                                    <div class="col-sm-9 ">
                                     <s:property value="#session.user.userName"/>
                                    </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">原密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请输入你原来的密码。</span>
                                     </div>
                                    </div>
                                    
                                  <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label">新密码<span class="redstar"> *</span></label>
                                    <div class="col-sm-9">
                                    <input type="password" name="newPassword" class="form-control">
                                    <span class="help-block m-b-none">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</span>
                                    </div>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">重复新密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="rePassword" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请再次输入密码。</span>
                                     </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">电子邮箱<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="text" class="form-control" value="<s:property value="#session.user.email"/>" name="user.email">
                                                   <span class="help-block m-b-none">此项为必填。</span>
                                                 </div>
                                               </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>

                                    <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left">
                                                   <s:if test="#session.user.icon == null">
									            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" width="128" height="128">
									            	</s:if>
									            	<s:else>
									            		<img src="<%=UrlHelper.getHomeUrl()%><s:property value='#session.user.icon' />" width="128" height="128">
									            	</s:else>
									            	<input type="file" id="profileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                 </span>
                                                 </div>
                                                 
                                                 
                                               </div>
                                               
                                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                               <div class="checkbox m-t-lg">
                                               <button type="button" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..." onclick="$('#modal-editprofile').find('.close').click();"><strong>关闭</strong></button>
                                               <button type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..." onclick="$('#modifyUserInfoForm').submit();"><strong>保存修改</strong></button>
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