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
<script type="text/javascript">
$(document).ready(function(){
	$('.profileavatar2').preimage();
	
	$(".chosen").chosen();
	$(".editgroupinfo").hide();
	
	/*$('#profileavatar').preimage();*/
	$('#editUserForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				$(".modal-dialog").find(".close").click();
				alert("保存成功！");
				location.reload();
			}else{
				alert(d.errorMessage);
				$('#editUserButton').removeAttr('disabled');
				$('#editUserButton').removeClass('disabled');
				
			}
		}    	
	});
	
	$(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			search();
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

function addUser() {
	if ($("#addprofileavatar").val()==null ||$("#addprofileavatar").val()== '') {
		alert("请上传图片！");
		return false;
	}
	//$('#titleImageFile').val($("#uploadTitleImgDiv>img").attr("src"));
	
	$(".modal-dialog").find(".close").click();
	$('#addUserForm').submit();
}

function deleteUser(id, obj) {
	if (confirm("确定删除吗？")) {
		$.post("user_delete.action?user.id=" + id,
			function (data, textStatus) {
				if (data.errorCode == 0) {
					alert("删除成功！");
					$(obj).parent().parent().parent().remove();
				}
		}, "json");
	}
}

function search() {
	$('#searchForm').submit();
}

//批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	}
	$('#batchOperateForm').submit();
}

//设置编辑层
function setEdit(id, userName, password, email, roleId, icon,realName,groupId,groupAdmin) {
	$('#userId').val(id);
	$('#userName').val(userName);
	$('#userPassword').val(password);
	$('#userPassword2').val(password);
	$('#userEmail').val(email);
	$('#realName').val(realName);
	$('#editUserIcon').attr('src', "<%=UrlHelper.getHomeUrl()%>"+icon);
	$("select[name=roleId]").val(roleId);
	$("select[name=roleId]").prop('disabled', false).trigger("chosen:updated");
	
	if(roleId == 1 || roleId == 2 || roleId == 3 || roleId == 6) {
		$(".editgroupinfo").hide();
	} else {
		$(".editgroupinfo").show();
	}
	
	$("select[name='user.groupAdmin']").val(groupAdmin);
	$("select[name='user.groupAdmin']").prop('disabled', false).trigger("chosen:updated");
	
	$("select[name='user.userGroup.id']").val(groupId);
	$("select[name='user.userGroup.id']").prop('disabled', false).trigger("chosen:updated");
	
	$(".gmember").hide();
}
function tochangegoup(obj) {
	var roleId = $(obj).val();
	if(roleId == 1 || roleId == 2 || roleId == 3 || roleId == 6) {
		$(".editgroupinfo").hide();
	} else {
		$(".editgroupinfo").show();
	}
}

function updateUser() {
	if($('#userPassword').val()!=$('#userPassword2').val()){
		alert('您两次输入的账号密码不一致！');
		$('#editUserButton').removeAttr('disabled');
		$('#editUserButton').removeClass('disabled');
		return false;
	}

	if ($("#updateUserIconImgDiv>img").attr("src") != '') {
		$('#editUserIconFile').val($("#updateUserIconImgDiv>img").attr("src"));
	}
	
	$('#editUserForm').submit();

}

/*
function checkGroupAdmin(obj) {
	var so = $(obj).parent().parent().parent().find("select[name='user.userGroup.id']");
	var t = $(so).find("option:selected").attr('aid');
	if(t> 0) {
		$(obj).val('false');
		$(obj).prop('disabled', false).trigger("chosen:updated");
	}
}
*/

function changeGroupAdmin(obj) {
	var t = $(obj).find("option:selected").attr('aid');
	var so = $(obj).parent().parent().parent().find("select[name='user.groupAdmin']");
	$(so).html("<option value='false'>否</option>");
	if(t == 0) {
		$(so).append("<option value='true'>是</option>");
	}
	$(so).prop('disabled', false).trigger("chosen:updated");
}

function checkGroupAdmin(obj) {
	if(obj.value == 'false') {
		var so = $(obj).parent().parent().parent().find("select[name='user.userGroup.id']");
		var vid = $(so).find("option:selected").attr('aid');
		
		if(vid == $('#userId').val()) {
			$.getJSON('usergroup_checkGroupAdmin.action?userGroupId='+$(so).val(),function(d){
				if(d.errorCode == 0) {
					$.each(d.userList,function(i,item){
						$('#changeGroupUserId').append('<option value="' + item.id+'">' + item.realName+'</option>');
					});
					$('#changeGroupUserId').prop('disabled', false).trigger("chosen:updated");
					$(".gmember").show();
				}
			});
		} else {
			$(".gmember").hide();
		}
	}
	return false;
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
                <h3 class="m-b-none">系统管理 &nbsp;&frasl;&nbsp; 用户管理</h3>
                <small>您可以添加、编辑、删除用户，也可以修改已有用户的权限</small>
              </div>
              </div>
              </div>

              <section class="panel panel-default">
                <header class="panel-heading">
                  用户管理
                <button href="#modal-adduser" class="btn btn-s-md btn-success btn-preset" style="margin: 5px 5px 5px 15px;" data-toggle="modal">
                <i class="fa fa-plus text"></i>
                <span class="text">添加用户</span>
                </button>
                <ul class="usergroup">
                	<li 
                		<s:if test="roleId == 0">
                			class="all"
                		</s:if>
                		<s:else>
                			class="researcher"
                		</s:else>
                	>
                		<a href="user_list.action?roleId=0" class="current">全部<span class="count">（<s:property value="totalUserNum" />）</span></a> 
                	</li>
                	<s:iterator value="roleList" id="role" status="u">
                		<li 
							<s:if test="roleId == id">
	                			class="all"
	                		</s:if>
	                		<s:else>
	                			class="researcher"
	                		</s:else>
							>
                			| <a href="user_list.action?roleId=<s:property value='id' />"><s:property value="name" /><span class="count">（<s:property value="userNum" />）</span></a>
                		</li>
                	</s:iterator>
                	
                </ul>
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
                      <input type="text" name="user.userName" value="<s:property value='user.userName' />" class="input-sm form-control" placeholder="搜索">
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
                        <th>用户名</th>
                        <th>姓名</th>
                        <th>群组</th>
                        <th>群组管理员</th>
                        <th>邮箱</th>
                        <th>权限</th>
                        <th>文章数量</th>
                        <th style="width: 70px;">编辑</th>
                      </tr>
                    </thead>
                    <tbody>
                    <form id="batchOperateForm" method="post" action="user_batchDelete.action">
                    <s:iterator value="userList" id="user" status="u">
                   		<tr>
                        	<td><label class="checkbox m-l m-t-none m-b-none i-checks"><input type="checkbox" name="userIds" value="<s:property value='id' />"><i></i></label></td>
	                        <td><s:property value="id"/></td>
	                        <td><s:property value="userName"/></td>
	                        <td><s:property value="realName"/></td>
	                        <td><s:property value="userGroup.groupName"/></td>
	                        <td>
	                        	<s:if test="groupAdmin">
	                        		是
	                        	</s:if>
	                        	<s:else>
	                        		否
	                        	</s:else>
	                        </td>
	                        <td>
	                        	<a href="#"><s:property value="email"/></a>
	                        </td>
	                        <td><s:property value="role.name" /></td>
	                        <td><s:property value="articleNum"/></td>
	                        <td>
	                        <div class="btn-group open">
	                        	<!-- 系统管理员 -->
	                            <s:if test="#session.user.role.id == 6">
	                            <a class="iconbtn" href="#modal-edituser" data-toggle="modal" onclick="setEdit(<s:property value='id' />, '<s:property value='userName' />', '<s:property value='password' />', '<s:property value='email' />', <s:property value='role.id' />, '<s:property value='icon' />','<s:property value='realName' />',0,'<s:property value='groupAdmin' />')"><i class="fa fa-pencil"></i></a>
	                            <a class="iconbtn" href="javascript:void(0)" onclick="deleteUser(<s:property value='id' />, this)"><i class="fa fa-trash-o"></i></a></div>
	                            </s:if>
	                            <s:if test="#session.user.role.id == 1">
	                            	<s:if test="#user.role.id != 1 && #user.role.id != 6">
	                            	<a class="iconbtn" href="#modal-edituser" data-toggle="modal" onclick="setEdit(<s:property value='id' />, '<s:property value='userName' />', '<s:property value='password' />', '<s:property value='email' />', <s:property value='role.id' />, '<s:property value='icon' />','<s:property value='realName' />','<s:property value='userGroup.id' />','<s:property value='groupAdmin' />')"><i class="fa fa-pencil"></i></a>
	                            	<a class="iconbtn" href="javascript:void(0)" onclick="deleteUser(<s:property value='id' />, this)"><i class="fa fa-trash-o"></i></a></div>
	                            	</s:if>
	                            </s:if>
	                            
                            </td>
                      	</tr>
                   	</s:iterator>
                   	</form>
                    </tbody>
                  </table>
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
  
  <form id="addUserForm" class="form-horizontal userForm" method="post" action="user_save.action" enctype="multipart/form-data">
  <div class="modal fade" id="modal-adduser" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加新用户</h3>
          <small>您可以在此添加新的用户。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                                     <div class="form-group">
                                     <label class="col-sm-2 control-label">用户名<span class="redstar"> *</span></label>
                                     <div class="col-sm-10">
                                     <input type="text"  name="user.userName" datatype="s4-16" errormsg="昵称至少4个字符,最多16个字符！"  class="form-control">
                                     <div class="Validform_checktip">此项为必填，请使用英文字母和数字作为用户名，用户名不能和已有用户重复，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                   <div class="form-group">
                                   <label class="col-sm-2 control-label">姓名</label>
                                     <div class="col-sm-10">
                                     <input type="text" name="user.realName" datatype="s4-16" errormsg="昵称至少4个字符,最多16个字符！"  class="form-control">
                                     <div class="Validform_checktip">请使用中文或英文字母作为姓名，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                   
                                   <div class="form-group">
                                                  <label class="col-sm-2 control-label">用户权限<span class="redstar"> *</span></label>
                                                  
                                                  <div class="col-sm-10">
                                                  <select name="roleId" class="chosen" onchange="tochangegoup(this);">
                                                  	<option value="-1">请选择用户权限</option>
                                                  	<s:iterator value="roleList" id="role" status="u">
                                                  	<s:if test="#session.user.role.id == 1 && #role.id !=1 && #role.id != 6">
                                                  		<option value="<s:property value='id'/>"><s:property value="name"/></option>
                                                  	</s:if>
                                                  	
                                                  	<s:if test="#session.user.role.id == 6">
                                                  		<option value="<s:property value='id'/>"><s:property value="name"/></option>
                                                  	</s:if> 
                                                  	
                                                  	</s:iterator>
                                                  </select>
                                                  </div>  
                                                                                    
                                                </div>
                                        
                                   <div class="line line-dashed b-b line-lg pull-in "></div>
                                   
                                   <div class="form-group editgroupinfo editgroupinfo">
                                   <label class="col-sm-2 control-label">所属群组</label>
                                     <div class="col-sm-10">
                                     <select name="user.userGroup.id" class="chosen" onchange="changeGroupAdmin(this);" >
                                     	<option value="-1">请选择</option>
                                     	<s:iterator value="groupList" status="u">
                                        	<option value="<s:property value='id'/>" aid="<s:property value="groupAdminUserId"/>"><s:property value="groupName"/></option>
                                        </s:iterator>
                                     </select>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in editgroupinfo"></div>
                                   
                                   <div class="form-group editgroupinfo">
                                   <label class="col-sm-2 control-label">群组管理员</label>
                                     <div class="col-sm-10">
                                     <select name="user.groupAdmin" class="chosen" >
                                     	<option value="false">否</option>
                                     </select>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in editgroupinfo"></div>
                                   
                                   
                                   
                                     <div class="form-group">
                                     <label class="col-sm-2 control-label">密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-10">
                                     <input type="password" name="user.password" class="form-control" datatype="*6-15" errormsg="密码范围在6~15位之间！">
                                     <div class="Validform_checktip">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                      <label class="col-sm-2 control-label">重复密码<span class="redstar"> *</span></label>
                                      <div class="col-sm-10">
                                      <input type="password" name="password2" class="form-control" datatype="*" recheck="user.password" errormsg="您两次输入的账号密码不一致！">
                                      <div class="Validform_checktip">此项为必填，请再次输入密码。</div>
                                      </div>
                                     </div>
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">电子邮箱<span class="redstar"> *</span></label>
                                        <div class="col-sm-10">
                                        <input type="text" name="user.email" class="form-control" datatype="e" errormsg="请输入正确格式的Email！">
                                                    <div class="Validform_checktip">此项为必填。</div>
                                                  </div>
                                                </div>
                                        <div class="line line-dashed b-b line-lg pull-in"></div>
              
                                                <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left avatar">
									            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/placeholder-thumb.png" width="128" height="128">
									            	<input type="file" id="addprofileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar profileavatar2" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                 </span>
                                                 </div>
                                               </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                   <input type="button" id="addUserButton" onclick="addUser()" value="添加新用户" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs"/>
                                                </div>
                                             
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
 </form>
    
<div class="modal fade" id="modal-edituser" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">编辑用户资料</h3>
          <small>您可以在此编辑用户资料。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
             <form id="editUserForm" class="form-horizontal userForm" method="post" action="user_update.action" enctype="multipart/form-data">
                                     <div class="form-group">
                                     <label class="col-sm-2 control-label">用户名<span class="redstar"> *</span></label>
                                     <div class="col-sm-10">
                                     <input type="text" id="userName" name="user.userName" datatype="s4-16" errormsg="昵称至少4个字符,最多16个字符！"  class="form-control">
                                     <div class="Validform_checktip">此项为必填，请使用中文、英文字母和数字作为用户名，用户名不能和已有用户重复，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                   <div class="form-group">
                                     <label class="col-sm-2 control-label">姓名</label>
                                     <div class="col-sm-10">
                                     <input type="text" id="realName" name="user.realName" datatype="s4-16" errormsg="昵称至少4个字符,最多16个字符！"  class="form-control">
                                     <div class="Validform_checktip">请使用中文或英文字母作为姓名，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                   
                                   <div class="form-group">
                                   	<label class="col-sm-2 control-label">用户权限<span class="redstar"> *</span></label>
                                                 <div class="col-sm-10">
                                                 <select name="roleId" class="chosen">
                                                 	<option value="-1">请选择用户权限</option>
                                                 	<s:iterator value="roleList" id="role" status="u">
                                                 	<s:if test="#session.user.role.id == 1 && #role.id !=1 && #role.id != 6">
                                                 		<option value="<s:property value='id'/>"><s:property value="name"/></option>
                                                 	</s:if>
                                                 	
                                                 	<s:if test="#session.user.role.id == 6">
                                                 		<option value="<s:property value='id'/>"><s:property value="name"/></option>
                                                 	</s:if> 
                                                 	
                                                 	</s:iterator>
                                                 </select>
                                                 </div>                            
                                    </div>
                                       
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                   
                                   <div class="form-group editgroupinfo">
                                   <label class="col-sm-2 control-label">所属群组</label>
                                     <div class="col-sm-10">
                                     <select name="user.userGroup.id" class="chosen" id="usergroupId" onchange="changeGroupAdmin(this);">
                                     	<s:iterator value="groupList" id="role" status="u">
                                        	<option value="<s:property value='id'/>" aid="<s:property value="groupAdminUserId"/>"><s:property value="groupName"/></option>
                                        </s:iterator>
                                     </select>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in editgroupinfo"></div>
                                   
                                   <div class="form-group editgroupinfo">
                                   <label class="col-sm-2 control-label">群组管理员</label>
                                     <div class="col-sm-10">
                                     <select name="user.groupAdmin" class="chosen" onchange="checkGroupAdmin(this);">
                                     	<option value="false">否</option>
                                     	<option value="true">是</option>
                                     </select>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in editgroupinfo"></div>
                                   
                                   <div class="form-group gmember">
                                   <label class="col-sm-2 control-label">新的管理员</label>
                                     <div class="col-sm-10">
                                     <select name="changeGroupUserId" class="chosen" id="changeGroupUserId">
                                     </select>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in gmember"></div>
                                   
                                     <div class="form-group">
                                     <label class="col-sm-2 control-label">密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-10">
                                     <input type="password" id="userPassword" name="user.password" class="form-control" datatype="*6-15" errormsg="密码范围在6~15位之间！">
                                     <div class="Validform_checktip">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</div>
                                     </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                      <label class="col-sm-2 control-label">重复密码<span class="redstar"> *</span></label>
                                      <div class="col-sm-10">
                                      <input type="password" id="userPassword2" name="password2" class="form-control" datatype="*" recheck="user.password" errormsg="您两次输入的账号密码不一致！">
                                      <div class="Validform_checktip">此项为必填，请再次输入密码。</div>
                                      </div>
                                     </div>
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
                                        <div class="form-group">
                                        <label class="col-sm-2 control-label">电子邮箱<span class="redstar"> *</span></label>
                                        <div class="col-sm-10">
                                        <input type="text" id="userEmail" name="user.email" class="form-control" datatype="e" errormsg="请输入正确格式的Email！">
                                                    <div class="Validform_checktip">此项为必填。</div>
                                                  </div>
                                                </div>
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
              
                                                
                                                <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left">
									            		<img id="editUserIcon" src="<%=UrlHelper.getHomeUrl()%>resources/common/images/t4.jpg" width="128" height="128">
									            	<input type="file" id="profileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar  profileavatar2" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                 </span>
                                                 </div>
                                               </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                	<input type="hidden" id="userId" name="user.id" />
                                                    <input type="button" id="editUserButton" onclick="updateUser()" value="编辑用户" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs"/>
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