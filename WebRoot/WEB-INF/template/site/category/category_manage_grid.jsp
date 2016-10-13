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
	$("#childrenFrame").load(function(){
		var mainheight = $(this).contents().find("body").height()+30;
		$(this).height("810px");
	});
	
	/******* 添加一级分类 *******/
	$('#addCategoryButton').click(function(){
		/* if ($('#tagName').val() == '') {
			alert("请输入标签名！");
			return ;
		}
		if ($('#tagAlias').val() == '') {
			alert("请输入标签别名！");
			return ;
		}
		if ($("input[name='tag.categoryId']:checked").val() <= 0) {
			alert("请选择标签分类！");
			return ;
		} */
		$('#addParentCategoryForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addParentCategoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加分类成功！");
				location.href = "category_manage.action";
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addParentCategoryForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}    	
	});
	/******* 添加一级分类 *******/
	
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
});
	
function showChildren(parentId) {
	$("#childrenFrame").attr("src","category_getChildren.action?parentId=" + parentId);
}

function deleteCategory(categoryId) {
	if(confirm("确认删除吗？")) {
		location.href = "category_delete.action?showType=<s:property value="showType"/>&category.id=" + categoryId;
	}
}

// 设置修改弹出层
function edit(id, name, alias,tagName) {
	$('#categoryId').val(id);
	$('#categoryName').val(name);
	$('#categoryAlias').val(alias);
	$('#categoryTagName').val(tagName);
}

//批量操作
function batchOperate() {
	if (typeof($("input[name='batchOperator']:checked").val()) == "undefined") {
		alert("请选择操作类型！");
		return ;
	}
	$('#batchOperateForm').submit();
}
</script>
</head>
<body class="" >
<%@include file="../head.jsp" %>
        <!-- content -->
        <section id="content">
          <section class="vbox">
            <section class="scrollable padder">
              <div class="m-b-md">
              <div class="row">
                <div class="col-sm-6">
                <h3 class="m-b-none">分类管理</h3>
                <small>您可以添加、编辑、删除一级和二级分类</small>
              </div>
              </div>
              </div>

              <section class="panel panel-default">
                <header class="panel-heading">
                  一级分类
                <button href="#modal-addcat" class="btn btn-s-md btn-success btn-preset" style="margin: 5px 5px 5px 15px;" data-toggle="modal">
                <i class="fa fa-plus text"></i>
                <span class="text">添加新的一级分类</span>
                </button>
                </header>
                <div class="row wrapper b-b">
                <div class="col-sm-3">
                <div class="btn-group">
                <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                   <span class="dropdown-label">批量操作</span> 
                   <span class="caret"></span>
                   </button>
                   <ul class="dropdown-menu dropdown-select">
                   <li class=""><a href="#"><input type="radio" name="d-s-r">删除</a></li>
                   </ul>
                   </div>
                    <button class="btn btn-sm btn-default">应用</button>                
                  </div>
                  
                  <div class="col-sm-6 text-center m-b-xs">
                    <div class="btn-group" data-toggle="buttons">
                      <label class="btn btn-sm btn-default <s:if test="showType == 1">active</s:if>" onclick='location="category_manage.action?menuUrl=category_manage&showType=1"' data-toggle="tooltip" data-placement="top" title="" data-original-title="网格显示">
			            <input type="radio" name="options"><i class="i i-grid2"></i>
			          </label>
			          <label class="btn btn-sm btn-default <s:if test="showType == 0">active</s:if>" onclick='location="category_manage.action?menuUrl=category_manage&showType=0"' data-toggle="tooltip" data-placement="top" title="" data-original-title="列表显示">
			            <input type="radio" name="options"><i class="fa fa-list-ul"></i>
			          </label>
                    </div>
                    </div>
                  
                  <div class="col-sm-3 pull-right-lg">
                    <div class="input-group">
                      <input type="text" class="input-sm form-control" placeholder="搜索标题">
                      <span class="input-group-btn">
                      <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                      </span>
                    </div>
                  </div>
                  
                </div>
                
                <div class="panel-body ">
				<s:iterator value="gridCategroyMap" id="cate">
                <section class="panel panel-default">
						<header class="panel-heading text-center">
							<i class="fa fa-tag m-r-xs"></i><s:property value="#cate.key"/>
						</header>
						<div id="container" class="panel-body m-t-sm no-padder">
							<s:iterator value="#cate.value" id="pcate">
							<div class="item col-sm-6 col-md-3 cat">
								<section class="panel b-a m-b-sm">
									<div class="clearfix text-center ">
										<div class="h5 m-t m-b-xs catname">
											<a href="#"><s:property value="name"/></a>
											<h5 class="cattag"><s:property value="tagName"/></h5>
										</div>
										<div class="clear b-b"></div>
										<div class="col-md-12 m-t-sm m-b-sm">
											<s:iterator value="#pcate.children" id="ccate">
											<a class="label label-success seccat"><s:property value="#ccate.name" /></a>
											</s:iterator>
										</div>
									</div>
									<div class="clearfix panel-footer">
										<a href="javascript:void(0)" onclick="deleteCategory(<s:property value='id' />)" class="pull-right">
										<i class="i i-trashcan text-muted"></i>
										</a> 
										<a href="#" class="m-l-xs">
											<label class="i-checks m-b-none">
												<input type="checkbox" name="ids[]"><i></i>
											</label>
										</a> 
										<a href="#modal-updatecat" class="pull-right m-r" data-toggle="modal" onclick="edit('<s:property value='id' />','<s:property value='name' />','<s:property value='alias' />','<s:property value='tagName' />')">
											<i class="i i-pencil2 text-muted"></i>
										</a>
										<a href="#modal" class="pull-right m-r" data-toggle="modal" onclick="showChildren(<s:property value='id' />)">
											<i class="i i-add-to-list text-muted"></i>
										</a>
									</div>
								</section>
							</div>
							</s:iterator>
						</div>
					</section>
                 </s:iterator>
                
                 </div>
                 
				<!-- 
                <footer class="panel-footer">
                  <div class="row">
                    <div class="col-sm-4 hidden-xs">
                      <div class="btn-group">
                      <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                         <span class="dropdown-label">批量操作</span> 
                         <span class="caret"></span>
                         </button>
                         <ul class="dropdown-menu dropdown-select">
                         <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">修改权限</a></li>
                         <li class=""><a href="#"><input type="radio" name="d-s-r">删除</a></li>
                         </ul>
                         </div>
                      <button class="btn btn-sm btn-default">应用</button>                  
                    </div>
                    <div class="col-sm-4 text-center">
                      <small class="text-muted inline m-t-sm m-b-sm">共32个条目，正在显示第1-10个</small>
                    </div>
                    <div class="col-sm-4 text-right text-center-xs">                
                    </div>
                  </div>
                </footer> -->
              </section>
            </section>
          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
        
        <!-- content -->
      </section>
    </section>
  </section>
  
  <div class="modal fade" id="modal">
  <div class="modal-dialog" style="width: 800px;">
      <div class="modal-content">
  	  <iframe id="childrenFrame" width ="100%" height="100%" frameborder="0"></iframe>
  	  </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div>
  
	<form id="addParentCategoryForm" class="form-horizontal" method="post" action="category_saveParent.action">
		<div class="modal fade" id="modal-addcat" style="display: none;" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h3 class="m-t-none">添加新的一级分类</h3>
						<small>您可以在此添加新的一级分类。</small>
					</div>
					<div class="modal-body wrapper-lg">
						<div class="row">
							<div class="col-sm-12">
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">一级分类名</label>
										<div class="col-sm-9">
											<input type="text" name="category.name" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" /> 
											<div class="Validform_checktip">
												此项为必填，新分类名不能和已有的标签名重复，大小写不限，不能使用特殊符号。
											</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">一级分类别名</label>
										<div class="col-sm-9">
											<input type="text" name="category.alias" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" />
											<div class="Validform_checktip">此项为必填，请使用小写英文字母作为分类别名，特殊符号仅支持"-"和"_"。</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">分类标签</label>
                                       <div class="col-sm-9">
                                      		<input type="text" class="form-control" name="category.tagName">
                                       		<span class="help-block m-b-none">此项为必填。</span>
                                       </div>
                                  </div>
							</div>
						</div>
						<div class="line line-dashed b-b line-lg pull-in"></div>
						<div class="checkbox m-t-lg">
							<input type="hidden" name="showType" value="<s:property value="showType"/>">
							<input type="button" value="添加新的一级分类" id="addCategoryButton" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs"/>
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
		</div>
	</form>
	
	<form id="updateCategoryForm" class="form-horizontal" method="post" action="category_update.action">
		<div class="modal fade" id="modal-updatecat" style="display: none;" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h3 class="m-t-none">修改分类</h3>
						<small>您可以在此修改分类。</small>
					</div>
					<div class="modal-body wrapper-lg">
						<div class="row">
							<div class="col-sm-12">
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">分类名</label>
										<div class="col-sm-9">
											<input type="text" name="category.name" id="categoryName" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" /> 
											<div class="Validform_checktip">
												此项为必填，新分类名不能和已有的标签名重复，大小写不限，不能使用特殊符号。
											</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
									<div class="form-group">
										<label class="col-sm-2 control-label tagselectname">一级分类别名</label>
										<div class="col-sm-9">
											<input type="text" name="category.alias" id="categoryAlias" datatype="s5-16" errormsg="名字至少5个字符,最多16个字符！" class="form-control" />
											<div class="Validform_checktip">此项为必填，请使用小写英文字母作为分类别名，特殊符号仅支持"-"和"_"。</div>
										</div>
									</div>
									<div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">分类标签</label>
                                       <div class="col-sm-9">
                                      		<input type="text" class="form-control" name="category.tagName" id="categoryTagName">
                                       		<span class="help-block m-b-none">此项为必填。</span>
                                       </div>
                                  </div>
							</div>
						</div>
						<div class="line line-dashed b-b line-lg pull-in"></div>
						<div class="checkbox m-t-lg">
							<input type="hidden" id="categoryId" name="category.id" />
							<input type="hidden" name="showType" value="<s:property value="showType"/>">
							<input type="submit" value="保存" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" />
						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
		</div>
	</form>
	
</body>
</html>