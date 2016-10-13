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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
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
	function editVisitFlag(uid,floderFlag,chartFlag) {
		$('#fform').find("input[name=userId]").val(uid);
		
		$('#fform').find('input[name=visitFloder]').removeAttr('checked');
		if(floderFlag) {
			$('#fform').find('input[name=visitFloder]').click();
		}
		
		$('#fform').find('input[name=visitChart]').removeAttr('checked');
		if(chartFlag) {
			$('#fform').find('input[name=visitChart]').click();
		}
	}
	
	function updateUserVisit() {
		$.getJSON('usergroup_updateUserVisit.action?'+$('#fform').serialize(),function(d){
			if(d.errorCode == 0) {
				alert("操作成功！");
				$(".modal").find('.close').click();
				location.reload();
			} else {
				alert(d.errorMessage);
			}
		});
	}
	
	$(document).ready(function(){
		$(".flodercount").text($('#vfcount').val());
		$(".chartcount").text($('#vccount').val());
	});
	</script>
</head>
<body class="" >
<%@include file="../head.jsp" %>
        <section id="content">
    <section class="vbox">
        <section class="scrollable wrapper-lg">
            <div class="m-b-md">
                <div class="row">
                    <div class="col-sm-6">
                        <h3 class="m-b-none m-t-none">群组名称 &nbsp;&frasl;&nbsp; 查看全部组员</h3>
                        <small>您可以在这里查找组员并设定该组员的权限。</small>
                    </div>
                    <div class="col-sm-6 text-right">
                    <h5 class="m-b-xs">组内剩余“项目文件夹”功能权限数<span class="redtext flodercount">3</span> / <s:property value="#session.user.userGroup.folderTotal"/></h5>
                    <h5 class="m-t-xs">组内剩余“数据分析”功能权限数<span class="redtext chartcount">3</span> / <s:property value="#session.user.userGroup.categoryTotal"/></h5>
                    </div>
                </div>

            </div>
            <div class="row m-b-lg">
                <div id="filters" class="col-sm-9 button-group" data-filter-group="role">
                    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter="*">全部人员</button>
                    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".aduser">高级组员</button>
                    <button class="btn btn-sm btn-default btn-rounded m-b-xs" data-filter=".user">组员</button>
                </div>
                <div class="col-sm-3 text-right text-left-xs">
                    <div class="btn-group">
                        <button data-toggle="dropdown" class="btn btn-sm btn-rounded btn-default dropdown-toggle">
                            <span class="dropdown-label">按最后登录时间排序</span>
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
                            <li class="sort active" data-sort-by="userlasttimelogin">
                                <a href="#"><input type="radio" name="d-s-r" checked="">按最后登录时间排序</a>
                            </li>
                            <li class="sort" data-sort-by="theusername"><a href="#"><input type="radio" name="d-s-r" >按姓名排序</a>
                            </li>
                            <li class="sort" data-sort-by="isuseronline"><a href="#"><input type="radio" name="d-s-r"
                                                               >按在线与否排序</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            

            <div id="container" class="row m-b usergroup">
                <s:set id="vfcount" value="0"></s:set>
                <s:set id="vccount" value="0"></s:set>
                <s:iterator value="userList" id="user" status="u">
                	<s:if test="role.id == 4"><div class="item col-sm-6 col-md-4 aduser" data-category="role" data-role="aduser"></s:if>
					<s:if test="role.id == 5"><div class="item col-sm-6 col-md-4 user" data-category="role" data-role="aduser"></s:if>

                    <section class="panel b-a">
                        <div class="panel-heading no-border bg-success lter online">
                        <s:if test="#user.groupAdmin == false">
                        <a href="#modal-setrole" class="btn btn-success pull-right" onclick="editVisitFlag(<s:property value="id" />,<s:property value="visitFloder" />,<s:property value="visitChart" />)" data-toggle="modal"><i class="fa fa-anchor"></i> 设置权限</a>
                        </s:if>
                            <div class="h5 text-lt m-t-sm m-b-sm block font-bold isuseronline"><i class="fa fa-check"></i>在线</div>
                        </div>
                        <div class="clearfix text-center m-t m-b-sm">
                            <div class="inline">
                                <div class="thumb-lg">
                                    <s:if test="icon == null || icon==''">
		            					<img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/avatar.jpg"  class="img-circle">
		            				</s:if>
		            				<s:else>
		            					<img src=".<s:property value='icon' />" class="img-circle">
		            				</s:else>
                                </div>
                                <div class="h4 m-t m-b-xs theusername"><s:property value="userName" /></div>
                               
                                <small class="text-muted m-b">
                                <s:if test="#user.groupAdmin == true">
                                	群组管理员
                                </s:if>
                                <s:else>
                                	<s:if test="#user.visitFloder == true || #user.visitChart == true">
                                		高级组员
                                	</s:if>
                                	<s:else>
                                		组员
                                	</s:else>
                                </s:else>
                                </small>
                               
                               
                                <div class="role">
                                	<s:if test="#user.visitFloder == true">
                                	<s:set id="vfcount" value="#vfcount + 1"></s:set>
                
                                	<span class="label bg-info m-l-xs">项目文件夹</span>
                                	</s:if>
                                	<s:if test="#user.visitChart == true">
                                	<s:set id="vccount" value="#vccount + 1"></s:set>
                                	<span class="label bg-info m-l-xs">数据分析</span>
                                	</s:if>
                                	</div>
                                <div class="updatetime">最后登录时间：<span class="userlasttimelogin"><s:date name="lastvisitDate" format="yyyy-MM-dd" /></span></div>
                            </div>
                        </div>
                        <div class="clearfix panel-footer text-center">
                        	<s:if test="#user.groupAdmin == true">
                        		<a href="chart_init.action?menuUrl=chart_init" class="btn btn-success m-r-xs"><i class="i i-statistics"></i> 数据分析结果</a>
                        		<a href="favorite_benrFavorite.action?menuUrl=favorite_myFavoriteList&st=member&showType=2&memberId=<s:property value="#user.id" />" class="btn btn-success"><i class="fa fa-folder-open"></i> 查看文件夹</a>
                        	</s:if>
                        	<s:else>
                        		<s:if test="#user.visitFloder == true">
                        			<a href="favorite_benrFavorite.action?menuUrl=favorite_myFavoriteList&st=member&showType=2&memberId=<s:property value="#user.id" />" class="btn btn-success"><i class="fa fa-folder-open"></i> 查看文件夹</a>
                        		</s:if>
                        		<s:if test="#user.visitChart == true">
                        			<a href="chart_init.action?menuUrl=chart_init" class="btn btn-success m-r-xs"><i class="i i-statistics"></i> 数据分析结果</a>
                        		</s:if>
                        	</s:else>
                        </div>
                    </section>
                </div>
               </s:iterator> 
                <input type="hidden" id="vfcount" value="<s:property value="#vfcount"/>"/>
                <input type="hidden" id="vccount" value="<s:property value="#vccount"/>"/>
            </div>
            <div>
            </div>
        </section>
    </section>

    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>



</section>
</section>
</section>
</section>




<!-- 弹出层 -->
<div class="modal fade" id="modal-setrole" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3 class="m-t-none">设置组员权限</h3>
        <small>您可以在此设置组员是否有使用特殊功能的权利。</small>
      </div>
        <div class="modal-body wrapper-lg">
          <div class="row">
            <div class="col-sm-12">
            <form class="form-horizontal" method="get" id="fform">
            	<input type="hidden" name="userId" />
                                   <div class="form-group">
                                   
                                   <div class="col-sm-12">
                                   <div class="checkbox i-checks">
                                     <label>
                                       <input type="checkbox" name="visitFloder" value="true">
                                       <i></i>
                                       开启<b>“项目文件夹”</b>权限
                                     </label>
                                     <small class="m-b-xs m-l-md">组内剩余“项目文件夹”功能权限数<span class="redtext flodercount">3</span> / <s:property value="#session.user.userGroup.folderTotal"/></small>
                                   </div>
                                   <div class="checkbox i-checks">
                                   <label>
                                     <input type="checkbox" name="visitChart" value="true">
                                     <i></i>
                                     开启<b>“数据分析”</b>权限
                                   </label>
                                   <small class="m-t-xs m-l-md">组内剩余“数据分析”功能权限数<span class="redtext chartcount">3</span> / <s:property value="#session.user.userGroup.categoryTotal"/></small>
                                   </div>
                                   </div>
                                   </div>
                                   
                                 <div class="line line-dashed b-b line-lg pull-in"></div>
                                              <div class="checkbox m-t-lg">
                                              <button type="button" onclick="updateUserVisit()" class="btn btn-md btn-success pull-right text-uc m-t-n-xs"><strong>确定</strong></button>
                                              </div>
                 </form>
                            </div>
            
          </div>          
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div>
  
  
  <script>
    var $container = $('#container').isotope({
        getSortData: {
            theusername: '.theusername',
            isuseronline: '.isuseronline',
            userlasttimelogin: '.userlasttimelogin'
        }
    });


    $(".text-left-xs .dropdown-select li").click(function () {
        var sortData = $(this).data("sort-by");
        $container.isotope({ sortBy: sortData,sortAscending: false})
    })


    $("#filters button").click(function () {
        var fitlerData = $(this).data("filter");
        $container.isotope({
            filter: fitlerData
        });

    })

</script>
</body>

</html>