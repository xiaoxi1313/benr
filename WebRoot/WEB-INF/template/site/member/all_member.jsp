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
    <meta name="description"
          content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link rel="shortcut icon" type="image/x-icon" href="<%=UrlHelper.getHomeUrl()%>favicon.ico">
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css"/>
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css"/>
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css"/>
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css"/>
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css"/>
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css"/>
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
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
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>

	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
	<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
	
<script>
$(document).ready(function(){

	$('#childFavoriteList').hide();
	//showParent();
    var $container = $('#container').isotope({
        getSortData: {
            theusername: '.theusername',
            isuseronline: '.isuseronline',
            userlasttimelogin: '.userlasttimelogin'
        }
    });


    $(".text-left-xs .dropdown-select li").click(function () {
        var sortData = $(this).data("sort-by");
        $container.isotope({ sortBy: sortData,sortAscending: false});
    });


    $("#filters button").click(function () {
        var fitlerData = $(this).data("filter");
        $container.isotope({
            filter: fitlerData
        });

    });
});

// 排序
function order(orderBy) {
	$('#orderById').val(orderBy);
	$('#oderByCondition').val('desc');
	
	$('#searchForm').submit();
}

// 弹出用户权限
function permission(userId) {
	$('#selectTr').parent().find("tr").each(function(){
		if($(this).attr('id') != 'selectTr') {
			$(this).remove();
		}
	})
	
	$('#idUserPermission').val(userId);
	$.post("user_getUserFavorite.action?user.id=" + userId,
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$('#userNameSpan').html(data.user.userName);
				$('#vipRemainsSpan').html(data.user.vipDates);
				
				$.each(data.userFavoriteList, function(i, item){
					
					var favoriteTr ="<tr><th>";
					favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.parentFavorite.name + "</label></div>"; 
					favoriteTr +="<input type='hidden' name='fid' value='" + item.childFavorite.id + "'/>"; 
					favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.childFavorite.name + "</label></div>";
					favoriteTr +="</th>";
					favoriteTr +="<th><a href=\"javascript:void(0)\" onclick=\"deleteFavorite(this)\" class=\"iconbtn\"><i class=\"fa fa-trash-o\"></i></a></th>";
					favoriteTr +="</tr>";
					$('#selectTr').before(favoriteTr);
				});
			}
			addrow();
	}, "json");
}

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
				$(o).parent().find("div").remove();
				//$(o).show();
				$(obj).parent().parent().find("select[c='ccc']").chosen();
			}
	}, "json");
}

function showParent() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'favorite_getAllParentFavorite.action',
		success : function(d) {
			$('#parentFavoriteList').empty();
			//var option = "<li class=\"active\"><a href=\"#\"><input value=\"-1\" type=\"radio\" name=\"d-s-r\" checked=\"checked\">请选择...</a></li>";
			var option = "";
			
			$.each(d.favoriteList, function(i, item){
				option += "<option value=\""+ item.id +"\">" + item.name + "</option>";
			});
			
			$('#parentFavoriteList').append(option);
			
			//$('#parentFavoriteList').chosen();
		},
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

function showChildren() {
	var parentId = $('#parentFavoriteList').val();
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'favorite_getFavoriteListByParentId.action?parentId=' + parentId,
		success : function(d) {
			//$("#childSpan").html('请选择');
			if (d.favoriteList != '') {
				$('#childFavoriteList').show();
				$('#childFavoriteList').empty();
				var option ="";
				
				$.each(d.favoriteList, function(i, item){
					option += "<option value=\""+ item.id +"\">"+ item.name + "</option>";
				});
				
				$('#childFavoriteList').append(option);		
				$('#childFavoriteList').chosen();
			} else {
				$('#childFavoriteList').hide();
			}
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 保存用户收藏夹权限
function saveFavorite() {
	var userId = $('#userId').val();
	var parentFavoriteId = $('#parentFavoriteList').val();
	var childFavoriteId = $('#childFavoriteList').val();
	if (childFavoriteId == null || childFavoriteId < 0) {
		alert("请选择子收藏夹！");
		return ;
	}
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'user_saveUserFavorite.action?userId=' + userId + '&childFavoriteId=' + childFavoriteId +'&parentFavoriteId=' + parentFavoriteId,
		success : function(d) {
			if (d.errorCode == 0) {
				alert("添加成功！");
				var favoriteTr ="<tr><th>" + $('#parentFavoriteList').find("option:selected").text() + "</th><th>" + $('#childFavoriteList').find("option:selected").text() + "<a href=\"javascript:void(0)\" onclick=\"deleteFavorite(" + $('#userId').val() + ","+$('#childFavoriteList').find("option:selected").val()+", this)\" class=\"iconbtn\"><i class=\"fa fa-trash-o\"></i></a></th></tr>";
				$('#selectTr').before(favoriteTr);
			} else {
				alert(e.errorMessage);
			}
			
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 删除收藏夹关系
function deleteFavorite(obj) {
	if($(obj).parent().parent().attr("id") != 'selectTr') {
		$(obj).parent().parent().remove();
	}
	return false;
	
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			dataType:'json',
			url : 'user_deleteUserFavorite.action?userId=' + userId + '&childFavoriteId=' + childFavoriteId,
			success : function(d) {
				if (d.errorCode == 0) {
					$(obj).parent().parent().remove();
				} else {
					alert(e.errorMessage);
				}
				
			} ,
			error : function(msg, testStatus, e) {
				alert(e);
			}
		});
	}
}

// 取消编辑
function cancleUpdate() {
	location.href = "user_allMember.action?menuUrl=user_allMember";
}

function updatePermission() {
	$('#updateForm').submit();
}


function addCategoryRow() {
	$('#selectCategoryTr').find("#parentCategoryList2_chosen").remove();
	var o = $('#selectCategoryTr').clone();
	$(o).removeAttr("id");
	$(o).removeAttr("style");
	var obj = $('<div>').append($(o)).html();
	$('#selectCategoryTr').parent().append(obj);
	
	$('#selectCategoryTr').parent().last().find("select[a='aaa']").chosen();
	$('#selectCategoryTr').find("#parentCategoryList2_chosen").remove();
	
	return false;
}
//删除收藏夹关系
function deleteCategoryRow(obj) {
	if($(obj).parent().parent().attr("id") != 'selectTr') {
		$(obj).parent().parent().remove();
	}
	return false;
}

function assignCategory(userId) {
	$('#selectCategoryTr').parent().find("tr").each(function(){
		if($(this).attr('id') != 'selectCategoryTr') {
			$(this).remove();
		}
	})
	
	$('#idUserAssignCategory').val(userId);
	$.post("user_getAssignCategory.action?userId=" + userId,
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$.each(data.categoryList, function(i, item){
					var favoriteTr ="<tr><th>";
					favoriteTr +="<div class=\"col-sm-5\"><label class=\"control-label\">" + item.name + "</label></div>"; 
					favoriteTr +="<input type='hidden' name='cid' value='" + item.id + "'/>"; 
					favoriteTr +="</th>";
					favoriteTr +="<th><a href=\"javascript:void(0)\" onclick=\"deleteCategoryRow(this)\" class=\"iconbtn\"><i class=\"fa fa-trash-o\"></i></a></th>";
					favoriteTr +="</tr>";
					$('#selectCategoryTr').before(favoriteTr);
				});
			}
			addCategoryRow();
	}, "json");
}

function updateAssignCategory() {
	$('#updateAssignCategoryForm').submit();
}
</script>

</head>
<body class="">
<%@include file="../head.jsp" %>
	<section id="content"> <section class="vbox"> <section
		class="scrollable wrapper-lg">
	<div class="m-b-md">
		<div class="row">
			<div class="col-sm-6">
				<h3 class="m-b-none">查看全部成员</h3>
				<small>您可以在这里查找成员并查看该成员的相关资料。</small>
			</div>
		</div>

	</div>
	<form id="searchForm" method="post" action="user_allMember.action?menuUrl=user_allMember">
		<input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
        <input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
	</form>
	<div class="row m-b-lg">
		<div id="filters" class="col-sm-9 button-group"
			data-filter-group="role">
			<button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter="*">全部人员</button>
			
			<s:if test="memberType == 1">
				<button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".aduser">高级用户</button>
				<button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".user">用户</button>
			</s:if>
			<s:else>
				<button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".adresearcher">高级研究员</button>
				<button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".researcher">研究员</button>
				<button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".editor">录入员</button>
				
			</s:else>
			
		</div>
		<div class="col-sm-3 text-right text-left-xs">
			<div class="btn-group">
				<button data-toggle="dropdown"
					class="btn btn-sm btn-rounded btn-default dropdown-toggle">
					<span class="dropdown-label">按最后登录时间排序</span> <span class="caret"></span>
				</button>
				<ul
					class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
					<li class="sort active" data-sort-by="userlasttimelogin">
						<a href="javascript:void(0)" onclick="order('u.lastvisitDate')"><input type="radio" name="d-s-r" checked="">按最后登录时间排序</a>
					</li>
					<li class="sort" data-sort-by="theusername">
						<a href="javascript:void(0)" onclick="order('u.userName')"><input type="radio" name="d-s-r">按姓名排序</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<style>
.sort-by-data {
	
}
</style>

	<div id="container" class="row m-b allmember">
	<s:iterator value="userList" id="user" status="u">
			<s:if test="role.id == 1"><div class="item col-sm-6 col-md-4 adresearcher" data-category="role" data-role="adresearcher"></s:if>
			<s:if test="role.id == 2"><div class="item col-sm-6 col-md-4 researcher" data-category="role" data-role="researcher"></s:if>
			<s:if test="role.id == 3"><div class="item col-sm-6 col-md-4 editor" data-category="role" data-role="editor"></s:if>
			<s:if test="role.id == 4"><div class="item col-sm-6 col-md-4 aduser" data-category="role" data-role="aduser"></s:if>
			<s:if test="role.id == 5"><div class="item col-sm-6 col-md-4 user" data-category="role" data-role="aduser"></s:if>
		
			<section class="panel b-a">
			
			<s:if test="online">
				<div class="panel-heading no-border bg-success lter online">
					<s:if test ="role.id == 3">
						<span class="pull-right badge dk m-t-sm postnumber"><s:property value="articleNum" /></span>
					</s:if>
					<div class="h4 text-lt m-t-sm m-b-sm block font-bold isuseronline">
						<i class="fa fa-check"></i>在线
					</div>
				</div>
			</s:if>
			<s:else>
				<div class="panel-heading no-border bg-light dk offline">
					<s:if test ="role.id == 3">
						<span class="pull-right badge dk m-t-sm postnumber"><s:property value="articleNum" /></span>
					</s:if>
					<div class="h4 text-lt m-t-sm m-b-sm block font-bold isuseronline">
						<i class="fa fa-times"></i>不在线
					</div>
				</div>
			</s:else>
				
			<div class="clearfix text-center m-t m-b-sm">
				<div class="inline">
					<div class="thumb-lg">
						<s:if test="icon == null || icon==''">
		            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg"  class="img-circle">
		            	</s:if>
		            	<s:else>
		            		<img src="<s:property value='icon' />" class="img-circle">
		            	</s:else>
					</div>
					<div class="h4 m-t m-b-xs theusername"><s:property value="userName" /></div>
					<small class="text-muted m-b"><s:property value="role.name" /></small>
					<div class="updatetime">
						最后登录时间：<span class="userlasttimelogin"><s:date name="#user.lastvisitDate" format="yyyy-MM-dd" /></span>
					</div>
				</div>
			</div>
			<div class="clearfix panel-footer text-center">
				<s:if test ="role.id == 3">
					<a class="btn btn-success" target="_blank" href="article_list.action?article.userId=<s:property value='id' />">
						<i class="i i-stack2"></i> 查看文章列表
					</a>
					<a href="#modal-role-2" onclick="assignCategory(<s:property value='id' />)" data-toggle="modal" class="btn btn-success pull-right">分类</a>
				</s:if>
				<s:elseif test ="role.id == 1 || role.id == 2">
					<a href="favorite_myFavoriteList.action?userId=<s:property value='id' />&showType=2" target="_blank" class="btn btn-success">
						<i class="glyphicon glyphicon-inbox"></i> 查看收藏夹
					</a>
					<a href="#modal-role-1" onclick="permission(<s:property value='id' />)" data-toggle="modal" class="btn btn-success pull-right">权限</a>
				</s:elseif>
				<s:elseif test ="role.id == 4 || role.id == 5">
					<div class="col-md-8 text-center userdays">会员有效期剩余
                        <div class="days"><span><s:property value="userGroup.vipRemains" /></span>天</div>
                    </div>
				</s:elseif>
			</div>
			</section>
		</div>
	</s:iterator>
	</div>
	<div></div>
	</section> </section> <a href="#" class="hide nav-off-screen-block"
		data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a> </section>
	</section>
	</section>
	</section>

<div class="modal fade" id="modal-role-1" style="display: none;" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none"><span id="userNameSpan"></span>的权限</h3>
         <small>您可以在此修改此用户的权限。</small>
       </div>
       
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
             					<form id="updateForm" method="post" action="user_updateUserPermission.action">
             						<input type="hidden" name="user.id" id="idUserPermission" />
                                   <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">权限</label>
                                    <div class="col-sm-9 ">
                                        <select class="chosen-select" name="roleId">
                                             <option value="1" <s:if test="user.role.id == 1">selected="selected"</s:if>>高级研究员</option>
                                             <option value="2" <s:if test="user.role.id == 2">selected="selected"</s:if>>研究员</option>
                                        </select>

                                    <div class="userdays">(会员有效期剩余<small class="days"><span id="vipRemainsSpan"><s:property value="user.vipRemains" /></span>天)</small></div>
                                    </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <!-- 
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">续期</label>
                                     <div class="col-sm-9">
                                     <div>
                                       <input type="text" name="vipAddDays" value="0" class="form-control" data-ride="spinner" data-min='-3650' data-max="3650" data-verticalbuttons="true" data-verticalupclass="fa fa-caret-up"  data-verticaldownclass="fa fa-caret-down">
                                     </div>
                                     <span class="help-block m-b-none">在此输入需要增加的有效天数。</span>
                                     </div>
                                     <input type="hidden" name="user.id" id="userId" />
                                     
                                    </div>                                   
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                     -->           
                                               <div class="form-group">
                                                <label class="col-sm-3 control-label">收藏夹权限</label>
                                                <div class="col-sm-9">
                                                <a class="btn btn-sm btn-default" href="javascript:void(0)" onclick="addrow(); return false;"><i class="fa fa-plus text"></i>添加可查看的收藏夹</a></div></div>
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                <label class="col-sm-3 control-label"></label>
                                                <div class="col-sm-9">
                                                <table style="width:100%;">
	                                                <thead>
		                                                <tr id="selectTr" class="chooselist" style="display:none;">
			                                                <th>
				                                                <div class="col-sm-5 no-padder m-r" >
				                                                 <!-- <label class="control-label">一级收藏夹</label> -->
				                                                 <select a="aaa" class="fchosen-select" name="pid" id="parentFavoriteList" onchange="getChildrenByParentFavoriteId(this)">
				                                                 	<option value="-1">请选择</option>
				                                                    <s:iterator value="favoriteList" id="favorite" status="u">
				                                                    	<option value="<s:property value='id' />"><s:property value="name" /></option>
				                                                    </s:iterator> 
		                                                		</select>		
		                                                		
				                                                </div>
				                                                <div class="col-sm-5 no-padder">
				                                                 <!-- <label class="control-label" style="width: 100px">二级收藏夹</label> -->
				                                                 <select c="ccc" class="fchosen-select" name="fid" id="childFavoriteList" >
		                                                		</select>
				                                                </div>
			                                                </th>
			                                                <th>
			                                                	<a class="iconbtn" onclick="deleteFavorite(this)" href="javascript:void(0)"><i class="fa fa-trash-o"></i></a>
			                                                </th>
		                                                </tr>
		                                                
	                                                </thead>
                                                </table>
                                                </div></div>
                                               </div>
                                               
                                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                               
                                               <div class="checkbox m-t-lg" style="height: 0px;">
                                               <br/>
                                               <br/>
                                               <br/>
                                               <button onclick="updatePermission()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>保存修改</strong></button>
                                               </div>
                                               
                             </div>
             </form>
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div> 

<!-- 分类分配 -->
<div class="modal fade" id="modal-role-2" style="display: none;"aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"aria-hidden="true">&times;</button>
				<h3 class="m-t-none">
					可管理的分类
				</h3>
				<small>您可以在此管理用户分类。</small>
			</div>
			<div class="modal-body wrapper-lg">
				<div class="row">
					<div class="col-sm-12">
						<form id="updateAssignCategoryForm" method="post" action="user_updateAssignCategory.action">
							<input type="hidden" name="userId" id="idUserAssignCategory" />
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label">可管理的分类</label>
								<div class="col-sm-9">
									<a class="btn btn-sm btn-default" href="javascript:void(0)" onclick="addCategoryRow(); return false;"> 
										<i class="fa fa-plus text"></i>添加分类
									</a>
								</div>
							</div>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label"></label>
								<div class="col-sm-9">
									<table style="width:100%;">
										<thead>
											<tr id="selectCategoryTr" class="chooselist" style="display:none;">
												<th>
													<div class="col-sm-5 no-padder m-r">
														<select a="aaa" name="cid" id="parentCategoryList2">
															<option value="-1">请选择</option>
															<s:iterator value="parentCategoryList" id="category" status="u">
																<option value="<s:property value='id' />">
																	<s:property value="name" />
																</option>
															</s:iterator>
														</select>
													</div>
												</th>
												<th>
													<a class="iconbtn" onclick="deleteCategoryRow(this)" href="javascript:void(0)">
														<i class="fa fa-trash-o"></i> 
													</a>
												</th>
											</tr>
										</thead>
									</table>
								</div>
							</div>
						</form>
					</div>
					<div class="line line-dashed b-b line-lg pull-in"></div>
					<div class="checkbox m-t-lg" style="height: 0px;">
						<br /> <br /> <br />
						<button onclick="updateAssignCategory()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs">
							<strong>保存修改</strong>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
 
</body>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
</html>




