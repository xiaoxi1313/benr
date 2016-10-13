<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
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
  
<script type="text/javascript">
$(document).ready(function(){
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
	
	$('#addChildFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			alert(d.img);
			if(d.errorCode==0){
				//alert("添加标签成功！");
				//location.href = "tag_manage.action";
	            //$("#showImage").html("<img src='showImage.action?imageUrl="+data[1]+"'/>"); 
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
		$('#addChildFavoriteForm').submit();
	});
});

// 根据子收藏夹刷新页面
function listArticle(childFavoriteId) {
	location.href = "favorite_child.action?favorite.id=" + $('#parentFavoriteId').val() + "&childFavorite.id=" + childFavoriteId;
}
</script>
</head>
<body class="" >
<section class="panel-default favsec">
              
                            <header class="panel-heading col-md-12"><s:property value="favorite.name" /><input type="hidden" name="favorite.id" id="parentFavoriteId" value="<s:property value='favorite.id' />" /></h4>
                              <button type="button" href="#modal-delete" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="删除"><i class="fa fa-trash-o"></i></button>
                              <button type="button" href="#modal-second-fav-sort" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="排序"><i class="fa fa-sort"></i></button>
                              <button type="button" href="#modal-edit-first-fav" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="编辑"><i class="fa fa-edit"></i></button>
                            </header>
               
               <section class="col-md-9 favsec no-padder" > 
                              <section class="hbox stretch" >
                               <aside class="padder p-r-none p-b-lg">              
               
                                    <section class="vbox">
                                    <section class="scrollable">
                                     <div class="row wrapper p-r-lg clearfix">
<div class="col-sm-12 text-left text-left-xs no-padder"> 
<div class="col-sm-9 no-padder"><h5 class="m-b-xs text-black"><s:property value="childFavorite.name" /></h5></div>
<div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共10篇文章</small></div>
</div> 
<div id="filters" class="col-sm-6 button-group no-padder">
    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter="*">全部文章</button>
    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".hulianwang">互联网</button>
    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".xiaofeidianzi">消费电子</button>
</div>                                   
<div class="col-sm-6 text-right text-left-xs no-padder">
<button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="添加标签" href="#modal-add-tags" data-toggle="modal"><i class="fa fa-tags"></i></button>
<button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="排序" href="#modal-second-fav-sort-diyiqi" data-toggle="modal"><i class="fa fa-sort"></i></button>
<button type="button" class="btn btn-sm btn-default pull-right m-l-xs" title="编辑" href="#modal-edit-second-fav" data-toggle="modal"><i class="fa fa-edit"></i></button>
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
                                     
                                     <div class="item col-sm-6 col-md-4 post hulianwang">
                                     <s:iterator value="articleList" id="article" status="u">
                                     	<section class="panel b-a">
	                                         <div class="clearfix text-center m-b-sm title-pic">
	                                              <div class="picframe">
	                                                  <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p1.jpg" class="thumb-o"></a>
	                                                  <div class="hover-content">
	                                                  <div class="overlay"></div>
	                                                  <div class="link-contianer">
	                                                  <a href="#" >查看详情</a>
	                                                  </div>
	                                                  </div>
	                                              </div>
	                                                 <div class="h5 m-t m-b-xs posttitlename"><a href="#"><s:property value="title" /></a></div>
	                                                 <div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
	                                                 <div class="label bg-success m-b-xs">分类：<span><s:property value="parentCategory.name" /></span></div>
	                                                 <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span><s:property value="childFavorite.name" /></span></div>
	                                               <div class="text-left abs-text"><s:property value="contentSubStr" /></div> 
	                                         
	                                         </div>
	                                         <div class="clearfix panel-footer">
	                                             <a href="#modal-delete" data-toggle="modal" class="pull-right"><i class="i i-trashcan text-muted"></i></a>
	                                             <a href="#" class="m-l-xs"><label class="i-checks m-b-none"><input type="checkbox" name="ids[]"><i></i></label></a>
	                                             <a href="#" class="pull-right m-r"><i class="i i-pencil2 text-muted"></i></a>
	                                         </div>
	                                     </section>
				                    </s:iterator>
                                     
                                     </div>
                                     
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
                   <button href="#modal-add-second-fav" class="btn btn-success bg-empty btn-sm" data-toggle="modal"><i class="fa fa-plus"></i> 添加子收藏夹</button>
                   
                 </header>
                 <section class="scrollable">
                   <div class="list-group auto list-group-alt no-radius no-borders">
                   <s:iterator value="favoriteList" id="favorite" status="u">
                   		<s:if test="#u.index == 0">
                   			 <a class="list-group-item active" href="javascript:void(0)" onclick="listArticle(<s:property value='id' />)">
		                         <i class="fa fa-fw fa-circle-o text-muted text-xs"></i>
		                         <span class="thumb-sm avatar pull-left"><img alt="..." src="<s:url action="viewImg.action"><s:param name="imageUrl" value="img"></s:param></s:url>" /></span><span class="subfavbtn"><s:property value="name" /></span>
		                     </a>
                   		</s:if>
                   		<s:else>
                   			 <a class="list-group-item" href="#">
		                         <i class="fa fa-fw fa-circle-o text-muted text-xs"></i>
		                         <span class="thumb-sm avatar pull-left"><img alt="..." src="<s:url action="viewImg.action"><s:param name="imageUrl" value="img"></s:param></s:url>" /></span><span class="subfavbtn"><s:property value="name" /></span>
		                     </a>
                   		</s:else>
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
  
  <div class="modal fade" id="modal-add-second-fav" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">添加子收藏夹</h3>
            <small>您可以在此添加子收藏夹。</small>
          </div>
            <div class="modal-body wrapper-lg">
              <div class="row">
						<div class="col-sm-12">
							<form id="addChildFavoriteForm" class="form-horizontal" method="post" action="favorite_save.action">
								<div class="form-group">
									<label class="col-sm-3 control-label">子收藏夹名<span
										class="redstar"> *</span>
									</label>
									<div class="col-sm-9">
										<input type="text" name="favorite.name" class="form-control" datatype="s5-16" errormsg="名称至少5个字符,最多16个字符！" /> 
										<div class="Validform_checktip">此项为必填，不能使用特殊符号。</div>
									</div>
								</div>
								<div class="line line-dashed b-b line-lg pull-in"></div>
								<div class="form-group">
									<label class="col-sm-3 control-label">子收藏夹别名<span
										class="redstar"> *</span>
									</label>
									<div class="col-sm-9">
										<input type="text" name="favorite.alias" class="form-control" datatype="s5-16" errormsg="名称至少5个字符,最多16个字符！" />
											<div class="Validform_checktip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
									</div>
								</div>

								<div class="line line-dashed b-b line-lg pull-in"></div>
								<div class="form-group">
									<label class="col-sm-3 control-label">上传缩略图</label>
									<div class="col-sm-9">

										<div class="dropfile visible-lg col-sm-12 no-padder">
											<small>请将缩略图拖拽至此</small>
										</div>
									</div>
								</div>

								<div class="line line-dashed b-b line-lg pull-in"></div>
								<div class="checkbox m-t-lg">

									<button type="button"
										class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md"
										data-loading-text="取消中...">
										<strong>取消</strong>
									</button>

									<button type="button" id="saveChildFavoriteButton"
										class="btn btn-md btn-success pull-right text-uc m-t-n-xs"
										data-loading-text="保存中...">
										<strong>保存</strong>
									</button>
									<input type="hidden" name="favorite.parentId" value="<s:property value='favorite.id' />" />
								</div>
							</form>
						</div>

					</div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </body>