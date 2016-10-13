<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app">
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.preimage.js"></script> 
  
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>

<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.childFavoriteList').hide();
	
	$(".cfl").each(function(index,o){
		obj = $(this);
		$.getJSON("usergroup_getGroupCategory.action?userGroup.id=" + $(obj).attr('gid'),
				function (data, textStatus) {
					temp = '';	
					$.each(data, function(i, item){
						temp += item.parentCategory.name + "-" + item.name + "<br/>";
					});
						
					$($(".cfl")[index]).html(temp);
			}, "json");
	});
	
	$(".wfl").each(function(index,o){
		obj2 = $(this);
		$.post("user_getGroupFavorite.action?user.userGroup.id=" + $(obj2).attr('gid'),
				function (data, textStatus) {
					if (data.errorCode == 0) {
						temp = '';
						$.each(data.userFavoriteList, function(i, item){
							temp += item.parentFavorite.name + "-" + item.childFavorite.name + "<br/>";
						});
						$($(".wfl")[index]).html(temp);
					}
			}, "json");
	});
	
});


function addrow() {
	$('#selectTr').find("#parentFavoriteList_chosen").remove();
	var o = $('#selectTr').clone();
	$(o).removeAttr("id");
	$(o).removeAttr("style");
	var obj = $('<div>').append($(o)).html();
	$('#selectTr').parent().append(obj);
	
	$('#selectTr').parent().last().find("select[a='aaa']").chosen();
	$('#selectTr').find("#parentFavoriteList_chosen").remove();
	
	return false;
}

function addrow2() {
	var o = $('#selectTr2').clone();
	$(o).removeAttr("id");
	$(o).removeAttr("style");
	var obj = $('<div>').append($(o)).html();
	$('#selectTr2').parent().append(obj);
	//$('#selectTr2').parent().last().find("select[a='aaa']").chosen();
	$('#selectTr2').parent().last().find("select[a='aaa']").each(function(){
		if($(this).is(':visible')) {
			$(this).chosen();
		}
	});
	
	$(".childFavoriteList").hide();
	return false;
}

function addcrow() {
	$('#selectCr').find("#parentCategoryList_chosen").remove();
	$('#selectCr').find("#editparentCategoryList_chosen").remove();
	var o = $('#selectCr').clone();
	$(o).removeAttr("id");
	$(o).removeAttr("style");
	var obj = $('<div>').append($(o)).html();
	$('#selectCr').parent().append(obj);
	
	$('#selectCr').parent().last().find("select[a='aaa']").chosen();
	$('#selectCr').find("#parentCategoryList_chosen").remove();
	$('#selectCr').find("#editparentCategoryList_chosen").remove();
	return false;
}

function addcrow2() {
	$('#selectCr2').find("#parentCategoryList_chosen").remove();
	$('#selectCr2').find("#editparentCategoryList_chosen").remove();
	var o = $('#selectCr2').clone();
	$(o).removeAttr("id");
	$(o).removeAttr("style");
	var obj = $('<div>').append($(o)).html();
	$('#selectCr2').parent().append(obj);
	
	$('#selectCr2').parent().last().find("select[a='aaa']").chosen();
	$('#selectCr2').find("#parentCategoryList_chosen").remove();
	$('#selectCr2').find("#editparentCategoryList_chosen").remove();
	return false;
}

//删除收藏夹关系
function deleteFavorite(obj) {
	if($(obj).parent().parent().attr("id") != 'selectTr') {
		$(obj).parent().parent().remove();
	}
	return false;
}

function getChildrenByParentFavoriteId(obj) {
	$.post("favorite_getFavoriteListByParentId.action?parentId=" + $(obj).val(),
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$(obj).parent().parent().find("select[c='ccc']").empty();
			
				$("<option value=\"-1\">请选择</option>").appendTo($(obj).parent().parent().find("select[c='ccc']"));
				$.each(data.favoriteList, function(i, item){
					$("<option value=\"" + item.id + "\">" + item.name + "</option>").appendTo($(obj).parent().parent().find("select[c='ccc']"));
				});
				
				var o = $(obj).parent().parent().find("select[c='ccc']");
				//$(o).show();
				//$(o).parent().find("div").remove();
				$(obj).parent().parent().find("select[c='ccc']").chosen();
				$(obj).parent().parent().find("select[c='ccc']").prop('disabled', false).trigger("chosen:updated");
			}
	}, "json");
}

function getChildrenByParentCategoryId(obj) {
	$.post("article_getCategoryListByParentId.action?parentCategoryId=" + $(obj).val(),
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$(obj).parent().parent().find("select[c='ccc']").empty();
			
				$("<option value=\"-1\">全部</option>").appendTo($(obj).parent().parent().find("select[c='ccc']"));
				$.each(data.categoryList, function(i, item){
					$("<option value=\"" + item.id + "\">" + item.name + "</option>").appendTo($(obj).parent().parent().find("select[c='ccc']"));
				});
				
				var o = $(obj).parent().parent().find("select[c='ccc']");
				//$(o).show();
				//$(o).parent().find("div").remove();
				$(obj).parent().parent().find("select[c='ccc']").chosen();
				$(obj).parent().parent().find("select[c='ccc']").prop('disabled', false).trigger("chosen:updated");
			}
	}, "json");
}

function insertUserGroup() {
	$.getJSON('usergroup_save.action?'+$('#userGroupForm').serialize(),function(d) {
		if(d.errorCode == 0) {
			alert("操作成功！");
			$(".modal").find(".close").click();
			location.reload();
		} else {
			alert(d.errorMessage);
		}
	});
}

function updateUserGroup() {
	
	var s = "userGroup.id="+$('#editid').val() + "&userGroup.groupName="+$('#editGroupName').val()+"&userGroup.lastVipDays="+$('#editlastVipDays').val();
	s+="&userGroup.categoryTotal=" + $('#editcategoryTotal').val()+"&userGroup.folderTotal="+$('#editfolderTotal').val();

	$('#modal-edituser').find("select[name='fid']").each(function(){
		if($(this).val() == '-1') {
			alert("请选择二级文件夹");
			return false;
		}
		if($(this).val() > 0) {
			s += "&fid=" + $(this).val();
		}
	});
	
	$('#modal-edituser').find("input[name='fid']").each(function(){
		if($(this).val() > 0) {
			s += "&fid=" + $(this).val();
		}
	});
	
	$('#modal-edituser').find("select[name='cid']").each(function(idx,d){
		if($(this).val() != null) {
			s += "&cid=" + $(this).val();
		}
	});
	
	$('#modal-edituser').find("input[name='cid']").each(function(){
		s += "&cid=" + $(this).val();
	});
	$('#modal-edituser').find("select[name='pcid']").each(function(){
		if($(this).val() > 0) {
			s += "&pcid=" + $(this).val();
		}
	});
	
	$('#modal-edituser').find("input[name='pcid']").each(function(){
		if($(this).val() > 0) {
			s += "&pcid=" + $(this).val();
		}
	});
	
	
	
	$.getJSON('usergroup_update.action?'+s,function(d) {
		if(d.errorCode == 0) {
			alert("操作成功！");
			location.reload();
		} else {
			alert(d.errorMessage);
		}
	});
}

function deleteUserGroup(id) {
	if(confirm('确定删除当前记录！')) {
		$.getJSON("usergroup_delete.action?userGroupId="+id,function(d){
			if(d.errorCode == 0) {
				alert("操作成功！");
				location.reload();
			} else {
				alert(d.errorMessage);
			}
		});
	}
}
function setEdit(id,name,folderTotal,categoryTotal) {
	$('#editGroupName').val(name);
	$('#editid').val(id);
	$('#editfolderTotal').val(folderTotal);
	$('#editcategoryTotal').val(categoryTotal);
	
	//取出当前有权限目录
	permission(id);
}

//弹出用户权限
function permission(userId) {
	$('#userId').val(userId);
	
	//取出已设置可以查看的文件夹
	$.post("user_getGroupFavorite.action?user.userGroup.id=" + userId,
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$.each(data.userFavoriteList, function(i, item){
					
					var favoriteTr ="<tr><th>";
					favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.parentFavorite.name + "</label></div>"; 
					favoriteTr +="<input type='hidden' name='fid' value='" + item.childFavorite.id + "'/>"; 
					favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.childFavorite.name + "</label></div>";
					favoriteTr +="</th>";
					favoriteTr +="<th><a href=\"javascript:void(0)\" onclick=\"deleteFavorite(this)\" class=\"iconbtn\"><i class=\"fa fa-trash-o\"></i></a></th>";
					favoriteTr +="</tr>";
					$('#selectTr2').before(favoriteTr);
				});
			}
	}, "json");
	
	//取出已设置可以查看的分类
	$.getJSON("usergroup_getGroupCategory.action?userGroup.id=" + userId,
			function (data, textStatus) {
				//if (data.errorCode == 0) {
					$.each(data, function(i, item){
						
						var favoriteTr ="<tr><th>";
						favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.parentCategory.name + "</label></div>"; 
						favoriteTr +="<input type='hidden' name='cid' value='" + item.id + "'/>"; 
						favoriteTr +="<input type='hidden' name='pcid' value='" + item.parentCategory.id + "'/>"; 
						favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.name + "</label></div>";
						favoriteTr +="</th>";
						favoriteTr +="<th><a href=\"javascript:void(0)\" onclick=\"deleteFavorite(this)\" class=\"iconbtn\"><i class=\"fa fa-trash-o\"></i></a></th>";
						favoriteTr +="</tr>";
						$('#selectCr2').before(favoriteTr);
					});
				//}
		}, "json");
}
</script>
</head>
<body class="" >
<%@include file="../head.jsp" %>
        <section id="content">
          <section class="vbox">
            <section class="scrollable padder">
              <div class="m-b-md">
              <div class="row">
                <div class="col-sm-6">
                <h3 class="m-b-none">用户组管理 </h3>
                <small> 您可以在此添加、编辑、删除用户组</small>
                
              </div>
              </div>
              </div>

              <section class="panel panel-default">
                <header class="panel-heading"> 
					<button class="btn btn-s-md btn-success btn-preset" href="#modal-adduser" data-toggle="modal">
						<i class="fa fa-plus text"></i> <span class="text">添加群组</span>
					</button>
				</header>
                <div class="row wrapper">
                <div class="col-sm-5">
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
                  
                  <form id="searchForm" method="post" action="user_list.action?menuUrl=user_list">
                  <div class="col-sm-3 pull-right-lg">
                    <div class="input-group">
                      <input type="text" name="groupName" value="<s:property value='groupName' />" class="input-sm form-control" placeholder="搜索">
                      <span class="input-group-btn">
                      <button class="btn btn-sm btn-default" type="button" onclick="search()"><i class="fa fa-search"></i></button>
                      </span>
                    </div>
                  </div>
                  <input type="hidden" name="roleId" value="<s:property value='roleId' />" />
                  <input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
                  <input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
                  </form>
                </div>
                <div class="table-responsive">
                  <form id="batchOperateForm" method="post" action="user_batchDelete.action">
                  <table class="table table-striped b-t b-light">
                    <thead>
                      <tr>
                        <th width="20"><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox"><i></i></label></th>
                        <th class="th-sortable active" data-toggle="class" orderfield="u.id" orderCond="asc">ID
                          <span class="th-sort">
                            <i class="fa fa-sort-down text"></i>
                            <i class="fa fa-sort-up text-active"></i>
                            <i class="fa fa-sort"></i>
                          </span>
                        </th>
                        <th>群组名称</th>
                        <th>创立时间</th>
                        <th>剩余天数</th>
                        <th>群组人数</th>
                        <th>文件夹权限数</th>
                        <th>数据分析权限数</th>
                        <th>已分配分类</th>
                        <th>已分配文件夹</th>
                        <th style="width: 70px;">编辑</th>
                      </tr>
                    </thead>
                    <tbody>
                    
                    <s:iterator value="userGroupList" id="user" status="u">
                   		<tr>
                        	<td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="userIds" value="<s:property value='id' />"><i></i></label></td>
	                        <td><s:property value="id"/></td>
	                        <td><s:property value="groupName"/></td>
	                        <td><s:property value="createDate"/> <s:date name="registerDate" format="yyyy-MM-dd"/></td>
	                        <td>
	                        	<a href="#"><s:property value="vipRemains"/></a>
	                        </td>
	                        <td><s:property value="members" /></td>
	                        <td><s:property value="folderTotal"/></td>
	                        <td><s:property value="categoryTotal"/></td>
	                        <td class="cfl" gid="<s:property value='id' />"></td>
	                        <td class="wfl" gid="<s:property value='id' />"></td>
	                        <td> 
	                        	<a class="iconbtn" href="#modal-edituser" data-toggle="modal" onclick="setEdit(<s:property value='id' />, '<s:property value='groupName' />',<s:property value='folderTotal' />,<s:property value='categoryTotal' />)"><i class="fa fa-pencil"></i></a>
	                            <a class="iconbtn" href="javascript:void(0)" onclick="deleteUserGroup(<s:property value='id' />, this)"><i class="fa fa-trash-o"></i></a></div>
                            </td>
                      	</tr>
                   	</s:iterator>
                   	
                    </tbody>
                  </table>
                  </form>
                </div>
                <footer class="panel-footer">
                  <pages:pages page="page" params="params"/>
                </footer>
              </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
  
<div class="modal fade" id="modal-adduser" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
    	<form action="usergroup_save.action" method="post" id="userGroupForm"/>
		<div class="modal-content">
	      	<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		        <h3 class="m-t-none">添加新群组</h3>
		        <small>您可以在此添加新的群组。</small>
			</div>
	        <div class="modal-body wrapper-lg">
	          <div class="row">
		            <div class="col-sm-12">
		              <div class="form-group">
		             		<label class="col-sm-3 control-label">群组名称<span class="redstar"> *</span></label>
		              		<div class="col-sm-9">
		              			<input type="text" id="userGroup_name"  name="userGroup.groupName" class="form-control">
		              			<div class="Validform_checktip">此项为必填，请使用英文字母和数字作为用户名，用户组名不能和已有用户组重复，大小写不限，不能使用特殊符号。</div>
		              		</div>
		              </div>
		              <div class="line line-dashed b-b line-lg pull-in"></div>
		              
		              <div class="form-group">
                       	<label class="col-sm-3 control-label">续期</label>
                       	<div class="col-sm-9">
                       		<div class="input-group bootstrap-touchspin">
                         		<input type="text" name="userGroup.lastVipDays" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                       		</div>
                       		<div class="userdays m-t-xs">会员有效期剩余<small class="days"><span id="vipRemainsSpan">0</span>天</small>，请在此输入需要增加或减少的有效天数。</div>
                       	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                       	<label class="col-sm-3 control-label">文件夹权限数</label>
                       	<div class="col-sm-9">
                       		<div class="input-group bootstrap-touchspin">
                         		<input type="text" name="userGroup.folderTotal" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                       		</div>
                       		<div class="userdays m-t-xs">目前文件夹权限数<small class="days"><span id="vipRemainsSpan">0</span></small>，请在此输入需要增加或减少的权限数。</div>
                       	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                       	<label class="col-sm-3 control-label">数据分析权限数</label>
                       	<div class="col-sm-9">
                       		<div class="input-group bootstrap-touchspin">
                         		<input type="text" name="userGroup.categoryTotal" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                       		</div>
                       		<div class="userdays m-t-xs">目前数据分析权限数<small class="days"><span id="vipRemainsSpan">0</span></small>，请在此输入需要增加或减少的权限数。</div>
                       	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                      	<label class="col-sm-3 control-label">文件夹权限<span class="redstar"> *</span></label>
                      	<div class="col-sm-9">
                      		<a class="btn btn-sm btn-default" href="javascript:void(0)" onclick="addrow(); return false;"><i class="fa fa-plus text"></i>添加可查看的收藏夹</a>
                      	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                      	<label class="col-sm-3 control-label"></label>
                      	<div class="col-sm-9">
                      		<table style="width:100%;">
                       			<thead>
                        			<tr id="selectTr" class="chooselist" style="display:none;">
                         				<th>
				                          <div class="col-sm-5 no-padder m-r" >
				                           <select a="aaa" class="fchosen-select" name="fid" id="parentFavoriteList" onchange="getChildrenByParentFavoriteId(this)">
				                           	<option value="-1">请选择</option>
				                              <s:iterator value="favoriteList" id="favorite" status="u">
				                              	<option value="<s:property value='id' />"><s:property value="name" /></option>
				                              </s:iterator> 
				                           </select>		
				                        		
				                          </div>
				                          <div class="col-sm-5 no-padder">
				                           <select c="ccc" class="fchosen-select childFavoriteList" name="fid" id="childFavoriteList">
				                        	</select>
				                          </div>
				                         </th>
				                         <th>
				                         	<a class="iconbtn" onclick="deleteFavorite(this)" href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
				                         </th>
                        			</tr>
                       			</thead>
                      		</table>
                      	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
		              
		              <div class="form-group">
                      	<label class="col-sm-3 control-label">分类目录权限<span class="redstar"> *</span></label>
                      	<div class="col-sm-9">
                      		<a class="btn btn-sm btn-default" href="javascript:void(0)" onclick="addcrow(); return false;"><i class="fa fa-plus text"></i>添加可查看的分类目录</a>
                      	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                      	<label class="col-sm-3 control-label"></label>
                      	<div class="col-sm-9">
                      		<table style="width:100%;">
                       			<thead>
                        			<tr id="selectCr" class="chooselist" style="display:none;">
                         				<th>
				                          <div class="col-sm-5 no-padder m-r" >
				                           <select a="aaa" class="fchosen-select" name="categoryId" id="parentCategoryList" onchange="getChildrenByParentCategoryId(this)">
				                           	<option value="-1">请选择</option>
				                              <s:iterator value="categoryList" id="favorite" status="u">
				                              	<option value="<s:property value='id' />"><s:property value="name" /></option>
				                              </s:iterator> 
				                           </select>		
				                        		
				                          </div>
				                          <div class="col-sm-5 no-padder">
				                           <select c="ccc" class="fchosen-select childFavoriteList" name="categoryId" id="childCategoryList">
				                        	</select>
				                          </div>
				                         </th>
				                         <th>
				                         	<a class="iconbtn" onclick="deleteFavorite(this)" href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
				                         </th>
                        			</tr>
                       			</thead>
                      		</table>
                      	</div>
                      </div>
		              
		              <div class="checkbox m-t-lg">
		              	<input type="button" id="addUserButton" onclick="insertUserGroup()" value="添加新群组" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs"/>
		              </div>
		          	</div>
	          </div>          
	        </div>
		</div><!-- /.modal-content -->
		</form>
	</div><!-- /.modal-dialog -->
</div>
  
  
<div class="modal fade" id="modal-edituser" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
		<div class="modal-content">
	      	<div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		        <h3 class="m-t-none">编辑新群组</h3>
		        <small>您可以在此编辑群组。</small>
			</div>
	        <div class="modal-body wrapper-lg">
	          
	          <div class="row">
    			<input type="hidden" name="id" id="editid"/>
		            <div class="col-sm-12">
		              <div class="form-group">
		             		<label class="col-sm-3 control-label">群组名称<span class="redstar"> *</span></label>
		              		<div class="col-sm-9">
		              			<input type="text" name="userGroup.groupName" id="editGroupName" class="form-control">
		              			<div class="Validform_checktip">此项为必填。</div>
		              		</div>
		              </div>
		              <div class="line line-dashed b-b line-lg pull-in"></div>
		              
                      <div class="form-group">
                       	<label class="col-sm-3 control-label">续期</label>
                       	<div class="col-sm-9">
                       		<div class="input-group bootstrap-touchspin">
                         		<input type="text" id="editlastVipDays" name="userGroup.lastVipDays" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                       		</div>
                       		<div class="userdays m-t-xs">会员有效期剩余<small class="days"><span id="vipRemainsSpan">0</span>天</small>，请在此输入需要增加或减少的有效天数。</div>
                       	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                       	<label class="col-sm-3 control-label">文件夹权限数</label>
                       	<div class="col-sm-9">
                       		<div class="input-group bootstrap-touchspin">
                         		<input type="text" id="editfolderTotal" name="userGroup.folderTotal" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                       		</div>
                       		<div class="userdays m-t-xs">目前文件夹权限数<small class="days"><span id="vipRemainsSpan">0</span></small>，请在此输入需要增加或减少的权限数。</div>
                       	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                       	<label class="col-sm-3 control-label">数据分析权限数</label>
                       	<div class="col-sm-9">
                       		<div class="input-group bootstrap-touchspin">
                         		<input type="text" id="editcategoryTotal" name="userGroup.categoryTotal" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                       		</div>
                       		<div class="userdays m-t-xs">目前数据分析权限数<small class="days"><span id="vipRemainsSpan">0</span></small>，请在此输入需要增加或减少的权限数。</div>
                       	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                      	<label class="col-sm-3 control-label">收藏夹权限</label>
                      	<div class="col-sm-9">
                      		<a class="btn btn-sm btn-default" href="javascript:void(0)" onclick="addrow2(); return false;"><i class="fa fa-plus text"></i>添加可查看的收藏夹</a>
                      	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                      	<label class="col-sm-3 control-label"></label>
                      	<div class="col-sm-9">
                      		<table style="width:100%;">
                       			<thead>
                        			<tr id="selectTr2" class="chooselist" style="display:none;">
                         				<th>
				                          <div class="col-sm-5 no-padder m-r" >
				                           <select a="aaa" class="fchosen-select" name="pid" onchange="getChildrenByParentFavoriteId(this)">
				                           	<option value="-1">请选择</option>
				                              <s:iterator value="favoriteList" id="favorite" status="u">
				                              	<option value="<s:property value='id' />"><s:property value="name" /></option>
				                              </s:iterator> 
				                           </select>		
				                        		
				                          </div>
				                          <div class="col-sm-5 no-padder">
				                           <select c="ccc" class="fchosen-select childFavoriteList" name="fid">
				                           </select>
				                          </div>
				                         </th>
				                         <th>
				                         	<a class="iconbtn" onclick="deleteFavorite(this)" href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
				                         </th>
                        			</tr>
                       			</thead>
                      		</table>
                      	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
		              
		              <div class="form-group">
                      	<label class="col-sm-3 control-label">分类目录权限<span class="redstar"> *</span></label>
                      	<div class="col-sm-9">
                      		<a class="btn btn-sm btn-default" href="javascript:void(0)" onclick="addcrow2(); return false;"><i class="fa fa-plus text"></i>添加可查看的分类目录</a>
                      	</div>
                      </div>
                      <div class="line line-dashed b-b line-lg pull-in"></div>
                      
                      <div class="form-group">
                      	<label class="col-sm-3 control-label"></label>
                      	<div class="col-sm-9">
                      		<table style="width:100%;">
                       			<thead>
                        			<tr id="selectCr2" class="chooselist" style="display:none;">
                         				<th>
				                          <div class="col-sm-5 no-padder m-r" >
				                           <select a="aaa" class="fchosen-select" name="pcid" id="editparentCategoryList" onchange="getChildrenByParentCategoryId(this)">
				                           	<option value="-1">请选择</option>
				                              <s:iterator value="categoryList" id="favorite" status="u">
				                              	<option value="<s:property value='id' />"><s:property value="name" /></option>
				                              </s:iterator> 
				                           </select>		
				                        		
				                          </div>
				                          <div class="col-sm-5 no-padder">
				                           <select c="ccc" class="fchosen-select childFavoriteList" name="cid">
				                        	</select>
				                          </div>
				                         </th>
				                         <th>
				                         	<a class="iconbtn" onclick="deleteFavorite(this)" href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
				                         </th>
                        			</tr>
                       			</thead>
                      		</table>
                      	</div>
                      </div>
		              
		              <div class="checkbox m-t-lg">
		              	<input type="button" onclick="updateUserGroup()" value="更新群组" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs"/>
		              </div>
		          	</div>
		          	  
	          </div> 
	                
	        </div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>  

  
</body>
</html>