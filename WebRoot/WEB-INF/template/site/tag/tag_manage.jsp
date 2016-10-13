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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/validform_style.css" type="text/css" />
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#listIframe").load(function(){
		var mainheight = $(this).contents().find("body").height()+30;
		$(this).height("720px");
	});
	
	/******* 添加标签 *******/
	$('#addTagButton').click(function(){
		if ($('#tagName').val() == '') {
			alert("请输入标签名！");
			return ;
		}
		if ($('#tagAlias').val() == '') {
			alert("请输入标签别名！");
			return ;
		}
		if (typeof($("input[name='tag.categoryId']:checked").val()) == "undefined") {
			alert("请选择标签分类！");
			return ;
		}
		$('#addTagForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加标签成功！");
				location.href = "tag_manage.action";
			}else{
				alert(d.errorMessage);
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
			}
		}    	
	});
	/******* 添加标签 *******/
	
	/******* 添加标签目录 *******/
	$('#addTagCategoryButton').click(function(){
		if ($('#tagCategoryName').val() == '') {
			alert("请输入标签目录名！");
			return ;
		}
		/*if ($('#tagCategoryAlias').val() == '') {
			alert("请输入标签目录别名！");
			return ;
		}*/
		$('#addTagCategoryForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addTagCategoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				$('#modal-form').attr("style", "display:none;");
				alert("添加标签目录成功！");
				location.href = "tag_manage.action";
			}else{
				alert(d.errorMessage);
				$('#addTagCategoryButton').removeAttr('disabled');
				$('#addTagCategoryButton').removeClass('disabled');
				
			}
		}    	
	});
	/******* 添加标签目录 *******/
	
	/******* 修改标签目录 *******/
	$('#updateTagCategoryButton').click(function(){
		if ($('#tagCategoryNameUpdate').val() == '') {
			alert("请输入标签目录名！");
			return ;
		}
		/*if ($('#tagCategoryAliasUpdate').val() == '') {
			alert("请输入标签目录别名！");
			return ;
		}*/
		$('#updateTagCategoryForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#updateTagCategoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				$('#modal-form').attr("style", "display:none;");
				alert("修改标签目录成功！");
				location.href = "tag_manage.action";
			}else{
				alert(d.errorMessage);
				$('#updateTagCategoryButton').removeAttr('disabled');
				$('#updateTagCategoryButton').removeClass('disabled');
				
			}
		}    	
	});
	/******* 修改标签目录 *******/
	
	/******* 删除标签目录 *******/
	$('#deleteTagCategoryButton').click(function(){
		if ($("input[name='tagCategory.id']:checked").val() <= 0) {
			alert("请选择要删除的标签目录！");
			return ;
		}
		if (confirm("确定删除吗？")) {
			$('#deleteTagCategoryForm').submit();
		}
	});
	//$('#loadingdiv').hide();
	$('#deleteTagCategoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				$('#modal-form2').hide();
				alert("删除标签目录成功！");
				location.href = "tag_manage.action";
			}else{
				alert(d.errorMessage);
				
			}
		}    	
	});
	/******* 删除标签目录 *******/
	
	$(".th-sortable").click(function(){
		if($(this).attr('orderfield') != undefined && $(this).attr('orderfield') != '') {
			$("#orderById").val($(this).attr('orderfield'));
			
			if($(this).attr('orderCond') == 'desc') {
				$("#oderByCondition").val("asc");
			} else {
				$("#oderByCondition").val("desc");
			}
			$('#searchForm').submit();
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
	
	$('#updateTagButton').click(function(){
		$.get('tag_update.action?' + $('#updateTagForm').serialize(),function(d){
			if(d.errorCode==0){
				$(".model").find('close').click();
				alert("修改标签成功！");
				location.reload();
			}else{
				alert(d.errorMessage);
			}
		},'json')
	})
	 
	
});

// 切换列表
function linkList(categoryId) {
	location.href = "tag_manage.action?tagCategoryId=" + categoryId;
}

// 删除标签
function deleteTag(tagId, tagCategoryId) {
	if(confirm("确认删除吗？")) {
		$.getJSON("tag_delete.action?tag.id=" + tagId + "&tagCategoryId=" + tagCategoryId,function(d){
			if(d.errorCode == 0) {
				window.location.reload();
			}
		})
	}
}

// 设置编辑框
function editTag(id, name, alias, categoryId, tooltip) {
	$('#tagNameUpdate').val(name);
	$('#tagIdUpdate').val(id);
	$('#tagAliasUpdate').val(alias);
	$('#tagTooltipUpdate').val(tooltip);
	
	$("select[name='tag.categoryId']").val(categoryId); 
}

function editTagCategory(id, name, alias) {
	$('#tagCategoryNameUpdate').val(name);
	$('#tagCategoryIdUpdate').val(id);
	$('#tagCategoryAliasUpdate').val(alias);
}

// 批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	}
	
	if(confirm('确定删除指定记录?')) {
		$.getJSON($('#batchOperateForm').attr('action') + "?" +$('#batchOperateForm').serialize(),function(d){
			if(d.errorCode == 0) {
				window.location.reload();
			}
		});
	}
	
	//$('#batchOperateForm').submit();
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
                <h3 class="m-b-none">标签管理</h3>
                <small>您可以添加、编辑、删除标签</small>
              </div>
              </div>
              </div>
                              
             <section class="panel panel-default">
             <header class="panel-heading">
              标签管理
             <button href="#modal-addtag" class="btn btn-s-md btn-success btn-preset" style="margin: 5px 5px 5px 15px;" data-toggle="modal">
             <i class="fa fa-plus text"></i>
             <span class="text">添加新标签</span>
             </button>
             
             </header> 
                  
              <ul class="nav nav-tabs m-b-n-xxs bg-light">
              		<li 
						<s:if test="tagCategoryId == -1">
							class="active"
						</s:if>
						<s:else>
							class=""
						</s:else>
					><a href="javascript:void(0)" data-toggle="tab" class="m-l" onclick='linkList(-1)'>全部</a></li>
              	<s:iterator value="tagCategoryList" id="tagCategory" status="u">
					<li 
						<s:if test="tagCategoryId == id">
							class="active"
						</s:if>
						<s:else>
							class=""
						</s:else>
					><a href="javascript:void(0)" data-toggle="tab" class="m-l" onclick='linkList(<s:property value="id"/>)'><s:property value="name" /></a></li>
				</s:iterator>
                <li class="">
                  <button href="#modal-form" class="btn btn-s-md btn-success btn-preset" style="margin: 5px;" data-toggle="modal">
                  <i class="fa fa-plus text"></i>
                  <span class="text">添加新标签目录</span>
                  </button>
                </li>
                <li class="">
                  <button href="#modal-form2" class="btn btn-s-md btn-danger btn-preset" style="margin: 5px;" data-toggle="modal">
                  <i class="fa fa-minus text"></i>
                  <span class="text">删除标签目录</span>
                  </button>
                </li>
                <li class="">
                	<s:iterator value="tagCategoryList" id="tagCategory" status="u">
						<s:if test="tagCategoryId == id">
							
							<button data-toggle="modal" style="margin: 5px;" onclick="editTagCategory('<s:property value='id' />', '<s:property value='name' />', '<s:property value='alias' />')" class="btn btn-s-md btn-default btn-preset" href="#modal-form-update">
			                  <i class="fa fa-edit text"></i>
			                  <span class="text">编辑标签目录</span>
			                  </button>
							
						</s:if>
				</s:iterator>
                	
                </li>
              </ul>
              
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
                                     <li class=""><a href="#"><input type="radio" name="batchOperator" value="1">删除</a></li>
                                     </ul>
                                     </div>
                                      <button class="btn btn-sm btn-default" onclick="batchOperate()">应用</button>     
		</div>
				<form id="searchForm" method="post" action="tag_manage.action">
				<div class="col-sm-3 pull-right-lg">
					<div class="input-group">
						<input type="text" name="tag.name" value="<s:property value='tag.name'/>" class="input-sm form-control" placeholder="搜索"/>
						<!--<input type="hidden" name="tagCategoryId" value="<s:property value='tagCategoryId'/>"/>-->
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="submit">
								<i class="fa fa-search"></i>
							</button> 
						</span>
					</div>
				</div>
				<input type="hidden" name="oderByCondition" id="oderByCondition" value="<s:property value='oderByCondition' />" />
				<input type="hidden" name="orderById" id="orderById" value="<s:property value='orderById' />"  />
				</form>
			</div>
			<div class="table-responsive tagtable">
				<table class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th class="row01" width="20"><label
								class="checkbox m-l m-t-none m-b-none i-checks"><input
									type="checkbox"><i></i>
							</label></th>
							<th class="row02 th-sortable" data-toggle="class" orderfield="id" orderCond="asc">ID <span
								class="th-sort"> <i class="fa fa-sort-down text"></i> <i
									class="fa fa-sort-up text-active"></i> <i class="fa fa-sort"></i>
							</span>
							</th>
							<th class="row03">标签名</th>
							<!-- <th class="row04">标签别名</th> -->
							<th class="row05">标签注释</th>
							<th class="th-sortable row06" data-toggle="class" orderfield="createTime" orderCond="asc">创建日期 <span
								class="th-sort"> <i class="fa fa-sort-down text"></i> <i
									class="fa fa-sort-up text-active"></i> <i class="fa fa-sort"></i>
							</span></th>
							<th class="row07">使用文章数</th>
							<th class="row08">标签状态</th>
							<th class="row09" style="width: 70px;">编辑</th>
						</tr>
					</thead>
					<form id="batchOperateForm" method="post" action="tag_batchDelete.action">
					<tbody>
					<s:iterator value="tagList" id="tag" status="u">
						<tr>
							<td><label class="checkbox m-n i-checks"><input type="checkbox" name="tagIds" value="<s:property value='id' />"><i></i>
						</label>
						</td>
							<td><s:property value="id"/></td>
							<td><s:property value="name"/></td>
							<!-- <td><s:property value="alias"/></td> -->
							<td><s:property value="tooltip"/></td>
							<td><s:date name="#tag.createTime" format="yyyy-MM-dd" /></td>
							<td><s:property value="articleNum"/></td>
							<td><s:property value="statusName"/></td>
							<td><div class="btn-group open">
									<a href="#modal-updatetag" data-toggle="modal" class="iconbtn" onclick="editTag(<s:property value='id' />, '<s:property value='name' />', '<s:property value='alias' />', <s:property value='categoryId' />, '<s:property value='tooltip'/>')"><i class="fa fa-pencil"></i> </a> 
									<a href="javascript:void(0)" onclick="deleteTag(<s:property value='id'/>,<s:property value='tagCategoryId' />)" class="iconbtn"><i class="fa fa-trash-o"></i> </a>
								</div>
							</td>
						</tr>
					</s:iterator>
					<input type="hidden" name="tagCategoryId" value="<s:property value='tagCategoryId' />" />
					</tbody>
					</form>
				</table>
			</div>
			<footer class="panel-footer">
				<pages:pages page="page" params="params"/>
			</footer>

		</div>
	</div>
			  
              </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
  
  <div class="modal fade" id="modal-addtag" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加标签</h3>
          <small>您可以在此添加新的标签。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                <form class="form-horizontal" id="addTagForm" method="post" action="tag_save.action">
                                       <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">标签名</label>
                                       <div class="col-sm-9">
                                       <input type="text" id="tagName" name="tag.name" class="form-control" datatype="s2-16" errormsg="标签名至少2个字符,最多16个字符！">
                                       <div class="Validform_checktip">此项为必填，新标签名不能和已有的标签名重复，大小写不限，不能使用特殊符号。</div>
                                       </div>
                                       </div>
                                     <!-- <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">标签别名</label>
                                       <div class="col-sm-9">
                                       <input type="text" id="tagAlias" name="tag.alias" class="form-control" datatype="s2-16" errormsg="标签别名至少2个字符,最多16个字符！">
                                       <div class="Validform_checktip">请使用小写英文字母作为标签别名，特殊符号仅支持"-"和"_"。</div>
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
                                                    <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                                                      <span class="dropdown-label">请选择标签分类</span> 
                                                      <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-select">
                                                        <s:iterator value="tagCategoryList" id="tagCategory" status="u">
															<li class="">
																<a href="#"><input type="radio" name="tag.categoryId" value="<s:property value='id' />"><s:property value="name" /></a>
															</li>
														</s:iterator>
                                                    </ul>
                                                    </div>                                   
                                                  </div></div></div>
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
               <div class="checkbox m-t-lg">
                  <button id="addTagButton" type="button" class="btn btn-s-md btn-success btn-preset">
						<i class="fa fa-plus text"></i> <span class="text">添加新标签</span>
					</button>
               </div>
               </form>
               
              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  <div class="modal fade" id="modal-form" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加标签目录</h3>
          <small>您可以在此添加新的标签目录。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                <form class="form-horizontal" id="addTagCategoryForm" method="post" action="tag_saveCategory.action">
                  <div class="form-group">
                    <label>标签目录名</label>
                    <input type="text" id="tagCategoryName" name="tagCategory.name" class="form-control" datatype="s2-16" errormsg="名字至少2个字符,最多16个字符！">
                    <div class="Validform_checktip">标签目录名不能和已有的重复，大小写不限，不能使用特殊符号。</div>
                  </div>
                  <div class="line line-dashed b-b line-lg pull-in"></div>
                  <div class="form-group">
                    <label>标签目录别名</label>
                    <input type="text" id="tagCategoryAlias" name="tagCategory.alias" class="form-control" datatype="s2-16" errormsg="名字至少2个字符,最多16个字符！">
                    <div class="Validform_checktip">请使用小写英文字母作为标签别名，特殊符号仅支持"-"和"_"。</div>
                  </div>
                  </form>
                  <div class="line line-dashed b-b line-lg pull-in"></div>
                  <div class="checkbox m-t-lg">
                    <button id="addTagCategoryButton" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" ><strong>添加新标签目录</strong></button>
                  </div>                
                
              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    
    <div class="modal fade update" id="modal-form-update" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">修改标签目录</h3>
          <small>您可以在此修改标签目录。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                <form class="form-horizontal" id="updateTagCategoryForm" method="post" action="tag_updateCategory.action">
                  <div class="form-group">
                    <label>标签目录名</label>
                    <input type="text" id="tagCategoryNameUpdate" name="tagCategory.name" class="form-control" datatype="s2-16" errormsg="名字至少2个字符,最多16个字符！">
                    <div class="Validform_checktip">标签目录名不能和已有的重复，大小写不限，不能使用特殊符号。</div>
                  </div>
                  <div class="line line-dashed b-b line-lg pull-in"></div>
                  <div class="form-group">
                    <label>标签目录别名</label>
                    <input type="text" id="tagCategoryAliasUpdate" name="tagCategory.alias" class="form-control" datatype="s2-16" errormsg="名字至少2个字符,最多16个字符！">
                    <div class="Validform_checktip">请使用小写英文字母作为标签别名，特殊符号仅支持"-"和"_"。</div>
                  </div>
                  <input type="hidden" name="tagCategory.id" id="tagCategoryIdUpdate" />   
                  </form>
                  <div class="line line-dashed b-b line-lg pull-in"></div>
                  <div class="checkbox m-t-lg">
                    <button id="updateTagCategoryButton" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" ><strong>修改标签目录</strong></button>
                  </div>     
              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    
    <div class="modal fade" id="modal-form2" style="display: none;" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body wrapper-lg">
					<div class="row">
						<div class="col-sm-12">
							<h3 class="m-t-none m-b">删除标签目录</h3>
							<p>您可以在此删除标签目录。</p>
							<form id="deleteTagCategoryForm" method="post" action="tag_deleteCategory.action">
								<div class="form-group">
									<label>标签目录名</label>
									<div class="btn-group m-r" style="margin-left: 15px;">
										<button data-toggle="dropdown"
											class="btn btn-sm btn-default dropdown-toggle">
											<span class="dropdown-label">请选择标签目录</span> <span class="caret"></span>
										</button>
										<ul class="dropdown-menu dropdown-select">
											<li class="active"><a href="#"><input type="radio" name="tagCategory.id" value="-1" checked="checked">请选择标签目录</a></li>
										<s:iterator value="tagCategoryList" id="tagCategory" status="u">
											<li class=""><a href="javascript:void(0)"><input type="radio" name="tagCategory.id" value="<s:property value='id'/>"><s:property value="name" /></a></li>
										</s:iterator>
										</ul>
									</div>
								</div>
								<div class="checkbox m-t-lg">
									<button type="button" id="deleteTagCategoryButton" class="btn btn-sm btn-danger pull-right text-uc m-t-n-xs">
										<strong>删除选中的标签目录</strong>
									</button>
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
  
  
  <div class="modal fade" id="modal-updatetag" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">修改标签</h3>
          <small>您可以在此修改标签。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                <form class="form-horizontal" id="updateTagForm" method="post" action="tag_update.action">
								<div class="form-group">
									<label class="col-sm-2 control-label tagselectname">标签名</label>
									<div class="col-sm-9">
										<input type="text" id="tagNameUpdate" name="tag.name"
											class="form-control" datatype="s2-16"
											errormsg="名字至少2个字符,最多16个字符！">
										<div class="Validform_checktip">此项为必填，新标签名不能和已有的标签名重复，大小写不限，不能使用特殊符号。</div>
									</div>
								</div>
								<!-- <div class="line line-dashed b-b line-lg pull-in"></div>
								<div class="form-group">
									<label class="col-sm-2 control-label tagselectname">标签别名</label>
									<div class="col-sm-9">
										<input type="text" id="tagAliasUpdate" name="tag.alias"
											class="form-control" datatype="s2-16"
											errormsg="名字至少2个字符,最多16个字符！">
										<div class="Validform_checktip">请使用小写英文字母作为标签别名，特殊符号仅支持"-"和"_"。</div>
									</div>
								</div> -->
								<div class="form-group">
									<label class="col-sm-2 control-label tagselectname">标签注释</label>
									<div class="col-sm-9">
										<input type="text" id="tagTooltipUpdate" name="tag.tooltip"
											class="form-control" datatype="s2-16"
											errormsg="注释至少2个字符,最多16个字符！">
										<div class="Validform_checktip">此项为必填，至少2个字符,最多16个字符。</div>
									</div>
								</div>
								<div class="line line-dashed b-b line-lg pull-in"></div>
								<div class="form-group">
									<label class="col-sm-2 control-label tagselectname">选择标签目录</label>
									<div class="btn-group col-sm-9">
										<select name="tag.categoryId" class="">
											<option value="-1">请选择</option>
											<s:iterator value="tagCategoryList" id="tagCategory" status="u">
												<option value="<s:property value='id' />"><s:property value="name" /></option>
											</s:iterator>
										</select>
									</div>
								</div>
							</div>
							</div>
                                                  
                                      <div class="line line-dashed b-b line-lg pull-in"></div>
               <div class="checkbox m-t-lg">
                    <button id="updateTagButton" type="button" class="btn btn-s-md btn-success btn-preset">
						<i class="fa fa-plus text"></i> <span class="text">保存</span>
					</button>
					<input type="hidden" name="tag.id" id="tagIdUpdate" />
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