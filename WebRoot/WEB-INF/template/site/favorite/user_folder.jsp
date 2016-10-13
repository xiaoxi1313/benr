<%@page import="com.newvery.Constants"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html>
<html lang="en" class="app topadminfav">
<head>  
    <meta charset="utf-8" />
    <title>本然创启™ 创新源数据库</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" />
    <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
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

    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>

    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.lazyload-any.min.js"></script>
<script type="text/javascript">
function load(img)
{
  img.fadeOut(0, function() {
    img.fadeIn(1000);
  });
}
$(document).ready(function(){
	
	//$(".lazyload").lazyload({load: load});
	
	var $container = $('#container').isotope({
	    getSortData: {
	        custom: '.custom',
	        postedtime: '.postedtime'
	    }
	});


	$(".sort .dropdown-select li").click(function () {
	    var sortData = $(this).data("sort-by");
	    $container.isotope({
	        sortBy: sortData,
	        sortAscending: false
	    });
	});


	 $("#filters button").click(function () {
	    var fitlerData = $(this).data("filter");
	    $container.isotope({
	        filter: fitlerData
	    });

	});

	 var $container2 = $('#container2').isotope({
	    getSortData: {
	        custom: '.custom',
	        postedtime: '.postedtime'
	    }
	});


	$(".sort2 .dropdown-select li").click(function () {
	    var sortData = $(this).data("sort-by");
	    $container2.isotope({
	        sortBy: sortData,
	        sortAscending: false
	    });
	});


	 $("#filters button").click(function () {
	    var fitlerData = $(this).data("filter");
	    $container.isotope({
	        filter: fitlerData
	    });

	});
	 
	 $("ul.droptrue").sortable({
         connectWith: "ul"
     });

     $("ul.dropfalse").sortable({
         connectWith: "ul",
         dropOnEmpty: false
     });

     //$("#group01, #group02, #group03").disableSelection();
	
	$('#addFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加项目成功！");
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addFavoriteForm').submit();
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
		}
		if ($("#aprofileavatar").val()==null ||$("#aprofileavatar").val()== '') {
			alert("请上传图片！");
			return false;
		}**/
		
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
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addChildFavoriteForm').submit();
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
		}
		if ($("#profilechildavatar").val()==null ||$("#profilechildavatar").val()== '') {
			alert("请上传图片！");
			return false;
		}**/
		
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
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#editParentFavoriteForm').submit();
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
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#editChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
					$('#editChildFavoriteButton').removeAttr('disabled');
					$('#editChildFavoriteButton').removeClass('disabled');
				}
				
			}
		}    	
	});
	
	/* 添加文件夹分组 */
	$('#saveFavoriteGroupForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加文件夹分组成功！");
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	
	$('#saveFavoriteGroupButton').click(function() {
		if ($('#addFavoriteGroupName').val() == '') {
			alert("请输入分组名称！");
			return false;
		}
		
		$('#saveFavoriteGroupForm').submit();
	});
	/* 添加文件夹分组 */
	
	/* 排序文件夹 */
	$('.orderfavorite').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			if(d.errorCode==0){
				alert("操作成功！");
				$('.modal').find(".close").click();
				location.reload();
			}else{
				alert(d.errorMessage);
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	
	$('#orderParentFavoriteButton').click(function() {
		$('#orderParentFavoriteForm').submit();
	});
	/* 排序文件夹 */
	
	/* 排序子文件夹 */
	$('#orderChileFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("操作成功！");
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	
	$('#orderParentFavoriteButton').click(function() {
		$('#orderChileFavoriteForm').submit();
	});
	/* 排序子文件夹 */
	
	/* 删除文件夹 */
	$('#deleteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("操作成功！");
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	/* 删除文件夹 */
	
	/* 修改分组名 */
	$('#editFavoriteGroupForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("操作成功！");
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addChildFavoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	
	$('#editFavoriteGroupButton').click(function() {
		$('#editFavoriteGroupForm').submit();
	});
	/* 修改分组名 */
	
	
	$('#exportTemplate').chosen();
	
	//导出
	$("#btnexporttemplate").click(function(){
		$(this).hide();
		var chfid = $(this).attr("cfid");
		$('#batchtip').html('批量导出操作将持续3-5分钟,请不要关闭此窗口');
		$.get($(this).attr('href') + "&exportTemplate="+$('#exportTemplate').val(),function(d){
			$('#batchtip').html('处理完成，请开始下载');
			$('#btndown').show();
		});
	})
	
});

function completeParent(id) {
	if ($('#btn-1').hasClass("btn-success active")) {
		//alert("未完成");
		completed = 0;
	} else {
		//alert("已完成");
		completed = 1;
	}
	
	$.post("favorite_complete.action?favorite.id=" + id + "&completed=" + completed, 
      function(data){
     	if(data.errorCode==0){
     		alert("操作成功！");
     		location.reload();
     	} else {
     		alert(data.errorMessage);
     	}
     },'json');
}

function completeChild(id) {
	if ($('#btn-2').hasClass("btn-success active")) {
		//alert("未完成");
		completed = 0;
	} else {
		//alert("已完成");
		completed = 1;
	}
	
	$.post("favorite_complete.action?favorite.id=" + id + "&completed=" + completed, 
      function(data){
     	if(data.errorCode==0){
     		alert("操作成功！");
     		location.reload();
     	} else {
     		alert(data.errorMessage);
     	}
     },'json');
}

//弹出标记父收藏夹层
function editParent(id, name, alias, img) {
	$('#editParentFavoriteName').val(name);
	$('#editParentFavoriteId').val(id);
	$('#editParentFavoriteAlias').val(alias);
	$('#editParentFavoriteImg').attr("src", "<%=UrlHelper.getHomeUrl()%>"+img);
}

// 弹出标记子收藏夹层
function editChild(id, name, alias, img) {
	$('#editChildFavoriteName').val(name);
	$('#editChildFavoriteId').val(id);
	$('#editChildFavoriteAlias').val(alias);
	$('#editChildFavoriteImg').attr("src", "<%=UrlHelper.getHomeUrl()%>"+img);
}

function editGroup(id, name) {
	$('#editGroupId').val(id);
	$('#editGroupName').val(name);
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

//取消父收藏夹排序
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

//取消删除收藏夹
function canelDelete() {
	$('#modal-delete').find(".close").click();
	$('#deleteCanelButton').removeAttr('disabled');
	$('#deleteCanelButton').removeClass('disabled');
}

function deleteFavorite(favoriteId) {
	$('#favoriteId').val(favoriteId);
	$('#deleteForm').attr('action', 'favorite_deleteAjax.action');
}

function deleteFavoriteGroup(groupId) {
	$('#favoriteGroupId').val(groupId);
	$('#deleteForm').attr('action', 'favorite_deleteFavoriteGroup.action');
}

function deleteArticleFavorite(articleId,groupId) {
	if (confirm("一旦删除将不可恢复数据，您确定要这么做吗？")) {
		$.getJSON('favorite_deleteArticleFavorite.action?articleFavorite.articleId=' + articleId + "&favoriteGroup.id="+groupId,function(d){
			if(d.errorCode == 0) {
				location.reload();
			} else {
				alert(d.errorMessage);
			}
		});
	}
}

function confirmDelete() {
	if (confirm("一旦删除将不可恢复数据，您确定要这么做吗？")) {
		canelDelete();
		$('#deleteForm').submit();
	}
}

/**
组合请求参数如： g=1&aid_1=文章id1;文章id2&g=2&aid_2=文章id1;文章id2
后台通过 getParameterValues("g"), 循环g,得到分组id, 然后通过aid_+ 当前的g值， 得到这个分组下的所有文章id, 然后用分号“;”分隔
*/

var sendgroupflag = false;
function fg(favoriteId) {
	if(!sendgroupflag) {
		sendgroupflag = true;
		var param = "";
		$(".fg").each(function(){
			//当前分组
			var gid = $(this).attr('gid');
			//当前分组文章id
			var aids = '';
			$(this).find(".aid").each(function(){
				var v = $(this).attr('aid');
				aids += v + ";";
			});
			param += "g="+gid+"&aid_"+gid + "="+aids+"&";
		});
		
		//alert(param);
		$.post("favorite_groupArticle.action?" + param + "&childFavorite.id=" + favoriteId, 
		      function(data){
		     	if(data.errorCode==0){
		     		alert("操作成功！");
		     		$(".model").find(".close").click();
		     		location.reload();
		     	} else {
		     		alert(data.errorMessage);
		     	}
		     	sendgroupflag = false;
	     },'json');
	}
	
}
</script>
</head>

<body class="">
    <%@include file="../head.jsp" %>

                <section id="content">
                    <section class="hbox stretch">

                        <aside class="aside-xs bg-success lt" id="subNavyear">
                            <section class="vbox animated fadeInLeft">
                                <section class="scrollable">
                                    <div class="list-group auto list-group-alt no-radius no-borders">
                                        <ul class="nav">
                                        	<%
                                          		Calendar a = Calendar.getInstance();
                                          	  	for (int i=a.get(Calendar.YEAR);i>Constants.START_YEAR-1;i--) {
                                          	  %>
                                          	  		<li class="list-group-item no-padder 
                                          	  			<%
                                          	  				String year = request.getParameter("year");
                                          	  				if (year != null && !"".equals(year)) {
                                          	  					if(i == Integer.parseInt(year)) {
                                          	  						%>
                                          	  						active
                                          	  						<%
                                          	  					}
                                          	  				}
                                          	  				
                                          	  			%>
                                          	  		"><a href="favorite_myFavoriteList.action?year=<%=i%>"><span class="subfavbtn"><%=i%></span></a>
                                            		</li>
                                          	  <%
                                          	  	}
                                          	  %>
                                        </ul>
                                    </div>
                                </section>
                            </section>
                        </aside>

                        <aside class="aside-md bg-light lt b-r" id="subNav">
                            <div class="wrapper b-b header aside-md addfolder">
                                <button href="#modal-add-first-fav" class="btn btn-success btn-preset notopm" data-toggle="modal"><i class="fa fa-plus text"></i><span class="text"> 添加</span>
                                </button>
                                <button type="button" class="btn btn-sm btn-success pull-right m-l-xs notopm" title="排序" href="#modal-first-fav-sort" data-toggle="modal"><i class="fa fa-sort"></i>
                                </button>
                            </div>
                            <section class="vbox">
                                <section class="scrollable">

                                    <div class="panel-group" id="accordion">
                                    	<s:iterator value="favoriteList" id="favorite" status="s">
                                    		<div class="panel-default b-b">
	                                            <div class="folderlist active">
	                                                <a class="accordion-toggle" href="favorite_myFavoriteList.action?parentFavorite.id=<s:property value='id' />&year=<s:property value='year' />">
	                                                    <div class="panel-heading">
	                                                    	<s:if test="#favorite.isCompleted()">
	                                                    		<i class="fa fa-check-circle-o pull-left m-t-sxs text-lg"></i>
	                                                    	</s:if>
	                                                        <s:property value="name" />
	                                                    </div>
	                                                </a>
	
	                                            </div>
	                                            <div id="collapseOne" class="panel-collapse in b-t">
	                                                <div class="panel-body no-padder text-sm subfolder">
	                                                    <ul class="nav">
	                                                    	<s:iterator value="children" id="inner" status="l">
	                                                    		<li class="b-b active">
	                                                    			<a href="favorite_myFavoriteList.action?parentFavorite.id=<s:property value='parentId' />&childFavorite.id=<s:property value='id' />&year=<s:property value='year' />">
	                                                    				<s:if test="#inner.isCompleted()">
				                                                    		<i class="fa fa-check-circle-o pull-left m-t-sxs text-lg"></i>
				                                                    	</s:if>
	                                                    				<i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><s:property value="#inner.name" />
	                                                    			</a>
	                                                        	</li>
	                                                    	</s:iterator>
	                                                    </ul>
	                                                </div>
	                                            </div>
	                                        </div>
                                    	</s:iterator>

                                    </div>
                                </section>
                            </section>
                        </aside>

                        <section class="panel-default favsec">

                            <header class="panel-heading col-md-12">
                                <h4 class="text-black col-md-6 m-t-xs m-b-xs no-padder">文件夹 <s:property value="parentFavorite.name" /></h4>
                                <button type="button" href="#modal-delete" onclick="deleteFavorite('<s:property value='parentFavorite.id'/>')" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="删除" data-original-title="删除"><i class="fa fa-trash-o"></i>
                                </button>
                                <button type="button" href="#modal-second-fav-sort" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="排序" data-original-title="排序"><i class="fa fa-sort"></i>
                                </button>
                                <button type="button" onclick="editParent(<s:property value='parentFavorite.id'/>, '<s:property value='parentFavorite.name'/>', '<s:property value='parentFavorite.alias'/>', '<s:property value='parentFavorite.img'/>')" href="#modal-edit-first-fav" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="编辑" data-original-title="编辑"><i class="fa fa-edit"></i>
                                </button>
                                
                                <button class="btn btn-sm btn-default pull-right m-l-xs <s:if test="parentFavorite.isCompleted()"> btn-success active</s:if>" id="btn-1" href="#btn-1" data-toggle="class:btn-success" onclick="completeParent('<s:property value='parentFavorite.id' />')">
                                   	<i class="fa fa-circle-o text"></i>
                                   	<span class="text">未完成</span>
                                   	<i class="fa fa-check-circle-o text-active"></i>
                                   	<span class="text-active">已完成</span>
                                </button>
                                <button href="#modal-add-second-fav" class="btn btn-default btn-sm pull-right" data-toggle="modal"><i class="fa fa-plus"></i> 添加子文件夹</button>
                            </header>

                            <section class="col-md-12 favsec no-padder">
                                <section class="hbox stretch">
                                    <aside class="padder p-r-none p-b-lg">

                                        <section class="vbox">
                                            <section class="scrollable">
                                                <div class="row wrapper p-r-lg clearfix">
                                                    <div class="col-sm-12 text-left text-left-xs no-padder">
                                                        <div class="col-sm-9 no-padder">
                                                            <h5 class="m-b-xs text-black">子文件夹-<s:property value="childFavorite.name" /></h5>
                                                        </div>
                                                        <div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共
                                                        
                                                        <s:set id="acount" name="acount" value="0"></s:set>
                                                        <s:iterator value="childFavorite.favoriteGroupList" id="favoriteGroup" status="s">
                                                        	<s:iterator value="articleList" id="inner" status="u">
                                                        		<s:set name="acount" value="%{#acount + 1}"></s:set>
                                                        	</s:iterator>
                                                        </s:iterator>
                                                        <s:property value="#acount"/> 篇资讯</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 text-right text-left-xs no-padder m-b-sm">
                                                        <button type="button" onclick="deleteFavorite(<s:property value='childFavorite.id'/>)" href="#modal-delete" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="删除"><i class="fa fa-trash-o"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="排序" href="#modal-second-fav-sort-diyiqi" data-toggle="modal"><i class="fa fa-sort"></i>
                                                        </button>
                                                        <button type="button" onclick="editChild(<s:property value='childFavorite.id'/>, '<s:property value='childFavorite.name'/>', '<s:property value='childFavorite.alias'/>', '<s:property value='childFavorite.img'/>')" class="btn btn-sm btn-default pull-right m-l-xs" title="编辑" href="#modal-edit-second-fav" data-toggle="modal"><i class="fa fa-edit"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="增加分组" href="#modal-add-group" data-toggle="modal"><i class="i i-folder-plus"></i>
                                                        </button>
                                                        
                                                        <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
						                                 <button href="#modal-export" class="btn btn-default btn-sm pull-right m-l-xs" data-toggle="modal">批量导出</button>
						                                </s:if>
                                                        
                                                        <button class="btn btn-sm btn-default pull-right m-l-xs<s:if test="childFavorite.isCompleted()"> btn-success active</s:if>" id="btn-2" href="#btn-2" data-toggle="class:btn-success" onclick="completeChild('<s:property value='childFavorite.id' />')">
                                                            <i class="fa fa-circle-o text"></i>
                                                            <span class="text">未完成</span>
                                                            <i class="fa fa-check-circle-o text-active"></i>
                                                            <span class="text-active">已完成</span>
                                                        </button>
                                                    </div>
													<s:iterator value="childFavorite.favoriteGroupList" id="favoriteGroup" status="s">
														<div class="col-md-12 no-padder ">
															<section class="panel panel-default">
	
																<header class="panel-heading text-center text-hg">
																	<div class="btn-group pull-left sort">
																		<button data-toggle="dropdown"
																			class="btn btn-sm btn-default dropdown-toggle">
																			<span class="dropdown-label">按时间排序</span> <span
																				class="caret"></span>
																		</button>
																		<ul class="dropdown-menu dropdown-select pull-none-xs">
																			<li class="sort active" data-sort-by="postedtime">
																				<a href="#"> <input type="radio" name="d-s-r"
																					checked="">按时间排序
																			</a>
																			</li>
																			<li class="sort" data-sort-by="custom"><a
																				href="#"> <input type="radio" name="d-s-r">自定义排序
																			</a></li>
	
																		</ul>
																	</div>
																	<i class="fa fa-folder-open m-r-xs"></i><s:property value="name" />
																	<s:if test="#favoriteGroup.id > 0">
																		<button type="button" href="#modal-delete" onclick="deleteFavoriteGroup(<s:property value='#favoriteGroup.id'/>)"
																			data-toggle="modal"
																			class="btn btn-sm btn-default pull-right m-l-xs"
																			title="删除" data-original-title="删除">
																			<i class="fa fa-trash-o"></i>
																		</button>
																		<button type="button" onclick="editGroup(<s:property value='#favoriteGroup.id'/>, '<s:property value='#favoriteGroup.name'/>')"
																			class="btn btn-sm btn-default pull-right m-l-xs"
																			title="设定分组名字" href="#modal-set-group-name"
																			data-toggle="modal">
																			<i class="fa fa-cog"></i>
																		</button>
																	</s:if>
																</header>
	
																<div id="container" class="m-t-sm">
																	<s:iterator value="articleList" id="inner" status="u">
																		<div class="item col-sm-6 col-md-3 post">
																			<section class="panel b-a m-b-sm">
																				<div class="clearfix text-center title-pic">
																					<div class="picframe">
																						<a href="#" class="lazyload"> <img src="<s:property value='titleImage' />" class="thumb-o">
																						</a>
																						<div class="hover-content">
																							<div class="overlay"></div>
																							<div class="link-contianer">
																								<a href="article_show.action?article.id=<s:property value='id' />" target="_blank">查看详情</a>
																							</div>
																						</div>
																					</div>
																					<div class="h5 m-t m-b-xs posttitlename">
																						<a href="article_show.action?article.id=<s:property value='id' />" target="_blank"><s:property value="title" /></a>
																					</div>
																					<div class="summary wrapper p-b-sm"><s:property value="summary" escape="false" /></div>
																					<div class="custom hidden">02</div>
																					<div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
																					<div class="label bg-success m-b-xs ">
																						一级分类：<span><s:property value="parentCategory.name" /></span>
																					</div>
																					<div class="clear m-b-xs"></div>
																					<div class="label bg-success m-b-xs text-center lt">
																						二级分类：<span><s:property value="childCategory.name" /></span>
																					</div>
																					<div class="col-md-12 tagzone b-t  m-t-sm">
																						<s:iterator value="#inner.hot3TagList">
	                                                                                	<a class="label label-info tag" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="tooltip" />"><s:property value="name" /></a>
	                                                                                	</s:iterator>
																					</div>
		
																				</div>
																				<div class="clearfix panel-footer">
																					<a onclick="deleteArticleFavorite(<s:property value='id' />,<s:property value='#favoriteGroup.id'/>)" data-toggle="modal" class="pull-right">
																						<i class="i i-trashcan text-muted"></i>
																					</a> 
																					<a href="#" class="m-l-xs"> 
																						<s:if test="#session.user.role.id == 1 ||#session.user.role.id == 2 || #session.user.role.id == 6 ">
																							<a class="pull-right m-r"
																								href="article_edit.action?article.id=<s:property value='id' />"
																								target="_blank"> <i
																								class="i i-pencil2 text-muted"></i>
																							</a>
																						</s:if>
																					</a>
																				</div>
		
																			</section>
		
																		</div>
																	</s:iterator>
																		
																</div>
	
															</section>
														</div>
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
                <input type="hidden" name="favorite.id" id="favoriteId" value="" />
                <input type="hidden" name="articleFavorite.parentFavoriteId" id="parentFavoriteId" value="<s:property value='parentFavorite.id' />" />
                <input type="hidden" name="articleFavorite.childFavoriteId" id="childFavoriteId" value="<s:property value='childFavorite.id' />" />
                <input type="hidden" name="articleFavorite.articleId" id="articleId" />
                <input type="hidden" name="favoriteGroup.id" id="favoriteGroupId" />
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
    <div class="modal fade" id="modal-delete-group" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header ">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">删除分组</h3>
                    <small>您可以在此删除分组，并将分组中的资讯转移到其他分组中。</small>
                </div>
                <div class="modal-body wrapper-lg lter">
                    <div class="row ">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">删除分组并将组内资讯转移至</label>
                            <div class="col-sm-9">
                                <div class="btn-group m-r">

                                    <select class="chosen-select">
                                        <option>未分组</option>
                                        <option>分组1</option>
                                        <option>分组2</option>
                                        <option>分组3</option>
                                    </select>
                                </div>
                                <span class="help-block ">请选择一个分组。</span>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>

                        <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong>
                        </button>

                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
     <form id="orderParentFavoriteForm" class="orderfavorite" method="post" action="favorite_orderFavoriteAjax.action" >
  <div class="modal fade" id="modal-first-fav-sort" style="display: none;" aria-hidden="true">
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
                <button type="button" id="orderParentFavoriteButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
    
	<form id="orderChildFavoriteForm" class="orderfavorite"  method="post" action="favorite_orderFavoriteAjax.action" >
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
  <div class="modal fade" id="modal-second-fav-sort-diyiqi"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog" style="width: 700px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h3 class="m-t-none">排序子文件夹-<s:property value="childFavorite.name" /></h3>
					<small>您可以在此自行排序该子文件夹里的资讯。</small>
				</div>
				<div class="modal-body wrapper-md">
					<div class="row">
						<div class="col-sm-12">
							<section class="scrollable wrapper" style="max-height: 450px;">
								<s:iterator value="childFavorite.favoriteGroupList" id="favoriteGroup" status="s">
									<div class="fg" gid="<s:property value="id" />">
										<header class="panel-heading text-center text-hg"><s:property value="name" /></header>
										<ul id="<s:property value='id' />" class="list-group gutter list-group-lg list-group-sp sortable droptrue">
											<!-- <s:if test="articleList.size() == 0">
											<li class="list-group-item bg-info"></li>
											</s:if> 美工样式中有调整-->
											<s:iterator value="articleList" id="inner" status="l">
												<li class="list-group-item bg-info aid" aid="<s:property value="id" />">
													<span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
													<div class="clear text-white">
														<s:property value="title" /> 
														<span class="label bg-success m-l-lg"><s:property value="parentCategory.name" /></span>
														<span class="text-danger m-l-lg pull-right"><s:date name="#inner.createTime" format="yyyy年MM月dd日" /></span>
													</div>
												</li>
											</s:iterator>
										</ul>
									</div>
								</s:iterator>
							</section>
							<div class="line line-dashed b-b line-lg pull-in"></div>
							<div class="checkbox m-t-lg">

								<button type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" onclick="fg('<s:property value='childFavorite.id' />');">
									<strong>保存</strong>
								</button>

							</div>
						</div>

					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<div class="modal fade" id="modal-add-first-fav" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">添加文件夹</h3>
                    <small>您可以在此添加文件夹。</small>
                </div>
                <div class="modal-body wrapper-lg">
                    <div class="row">
                        <div class="col-sm-12">
                            <form id="addFavoriteForm" class="form-horizontal" method="post" action="favorite_save.action" enctype="multipart/form-data">
                            	<input type="hidden" name="year" value="<s:property value="year" />">
                                 <div class="form-group">
                                 <label class="col-sm-3 control-label">文件夹名<span class="redstar"> *</span></label>
                                 <div class="col-sm-9">
                                 <input type="text" name="favorite.name" class="form-control" datatype="s2-16" errormsg="名称至少2个字符,最多16个字符！" />
                                 <div class="Validform_checktip" id="parentFavoriteNameTip">此项为必填，不能使用特殊符号。</div>
                                 </div>
                                 </div>
                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                 
                                 <div class="form-group">
                                 <label class="col-sm-3 control-label">文件夹别名<span class="redstar"> *</span></label>
                                 <div class="col-sm-9">
                                 <input type="text" name="favorite.alias" datatype="s2-16" errormsg="别名至少2个字符,最多16个字符！" class="form-control" />
                                 <div class="Validform_checktip" id="parentFavoriteAliasTip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
                                 </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                           
                                            <div class="checkbox m-t-lg">
                                            <button id="saveFavoriteButton" type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                                            </div>
                                          <input type="hidden" name="favorite.type" value="2" />
                                          </form>
                        </div>

                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="modal-add-second-fav" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">添加子文件夹</h3>
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
                                                  
                                                  <div class="checkbox m-t-lg">
				
													<button type="button" id="saveChildFavoriteButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs">
														<strong>保存</strong>
													</button>
													
                                                  </div>
                             		<input type="hidden" name="favorite.type" value="2" />.
                             </form>
                        </div>

                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
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
                                     
                              				<div class="checkbox m-t-lg">
                                            	<button id="editParentFavoriteButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                                            	<input type="hidden" name="favorite.id" id="editParentFavoriteId" />
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
                                                
                              			<div class="checkbox m-t-lg">
                                        	<button id="editChildFavoriteButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>保存</strong></button>
                                        	<input type="hidden" name="favorite.id" id="editChildFavoriteId" />
                                        </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    </form>
</div>
    <div class="modal fade" id="modal-add-group" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">添加群组</h3>
                    <small>您可以在此设置群组的名字。</small>
                </div>
                <div class="modal-body wrapper-lg">
                    <div class="row">
                        <div class="col-sm-12">
                            <form id="saveFavoriteGroupForm" class="form-horizontal" method="post" action="favorite_addFavoriteGroup.action">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">群组名</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" name="favoriteGroup.name" id="addFavoriteGroupName">
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="checkbox m-t-lg">

                                    <button type="button" id="saveFavoriteGroupButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>保存</strong>
                                    </button>
									
									<input type="hidden" name="favoriteGroup.favoriteId" value="<s:property value='childFavorite.id' />" />
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
    
    <div class="modal fade" id="modal-set-group-name" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">设置群组名字</h3>
                    <small>您可以在此设置群组的名字。</small>
                </div>
                <div class="modal-body wrapper-lg">
                    <div class="row">
                        <div class="col-sm-12">
                            <form class="form-horizontal" id="editFavoriteGroupForm" method="post" action="favorite_updateFavoriteGroup.action">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">群组名</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="editGroupName" name="favoriteGroup.name" class="form-control">
                                    </div>
                                </div>
                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                <div class="checkbox m-t-lg">

                                    <button type="button" id="editFavoriteGroupButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>保存</strong>
                                    </button>
									<input type="hidden" id="editGroupId" name="favoriteGroup.id" />
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
    
    
    <!-- 导出选择模板 -->
 	<div class="modal fade" id="modal-export" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 120px;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">选择导出模板</h3>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              	<div class="panel-body no-padder">
                	<div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                    	<select name="exportTemplate" id="exportTemplate">
                    		<option value="simple">打印模板</option>
                    		<option value="show">阅读模板</option>
                    	</select>
                	</div>
                </div>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                	<span id="batchtip" style="color:red;font-weight: bold;"></span>
                	<button id="btnexporttemplate" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" href="articleBatchExport.action?childFavoriteId=<s:property value="childFavorite.id" />" cfid="<s:property value="childFavorite.id" />"><strong>确定</strong></button>
                	<a id="btndown" href="articleBatchDownload.action?childFavoriteId=<s:property value="childFavorite.id" />" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" target="_blank" style="display:none;">开始下载</a>
                </div>
              </div>
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
</body>

</html>