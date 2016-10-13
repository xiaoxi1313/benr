<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app topadminhome">
<head>
  <meta charset="utf-8" />
  <title><s:property value="tag.name"/>==文章列表</title> 
  <link rel="shortcut icon" type="image/x-icon" href="<%=UrlHelper.getHomeUrl()%>favicon.ico">
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
  <script type="text/javascript">
	$(document).ready(function(){
		$('#batchDiv').html('');
	});
 </script>
</head>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>

	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h3 class="m-t-none">查看含该标签的资讯列表</h3>
			<small>您可以在此查看使用了该标签的资讯列表。</small>
		</div>
		<div class="modal-body no-padder">
			<div class="row wrapper">
				<div class="col-sm-3 m-b-xs"></div>
				<div class="col-sm-6 text-center m-b-xs"></div>
				<div class="col-sm-3">
					<div class="input-group">
						<input type="text" class="input-sm form-control" placeholder="搜索">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">
								<i class="fa fa-search"></i>
							</button> </span>
					</div>
				</div>
			</div>
			<div class="table-responsive  panel m-b-none">
				<table class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th>标题</th>
							<th class="th-sortable" data-toggle="class">时间 
								<span class="th-sort"> 
								<i class="fa fa-sort-down text"></i> 
								<i class="fa fa-sort-up text-active"></i> 
								<i class="fa fa-sort"></i>
							</span>
							</th>
							<th class="th-sortable" data-toggle="class">一级类别 
								<span class="th-sort"> 
									<i class="fa fa-sort-down text"></i> 
									<i class="fa fa-sort-up text-active"></i> 
									<i class="fa fa-sort"></i>
								</span>
							</th>
							<th class="th-sortable" data-toggle="class">二级类别 
								<span class="th-sort"> 
									<i class="fa fa-sort-down text"></i> 
									<i class="fa fa-sort-up text-active"></i> 
									<i class="fa fa-sort"></i>
								</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="articleList">
						<tr>
							<td>
								<a class="row-title" href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a>
							</td>
							<td><s:date name="createTime" format="yyyy-MM-dd"/></td>
							<td><s:property value="parentCategory.name" /></td>
							<td><s:property value="childCategory.name" /></td>
						</tr>
						</s:iterator>
					</tbody>

				</table>
				<footer class="panel-footer">
					<pages:pages page="page" params="params"/>
				</footer>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->

<!-- /.modal-dialog -->

</html>