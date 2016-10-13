<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app topadminfav">
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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/validform_style.css" type="text/css" />
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>
  
  <!-- wysiwyg -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/Validform_v5.3.2_min.js"></script>
  <script>
$(document).ready(function(){
	$('.profileavatar2').preimage();
	var $container = $('#container').isotope({
          getSortData: {
              posttitlename: '.posttitlename',
              postedtime: '.postedtime'
          }
    });
  
	/*
    $(".text-left-xs .dropdown-select li").click(function () {
          var sortData = $(this).data("sort-by");
          $container.isotope({ sortBy: sortData,sortAscending: false});
    });*/
  
    $("#filters button").click(function () {
          var fitlerData = $(this).data("filter");
          $container.isotope({
              filter: fitlerData
          });
    });
	
	$('.form-horizontal').Validform({
		tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
			if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				var objtip=o.obj.siblings(".Validform_checktip");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}else{
				var objtip=o.obj.find("#msgdemo");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}
		},
		ajaxPost:false
	});
	
	$('#addFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加项目成功！");
				location.href = "favorite_list.action";
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#addFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	
	$('#saveFavoriteButton').click(function() {
		/**
		if (typeof($("#uploadImgDiv>img").attr("src")) == 'undefined') {
			alert("请上传图片！");
			return false;
		}**/
		if ($("#aprofileavatar").val()==null ||$("#aprofileavatar").val()== '') {
			alert("请上传图片！");
			return false;
		}
		
		if ($('#parentFavoriteNameTip').hasClass("Validform_wrong")) {
			return false;
		}
		
		if ($('#parentFavoriteAliasTip').hasClass("Validform_wrong")) {
			return false;
		}
		
		//$('#imageFile').val($("#uploadImgDiv>img").attr("src"));
		$('#addFavoriteForm').submit();
	});
	
	$('#addChildFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加文件夹成功！");
				location.href = "favorite_list.action";
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#addChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	
	$('#saveChildFavoriteButton').click(function() {
		/**
		if (typeof($("#uploadChildImgDiv>img").attr("src")) == 'undefined') {
			alert("请上传图片！");
			return false;
		}**/
		if ($("#profilechildavatar").val()==null ||$("#profilechildavatar").val()== '') {
			alert("请上传图片！");
			return false;
		}
		
		if ($('#childFavoriteNameTip').hasClass("Validform_wrong")) {
			return false;
		}
		
		if ($('#childFavoriteAliasTip').hasClass("Validform_wrong")) {
			return false;
		}
		
		//$('#childImageFile').val($("#uploadChildImgDiv>img").attr("src"));
		$('#addChildFavoriteForm').submit();
	});
	
	$('#editParentFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("修改收藏夹成功！");
				location.href = "favorite_list.action";
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#editParentFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
					$('#editParentFavoriteButton').removeAttr('disabled');
					$('#editParentFavoriteButton').removeClass('disabled');
				}
				
			}
		}    	
	});
	
	$('#editChildFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("修改收藏夹成功！");
				location.href = "favorite_list.action";
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#editChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
					$('#editChildFavoriteButton').removeAttr('disabled');
					$('#editChildFavoriteButton').removeClass('disabled');
				}
				
			}
		}    	
	});
});

/**
 * 上传并解析按钮
 */
function uploadImage() { 
	$('#form2').submit();
}

/**
 * 刷新
*/
function listByParent(parentId) {
	location.href = "favorite_list.action?parentFavorite.id=" + parentId;
} 

function listByChild(childId) {
	location.href = "favorite_list.action?parentFavorite.id=" + $('#parentFavoriteId').val() + "&childFavorite.id=" + childId;
}

// 弹出标记父收藏夹层
function editParent(id, name, alias, img) {
	$('#editParentFavoriteName').val(name);
	$('#editParentFavoriteId').val(id);
	$('#editParentFavoriteAlias').val(alias);
	$('#editParentFavoriteImg').attr("src", "<%=UrlHelper.getHomeUrl()%>"+img);
}

function canelEditParentFavorite() {
	$('#editParentFavoriteName').val('');
	$('#editParentFavoriteId').val('');
	$('#editParentFavoriteAlias').val('');
	$('#editParentFavoriteImg').attr("src", '');
	$('#modal-edit-first-fav').find(".close").click();
	$('#canelEditParentFavoriteButton').removeAttr('disabled');
	$('#canelEditParentFavoriteButton').removeClass('disabled');
}

// 修改父收藏夹
function updateParent() {
	if ($("#editParentFavoriteImgDiv>img").attr("src") != '') {
		$('#editParentImageFile').val($("#editParentFavoriteImgDiv>img").attr("src"));
	}
	
	$('#editParentFavoriteForm').submit();
}

// 弹出标记子收藏夹层
function editChild(id, name, alias, img) {
	$('#editChildFavoriteName').val(name);
	$('#editChildFavoriteId').val(id);
	$('#editChildFavoriteAlias').val(alias);
	$('#editChildFavoriteImg').attr("src", "<%=UrlHelper.getHomeUrl()%>"+img);
}

function canelEditChildFavorite() {
	$('#editChildFavoriteName').val('');
	$('#editChildFavoriteId').val('');
	$('#editChildFavoriteAlias').val('');
	$('#editChildFavoriteImg').attr("src", '');
	$('#modal-edit-second-fav').find(".close").click();
	$('#canelEditChildFavoriteButton').removeAttr('disabled');
	$('#canelEditChildFavoriteButton').removeClass('disabled');
}

// 修改子收藏夹
function updateChild() {
	if ($("#editChildFavoriteImgDiv>img").attr("src") != '') {
		$('#editChildImageFile').val($("#editChildFavoriteImgDiv>img").attr("src"));
	}
	
	$('#editChildFavoriteForm').submit();
}

// 添加标签
function addTag() {
	if ($('#editor').html() == '') {
		alert("请填写内容！");
		return ;
	}
	if (typeof($("input[name='articleIds']:checked").val()) == 'undefined') {
		alert("请选择文章！");
		return ;
	}
	$('#tagContent').val($('#editor').html());
	
	$('#tagType').val($("input[name='annotate.type']:checked").val());
	$('#addTagForm').submit();
}

function resetTag() {
	$('#editor').html('');
	$('#resetTagButton').removeAttr('disabled');
	$('#resetTagButton').removeClass('disabled');
}

function deleteFavorite(favoriteId) {
	$('#favoriteId').val(favoriteId);
	$('#deleteForm').attr('action', 'favorite_delete.action');
}

function confirmDelete() {
	if (confirm("一旦删除将不可恢复数据，您确定要这么做吗？")) {
		$('#deleteForm').submit();
	}
}

function deleteArticle(articleId) {
	$('#articleId').val(articleId);
	$('#deleteForm').attr('action', 'favorite_deleteArticle.action');
}

// 取消父收藏夹排序
function canelOrderParent() {
	$('#modal-first-fav-sort').find(".close").click();
	$('#orderParentFavoriteCanelButton').removeAttr('disabled');
	$('#orderParentFavoriteCanelButton').removeClass('disabled');
}

// 取消子收藏夹排序
function canelOrderChild() {
	$('#modal-second-fav-sort').find(".close").click();
	$('#orderChildFavoriteCanelButton').removeAttr('disabled');
	$('#orderChildFavoriteCanelButton').removeClass('disabled');
}

// 取消文章排序
function canelOrderArticle() {
	$('#modal-second-fav-sort-diyiqi').find(".close").click();
	$('#orderArticleButton').removeAttr('disabled');
	$('#orderArticleButton').removeClass('disabled');
}

// 取消删除收藏夹
function canelDelete() {
	$('#modal-delete').find(".close").click();
	$('#deleteCanelButton').removeAttr('disabled');
	$('#deleteCanelButton').removeClass('disabled');
}

// 完成/取消完成
function completeFavorite(farivoteId, completed) {
	$.post("favorite_complete.action?favorite.id=" + farivoteId + "&completed=" + completed, 
	      function(data){
	     	if(data.errorCode==0){
	     		alert("操作成功！");
	     		location.reload();
	     	} else {
	     		alert(data.errorMessage);
	     	}
	     },'json');
}
</script>
</head>
<body class="" >
  <%@include file="../head.jsp" %>
        <section id="content">
          <section class="hbox stretch">
          <aside class="aside-sm bg-light dker b-r" id="subNav">
            <div class="wrapper b-b header">
            <button href="#modal-add-first-fav" class="btn btn-success btn-preset notopm" data-toggle="modal"><span class="text"> 新增项目</span></button>
            <button type="button" class="btn btn-sm btn-success pull-right m-l-xs notopm" title="排序" href="#modal-first-fav-sort" data-toggle="modal"><i class="fa fa-sort"></i></button>
            
            </div>
            <ul class="nav">
            <s:iterator value="favoriteList" id="favorite" status="u">
           		<li 
           			<s:if test="id == parentFavorite.id">
           				class="b-b active"
           			</s:if>
           			<s:else>
           				class="b-b "
           			</s:else>
           		>
           			<a href="javascript:void(0)" onclick="listByParent(<s:property value='id' />)"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><span class="thumb-sm avatar pull-left"><img src="<s:property value="img" />" /></span><s:property value="name" /></a>
           		</li>
           	</s:iterator>
            </ul>
          </aside>

              <section class="panel-default favsec">
              
                            <header class="panel-heading col-md-12">
                              <h4 class="text-black col-md-6 m-t-xs m-b-xs no-padder"><s:property value='parentFavorite.name' /></h4>
                              <button type="button" onclick="deleteFavorite('<s:property value='parentFavorite.id'/>')" href="#modal-delete" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="删除"><i class="fa fa-trash-o"></i></button>
                              <button type="button" href="#modal-second-fav-sort" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="排序"><i class="fa fa-sort"></i></button>
                              <button type="button" onclick="editParent(<s:property value='parentFavorite.id'/>, '<s:property value='parentFavorite.name'/>', '<s:property value='parentFavorite.alias'/>', '<s:property value='parentFavorite.img'/>')" href="#modal-edit-first-fav" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="编辑"><i class="fa fa-edit"></i></button>
                              <s:if test="parentFavorite.completed == true">
					          	<input type="button" value="取消完成" onclick="completeFavorite(<s:property value='parentFavorite.id' />, 0)"/>
					          </s:if>
					          <s:else>
					          	<input type="button" value="完成" onclick="completeFavorite(<s:property value='parentFavorite.id' />, 1)"/>
					          </s:else>
                            </header>
               
               <section class="col-md-9 favsec no-padder" > 
                              <section class="hbox stretch" >
                               <aside class="padder p-r-none p-b-lg">              
               
                                    <section class="vbox">
                                    <section class="scrollable">
                                     <div class="row wrapper p-r-lg clearfix">
<div class="col-sm-12 text-left text-left-xs no-padder"> 
<div class="col-sm-9 no-padder"><h5 class="m-b-xs text-black"><s:property value='childFavorite.name' /></h5></div>
<div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共<s:property value="articleList.size()"/>篇文章</small></div>
</div> 
<div id="filters" class="col-sm-6 button-group no-padder">
    <!-- <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter="*">全部文章</button>
    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".hulianwang">互联网</button>
    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".xiaofeidianzi">消费电子</button> -->
</div>                                   
<div class="col-sm-6 text-right text-left-xs no-padder">
<button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="添加标签" href="#modal-add-tags" data-toggle="modal"><i class="fa fa-tags"></i></button>
<button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="排序" href="#modal-second-fav-sort-diyiqi" data-toggle="modal"><i class="fa fa-sort"></i></button>
<button type="button" onclick="editChild(<s:property value='childFavorite.id'/>, '<s:property value='childFavorite.name'/>', '<s:property value='childFavorite.alias'/>', '<s:property value='childFavorite.img'/>')" class="btn btn-sm btn-default pull-right m-l-xs" title="编辑" href="#modal-edit-second-fav" data-toggle="modal"><i class="fa fa-edit"></i></button>
<button type="button" onclick="deleteFavorite(<s:property value='childFavorite.id'/>)" href="#modal-delete" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="删除"><i class="fa fa-trash-o"></i></button>
    <div class="btn-group">
        <button data-toggle="dropdown" class="btn btn-sm  btn-default dropdown-toggle">
            <span class="dropdown-label">按发布时间排序</span>
            <span class="caret"></span>
        </button>
        <ul class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
            <li class="sort active" data-sort-by="postedtime">
                <a href="#"><input type="radio" name="d-s-r" checked="">按发布时间排序</a>
            </li>
            <li class="sort" data-sort-by="posttitlename"><a href="#"><input type="radio" name="d-s-r">按文章名排序</a>
            </li>
        </ul>
    </div>
</div>

                                     <div id="container" class="m-b block-fl m-t-sm">
                                     <form id="addTagForm" method="post" action="favorite_addTag.action" >
                                     
                                     <!-- 循环部分 -->
                                     <s:iterator value="articleList" id="article" status="u">
                                     <div class="item col-sm-6 col-md-4 post hulianwang">
                                     <section class="panel b-a">
                                         <div class="clearfix text-center m-b-sm title-pic">
                                              <div class="picframe">
                                              	
                                                  <a href="article_show.action?article.id=<s:property value='id' />" target="_blank">
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
                                                  <a href="article_show.action?article.id=<s:property value='id' />" target="_blank">查看详情</a>
                                                  </div>
                                                  </div>
                                              </div>
                                                 <div class="h5 m-t m-b-xs posttitlename"><a href="#"><s:property value="title" /></a></div>
                                                 <div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
                                                 <div class="label bg-success m-b-xs">分类：<span><s:property value="parentCategory.name" /></span></div>
                                                 <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span><s:property value="childFavorite.name" /></span></div>
                                               <div class="text-left abs-text"><s:property value="summary" escape="false"/>.</div> 
                                         
                                         </div>
                                         <div class="clearfix panel-footer">
                                             <a href="#modal-delete" onclick="deleteArticle(<s:property value='id' />)" data-toggle="modal" class="pull-right"><i class="i i-trashcan text-muted"></i></a>
                                             <a href="#" class="m-l-xs"><label class="i-checks m-b-none"><input type="checkbox" name="articleIds" value="<s:property value='id' />"><i></i></label></a>
                                             <a href="#" class="pull-right m-r"><i class="i i-pencil2 text-muted"></i></a>
                                         </div>
                                     </section>
                                     </div>
                                     </s:iterator>
                                     <!-- 循环部分 -->
                                     <input type="hidden" name="annotate.content" id="tagContent" />
				                     <input type="hidden" name="annotate.type" id="tagType" />
                                     </form>
                                     </div>
                                     </div>
                                     </section>
                                    </section>
               
                                                                    
                               </aside>
                              </section>
                              </section>
               
               <section class="col-md-3 favsec no-padder">        
               <section class="hbox stretch" >             
               <aside class="aside bg-success lt" id="fav001">
               <section class="vbox animated fadeInRight">
                 <header class="dker header">
                   <button href="#modal-add-second-fav" class="btn btn-success bg-empty btn-sm" data-toggle="modal"><i class="fa fa-plus"></i> 子文件夹</button>
                   
                 </header>
                 <section class="scrollable">
                   <div class="list-group auto list-group-alt no-radius no-borders">
                     <s:iterator value="childFavoriteList" id="favorite" status="u">
                  		<a 
		           			<s:if test="id == childFavorite.id">
		           				class="list-group-item active"
		           			</s:if>
		           			<s:else>
		           				class="list-group-item"
		           			</s:else>
                  			class="list-group-item" href="javascript:void(0)" onclick="listByChild(<s:property value='id' />)">
	                         <i class="fa fa-fw fa-circle-o text-muted text-xs"></i>
	                         <span class="thumb-sm avatar pull-left"><img src='<s:property value="img" />' /></span><span class="subfavbtn"><s:property value="name" /></span>
	                    </a>
                   </s:iterator>
                   </div>
                 </section>
               </section>
             </aside>
               </section>
               </section>

              </section>

          </section>
          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
        </section>
      </section>
    </section>
  </section>
  
  <form id="deleteForm" method="post">
  <div class="modal fade" id="modal-delete" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header bg-warning">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none m-b-none">注意</h3>

          </div>
            <div class="modal-body wrapper-lg bg-warning lter">
              <div class="row text-center">
                <div class="col-sm-12">
                <h4 class="m-t-none">您确定要删除您选择的项目吗？</h4>
                </div>
                
                <button type="button" onclick="confirmDelete()" class="btn btn-md btn-success text-uc" ><strong>确定</strong></button>
                <button id="deleteCanelButton" onclick="canelDelete()" class="btn btn-md btn-danger text-uc m-l-sm" data-loading-text="取消中..."><strong>取消</strong></button>
                <input type="hidden" name="favorite.id" id="favoriteId" value="" />
                <input type="hidden" name="articleFavorite.parentFavoriteId" id="parentFavoriteId" value="<s:property value='parentFavorite.id' />" />
                <input type="hidden" name="articleFavorite.childFavoriteId" id="childFavoriteId" value="<s:property value='childFavorite.id' />" />
                <input type="hidden" name="articleFavorite.articleId" id="articleId" />
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
  <form id="orderParentFavorite" method="post" action="favorite_orderFavorite.action" >
  <div class="modal fade" id="modal-first-fav-sort" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="width: 700px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">排序项目</h3>
            <small>您可以在此自行排序项目。</small>
          </div>
            <div class="modal-body wrapper-md">
              <div class="row">
                <div class="col-sm-12">
                <section class="scrollable wrapper" style="max-height: 450px;">
                  <div class="">
                    <ul class="list-group gutter list-group-lg list-group-sp sortable">
                    <s:iterator value="favoriteList" id="favorite" status="u">
                    	<li class="list-group-item bg-info">
	                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
	                        <div class="clear text-white">
	                          <s:property value="name" />
	                          <input type="hidden" name="orderFavoriteId" value="<s:property value='id' />" />
	                        </div>
	                    </li>
                    </s:iterator>
                    </ul>
                    <input type="hidden" name="childId" value="0" />
                  </div>
                </section>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
  
  <form id="orderChildFavorite" method="post" action="favorite_orderFavorite.action" >
  <div class="modal fade" id="modal-second-fav-sort" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="width: 700px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">排序文件夹</h3>
            <small>您可以在此自行排序文件夹。</small>
          </div>
            <div class="modal-body wrapper-md">
              <div class="row">
                <div class="col-sm-12">
                <section class="scrollable wrapper" style="max-height: 450px;">
                  <div class="">
                    <ul class="list-group gutter list-group-lg list-group-sp sortable">
                    <s:iterator value="childFavoriteList" id="favorite" status="u">
                    	<li class="list-group-item bg-info">
	                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
	                        <div class="clear text-white">
	                          <s:property value="name" />
	                          <input type="hidden" name="orderFavoriteId" value="<s:property value='id' />" />
	                        </div>
	                    </li>
                    </s:iterator>
                    </ul>
                  </div>
                </section>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                   
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
  
  <form id="orderArticle" method="post" action="favorite_orderArticle.action" >
  <div class="modal fade" id="modal-second-fav-sort-diyiqi" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="width: 700px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">排序文件夹-<s:property value='childFavorivate.name' /></h3>
            <small>您可以在此自行排序该子文件夹里的文章。</small>
          </div>
            <div class="modal-body wrapper-md">
              <div class="row">
                <div class="col-sm-12">
                <section class="scrollable wrapper" style="max-height: 450px;">
                  <div class="">
                    <ul class="list-group gutter list-group-lg list-group-sp sortable">
                    <s:iterator value="articleList" id="article" status="u">
                    	 <li class="list-group-item bg-info">
	                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
	                        <div class="clear text-white">
	                          <s:property value="title"/> <span class="label bg-success m-l-lg"><s:property value="parentCategory.name" /></span><span class="text-danger m-l-lg pull-right"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></span>
	                          <input type="hidden" name="articleIds" value="<s:property value='id' />" />
	                        </div>
	                      </li>
                    </s:iterator>
                    </ul>
                    <input type="hidden" name="childId" value="<s:property value='childFavorivate.id' />" />
                  </div>
                </section>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
  <div class="modal fade" id="modal-add-tags" style="display: none;" aria-hidden="true">
          <div class="modal-dialog" style="width: 700px;">
            <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3 class="m-t-none">添加热门标签或趋势标签</h3>
              <small>您可以在此为选中的文章添加热门标签或趋势标签。</small>
            </div>
              <div class="modal-body wrapper-lg">
                <div class="row">
                  <div class="col-sm-12">
                  <form class="form-horizontal" method="post" >
                                         <div class="form-group">
                                         <div class="radio col-sm-6 text-center p-b-lg">
                                           <label class="h4">
                                             <input type="radio" name="annotate.type" id="optionsRadios1" value="2" checked="checked">
                                             添加热门标签
                                           </label>
                                         </div>
                                         <div class="radio col-sm-6 text-center p-b-lg">
                                           <label class="h4">
                                             <input type="radio" name="annotate.type" id="optionsRadios2" value="3">
                                             添加趋势标签
                                           </label>
                                         </div>
                                       <div class="line line-dashed b-b line-lg pull-in"></div>
  
                                           <div class="btn-toolbar m-b-sm m-t-sm btn-editor" data-role="editor-toolbar" data-target="#editor">
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="Font"><i class="fa fa-font"></i><b class="caret"></b></a>
                                                 <ul class="dropdown-menu">
                                                 </ul>
                                             </div>
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="字体大小"><i class="fa fa-text-height"></i>&nbsp;<b class="caret"></b></a>
                                                 <ul class="dropdown-menu">
                                                 <li><a data-edit="fontSize 5"><font size="5">巨大</font></a></li>
                                                 <li><a data-edit="fontSize 3"><font size="3">正常</font></a></li>
                                                 <li><a data-edit="fontSize 1"><font size="1">小</font></a></li>
                                                 </ul>
                                             </div>
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm" data-edit="bold" title="加粗 (Ctrl/Cmd+B)"><i class="fa fa-bold"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="italic" title="斜体 (Ctrl/Cmd+I)"><i class="fa fa-italic"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="strikethrough" title="中划线"><i class="fa fa-strikethrough"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="underline" title="Underline (Ctrl/Cmd+U)"><i class="fa fa-underline"></i></a>
                                             </div>
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm" data-edit="insertunorderedlist" title="点列"><i class="fa fa-list-ul"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="insertorderedlist" title="数字列"><i class="fa fa-list-ol"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="outdent" title="减少缩进 (Shift+Tab)"><i class="fa fa-dedent"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="indent" title="缩进 (Tab)"><i class="fa fa-indent"></i></a>
                                             </div>
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm" data-edit="justifyleft" title="左对齐 (Ctrl/Cmd+L)"><i class="fa fa-align-left"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="justifycenter" title="居中 (Ctrl/Cmd+E)"><i class="fa fa-align-center"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="justifyright" title="右对齐 (Ctrl/Cmd+R)"><i class="fa fa-align-right"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="justifyfull" title="左右对齐 (Ctrl/Cmd+J)"><i class="fa fa-align-justify"></i></a>
                                             </div>
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="超链接"><i class="fa fa-link"></i></a>
                                               <div class="dropdown-menu">
                                                 <div class="input-group m-l-xs m-r-xs">
                                                   <input class="form-control input-sm" placeholder="URL" type="text" data-edit="createLink"/>
                                                   <div class="input-group-btn">
                                                     <button class="btn btn-default btn-sm" type="button">添加</button>
                                                   </div>
                                                 </div>
                                               </div>
                                               <a class="btn btn-default btn-sm" data-edit="unlink" title="移除超链接"><i class="fa fa-cut"></i></a>
                                             </div>
                                             
                                             <div class="btn-group hide">
                                               <a class="btn btn-default btn-sm" title="插入图片 (或拖拽)" id="pictureBtn"><i class="fa fa-picture-o"></i></a>
                                               <input type="file" data-role="magic-overlay" data-target="#pictureBtn" data-edit="insertImage" />
                                             </div>
                                             <div class="btn-group m-b-xs">
                                               <a class="btn btn-default btn-sm" data-edit="undo" title="撤销 (Ctrl/Cmd+Z)"><i class="fa fa-undo"></i></a>
                                               <a class="btn btn-default btn-sm" data-edit="redo" title="重做 (Ctrl/Cmd+Y)"><i class="fa fa-repeat"></i></a>
                                             </div>
                                           
                                           <div id="editor" class="form-control" style="overflow:scroll;height:100%;min-height:300px;;">
                                           </div>
                                          </div>
                                        </div>
                                            
                                                                                                      
                                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                                    <div class="checkbox m-t-lg">
                                                    
                                                    <button onclick="resetTag()" id="resetTagButton" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="重置中..."><strong>重置</strong></button>
                                                    
                                                    <button onclick="addTag()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="添加中..."><strong>添加</strong></button>
                                                       
                                                    </div>
                                                  </form>
                                  </div>
                  
                </div>          
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div>
  <div class="modal fade" id="modal-add-first-fav" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加项目</h3>
          <small>您可以在此添加项目。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              <form id="addFavoriteForm" class="form-horizontal" method="post" action="favorite_save.action" enctype="multipart/form-data">
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">项目名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" name="favorite.name" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" />
                                     <div class="Validform_checktip" id="parentFavoriteNameTip">此项为必填，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">项目别名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" name="favorite.alias" datatype="s2-16" errormsg="别名至少2个字符,最多16个字符！" class="form-control" />
                                     <div class="Validform_checktip" id="parentFavoriteAliasTip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
                                     </div>
                                    </div>
                                        
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-3 control-label">上传缩略图</label>
                                                  <div class="col-sm-9">
													 <span class="thumb-lg avatar pull-left">
													 	<img src="/resources/common/images/placeholder-thumb.png" width="128" height="128">
									            	<input type="file" id="aprofileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar  profileavatar2" />
	                                                 </span>
                                                  </div>
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                <button id="saveFavoriteButton" type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                                                </div>
                                                
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  <div class="modal fade" id="modal-add-second-fav" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">添加文件夹</h3>
            <small>您可以在此添加子文件夹。</small>
          </div>
            <div class="modal-body wrapper-lg">
              <div class="row">
                <div class="col-sm-12">
                <form id="addChildFavoriteForm" class="form-horizontal" method="post" action="favorite_save.action">
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">文件夹名<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="hidden" id="parentFavoriteId" name="favorite.parentId" value="<s:property value='parentFavorite.id' />" />
                                       <input type="text" name="favorite.name" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" /> 
										<div class="Validform_checktip" id="childFavoriteNameTip">此项为必填，不能使用特殊符号。</div>
                                       </div>
                                       </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">文件夹别名<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="text" name="favorite.alias" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" />
											<div class="Validform_checktip" id="childFavoriteAliasTip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
                                       </div>
                                      </div>
                                          
                                                  <div class="line line-dashed b-b line-lg pull-in"></div>
                                                  <div class="form-group">
                                                    <label class="col-sm-3 control-label">上传缩略图</label>
                                                    <div class="col-sm-9">
  													 <span class="thumb-lg avatar pull-left">
  													 	<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/placeholder-thumb.png" width="128" height="128">
									            		<input type="file" id="profilechildavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar  profileavatar2" />
	                                                 </span>
                                                    </div>
                                                  </div>
                                                  
                                                  <div class="line line-dashed b-b line-lg pull-in"></div>
                                                  <div class="checkbox m-t-lg">
				
													<button type="button" id="saveChildFavoriteButton"
														class="btn btn-md btn-success pull-right text-uc m-t-n-xs"
														>
														<strong>保存</strong>
													</button>
													
                                                  </div>
                                                </form>
                                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  <div class="modal fade" id="modal-edit-first-fav" style="display: none;" aria-hidden="true">
      <form id="editParentFavoriteForm" class="form-horizontal" method="post" action="favorite_update.action">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">编辑项目</h3>
          <small>您可以在此编辑项目名字和缩略图。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">项目名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" id="editParentFavoriteName" name="favorite.name" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" /> 
									 <div class="Validform_checktip">此项为必填，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">项目别名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" id="editParentFavoriteAlias" name="favorite.alias" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" />
											<div class="Validform_checktip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
                                     </div>
                                    </div>
                                        
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-3 control-label">上传缩略图</label>
                                                  <div class="col-sm-9">
                                                  <span class="thumb-lg avatar pull-left">
									            		<img id="editParentFavoriteImg" src="<%=UrlHelper.getHomeUrl()%>resources/common/images/placeholder-thumb.png" width="128" height="128">
									            	<input type="file" id="editprofileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar  profileavatar2" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                  </span>
                                                  <input type="hidden" name="favorite.id" id="editParentFavoriteId" />
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                <button id="editParentFavoriteButton" onclick="updateParent()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                                                </div>
                                              
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    </form>
  </div>
  <div class="modal fade" id="modal-edit-second-fav" style="display: none;" aria-hidden="true">
       <form id="editChildFavoriteForm" class="form-horizontal" method="post" action="favorite_update.action">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">编辑文件夹</h3>
          <small>您可以在此编辑文件夹名字和缩略图。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">文件夹名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" id="editChildFavoriteName" name="favorite.name" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" /> 
									 <div class="Validform_checktip">此项为必填，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">文件夹别名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" id="editChildFavoriteAlias" name="favorite.alias" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" />
											<div class="Validform_checktip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
                                     </div>
                                    </div>
                                        
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-3 control-label">上传缩略图</label>
                                                  <div class="col-sm-9">
                                                  <span class="thumb-lg avatar pull-left">
									            		<img id="editChildFavoriteImg" src="<%=UrlHelper.getHomeUrl()%>resources/common/images/placeholder-thumb.png" width="128" height="128">
									            	<input type="file" id="editprofilechildavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar  profileavatar2" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                  </span>
                                                  <input type="hidden" name="favorite.id" id="editChildFavoriteId" />
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                <button id="editChildFavoriteButton" onclick="updateChild()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>保存</strong></button>
                                                </div>
                                              
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    </form>
</div>
  
</body>
</html>