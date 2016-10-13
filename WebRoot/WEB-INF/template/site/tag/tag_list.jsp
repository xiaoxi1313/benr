<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app topadmineditpost">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>本然数据库</title>
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
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.tooltip.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.spline.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.pie.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.resize.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.grow.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
<script type="text/javascript">
function deleteTag(tagId,obj) {
	if(confirm("确认删除吗？")) {
		$.get("tag_delete.action?tag.id=" + tagId, function(result){
			$(this).parent().parent().parent().remove();
		    //window.location.reload();
		});
	}
}
</script>
</head>
<body class="" >
<form id="searchForm" method="post" action="tag_list.action">
<div class="tab-content">
		<div class="panel tab-pane active m-b-none" id="tagtab01">
			<div class="row wrapper">
				<div class="col-sm-5 m-b-xs">
					<div class="btn-group m-r">
						<button data-toggle="dropdown"
							class="btn btn-sm btn-default dropdown-toggle">
							<span class="dropdown-label">批量操作</span> <span class="caret"></span>
						</button>
						<ul class="dropdown-menu dropdown-select">
							<li class="active">
								<a href="#"><input type="radio" name="d-s-r" checked="">修改标签状态 </a>
							</li>
							<li class="">
								<a href="#"><input type="radio" name="d-s-r">修改标签目录</a>
							</li>
							<li class="">
								<a href="#"><input type="radio" name="d-s-r">删除</a>
							</li>
						</ul>
					</div>
					<button class="btn btn-sm btn-default">应用</button>
				</div>

				<div class="col-sm-3 pull-right-lg">
					<div class="input-group">
						<input type="text" name="tag.name" value="<s:property value='tag.name'/>" class="input-sm form-control" placeholder="搜索"/>
						<input type="hidden" name="tagCategoryId" value="<s:property value='tagCategoryId'/>"/>
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="submit">
								<i class="fa fa-search"></i>
							</button> 
						</span>
					</div>
				</div>
			</div>
			<div class="table-responsive">
				<table class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th width="20"><label
								class="checkbox m-l m-t-none m-b-none i-checks"><input
									type="checkbox"><i></i>
							</label></th>
							<th class="th-sortable" data-toggle="class">ID <span
								class="th-sort"> <i class="fa fa-sort-down text"></i> <i
									class="fa fa-sort-up text-active"></i> <i class="fa fa-sort"></i>
							</span>
							</th>
							<th>标签名</th>
							<th>标签别名</th>
							<th class="th-sortable" data-toggle="class">创建日期 <span
								class="th-sort"> <i class="fa fa-sort-down text"></i> <i
									class="fa fa-sort-up text-active"></i> <i class="fa fa-sort"></i>
							</span></th>
							<th>附加的文章数量</th>
							<th>标签状态</th>
							<th style="width: 70px;">编辑</th>
						</tr>
					</thead>
					<tbody>
					<s:iterator value="tagList" id="tag" status="u">
						<tr>
							<td>
								<label class="checkbox m-l m-t-none m-b-none i-checks">
									<input type="checkbox" name="post[]"><i></i>
								</label>
							</td>
							<td><s:property value="id"/></td>
							<td><s:property value="name"/></td>
							<td><s:property value="alias"/></td>
							<td><s:date name="#tag.createTime" format="yyyy-MM-dd" /></td>
							<td><s:property value="articleNum"/></td>
							<td><s:property value="statusName"/></td>
							<td><div class="btn-group open">
									<a href="#" class="iconbtn"><i class="fa fa-pencil"></i> </a> 
									<a href="javascrpti:void(0)" onclick="deleteTag(<s:property value="id"/>,this)" class="iconbtn"><i class="fa fa-trash-o"></i> </a>
								</div>
							</td>
						</tr>
					</s:iterator>
					</tbody>
				</table>
			</div>
			<footer class="panel-footer">
				<pages:pages page="page" params="params"/>
			</footer>

		</div>
	</div>
</form>

</body>
</html>