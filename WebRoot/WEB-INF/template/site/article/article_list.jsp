<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%@page import="com.newvery.utils.TimeUtil"%>
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

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
  
  $(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			
			$("#showType").val(1);
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
});

function deleteArticle(id) {
	if (confirm("确定删除吗？")) {
		if ($('#articleUserId').val() == '') {
			location.href = "article_delete.action?article.id=" + id;
		} else {
			location.href = "article_delete.action?article.id=" + id + "&article.userId=" + $('#articleUserId').val();
		}
	}
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
}

//批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	}
	$('#batchOperateForm').submit();
}

// 网格显示排序搜索
function gridSortSearch(orderCond) {
	$("#orderById").val(orderCond);
	$("#oderByCondition").val("desc");
	$("#showType").val(2);
	
	searchForm();
}

function searchForm() {
	$('#searchForm').submit();
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
                <s:if test="user == null">             
                  <section class="row m-b-md col-md-9">
                  <div class="row">
                    <div class="col-sm-12">
                      <h3 class="m-b-xs text-black">我的文章列表</h3>
                      <small>在此查看您所有的文章。请注意：您发布的文章在超过24小时候后将失去修改的权限，如需调整请联系高级研究员。</small>
                    </div>
                    </div>
                  </section>
                </s:if>
                  <section class="col-md-12 row">
                  
                  <section class="panel panel-default list-show">
                  <header class="panel-heading">
                  <s:if test="user == null">     
                  	<s:property value="#session.user.userName"/>
                  </s:if>
                  <s:else>
                  	<s:property value="user.userName" />
                  </s:else>
                  的全部文章
                  </div>
                  </header>
                  <div class="row wrapper">
                  <div class="col-sm-5 m-b-xs">
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
                                    <div class="col-sm-4 m-b-xs">
                                      <div class="btn-group" data-toggle="buttons">
                                        <label class="btn btn-sm btn-default" onclick="changeList(2)" data-toggle="tooltip" data-placement="top" title="" data-original-title="网格显示">
                                          <input type="radio" name="options" id="option1"><i class="i i-grid2"></i>
                                        </label>
                                        <label class="btn btn-sm btn-default active" onclick="changeList(1)" data-toggle="tooltip" data-placement="top" title="" data-original-title="列表显示">
                                          <input type="radio" name="options" id="option2" ><i class="fa fa-list-ul"></i>
                                        </label>
                                      </div>
                                    </div>
                                    <div class="col-sm-3">
                                    <s:if test="user==null">
                                    	<form id="searchForm" method="post" action="article_list.action">
                                    </s:if>
                                    <s:else>
                                    	<form id="searchForm" method="post" action="article_list.action?article.userId=<s:property value='user.id' />">
                                    </s:else>
                                      
                                      <div class="input-group">
                                        <input type="text" class="input-sm form-control" name="article.title" value="<s:property value='article.title' />" placeholder="搜索">
                                        <span class="input-group-btn">
                                          <button class="btn btn-sm btn-default" type="submit"><i class="fa fa-search"></i></button>
                                        </span>
                                      </div>
                                      <input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
					                  <input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
					                  <input type="hidden" name="showType" id="showType" value="<s:property value='showType' />" />
                                      </form>
                                    </div>
                                  </div>
                                  
                                  <form id="batchOperateForm" method="post" action="article_batchDelete.action">
                                  <!-- 列表 -->
                                  <div class="table-responsive userpostlist" id="listDiv"
                                  	<s:if test="showType == 2">
                                  		style="display:none"
                                  	</s:if>
                                  	>
                                    <table class="table table-striped b-t b-light">
                                      <thead>
                                        <tr>
                                          <th class="list-choose"><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox"><i></i></label></th>
                                          <th id="id" class="th-sortable list-id" data-toggle="class" style="width:70px;" orderfield="id" orderCond="asc">ID
                                            <span class="th-sort">
                                              <i class="fa fa-sort-down text"></i>
                                              <i class="fa fa-sort-up text-active"></i>
                                              <i class="fa fa-sort"></i>
                                            </span>
                                          </th>
                                          <th class="list-title">标题</th>
                                          <th class="th-sortable list-time" data-toggle="class" orderfield="createTime" orderCond="asc">修改时间
                                          <span class="th-sort">
                                            <i class="fa fa-sort-down text"></i>
                                            <i class="fa fa-sort-up text-active"></i>
                                            <i class="fa fa-sort"></i>
                                          </span>
                                          </th>
                                          <th class="list-1cat">一级类别</th>
                                          <th class="list-2cat">二级类别</th>
                                          <th class="list-state">状态</th>
                                          <th style="min-width: 70px;">编辑</th>
                                        </tr>
                                      </thead>
                                      <tbody>
                                      <s:iterator value="articleList" id="article" status="u">
                                      	<tr>
                                          <td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="articleIds" value="<s:property value='id' />"><i></i></label></td>
                                          <td><s:property value="id" /></td>
                                          <td><a class="row-title" href="article_show.action?article.id=<s:property value='id' />"><s:property value="title" /></a></td>
                                          <td><s:date name="#article.createTime" format="yyyy-MM-dd" />&nbsp;<span><s:date name="#article.createTime" format="hh:mm:ss" /></span></td>
                                          <td><s:property value="parentCategory.name" /></td>
                                          <td><s:property value="childCategory.name" /></td>
                                          <td><s:property value="statusName" /></td>
                                          <td><div class="btn-group open">
                                          	  <s:if test="editable==true">
                                              		<a href="article_edit.action?article.id=<s:property value='id' />" class="iconbtn"><i class="fa fa-pencil"></i></a>
                                              </s:if>
                                              <a href="javascript:void(0)" onclick="deleteArticle(<s:property value='id' />)" class="iconbtn"><i class="fa fa-trash-o"></i></a>
                                              </td>
                                        </tr>
                                      </s:iterator>
                                      </tbody>
                                    </table>
                                  </div>
                                  <!-- 列表 -->

								<!-- 网格 -->
								<div class="panel-body p-b-none" id="gridDiv" 
									<s:if test="showType != 2">
                                  		style="display:none"
                                  	</s:if>
									>
									<!-- <div class="col-sm-6 button-group no-padder" id="filters">
										<button data-filter="*"
											class="btn btn-sm btn-default btn-rounded m-b-xs">全部文章</button>
										<button data-filter=".hulianwang"
											class="btn btn-sm btn-default btn-rounded m-b-xs">互联网</button>
										<button data-filter=".xiaofeidianzi"
											class="btn btn-sm btn-default btn-rounded m-b-xs">消费电子</button>
									</div> -->
									<div class="col-sm-6 text-right text-left-xs no-padder">

										<div class="btn-group">
											<button
												class="btn btn-sm  btn-default dropdown-toggle p-r-lg"
												data-toggle="dropdown">
												<span class="dropdown-label">
													<s:if test="orderById == 'title'">按文章名排序</s:if>
													<s:else>按发布时间排序</s:else>
												</span> <span
													class="caret"></span>
											</button>
											<ul
												class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
												<li data-sort-by="postedtime" class="sort active"><a
													href="javascript:void(0)" onclick="gridSortSearch('createTime')"><input type="radio" checked="" name="d-s-r">按发布时间排序</a>
												</li>
												<li data-sort-by="posttitlename" class="sort"><a
													href="javascript:void(0)" onclick="gridSortSearch('title')"><input type="radio" name="d-s-r">按文章名排序</a>
												</li>
											</ul>
										</div>
									</div>

									<div class="block-fl m-t-sm" id="container" >
									<s:iterator value="articleList" id="article" status="u">
										<div class="item col-sm-6 col-md-4 post hulianwang" >
											<section class="panel b-a">
												<div class="clearfix text-center m-b-sm title-pic">
													<div class="picframe">
														<a href="#"><img class="thumb-o" src="<s:property value='titleImage' />">
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

													<div class="text-left abs-text"><s:property value="summary" escape="false" /></div>

												</div>
												<div class="clearfix panel-footer">
													<a class="m-l-xs" href="#"><label
														class="i-checks m-b-none"><input type="checkbox" name="articleIds" value="<s:property value='id' />"><i></i>
													</label>
													</a> <a class="pull-right" href="#"><i
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
                                <input type="hidden" id="articleUserId" name="article.userId" value="<s:property value='user.id' />"/>
                                </form>
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
</html>