<%@page import="com.newvery.utils.TimeUtil"%>
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
    <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
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
	
});

function getChildrenByParentFavoriteId(obj) {
	$.post("favorite_getFavoriteListByParentId.action?fromShare=1&parentId=" + $(obj).val(),
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$(obj).parent().parent().parent().find("select[c='ccc']").empty();
			
				$("<option value=\"-1\">请选择</option>").appendTo($(obj).parent().parent().find("select[c='ccc']"));
				$.each(data.favoriteList, function(i, item){
					$("<option value=\"" + item.id + "\">" + item.name + "</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
				});
				
				var o = $(obj).parent().parent().parent().find("select[c='ccc']");
				//$(o).show();
				//$(o).parent().find("div").remove();
				$(obj).parent().parent().parent().find("select[c='ccc']").chosen();
				$(obj).parent().parent().parent().find("select[c='ccc']").prop('disabled', false).trigger("chosen:updated");
			}
	}, "json");
}

/**
组合请求参数如： g=1&aid_1=文章id1;文章id2&g=2&aid_2=文章id1;文章id2
后台通过 getParameterValues("g"), 循环g,得到分组id, 然后通过aid_+ 当前的g值， 得到这个分组下的所有文章id, 然后用分号“;”分隔
*/
function upshare() {
	var param = "";
	$(".auserid").each(function(){
		if(this.checked) {
			param += "&userId=" + this.value;
		}
	});
	
	//alert(param);
	$.post("shareFavorite.action?" + param + "&parentFavorite.id=" + $('#apid').val() + "&childFavorite.id="+$('#acid').val(), 
	      function(data){
	     	if(data.errorCode==0){
	     		alert("操作成功！");
	     		$('#modal-add-share-folder').find(".close").click();
	     	} else {
	     		alert(data.errorMessage);
	     	}
     },'json');
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
                                        	int year = TimeUtil.getYear(new Date());
                                        	for(int y = year; y > year - 5; y--) {
                                        	%>
                                            <li class="list-group-item no-padder <%=String.valueOf(y).equals(request.getParameter("year")) ? "active" : ""%>"><a href="usersharefoavorite.action?year=<%=y%>"><span class="subfavbtn"><%=y %></span></a></li>
                                            <%
                                        	}
                                            %>
                                            
                                        </ul>
                                    </div>
                                </section>
                            </section>
                        </aside>

                        <aside class="aside-md bg-light lt b-r" id="subNav">
                            <s:if test="#session.user.groupAdmin">
                            <div class="wrapper b-b header">
                                <button href="#modal-add-share-folder" class="btn btn-success btn-preset notopm" data-toggle="modal"><i class="fa fa-plus text"></i><span class="text"> 添加我的项目到共享</span>
                                </button>
                            </div>
                            </s:if>
                            <section class="vbox">
                                <section class="scrollable">

                                    <div class="panel-group" id="accordion">
                                    	<s:iterator value="favoriteList" id="favorite" status="s">
                                    		<div class="panel-default b-b">
	                                            <div class="folderlist active">
	                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                                                    <div class="panel-heading">
	                                                        <s:property value="name" />
	                                                    </div>
	                                                </a>
	
	                                            </div>
	                                            <div id="collapseOne" class="panel-collapse in b-t">
	                                                <div class="panel-body no-padder text-sm subfolder">
	                                                    <ul class="nav">
	                                                    	<s:iterator value="children" id="inner" status="l">
	                                                    		<li class="b-b active"><a href="usersharefoavorite.action?parentFavorite.id=<s:property value='parentId' />&childFavorite.id=<s:property value='id' />"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><s:property value="#inner.name" /></a>
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
                                <button type="button" href="#modal-delete" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="移出" data-original-title="移出"><i class="fa fa-sign-out"></i>
                                </button>

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
                                                        <div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共10篇资讯</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 text-right text-left-xs no-padder m-b-sm">
                                                        <button type="button" href="#modal-delete" data-toggle="modal" class="btn btn-sm btn-default pull-right m-l-xs" title="移出" data-original-title="移出"><i class="fa fa-sign-out"></i></button>
                                                    </div>
<!--  -->
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
																	
																</header>
	
																<div id="container" class="m-t-sm">
																	<s:iterator value="articleList" id="inner" status="u">
																		<div class="item col-sm-6 col-md-3 post">
																			<section class="panel b-a m-b-sm">
																				<div class="clearfix text-center title-pic">
																					<div class="picframe">
																						<a href="#"> <img src="<s:property value='titleImage' />" class="thumb-o">
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
																					<div class="summary wrapper p-b-sm"><s:property value="summary" /></div>
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
																						<s:iterator value="#article.hot3TagList">
	                                                                                	<a class="label label-info tag"><s:property value="name" /></a>
	                                                                                	</s:iterator>
																					</div>
		
																				</div>
		
																			</section>
		
																		</div>
																	</s:iterator>
																		
																</div>
	
															</section>
														</div>
													</s:iterator>
<!--  -->
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
    
</body>
<div class="modal fade" id="modal-add-share-folder" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header ">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3 class="m-t-none">添加我的项目文件夹至共享</h3>
                    <small>您可以在此添加我的项目中的文件夹作为共享文件夹给群组中的用户查看。</small>
                </div>
                <div class="modal-body wrapper-lg lter">
                    <div class="row ">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">选择共享文件夹<span class="redstar"> *</span></label>
                                 <table>
                                       <tbody>
                                                                        <tr class="m-b-md block">
                                                                            <td>
                                                                                <div class="btn-group m-r">

                                                                                    <select class="chosen-select" id="apid" onchange="getChildrenByParentFavoriteId(this)">
                                                                                        <option>请选择</option>
                                                                                        <s:iterator value="favoriteList">
                                                                                        <option value="<s:property value="id" />"><s:property value="name" /></option>
                                                                                        </s:iterator>
                                                                                    </select>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div class="btn-group m-r">
                                                                                    <select class="chosen-select" c='ccc' id="acid">
                                                                                        <option value="-1">全部子文件夹</option>
                                                                                    </select>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        </tbody>
                                                                        </table>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                                                    <label class="col-sm-3 control-label">选择分享组员<span class="redstar"> *</span></label>
                                                         <div class="col-sm-9">
                                                         	<s:iterator value="userList"> 
                                                               <div class="checkbox i-checks">
                                                                 <label>
                                                                   <input type="checkbox" class="auserid" value="<s:property value="id" />">
                                                                   <i></i>
                                                                  <s:property value="userName" />
                                                                 </label>
                                                               </div>
                                                            </s:iterator>
                                                         </div>
                                                </div>
                                                <div class="line line-dashed b-b line-lg pull-in"></div>
                        <button type="button" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" onclick="upshare()"><strong>确定</strong>
                        </button>

                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    
    
    
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

                        <button type="submit" class="btn btn-md btn-success text-uc" data-loading-text="确定中..."><strong>确定</strong>
                        </button>

                        <button type="submit" class="btn btn-md btn-danger text-uc m-l-sm" data-loading-text="取消中..."><strong>取消</strong>
                        </button>

                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</html>