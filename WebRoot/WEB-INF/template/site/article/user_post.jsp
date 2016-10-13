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
  <link rel="shortcut icon" type="image/x-icon" href="<%=UrlHelper.getHomeUrl()%>favicon.ico" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/icon.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/font.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/app.css" type="text/css" /> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/util.carousel.css">
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/util.animate.css" />
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/utilcarousel/jquery.utilcarousel.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $('#post-carousel').utilCarousel({
        responsiveMode : 'itemWidthRange',
		itemWidthRange : [100, 130],
		itemAnimation:'util-flip-in-y',
		navigationText : ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
		navigation : true,
		rewind : false,
		lazyLoad: true
    });
    
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
	
	$('#profileavatar').preimage();
	$('#modifyUserInfoForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
		},
		success:function(d) {
			if(d.errorCode==0){
				alert('操作成功');
			}else{
				alert(d.errorMessage);
			}
		}    	
	});
	
}); 

// 点击回复按钮
function reply(commentId) {
	//$('#comment').val('@: ');
	$('#commentParentId').val(commentId);
}

function logout() {
	if (confirm("确定退出吗？")) {
		location.href = "logout.action";
	}
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
</script>
</head>
<body class="" >
  <section class="vbox">
    <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow">
      <div class="navbar-header aside-md dk">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
          <i class="fa fa-bars"></i>
        </a>
        <a href="index.html" class="navbar-brand">
          <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/logo.jpg" class="m-r-sm" alt="scale">
          <span class="hidden-nav-xs">本然数据库</span>
        </a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user">
          <i class="fa fa-cog"></i>
        </a>
      </div>
      
      <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" role="search">
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-btn">
              <button type="submit" class="btn btn-sm bg-white b-white btn-icon"><i class="fa fa-search"></i></button>
            </span>
            <input type="text" class="form-control input-sm no-border" placeholder="请搜索...">            
          </div>
        </div>
      </form>
      <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <span class="thumb-sm avatar pull-left">
              	<s:if test="#session.user.icon == null || #session.user.icon==''">
            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" >
            	</s:if>
            	<s:else>
            		<img src="<s:property value='#session.user.icon' />" alt="...">
            	</s:else>
            </span>
            <s:property value="#session.user.userName"/> <b class="caret"></b>
          </a>
          <ul class="dropdown-menu animated fadeInRight">            
            <li>
              <span class="arrow top"></span>
              <a href="#modal-editprofile" data-toggle="modal">个人资料设置</a>
            </li>
            <li class="divider"></li>
            <li>
              <a href="javascript:void(0)" onclick="logout()" data-toggle="ajaxModal" >登出</a>
            </li>
          </ul>
        </li>
      </ul>      
    </header>
    <section>
      <section class="hbox stretch">
        <!-- .aside -->
        <aside class="bg-black aside-md hidden-print hidden-xs nav-xs" id="nav">          
          <section class="vbox">
            <section class="w-f scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
                <div class="clearfix wrapper dk nav-user hidden-xs">
                  <div class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <span class="thumb avatar pull-left m-r">                        
                        <s:if test="#session.user.icon == null || #session.user.icon==''">
		            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" >
		            	</s:if>
		            	<s:else>
		            		<img src="<s:property value='#session.user.icon' />" alt="...">
		            	</s:else>
                        <i class="on md b-black"></i>
                      </span>
                      <span class="hidden-nav-xs clear">
                        <span class="block m-t-xs">
                          <strong class="font-bold text-lt"><s:property value="#session.user.userName"/></strong> 
                          <b class="caret"></b>
                        </span>
                        <span class="text-muted text-xs block"><s:property value="#session.user.role.name"/></span>
                      </span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">                      
                      <li>
                        <span class="arrow top hidden-nav-xs"></span>
                        <a href="#modal-editprofile" data-toggle="modal">个人资料设置</a>
                      </li>
                      <li class="divider"></li>
                      <li>
                        <a href="javascript:void(0)" onclick="logout()" data-toggle="ajaxModal" >登出</a>
                      </li>
                    </ul>
                  </div>
                </div>                


                <!-- nav -->                 
                <nav class="nav-primary hidden-xs">
                  <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">主菜单</div>
                  <ul class="nav nav-main" data-ride="collapse">
                    <li >
                      <a href="user_index.action" class="auto">
                        <span class="pull-right text-muted">
                          <i class="i i-circle-sm-o text"></i>
                          <i class="i i-circle-sm text-active"></i>
                        </span>
                        <i class="i i-stack icon">
                        </i>
                        <span class="font-bold">我的主页</span>
                      </a>
                      
                    </li>

                  </ul>
                  <div class="line dk hidden-nav-xs"></div>
                 
                  </ul>
                </nav>
                <!-- / nav -->
              </div>
            </section>
            
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <a href="modal.lockme.html" data-toggle="ajaxModal" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs">
                <i class="i i-logout"></i>
              </a>
              <a href="#nav" data-toggle="class:nav-xs" class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs">
                <i class="i i-circleleft text"></i>
                <i class="i i-circleright text-active"></i>
              </a>
            </footer>
          </section>
        </aside>
        <!-- /.aside -->
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
									<a href="#"><s:property value="title" /></a>
								</div>
						    </div>
						</div>
                  </s:iterator>
                  </div>
                    </div>
                  </section>
                  <section class="col-md-9 row">
                          <section class="vbox">
                          <div class="wrapper dk p-b-none clearfix ">
                                          <a href="#" data-toggle="class" class="pull-left m-r-sm"><i class="fa fa-star-o fa-lg text"></i><i class="fa fa-star text-warning fa-lg text-active"></i></a>
                                          <h4 class="m-n"> <s:property value="article.title" /></h4> 
                                        </div>
                                        <div>
                                          <div class="block clearfix wrapper b-b">
                                            <a href="#" class="thumb-xs inline"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a0.png" class="img-circle "></a> 
                                            <span class="inline m-l-xs"> <s:property value="article.user.userName" /></span>
                                            <em class="text-xs m-l-sm">发表于 <span class="text-danger"><s:date name="article.createTime" format="yyyy年MM月dd日" /></span></em>
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
                          <section class="comment-list block m-b-xl">
                                              <s:iterator value="commentList" id="comment" status="u">
									<article id="comment-id-1" class="comment-item">
										<a class="pull-left thumb-sm avatar"> <img
											src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a1.png"
											class="img-circle"> </a> <span class="arrow left"></span>
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
													<a href="javascript:void(0)" onclick="reply(<s:property value='id' />)" class="btn btn-default btn-xs"> 
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
														class="label bg-dark m-l-xs">高级研究员</label> <s:property value="#inner.comment" />
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
													<input type="hidden" name="article.id" value="<s:property value='article.id' />" />
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
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   标签管理                    
                   </header>
                   <div class="panel-body tagform">
                   <div class="tagtitle" style="margin-top: 0;">标签</div>
                   <s:iterator value="tagList" id="tag" status="u">
                   		<a class="label label-info tag"><s:property value="name" /></a>
                   </s:iterator>
                   </div>
                   </li> 
                                          
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   批注管理                    
                   </header>
                                   
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
	                       <a href="#" class="h5"><s:property value="annotate.user.UserName" /></a>
	                       <small class="block"><s:property value="annotate.user.role.name" /></small>
	                       </div>
	                       <div class="postil m-t-sm t-t"><s:property value="annotate.content" escape="false"/></div>
	                       </div>
                       </article>
                   </s:if>                                      
                   </div>
                   </li>
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   热门标签                    
                   </header>
                                    
                   <s:if test="hotTag != null">                        
                   <article class="b-b">
                       <div class="panel-body">
                       
                       <div class="media-body">
                       <div class="block writetime">标注时间：<s:date name="hotTag.createTime" format="yyyy年MM月dd日"/></div>
                       </div>
                       <div class="postil m-t-sm t-t"><s:property value="hotTag.content" escape="false"/></div>
                       </div>
                       </article>
                   </s:if>      
                                    
                   </div>
                   </li>
                   
                   <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   趋势标签                    
                   </header>
                                    
                   <s:if test="trendTag != null">                                  
                   <article class="b-b">
                       <div class="panel-body">
                       
                       <div class="media-body">
                       <div class="block writetime">标注时间：<s:date name="trendTag.createTime" format="yyyy年MM月dd日"/></div>
                       </div>
                       <div class="postil m-t-sm t-t"><s:property value="trendTag.content" escape="false"/></div>
                       </div>
                       </article>
                   </s:if>       
                                    
                   </div>
                   </li>
                   
                   </ul>    
                   </section> 
                   <section class="scrollable col-md-3 siderbar">
                   <ul class="list-group gutter list-group-lg list-group-sp sortable">  
                    <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
                   <div class="panel panel-default portlet-item m-b-none">
                   <header class="panel-heading">
                   <ul class="nav nav-pills pull-right">
                   <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
                   </ul>
                   收藏夹                    
                   </header>
                   <div class="panel-body">
                   
	                   <s:if test="articleFavorite == null || articleFavorite.id == 0">
	                   	   <div class="text-center p-b-t-l">
			                   <button href="#modal-add-to-fav" class="btn btn-sm btn-success text-lg" data-toggle="modal">
			                   <i class="fa fa-plus text"></i> 添加到我的收藏夹
			                   </button>  
		                   </div>
	                   </s:if>
	                   <s:else>
	                   	   <div class="panel-body">
		                        <a class="btn btn-sm btn-default add-btn pull-right" href="#modal-add-to-fav" data-toggle="modal">编辑</a>
		                        <div class="include"><s:property value="articleFavorite.childFavorite.name" /></div>
		                   </div>
	                   </s:else>
                   
                   </div>
                   
                   <div class="panel-body hidden">
                   <a href="#" class="btn btn-sm btn-default add-btn pull-right">编辑</a>
                   <div class="include">本文已收藏至：</div>
                   <div class="part-clear"></div>
                   <a href="#" class="text-success p-b-t-md fav-list m-t-sm">2014-OPPO信息情报-第9期</a>
                   </div>
                   
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
          <h3 class="m-t-none">添加到收藏夹</h3>
          <small>您可以在此选择此篇文章要添加到哪个收藏夹。</small>
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
    
  <!-- 用户编辑 -->
     <div class="modal fade" id="modal-editprofile" style="display: none;" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
         <h3 class="m-t-none">个人资料设置</h3>
         <small>您可以在此修改您的个人资料。</small>
       </div>
         <div class="modal-body wrapper-lg">
           <div class="row">
             <div class="col-sm-12">
             <form class="form-horizontal" method="post" id="modifyUserInfoForm" action="updateUserProfile.action" enctype="multipart/form-data">
             	<input type="hidden" name="user.id" value="<s:property value="#session.user.id"/>"/>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">用户名</label>
                                    <div class="col-sm-9 ">
                                     <s:property value="#session.user.userName"/>
                                    </div>
                                    </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">原密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请输入你原来的密码。</span>
                                     </div>
                                    </div>
                                    
                                  <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label">新密码<span class="redstar"> *</span></label>
                                    <div class="col-sm-9">
                                    <input type="password" name="newPassword" class="form-control">
                                    <span class="help-block m-b-none">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</span>
                                    </div>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">重复新密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="rePassword" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请再次输入密码。</span>
                                     </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">电子邮箱<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="text" class="form-control" value="<s:property value="#session.user.email"/>" name="user.email">
                                                   <span class="help-block m-b-none">此项为必填。</span>
                                                 </div>
                                               </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>

                                    <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left">
                                                   <s:if test="#session.user.icon == null">
									            		<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg" width="128" height="128">
									            	</s:if>
									            	<s:else>
									            		<img src="<%=UrlHelper.getHomeUrl()%><s:property value='#session.user.icon' />" width="128" height="128">
									            	</s:else>
									            	<input type="file" id="profileavatar" name="avatar" class="btn btn-s-md btn-default btn-rounded change-avatar" />
                                                   <!-- <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> -->
                                                 </span>
                                                 </div>
                                                 
                                                 
                                               </div>
                                               
                                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                               <div class="checkbox m-t-lg">
                                               <button type="button" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..." onclick="$('#modal-editprofile').find('.close').click();"><strong>关闭</strong></button>
                                               <button type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..." onclick="$('#modifyUserInfoForm').submit();"><strong>保存修改</strong></button>
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