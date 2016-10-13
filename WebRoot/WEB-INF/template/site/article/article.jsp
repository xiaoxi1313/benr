<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/util.carousel.css">
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/util.animate.css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/jquery.autocomplete.css" type="text/css" />  
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
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/jquery.utilcarousel.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.autocomplete.js"></script>  
  
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>

  
<script type="text/javascript">
$(document).ready(function(){
	//更新文章摘工
	if($('#upSummary').length > 0) {
		$('#btnSummary').click(function(){
			$.post('article_updateSummary.action?article.id=<s:property value="article.id"/>',{'article.summary':$('#upSummary').val()},function(d){
				if(d.errorCode == 0) {
					alert('操作成功');
				}
			},'json');
		});
	}
	
	$('#addtagcategoryid').chosen();
	$('#addtagcategoryid').prop('disabled', false).trigger("chosen:updated");
	var acd;				//最新的autocomplete列表数据
	 $("#ac1").autocomplete('tag_listAllTag.action', {
			minChars: 1,
			autoFill: true,
			selectOnly:true,
	        remoteDataType: 'json',
	        processData: function(data) {
				var processed = [];
				if(data.tagList != undefined) {
					for (var i=0; i < data.tagList.length; i++) {
						processed.push([$.trim(data.tagList[i].name)]);
					}
				}
				
				//重新查找时，隐藏输入
				$('#selflag').val('1');
	        	$("#modal-add-tag-new").hide();
	        	$("#acblock").css("display", "none");
				
				acd = processed;
				return processed;
	        },
	        formatItem: function(row, i, n) {
		   		return row;     
	       	},
	        onItemSelect: function(item) {
	        	$('#selflag').val('1');
	        	$("#modal-add-tag-new").hide();
	        	$("#acblock").css("display", "none");
	        },
	        onNoMatch:function() {
	        	if(acd.length > 0) {
	        		//防止用户点击页面其它位置而未选中对象
	        		var filterfalg = false;
	        		for(var i = 0; i < acd.length;i++) {
	        			if(acd[i] ==  $("#ac1").val()) {
	        				filterfalg = true;
	        				break;
	        			}
	        		}
	        	}
	        	if(filterfalg) {
	        		return ;
	        	}
	        	
	        	$('#selflag').val('0');
	        	$('#tagAlias').val('');
	        	$("#modal-add-tag-new").show();
	        	$("#acblock").css("display", "block");
	        },
	        onFinish:function() {
	        	
	        }
	 	});
	 /******* 添加标签 *******/
	$('#addTagButton').click(function(){
		if($('#selflag').val()!='1'){
			if ($('#ac1').val() == '') {
				alert("请输入标签名！");
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				return ;
			}
			if ($('#addtagcategoryid').val==undefined ||$('#addtagcategoryid').val() <= 0) {
				alert("请选择标签分类！");
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				return ;
			}
		}
		var url = 'article_addArticleTag.action?articleId='+$('#articleId').val();
		$('#addTagForm').attr('action',url);
		$('#addTagForm').submit();
	});
	$('#addTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				var tag = '<a class="label label-info tag">' + d.tag.name + '<button type="button" class="close" onclick="deleteTag('+d.tag.id+')" data-dismiss="alert">×</button></a>';
				var hidden = '<input type="hidden" id="' + d.tag.id + 'TagId" name="tagIds" value="' + d.tag.id + '" />';
				$('#tagDiv').after(tag);
				$("#result").append(hidden);
				
				$("#modal-add-tag").find(".close").click();
				$('#addTagButton').removeAttr('disabled');
				$('#addTagButton').removeClass('disabled');
				
				$('#ac1').val('');
				$('#tagAlias').val('');
				$('#acblock').hide();
				$('#addtagcategoryid').val(-1);
				$('#addtagcategoryid').prop('disabled', false).trigger("chosen:updated");
				$('#modal-add-tag-new').hide();
				
				//$('#addTagDialog').dialog('close'); 
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					//$('#addTagForm').submit();
				}else if(d.errorCode == 1) { //删除成功
					
				}else {
					alert(d.errorMessage);
				}
			}
		}    	
	});
	/******* 添加标签 *******/ 
	
	
    $('#post-carousel').utilCarousel({
        responsiveMode : 'itemWidthRange',
		itemWidthRange : [100, 130],
		itemAnimation:'util-flip-in-y',
		navigationText : ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
		navigation : true,
		rewind : false,
		lazyLoad: true
    });
    
    showFavoriteParent();
    
    /******* 文章添加到收藏夹 *******/
	$('#favoriteButton').click(function(){
		/* if ($('#articleFavoriteId').val() > 0) {
			
		} else {
			if (typeof($("input[name='articleFavorite.childFavoriteId']:checked").val()) == 'undefined') {
				alert("请选择收藏夹！");
				$('#favoriteButton').removeAttr('disabled');
				$('#favoriteButton').removeClass('disabled');
				return ;
			}
		} */
		
		$('#favoriteForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#favoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("收藏成功！");
				$("#modal-add-to-fav").find(".close").click();
				$('#favoriteButton').removeAttr('disabled');
				$('#favoriteButton').removeClass('disabled');
				
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#favoriteForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 文章添加到收藏夹 *******/
	
	
	/******* 评论文章 *******/
	$('#commentButton').click(function(){
	
		if ($('#comment').val() == '') {
			alert("请输入评论！");
			return ;
		}
		$('#commentForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#commentForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("评论成功！");
				$('#comment').val('');
				$('#commentParentId').val('0');
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#commentForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 评论文章 *******/
	
	/******* 批注 *******/
	$('#addAnnotateButton').click(function(){
	
		$('#addAnnotateForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addAnnotateForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				//alert("添加批注成功！");
				$("#modal-add-commits").find(".close").click();
				$('#addAnnotateButton').removeAttr('disabled');
				$('#addAnnotateButton').removeClass('disabled');
				location.href = "article_show.action?article.id=" + d.annotate.articleId;
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#addAnnotateForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	
	
	$('#editAnnotateButton').click(function(){
	
		$('#editAnnotateForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#editAnnotateForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				//alert("修改批注成功！");
				$("#modal-edit-commits").find(".close").click();
				$('#editAnnotateButton').removeAttr('disabled');
				$('#editAnnotateButton').removeClass('disabled');
				location.href = "article_show.action?article.id=" + d.annotate.articleId;
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#editAnnotateForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 批注 *******/
	
	/******* 热门标签 *******/
	$('#addHotTagButton').click(function(){
	
		if ($('#hotTagContent').val() == '') {
			alert("请填写标签内容！");
			return ;
		}
		$('#addHotTagForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addHotTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				//alert("添加热门标签成功！");
				$("#modal-add-hottag").find(".close").click();
				$('#addHotTagButton').removeAttr('disabled');
				$('#addHotTagButton').removeClass('disabled');
				location.href = "article_show.action?article.id=" + d.annotate.articleId;
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#addHotTagForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	
	$('#editHotTagButton').click(function(){
	
		if ($('#hotTagContentEdit').val() == '') {
			alert("请填写标签内容！");
			return ;
		}
		$('#editHotTagForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#editHotTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				//alert("修改热门标签成功！");
				$("#modal-edit-hottag").find(".close").click();
				$('#editHotTagButton').removeAttr('disabled');
				$('#editHotTagButton').removeClass('disabled');
				location.href = "article_show.action?article.id=" + d.annotate.articleId;
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#editHotTagForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 热门标签 *******/
	
	/******* 趋势标签 *******/
	$('#addTrendTagButton').click(function(){
	
		if ($('#trendTagContent').val() == '') {
			alert("请填写标签内容！");
			return ;
		}
		$('#addTrendTagForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#addTrendTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				//alert("添加趋势标签成功！");
				$("#modal-add-hottag").find(".close").click();
				$('#addTrendTagButton').removeAttr('disabled');
				$('#addTrendTagButton').removeClass('disabled');
				location.href = "article_show.action?article.id=" + d.annotate.articleId;
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#addTrendTagForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	
	$('#editTrendTagButton').click(function(){
	
		if ($('#trendTagContentEdit').val() == '') {
			alert("请填写标签内容！");
			return ;
		}
		$('#editTrendTagForm').submit();
	});
	//$('#loadingdiv').hide();
	$('#editTrendTagForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				//alert("修改趋势标签成功！");
				$("#modal-edit-hottag").find(".close").click();
				$('#editTrendTagButton').removeAttr('disabled');
				$('#editTrendTagButton').removeClass('disabled');
				location.href = "article_show.action?article.id=" + d.annotate.articleId;
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#editTrendTagForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 趋势标签 *******/
	
	
	$('#categoryForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("修改分类成功！");
				$("#modal-edit_category").find(".close").click();
				$('#categoryButton').removeAttr('disabled');
				$('#categoryButton').removeClass('disabled');
				location.reload();
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#categoryForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	
	$('#parentFavoriteList').change(function(){
		showFavoriteChildren($(this).val());
	});
	
	$('#exportTemplate').chosen();
	
	//导出
	$("#btnexporttemplate").click(function(){
		window.open($(this).attr('href') + "&exportTemplate="+$('#exportTemplate').val());
	})
}); 

function deleteUserFavorite(id,obj) {
	$.getJSON('article_deleteAritcleFavorite.action?articleFavorite.id='+id,function(d){
		if(d.errorCode == 0) {
			alert('操作成功');
			location.reload();
		}
	});
}

// 显示收藏夹一级列表
function showFavoriteParent() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getParentFavoriteList.action',
		date : 'id=' + 0,
		success : function(d) {
			$('#parentFavoriteList').empty();
			var option = "<option value='-1'>请选择</option>";
			$.each(d.favoriteList, function(i, item){
				option +="<option value='" + item.id+ "' " + (item.id==$('#parentFavoriteList').attr('val') ? "selected":"") +">" + item.name + "</option>";
			});
			$('#parentFavoriteList').append(option);
			$('#parentFavoriteList').chosen();
			
			if($('#parentFavoriteList').attr('val') != '') {
				showFavoriteChildren($('#parentFavoriteList').attr('val'));
			}
		},
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 显示收藏夹二级列表
function showFavoriteChildren(parentId) {
	if(parentId <= 0) return ;
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getFavoriteListByParentId.action?parentFavoriteId=' + parentId,
		success : function(d) {
			$('#childFavoriteList').empty();
			var option ="";
			
			if (d.favoriteList != '' && d.favoriteList.length > 0) {
				$.each(d.favoriteList, function(i, item){
					option +="<option value='" + item.id+ "'>" + item.name + "</option>";
				});
			} else {
				option +="<option value='-1'>选择收藏夹</option>";
			}
			$('#childFavoriteList').append(option);
			$('#childFavoriteList').chosen();
			$('#childFavoriteList').prop('disabled', false).trigger("chosen:updated");
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 点击回复按钮
function reply(commentId, userName) {
	//$('#comment').val('@: ');
	$('#commentParentId').val(commentId);
	$('#comment').attr('placeholder', '回复 ：' + userName);
}

// 保存按钮，文章状态变为已读已审批
function saveArticle(articleId) {
	location.href = "article_changeStatus.action?article.status=4&article.id=" + articleId;
}

// 跳过本文
function jumpArticle(articleId) {
	location.href = "article_changeStatus.action?article.id=" + articleId;
}

// 级联显示二级分类
function showCategoryChildren() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getCategoryListByParentId.action?parentCategoryId=' + $('#parentCategoryId').val(),
		success : function(d) {
			$('#childCategoryList').empty();
			$('#childCategoryList').append('<option value="-1">请选择二级分类</option>');
			if (d.categoryList != '') {
				$.each(d.categoryList, function(i, item){
					$('<option value="' + item.id +'" >' + item.name + '</option>').appendTo($('#childCategoryList'));
				});
			}
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 修改文章分类
function updateCategory() {
	/*if ($('#childCategoryList').val() == '' || $('#childCategoryList').val() < 0) {
		alert("请选择二级分类！");
		$('#categoryButton').removeAttr('disabled');
		$('#categoryButton').removeClass('disabled');
		return false;
	}*/
	
	$.getJSON("article_categoryUpdate.action?article.id=<s:property value='article.id' />&article.parentCategoryId="+$('#parentCategoryId').val()+"&article.childCategoryId="+$('#childCategoryList').val(),function(d){
		if(d.errorCode==0){
			alert("修改分类成功！");
			$("#modal-edit_category").find(".close").click();
			$('#categoryButton').removeAttr('disabled');
			$('#categoryButton').removeClass('disabled');
			location.reload();
		}else{
			alert(d.errorMessage);
		}
	});
	
	//$('#categoryForm').submit();
}

//删除标签
function deleteTag(tagId) {
	$('#' + tagId + 'TagId').remove();
	var url = "article_deleteArticleTag.action?articleId="+$('#articleId').val()+"&tag.id="+tagId;
	$('#addTagForm').attr('action',url);
	$('#addTagForm').submit();
}

// 点赞/踩
function praise(aritlceId, type) {
	$.post("article_praise.action?articlePraise.articleId=" + aritlceId + "&articlePraise.type=" + type, 
	      function(data){
	     	if(data.errorCode==0){
	     		if (type == 1) {
	     			$('#praiseUpNumSpan').text(data.article.praiseUpNum);
	     		}
	     		else if (type == 2) {
	     			$('#praiseDownNumSpan').text(data.article.praiseDownNum);
	     		}
	     	} else {
	     		alert(data.errorMessage);
	     	}
	     },'json');
}
//删除文章
function deleteArticle(id) {
	if (confirm("确定将文章放入回收站吗？")) {
		$.post("index_deleteArticle.action?article.id=" + id,
			function (data, textStatus) {
				if (data.errorCode == 0) {
					location.href='index.action?menuUrl=index';
				}
		}, "json");
	}
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
                  <section class="m-b-md m-t-md col-md-12">
                  <div class="row">
                  <div id="post-carousel" class="util-carousel">
	                  <s:iterator value="articleList" id="article" status="u">
	                  		<div class="item">
								<a href="article_show.action?article.id=<s:property value='id' />" target="_blank"><img class="img-lazy" data-src="<s:property value='titleImage' />" src="<s:property value='titleImage' />" alt="" /></a>
			                    <div class="hover-content">
									<div class="overlay"></div>
									<div class="link-contianer">
										<a href="article_show.action?article.id=<s:property value='id' />"><s:property value="title" /></a>
									</div>
							    </div>
							</div>
	                  </s:iterator>
	                  </div>
                    </div>
                  </section>
                  
                  <section class="scrollable col-md-3 siderbar">
                  <ul class="list-group gutter list-group-lg list-group-sp sortable"> 
                  
                  <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                  <div class="panel panel-default portlet-item m-b-none">
                  <header class="panel-heading">
                  <ul class="nav nav-pills pull-right">
                  <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                  </ul>
                  资讯分类                    
                  </header>
                  <div class="panel-body">
                  		<s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                   		<a class="btn btn-sm btn-default add-btn pull-right" href="#modal-edit_category" data-toggle="modal">编辑</a>
                   		</s:if>
                        <div class="include"><s:property value="article.parentCategory.name" /></div>
                        <div class="part-clear"></div>
                        <s:if test="article.childCategory != null">
                        <span class="pull-left m-r"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/includeine.png"></span><div class="include seclevel"><s:property value="article.childCategory.name" /></div>
                   		</s:if>
                   </div>
                  </div>
                  </li>  
                  
                  <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   标签管理                    
                   </header>
	                   <div class="panel-body tagform">
	                   <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
		                   <div id="tagDiv" class="tagtitle" style="margin-top: 0;">新增标签<button href="#modal-add-tag" data-toggle="modal" class="btn btn-sm btn-default add-btn">
		                   <i class="fa fa-plus text"></i></button>
		                   </div>
	                   </s:if>
	                   <s:iterator value="tagList" id="tag" status="u">
	                    	<a class="label label-info tag" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="tooltip" />"><s:property value="name" />
	                    	<s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
	                    	<button type="button" class="close" onclick="deleteTag(<s:property value='id' />)" data-dismiss="alert">×</button>
	                    	</s:if>
	                    	</a>
	                    </s:iterator>
	                   </div>
                   
                   </div>
                   </li> 
                   </s:if>
                   <s:else>
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   标签                    
                   </header>
	                   <div class="panel-body tagform">
	                   <s:iterator value="tagList" id="tag" status="u">
	                    	<a class="label label-info tag" href="article_forTag.action?tag.id=<s:property value="id" />" target="_blank" data-toggle="tooltip" data-placement="top" data-original-title="<s:property value="tooltip" />">
	                    		<s:property value="name" />
	                    	</a>
	                    </s:iterator>
	                   </div>
                   
                   </div>
                   </li> 
                   </s:else>
                   
                   <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   热门标签                    
                   </header>
                   	<s:if test="hotTag == null">
                   		<s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
	                   <div class="text-center p-b-t-l b-b">
	                   <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
	                   <button href="#modal-add-hottag" data-toggle="modal" class="btn btn-sm btn-success">
	                   <i class="fa fa-plus text"></i> 添加热门标签
	                   </button>  
	                   </s:if>
	                   </div>  
	                   </s:if>           
                   </s:if>
                   <s:if test="hotTag != null">                        
                   <article class="b-b">
                       <div class="panel-body">
                       
                       <div class="media-body">
                       <div class="pull-right media-xs text-center text-muted">
                       <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                       <a href="#modal-edit-hottag" data-toggle="modal" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                       </s:if>
                       </div>
                       <div class="block writetime">标注时间：<s:date name="hotTag.createTime" format="yyyy年MM月dd日"/></div>
                       </div>
                       <div class="postil m-t-sm t-t"><s:property value="hotTag.content" escape="false"/></div>
                       </div>
                       </article>
                   </s:if> 
                                    
                   </div>
                   </li>
                   </s:if>
                   
                           
                   <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   趋势标签                    
                   </header>
                   	<s:if test="trendTag == null">
	                   <div class="text-center p-b-t-l b-b">
	                   <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
	                   <button href="#modal-add-trendstag" data-toggle="modal" class="btn btn-sm btn-success">
	                   <i class="fa fa-plus text"></i> 添加趋势标签
	                   </button>  
	                   </s:if>
	                   </div>   
                   </s:if>
                   
                   <s:if test="trendTag != null">                                  
                   <article class="b-b">
                       <div class="panel-body">
                       
                       <div class="media-body">
                       <div class="pull-right media-xs text-center text-muted">
                       <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2">
                       <a href="#modal-edit-trendstag" data-toggle="modal" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                       </s:if>
                       </div>
                       <div class="block writetime">标注时间：<s:date name="trendTag.createTime" format="yyyy年MM月dd日"/></div>
                       </div>
                       <div class="postil m-t-sm t-t"><s:property value="trendTag.content" escape="false"/></div>
                       </div>
                       </article>
                   </s:if> 
                                    
                   </div>
                   </li>
                   </s:if>
                   
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   项目文件夹                  
                   </header>
                   <div class="panel-body">
                   		<div class="text-center p-b-t-l">
		                   <button href="#modal-add-to-fav" class="btn btn-sm btn-success text-lg" data-toggle="modal">
		                   <i class="fa fa-plus text"></i> 添加到我的文件夹
		                   </button>  
	                   </div>
	                   <s:if test="userArticleFavoriteList != null && userArticleFavoriteList.size() > 0">
	                   	   <s:iterator value="userArticleFavoriteList">
	                   	   <div class="panel-body">
		                        <div class="include"><s:property value="parentFavorite.name" /></div>
                        		<div class="part-clear"></div>
                        		 <s:if test="childFavorite != null">
                        		 	<span class="pull-left m-r"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/includeine.png"></span>
                        		 	<div class="include seclevel"><s:property value="childFavorite.name" /> 
                        		 	<button type="button" class="close" onclick="deleteUserFavorite(<s:property value='id' />,this)" data-dismiss="alert">×</button>
                        		 	</div>
                        		 </s:if>
		                   </div>
		                   </s:iterator>
	                   </s:if>
                   
                   </div>
                   
                   </div>
                   </li> 
                   
                   
                   <li class="list-group-item col-md-12 sortable p-t-none savepanel" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   导出                    
                   </header>
                   <div class="panel-body">
                   <a href="#modal-export" class="btn btn-default jumpbtn" data-toggle="modal">导出</a>
                   <s:if test="prevArticle != null">
                   <a class="btn btn-success" href="article_show.action?article.id=<s:property value='prevArticle.id' />">上一篇</a>
                   </s:if>
                   <s:if test="nextArticle != null">
                   <a class="btn btn-success" href="article_show.action?article.id=<s:property value='nextArticle.id' />">下一篇</a>
                   </s:if>
                   </div></div>
                   </li> 
                   
                   </ul>    
                   </section> 
                  
                  <section class="col-md-6 row">
                          <section class="vbox">
                          <div class="wrapper dk p-b-none clearfix ">
                          <div class="post-state m-b-sm">
                          	<s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                          	<span class="badge bg-warning m-l-xs pull-left"><s:property value="article.statusName" /></span>
                          		<s:if test="article.deleted == 0">
                          		<a href="javascript:deleteArticle(<s:property value="article.id"/>)" class="btn btn-s-sxs btn-default btn-rounded pull-right"><i class="fa fa-trash-o"></i></a>
                            	</s:if>
                            	<a class="btn btn-s-sm btn-default btn-rounded pull-right m-r-sm" href="article_edit.action?article.id=<s:property value="article.id" />">编辑此文</a>
                            </s:if>
                          </div>
                          
                          <div class="post-title pull-left"><a href="#" data-toggle="class" class="pull-left m-r-sm"><i class="fa fa-star-o fa-lg text"></i><i class="fa fa-star text-warning fa-lg text-active"></i></a>
                                          <h4 class="m-n"><s:property value="article.title" /></h4> </div>
                                        </div>
                                        <div>
                                          <div class="block clearfix wrapper b-b">
                                            <a href="#" class="thumb-xs inline"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a0.png" class="img-circle "></a> 
                                            <span class="inline m-l-xs"> <s:property value="article.user.userName" /></span>
                                            <em class="text-sm m-l-sm">发表于 <span class="text-danger"><s:date name="article.createTime" format="yyyy年MM月dd日" /></span></em>
                                            <h5>原文链接：<a href="<s:property value="article.sourceLink" />" target="_blank"><s:property value="article.sourceLink" /></a></h5>
                                          </div>
                                          <div class="post-container wrapper b-b titleimg">
                                               <img src="<s:property value="article.titleImage" />" />
                                          </div>
                                          
                                          <div class="post-summary">
                                          	<s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                                          		<textarea style="border:0px;width:100%;height:500px;background: #89c3a8;" id="upSummary"><s:property value="article.summary" escape="false" /></textarea>
                                          		<a id="btnSummary" class="btn btn-sm btn-default add-btn pull-right" href="javascript:void(0);">保存摘要</a>
                                          	</s:if>
                                          	<s:else>
                                          		<s:property value="article.summary" escape="false" />
                                          	</s:else>
                                          </div>
                                          
                                          
                                          <div class="wrapper">
                                          <div class="col-md-12 no-padder m-b-md">
                                          <div class="panel panel-default portlet-item m-b-none">
                                          <header class="panel-heading">
                                          <ul class="nav nav-pills pull-right">
                                          <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                                          </ul>
                                          批注管理                    
                                          </header>
                                          <div class="text-center p-b-t-l b-b">
                                          <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
                                          <button href="#modal-add-commits" data-toggle="modal" class="btn btn-sm btn-success">
                                          <i class="fa fa-plus text"></i> 添加新批注
                                          </button>  
                                          </s:if>
                                          </div>                                     
                                          <s:if test="annotate != null">
					                   	   <article class="b-b">
						                       <div class="panel-body">
						                       <span class="pull-left thumb-sm avatar">
						                       	<s:if test="annotate.user.icon == null || annotate.user.icon==''">
								            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" class="img-circle">
								            	</s:if>
								            	<s:else>
								            		<img src="<s:property value='annotate.user.icon' />" class="img-circle">
								            	</s:else>
						                       </span>
						                       <div class="media-body">
						                       <div class="pull-right media-xs text-center text-muted">
						                       <s:if test="#session.user.role.id == 1 || #session.user.role.id == 2 || #session.user.role.id == 6">
						                       <a href="#modal-edit-commits" data-toggle="modal" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
						                       </s:if>
						                       </div>
						                       <a href="#" class="h5"><s:property value="annotate.user.UserName" /></a>
						                       <small class="block"><s:property value="annotate.user.role.name" /></small>
						                       </div>
						                       <div class="postil m-t-sm t-t"><s:property value="annotate.content" escape="false"/></div>
						                       </div>
					                       </article>
					                   </s:if>                                     
                                          </div>
                                          </div>
                                          </div>
                                          
                                          <div class="post-container wrapper b-b">
                                            <s:property value="article.content" escape="false" />
                                          </div>
                                        </div>
                                        
                                        <div class="likeorhate text-center m-t-sm">
                                      		<button class="btn btn-default" onclick="praise(<s:property value="article.id" />, 1)">
	                                          <span class="text">
	                                            <i class="fa fa-thumbs-up text-success"></i> <span id="praiseUpNumSpan"><s:property value="article.praiseUpNum" /></span>
	                                          </span>
	                                        </button>
	                                         <button class="btn btn-default m-l-sm" onclick="praise(<s:property value="article.id" />, 2)">
		                                        <span class="text">
		                                          <i class="fa fa-thumbs-down text-danger"></i> <span id="praiseDownNumSpan"><s:property value="article.praiseDownNum" /></span>
		                                        </span>
	                                        </button>
                                        </div>
                                        
                                        <div class="wrapper">
                                          点此按钮发表新的评论 <a href="#comment-form">发表新评论</a>
                                        </div>
                                    </section>
                          
                          <!-- 评论相关 -->
                          <section class="comment-list block m-b-xl">
                          	<s:iterator value="commentList" id="comment" status="u">
								<article id="comment-id-1" class="comment-item">
										<a class="pull-left thumb-sm avatar"> 
											<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a1.png" class="img-circle"> 
										</a> <span class="arrow left"></span>
										<section class="comment-body panel panel-default">
											<header class="panel-heading bg-white">
												<a href="#"><s:property value="user.userName" /></a> <label class="label bg-info m-l-xs">作者</label>
												<span class="text-muted m-l-sm pull-right"> 
													<i class="fa fa-clock-o"></i> <s:property value="createDateShowStr" /> 
												</span>
											</header>
											<div class="panel-body">
												<div><s:property value="comment" /></div>
												<div class="comment-action m-t-sm">
													<a href="#" data-toggle="class" class="btn btn-default btn-xs active"> 
														<i class="fa fa-star-o text-muted text"></i> 
														<i class="fa fa-star text-danger text-active"></i> 喜欢 
													</a> 
													<a href="javascript:void(0)" onclick="reply(<s:property value='id' />,'<s:property value='user.userName'/>')" class="btn btn-default btn-xs"> 
														<i class="fa fa-mail-reply text-muted"></i> 回复 
													</a>
												</div>
											</div>
										</section>
								</article>
									
									<!-- .comment-reply -->
									<s:iterator value="children" id="inner">
								    	<article id="comment-id-2" class="comment-item comment-reply">
											<a class="pull-left thumb-sm avatar"> <img
												src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a8.png">
											</a> <span class="arrow left"></span>
											<section class="comment-body panel panel-default text-sm">
												<div class="panel-body">
													<span class="text-muted m-l-sm pull-right"> <i
														class="fa fa-clock-o"></i> <s:property value="#inner.createDateShowStr" />  </span> <a href="#"><s:property value="#inner.user.userName" /></a> <label
														class="label bg-dark m-l-xs"><s:property value="#inner.user.role.name" /></label> <s:property value="#inner.comment" />
												</div>
											</section>
										</article>
								    </s:iterator>					
									
								</s:iterator>
									
							<!-- comment form -->
							<article class="comment-item media" id="comment-form">
								<a class="pull-left thumb-sm avatar"><img
									src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a6.png">
								</a>
								<section class="media-body">
									<form id="commentForm" class="m-b-none" method="post" action="article_comment.action">
										<div class="input-group">
											<input type="text" id="comment" name="comment.comment" class="form-control" placeholder="在此输入评论" /> 
											<input type="hidden" id="commentParentId" name="comment.parentId" value="0" />
											<input type="hidden" id="articleId" name="article.id" value="<s:property value='article.id' />" />
											<span class="input-group-btn">
												<button id="commentButton" class="btn btn-primary" type="button">发表</button>
											</span>
										</div>
									</form>
								</section>
							</article>
                      </section>
                  </section>
                  
                   
                   <section class="scrollable col-md-3 siderbar">
                   <ul class="list-group gutter list-group-lg list-group-sp sortable">  
                                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   
                   <!-- 关联文章 -->
                   <div class="panel panel-default portlet-item m-b-none" id="aboutarticle">
                   <script type="text/javascript">
                   $(document).ready(function(){
                	   $.get('aboutArticle.jsp?article.id=<s:property value="article.id"/>',function(res){
                		   $('#aboutarticle').html(res);
                	   })
                   })
                   </script>
                   </div>
                   
                   </li>
                   </ul>    
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
 
  <div class="modal fade" id="modal-add-to-fav" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加到文件夹</h3>
          <small>您可以在此选择此篇文章要添加到哪个文件夹。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              <form id="favoriteForm" class="form-horizontal" method="post" 
              		<s:if test="articleFavorite==null || articleFavorite.id=0">action="article_favorite.action"</s:if>
              		<s:else>action="article_favoriteUpdate.action"</s:else>
              		>
                                     <div class="form-group">
                                     <div class="m-b-xs prename">
                                     <span class="selectname longname">分析范围选择</span>
                                     <div class="btn-group m-r">
                                     
                                     <select name="articleFavorite.parentFavoriteId" id="parentFavoriteList" val='<s:property value="articleFavorite.parentFavorite.id" />'>
                                     </select>
                                    
                                     </div>
                                     
                                     <div class="btn-group m-r">
                                     
                                     <select name="articleFavorite.childFavoriteId" id="childFavoriteList" val='<s:property value="articleFavorite.childFavorite.id" />'>
                                     </select>
                                     
                                     </div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                   <div class="checkbox m-t-lg">
                                    <input type="button" id="favoriteButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" value="确定" />
                                    <input type="hidden" name="article.id" value="<s:property value='article.id' />" />
                                    
                                   </div>
                                 </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    
<div class="modal fade" id="modal-add-commits" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 70%;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加批注</h3>
          <small>您可以在此添加对本文的批注。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              <form id="addAnnotateForm" class="form-horizontal" method="post" action="article_annotate.action">
                      <div class="panel-body no-padder">
                                     <div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                                       <textarea name="annotate.content" id="annotateContentAdd"><s:property value='annotate.content' escape="false"/></textarea>
                                     <input type="hidden" name="annotate.content" id="annotateContent" />
                                     <input type="hidden" name="annotate.articleId" value="<s:property value='article.id' />" />
                                     <input type="hidden" name="annotate.type" value="1" />
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                
                                                
                                                <button id="addAnnotateButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                   
                                                </div>
                                              
                              </div>
              </form>
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
</div>    
    
    <div class="modal fade" id="modal-edit-commits" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 70%;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">修改批注</h3>
          <small>您可以在此修改对本文的批注。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              <form id="editAnnotateForm" class="form-horizontal" method="post" action="article_annotateUpdate.action">
                      <div class="panel-body no-padder">
                      				<div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                                     <textarea name="annotate.content" id="annotateContentUpdate"><s:property value='annotate.content' escape="false"/></textarea>
                                    </div>
                                     <input type="hidden" name="annotate.articleId" value="<s:property value='article.id' />" />
                                     <input type="hidden" name="annotate.type" value="1" />
                                     <input type="hidden" name="annotate.id" id="annotateIdUpdate" value="<s:property value='annotate.id'/>"/>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                
                                                
                                                <button id="editAnnotateButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                   
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    
    
    
  <div class="modal fade" id="modal-add-hottag" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 70%;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加热门标签</h3>
          <small>您可以在此添加热门标签。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              <form id="addHotTagForm" class="form-horizontal" method="post" action="article_annotate.action">
                      <div class="panel-body no-padder">
                                     <div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                                       <textarea name="annotate.content" id="hotTagContent"></textarea>
                                     </div>
                                     <input type="hidden" name="annotate.articleId" value="<s:property value='article.id' />" />
                                     <input type="hidden" name="annotate.type" value="2" />
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                
                                                <button id="addHotTagButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
    
    <div class="modal fade" id="modal-edit-hottag" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 70%;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">修改热门标签</h3>
          <small>您可以在此修改热门标签。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              <form id="editHotTagForm" class="form-horizontal" method="post" action="article_annotateUpdate.action">
                      <div class="panel-body no-padder">
                                     <div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                                       <textarea name="annotate.content" id="hotTagContentEdit"><s:property value='hotTag.content' escape="false"/></textarea>
                                     </div>
                                     <input type="hidden" name="annotate.articleId" value="<s:property value='article.id' />" />
                                     <input type="hidden" name="annotate.type" value="2" />
                                     <input type="hidden" name="annotate.id" value="<s:property value='hotTag.id'/>"/>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                
                                                
                                                <button id="editHotTagButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                   
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  
  <div class="modal fade" id="modal-add-trendstag" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 70%;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">添加趋势标签</h3>
          <small>您可以在此添加趋势标签。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              <form id="addTrendTagForm" class="form-horizontal" method="post" action="article_annotate.action">
                      <div class="panel-body no-padder">
                                     <div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                                       <textarea name="annotate.content" id="trendTagContent"></textarea>
                                   	 </div>
                                   	 <input type="hidden" name="annotate.articleId" value="<s:property value='article.id' />" />
                                     <input type="hidden" name="annotate.type" value="3" />
                                   	 </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                <button id="addTrendTagButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
 
 <div class="modal fade" id="modal-edit_category" aria-hidden="true">
      <div class="modal-dialog">
      <form id="categoryForm" class="form-horizontal" method="post" action="<%=UrlHelper.getHomeUrl()%>article_categoryUpdate.action">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">编辑文章分类</h3>
          <small>您可以在此编辑文章文类。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              
                                     <div class="form-group">
                                     <div class="m-b-xs prename">
                                     <span class="selectname longname">文章分类选择</span>
                                     <div class="btn-group m-r">
	                                     <select id="parentCategoryId" name="article.parentCategoryId" class="chosen" onchange="showCategoryChildren()">
						                   	<option value="-1">请选择一级分类</option>
						                   	<s:iterator value="categoryList" id="category" status="u">
						                   	<option <s:if test="article.parentCategoryId == id">selected="selected"</s:if> value="<s:property value='id' />"><s:property value="name" /></option>
						                   	</s:iterator>
						                 </select>
                                     </div>
                                     
                                     <div class="btn-group m-r">
                                     	<select id="childCategoryList" name="article.childCategoryId" class="chosen">
						                   	<option value="-1">请选择二级分类</option>
						                   	<s:iterator value="childCategoryList" id="category" status="u">
						                   	<option <s:if test="article.childCategoryId == id">selected="selected"</s:if> value="<s:property value='id' />"><s:property value="name" /></option>
						                   	</s:iterator>
						                 </select>
                                     </div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                   <div class="checkbox m-t-lg">
                                    <input type="button" id="categoryButton" onclick="updateCategory()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" value="确定" />
                                    <input type="hidden" name="article.id" value="<s:property value='article.id' />" />
                                    
                                   </div>
                                 
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
         </form>
      </div><!-- /.modal-dialog -->
    </div>
       
 <div class="modal fade" id="modal-edit-trendstag" style="display: none;" aria-hidden="true">
      <div class="modal-dialog" style="min-width: 70%;">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">修改趋势标签</h3>
          <small>您可以在此修改趋势标签。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12 no-padder">
              <form id="editTrendTagForm" class="form-horizontal" method="post" action="article_annotateUpdate.action">
                      <div class="panel-body no-padder">
                                     <div class="btn-toolbar m-b-sm m-t-none btn-editor" data-role="editor-toolbar" data-target="#editor">
                                       <textarea name="annotate.content" id="trendTagContentEdit"><s:property value='trendTag.content' escape='false'/></textarea>
                                   	 </div>
                                   	 <input type="hidden" name="annotate.articleId" value="<s:property value='article.id' />" />
                                     <input type="hidden" name="annotate.type" value="3" />
                                     <input type="hidden" name="annotate.id" value="<s:property value='trendTag.id' />" />
                                   	 </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    
                                                <div class="checkbox m-t-lg">
                                                <button id="editTrendTagButton" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  
  
     
    
    <!-- 新增标签 -->
 <div class="modal fade" id="modal-add-tag" style="display: none;" aria-hidden="true">
 <form id="addTagForm" class="form-horizontal" method="post" action="article_addTag.action">
     <div class="modal-dialog" id="addTagDialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">添加新标签</h3>
         <small>您可以在此添加新的热门标签。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
                                      <div class="form-group">
                                      <label class="col-sm-2 control-label tagselectname">请输入标签</label>
                                      <div class="col-sm-9">
                                      <input type="text" id="ac1" name="tag.name" class="form-control" />
                                      <span class="help-block m-b-none" style="display: none;" id="acblock">库中没有该标签，您可以将其作为新标签添加到标签库中，并应用在这篇文章上。</span>
                                      <input type="hidden" name="tag.hot" value="0" />
                                      <input type="hidden" id="selflag" value="0" />
                                      </div>
                                      </div>
                                      <div id="modal-add-tag-new" style="display: none;" aria-hidden="true">
                                       <!-- <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-2 control-label tagselectname">标签别名</label>
                                       <div class="col-sm-9">
                                       <input type="text" id="tagAlias" name="tag.alias" class="form-control">
                                       <span class="help-block m-b-none">此项为必填，请使用小写英文字母作为标签别名，特殊符号仅支持"-"和"_"。</span>
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
                                      			<select name="tag.categoryId" id="addtagcategoryid">
                                      				<option value="-1">请选择标签分类</option>
                                      				<s:iterator value="tagCategoryList" id="tagCategory" status="u">
                                      				<option value="<s:property value='id' />"><s:property value="name" /></option>
                                      				</s:iterator>
                                      			</select>                                  
                                       </div>
                                     </div>
                                     </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
              <div class="checkbox m-t-lg">
                 <input type="button" id="addTagButton" value="确定" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" />
              </div>
              
             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
     </form>
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
                	<button id="btnexporttemplate" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" href="exportArticl.action?article.id=<s:property value="article.id" />"><strong>确定</strong></button>
                </div>
              </div>
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
 
</body>
</html>