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
	$("#childIframe").load(function(){
		var mainheight = $(this).contents().find("body").height()+30;
		$(this).height(mainheight);
	});
	
	var $container = $('#container').isotope({
          getSortData: {
              posttitlename: '.posttitlename',
              postedtime: '.postedtime'
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
	
	$('#form2').ajaxForm({
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
				$("#tipFont").text(d.url + " 图片上传成功！");  
	            //$("#showImage").html("<img src='showImage.action?imageUrl="+data[1]+"'/>"); 
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#form2').submit();
				} else {
					//alert(d.errorMessage);
					$("#tipFont").text(d.errorMessage);
				}
				
			}
		}, 
		fail:function(d) {
			alert(d);
		}   	
	});
	
	$('#addFavoriteForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			//$('#loadingdiv').hide();
			if(d.errorCode==0){
				alert("添加收藏夹成功！");
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
		$('#addFavoriteForm').submit();
	});
});

/**
 * 上传并解析按钮
 */
function uploadImage() { 
	$('#form2').submit();
}

/**
 * 刷新子收藏夹
*/
function listChildren(parentId) {
	$("#childIframe").attr("src","favorite_child.action?parentId=" + parentId);
}
</script>
</head>
<body class="" >
        <%@include file="../head.jsp" %>
        <section id="content">
          <section class="hbox stretch">
          <aside class="aside-sm bg-light dker b-r" id="subNav">
            <div class="wrapper b-b header">
            <button href="#modal-add-first-fav" class="btn btn-success btn-preset notopm" data-toggle="modal"><i class="fa fa-plus text"></i><span class="text"> 添加</span></button>
            <button type="button" class="btn btn-sm btn-success pull-right m-l-xs notopm" title="排序" href="#modal-first-fav-sort" data-toggle="modal"><i class="fa fa-sort"></i></button>
            </div>
            <ul class="nav">
           	<s:iterator value="favoriteList" id="favorite" status="u">
           		<s:if test="#u.index == 0">
           			<li class="b-b active"><a href="javascript:void(0)" onclick="listChildren(<s:property value='id' />)" ><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><span class="thumb-sm avatar pull-left"><img alt="..." src="<s:url action="viewImg.action"><s:param name="imageUrl" value="img"></s:param></s:url>" /></span><s:property value="name" /></a></li>
           		</s:if>
           		<s:else>
           			<li class="b-b "><a href="javascript:void(0)" onclick="listChildren(<s:property value='id' />)"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><span class="thumb-sm avatar pull-left"><img alt="..." src="<s:url action="viewImg.action"><s:param name="imageUrl" value="img"></s:param></s:url>" /></span><s:property value="name" /></a></li>
           		</s:else>
           	</s:iterator>
            </ul>
          </aside>

    <iframe id="childIframe" width ="100%" height="100%" src="favorite_child.action" frameborder="0">
	</iframe>
  
  <form id="deleteForm" method="post" action="favorite_delete.action">
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
                
                <button type="submit" class="btn btn-md btn-success text-uc" data-loading-text="确定中..."><strong>确定</strong></button>
                <button class="btn btn-md btn-danger text-uc m-l-sm" data-loading-text="取消中..."><strong>取消</strong></button>
                <input type="hidden" name="favorite.id" id="favoriteId" />
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  </form>
  <div class="modal fade" id="modal-first-fav-sort" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="width: 700px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">排序收藏夹</h3>
            <small>您可以在此自行排序收藏夹。</small>
          </div>
            <div class="modal-body wrapper-md">
              <div class="row">
                <div class="col-sm-12">
                <section class="scrollable wrapper" style="max-height: 450px;">
                  <div class="">
                    <ul class="list-group gutter list-group-lg list-group-sp sortable">
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 A
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 B
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 C
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 D
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 E
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 F
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 G
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          收藏夹 H
                        </div>
                      </li>
                    </ul>
                  </div>
                </section>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                
                <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..."><strong>取消</strong></button>
                
                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存</strong></button>
                   
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  <div class="modal fade" id="modal-second-fav-sort" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="width: 700px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">排序子收藏夹</h3>
            <small>您可以在此自行排序子收藏夹。</small>
          </div>
            <div class="modal-body wrapper-md">
              <div class="row">
                <div class="col-sm-12">
                <section class="scrollable wrapper" style="max-height: 450px;">
                  <div class="">
                    <ul class="list-group gutter list-group-lg list-group-sp sortable">
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第1期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第2期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第3期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第4期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第5期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第6期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第7期
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          子收藏夹-第8期
                        </div>
                      </li>
                    </ul>
                  </div>
                </section>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                
                <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..."><strong>取消</strong></button>
                
                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存</strong></button>
                   
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
  <div class="modal fade" id="modal-second-fav-sort-diyiqi" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="width: 700px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">排序子收藏夹-第1期</h3>
            <small>您可以在此自行排序该子收藏夹里的文章。</small>
          </div>
            <div class="modal-body wrapper-md">
              <div class="row">
                <div class="col-sm-12">
                <section class="scrollable wrapper" style="max-height: 450px;">
                  <div class="">
                    <ul class="list-group gutter list-group-lg list-group-sp sortable">
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          小米4发布 <span class="label bg-success m-l-lg">互联网</span><span class="text-danger m-l-lg pull-right">2014年10月11日</span>
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          锤子的困惑<span class="label bg-success m-l-lg">互联网</span><span class="text-danger m-l-lg pull-right">2014年12月11日</span>
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          可穿戴设备的春天<span class="label bg-success m-l-lg">消费电子</span><span class="text-danger m-l-lg pull-right">2014年08月15日</span>
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          摄影设备<span class="label bg-success m-l-lg ">消费电子</span><span class="text-danger m-l-lg pull-right">2014年02月18日</span>
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          完美的加工工艺<span class="label bg-success m-l-lg">消费电子</span><span class="text-danger m-l-lg pull-right">2014年04月11日</span>
                        </div>
                      </li>
                      <li class="list-group-item bg-info">
                        <span class="pull-left media-xs"><i class="fa fa-sort text-muted fa m-r-sm"></i></span>
                        <div class="clear text-white">
                          新的手机应用<span class="label bg-success m-l-lg">互联网</span><span class="text-danger m-l-lg pull-right">2014年05月16日</span>
                        </div>
                      </li>
                    </ul>
                  </div>
                </section>
                <div class="line line-dashed b-b line-lg pull-in"></div>
                <div class="checkbox m-t-lg">
                
                <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..."><strong>取消</strong></button>
                
                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存</strong></button>
                   
                </div>
                </div>
                
              </div>          
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
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
                  <form class="form-horizontal" method="get">
                                         <div class="form-group">
                                         <div class="radio col-sm-6 text-center p-b-lg">
                                           <label class="h4">
                                             <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                             添加热门标签
                                           </label>
                                         </div>
                                         <div class="radio col-sm-6 text-center p-b-lg">
                                           <label class="h4">
                                             <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
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
                                                    
                                                    <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="重置中..."><strong>重置</strong></button>
                                                    
                                                    <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="添加中..."><strong>添加</strong></button>
                                                       
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
          <h3 class="m-t-none">添加收藏夹</h3>
          <small>您可以在此添加收藏夹。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              		<form id="addFavoriteForm" class="form-horizontal" method="post" action="favorite_save.action">
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">收藏夹名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" name="favorite.name" class="form-control" datatype="s5-16" errormsg="名称至少5个字符,最多16个字符！" />
                                     <div class="Validform_checktip">此项为必填，不能使用特殊符号。</div>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">收藏夹别名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" name="favorite.alias" datatype="s5-16" errormsg="别名至少5个字符,最多16个字符！" class="form-control" />
                                     <div class="Validform_checktip">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</div>
                                     </div>
                                   	<input type="hidden" name="favorite.parentId" value="0" />
                                    </div>
                     </form>
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-3 control-label">上传缩略图</label>
                                                  <div class="col-sm-9">

                                                    <!-- <div class="dropfile visible-lg col-sm-12 no-padder">
			                                            <small>请将缩略图拖拽至此</small> -->
														<center>
															<form id="form2" method="post" action="upload.action" enctype="multipart/form-data">
																<table width="400" border="1" cellspacing="1"
																	cellpadding="10">
																	<tr>
																		<td height="25">浏览图片：</td>
																		<td>
																			<input id="fileupload" name="fileupload" type="file" />
																			<div id="tipDiv"><font id="tipFont" color='red'>123456</font></div>
																		</td>
																	</tr>
																	<tr>
																		<td colspan="2" align="center">
																			<input type="button" onclick="uploadImage()" value="上传" />
																		</td>
																	</tr>
																</table>
															</form>
															<br/> <span>图片预览</span>
															<div id="showImage"></div>
														</center>
													<!-- </div> -->
                                                  </div>
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                
                                                <button type="button" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..."><strong>取消</strong></button>
                                                
                                                <button id="saveFavoriteButton" type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存</strong></button>
                                                   
                                                </div>
                                              
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  
  <div class="modal fade" id="modal-edit-first-fav" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">编辑收藏夹</h3>
          <small>您可以在此编辑收藏夹名字和缩略图。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              <form class="form-horizontal" method="get">
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">收藏夹名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，不能使用特殊符号。</span>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">收藏夹别名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</span>
                                     </div>
                                    </div>
                                        
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-3 control-label">上传缩略图</label>
                                                  <div class="col-sm-9">
                                                  <div class=" col-sm-4 no-padder">
                                                      <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/t4.jpg" class="img-circle uploadedthumb">
                                                  </div>
                                                    <div class="dropfile visible-lg col-sm-8 no-padder">
                                                      <small>请将缩略图拖拽至此</small>
                                                    </div>
                                                  </div>
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                
                                                <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="删除..."><strong>删除</strong></button>
                                                
                                                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存</strong></button>
                                                   
                                                </div>
                                              </form>
                              </div>
              
            </div>          
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div>
  <div class="modal fade" id="modal-edit-second-fav" style="display: none;" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 class="m-t-none">编辑子收藏夹</h3>
          <small>您可以在此编辑子收藏夹名字和缩略图。</small>
        </div>
          <div class="modal-body wrapper-lg">
            <div class="row">
              <div class="col-sm-12">
              <form class="form-horizontal" method="get">
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">子收藏夹名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="text" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，不能使用特殊符号。</span>
                                     </div>
                                     </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                     <div class="form-group">
                                     <label class="col-sm-3 control-label">子收藏夹别名<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请使用英文字母，大小写不限，不能使用特殊符号和空格。</span>
                                     </div>
                                    </div>
                                        
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="form-group">
                                                  <label class="col-sm-3 control-label">上传缩略图</label>
                                                  <div class="col-sm-9">
                                                  <div class=" col-sm-4 no-padder">
                                                      <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/t4.jpg" class="img-circle uploadedthumb">
                                                  </div>
                                                    <div class="dropfile visible-lg col-sm-8 no-padder">
                                                      <small>请将缩略图拖拽至此</small>
                                                    </div>
                                                  </div>
                                                </div>
                                                
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                                                <div class="checkbox m-t-lg">
                                                
                                                <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="删除中..."><strong>删除</strong></button>
                                                
                                                <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存</strong></button>
                                                   
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