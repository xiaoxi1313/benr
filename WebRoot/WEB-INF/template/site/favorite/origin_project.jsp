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

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>  
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  
<script type="text/javascript">
// 网格方式显示
function changeGrid(parentId, childId) {
	location.href = "?showType=2&parentFavorite.id=" + parentId + "&childFavorite.id=" + childId + "<%=request.getParameter("userId") != null ?"&userId="+request.getParameter("userId"):""%>" + "&menuUrl=<%=request.getParameter("menuUrl") != null ? request.getParameter("menuUrl"):""%>";
}
</script>
</head>
<body class="" >
  <%@include file="../head.jsp" %>
        <section id="content">
        <%
        //查看某个用户成员文件夹
        if("member".equals(request.getParameter("st"))) {
        %>
        <section class="panel-default"><header class="panel-heading">
	        切换组员
	        <div class="btn-group m-l">
	        <select class="chosen-selec2t" onchange="location.href='favorite_benrFavorite.action?menuUrl=favorite_myFavoriteList&st=member&memberId=' + this.value">
	        	<option value="0">请选择</option>
	        	<s:iterator value="memberList">
	            <option value="<s:property value="id"/>"><s:property value="realName"/></option>
	            </s:iterator>
	        </select>
	        </div>
	        </header>
        </section>
        <%} %>
          <section class="hbox stretch">
          
                        <aside class="aside-xs bg-success lt" id="subNavyear">
                            <section class="vbox animated fadeInLeft">
                                <section class="scrollable">
                                    <div class="list-group auto list-group-alt no-radius no-borders">
                                        <ul class="nav">
                                        	<s:iterator value="userFavoriteYears" id="syear">
                                        		<li class="list-group-item no-padder <s:if test="#syear == year">active</s:if>">
                                        			<a href="?showType=2&year=<s:property value="#syear"/><%=request.getParameter("userId") != null ?"&userId="+request.getParameter("userId"):""%>&menuUrl=<%=request.getParameter("menuUrl") != null ? request.getParameter("menuUrl"):""%>"><span class="subfavbtn"><s:property value="#syear"/></span></a>
                                        		</li>
                                        	</s:iterator>
                                        </ul>
                                    </div>
                                </section>
                            </section>
                        </aside>

                        <aside class="aside-md bg-light lt b-r" id="subNav">
                            
                            <section class="vbox">
                                <section class="scrollable">

                                    <div class="panel-group" id="accordion">
                                    	<s:iterator value="favoriteList" id="favorite" status="s">
                                    		<div class="panel-default b-b">
	                                            <div class="folderlist active">
	                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#<s:property value='id'/>">
	                                                    <div class="panel-heading">
	                                                        <s:property value='name'/>
	                                                    </div>
	                                                </a>
	
	                                            </div>
	                                            <div id="<s:property value='id'/>" class="panel-collapse in b-t">
	                                                <div class="panel-body no-padder text-sm subfolder">
	                                                    <ul class="nav">
	                                                    	<s:iterator value="children" id="inner" status="l">
	                                                    		<li class="b-b "><a href="?parentFavorite.id=<s:property value='parentId' />&childFavorite.id=<s:property value= 'id'/>&showType=1<%=request.getParameter("userId") != null ?"&userId="+request.getParameter("userId"):""%>&menuUrl=<%=request.getParameter("menuUrl") != null ? request.getParameter("menuUrl"):""%>"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><s:property value="name" /></a>
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

              <section class="panel-default userfav"> 

               <section class="hbox stretch">
                           <section>
                             <section class="vbox">
                               <section class="scrollable padder p-r-none">              
                                 <section class="row m-b-md col-md-12">
                                 <div class="row">
                                   <div class="col-sm-6">
                                     <h3 class="m-b-xs text-black">子文件夹-<s:property value="childFavorite.name" /></h3>
                                   </div>
                                   </div>
                                 </section>
                                 <section class="col-md-12 row p-r-none">
                                 
                                 <!--<section class="panel panel-default">
                                 <header class="panel-heading">资讯筛选</header>
                                 <div class="panel-body">
                                 <div class="row wrapper selectrow">
                                 <div class="m-b-xs prename">
                                 <span class="selectname">关键词</span>
                                 <div class="btn-group m-r titleinput">
                                 <input type="text" class="form-control">
                                 </div>
                                 </div>
               
                                 <div class="row wrapper selectrow search-btn">
                                 <a href="#" class="btn btn-s-md btn-primary">开始搜索</a>
                                 <a href="#" class="btn btn-s-md btn-primary">重置</a>
                                 </div>
               
                                 </div>
                                 </div>
                                 </section>-->
                                 <section class="panel panel-default list-show">
                                 <header class="panel-heading">
                                 信息列表
                                 </header>
                                 <div class="row wrapper">
                                 <div class="col-sm-5 m-b-xs">
                                              
                                 </div>
                                                   <div class="col-sm-4 m-b-xs">
                                                     <div class="btn-group" data-toggle="buttons">
                                                       <label class="btn btn-sm btn-default" onclick="changeGrid(<s:property value='parentFavorite.id' />, <s:property value='childFavorite.id' />)" data-toggle="tooltip" data-placement="top" title="" data-original-title="网格显示">
                                                         <input type="radio" name="options" id="option1">
                                                         	<a href ="#"><i class="i i-grid2"></a></i>
                                                       </label>
                                                       <label class="btn btn-sm btn-default active" data-toggle="tooltip" data-placement="top" title="" data-original-title="列表显示">
                                                         <input type="radio" name="options" id="option2" ><i class="fa fa-list-ul"></i>
                                                       </label>
                                                     </div>
                                                   </div>
                                                   <form method="post" action="favorite_benrFavorite.action?showType=1">
                                                   <div class="col-sm-3">
                                                     <div class="input-group">
                                                       <input type="text" class="input-sm form-control" placeholder="搜索标题" name="article.title" value="<s:property value='article.title' />">
                                                       <span class="input-group-btn">
                                                         <button class="btn btn-sm btn-default" type="submit"><i class="fa fa-search"></i></button>
                                                       </span>
                                                     </div>
                                                   </div>
                                                   </form>
                                                 </div>
                                                 
                                                 <s:iterator value="childFavorite.favoriteGroupList" id="group" status="s">
                                                 	<div class="wapper padder">
		                                                 <section class="panel panel-default">
		                                                 
		                                                 <header class="panel-heading text-center">
		                                                  <i class="fa fa-folder-open m-r-xs"></i><s:property value="name" />
		                                                  </header>
		                                                  
		                                                 <div class="table-responsive">
		                                                   <table class="table table-striped b-light">
		                                                     <thead>
		                                                       <tr>
		                                                         
		                                                         <th>标题</th>
		                                                         <th style="width: 40%;">摘要</th>
		                                                         <th class="th-sortable" data-toggle="class">时间
		                                                         </th>
		                                                         <th class="th-sortable" data-toggle="class">一级类别
		                                                         </th>
		                                                         <th class="th-sortable" data-toggle="class">二级类别
		                                                         </th>
		                                                       </tr>
		                                                     </thead>
		                                                     <tbody>
		                                                     	<s:iterator value="#group.articleList" id="article" status="s">
		                                                     	   <tr>
			                                                         
			                                                         <td><a class="row-title" href="#"><s:property value="title" /></a></td>
			                                                         <td><s:property value="summary" /></td>
			                                                         <td><s:date name="#article.createTime" format="yyyy-MM-dd" /></td>
			                                                         <td><s:property value="parentCategory.name" /></td>
			                                                         <td><s:property value="childCategory.name" /></td>
			
			                                                        
			                                                       </tr>
		                                                     	</s:iterator>
		                                                       
		                                                       </tbody>
		                                                     </table>
		                                                  </div>     
		                                                 </section>
		                                              </div>
                                                 </s:iterator>
                                    </section>
                                 </section>
                                       
                                                                    
                               </section>
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js" charset="UTF-8"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js" charset="UTF-8"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  
<div class="modal fade" id="modal-edituserprofile" style="display: none;" aria-hidden="true">
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
             <form class="form-horizontal" method="get">
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">用户名</label>
                                    <div class="col-sm-9 ">
                                    张小帅
                                    </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                    <label class="col-sm-3 control-label p-t-none">权限</label>
                                    <div class="col-sm-9 ">
                                    高级用户 
                                    <div "userdays">(会员有效期剩余<small class="days"><span>225</span>天)</small></div>
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
                                    <input type="password" name="password" class="form-control">
                                    <span class="help-block m-b-none">此项为必填，请使用英文字母和数字作为密码，密码长度为8~16位之间，大小写不限，不能使用特殊符号。</span>
                                    </div>
                                   </div>
                                   <div class="line line-dashed b-b line-lg pull-in"></div>
                                    <div class="form-group">
                                     <label class="col-sm-3 control-label">重复新密码<span class="redstar"> *</span></label>
                                     <div class="col-sm-9">
                                     <input type="password" name="password" class="form-control">
                                     <span class="help-block m-b-none">此项为必填，请再次输入密码。</span>
                                     </div>
                                    </div>
                                     <div class="line line-dashed b-b line-lg pull-in"></div>
                                       <div class="form-group">
                                       <label class="col-sm-3 control-label">电子邮箱<span class="redstar"> *</span></label>
                                       <div class="col-sm-9">
                                       <input type="text" class="form-control" value="example@example.com">
                                                   <span class="help-block m-b-none">此项为必填。</span>
                                                 </div>
                                               </div>
                                    <div class="line line-dashed b-b line-lg pull-in"></div>

                                    <div class="form-group">
                                                 <label class="col-sm-3 control-label">上传头像</label>
                                                 <div class="col-sm-9">
                                                 <span class="thumb-lg avatar pull-left">
                                                   <img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/a0.png" alt="...">
                                                   <a href="#" class="btn btn-s-md btn-default btn-rounded change-avatar">点击更改头像</a> 
                                                 </span>
                                                 </div>
                                                 
                                                 
                                               </div>
                                               
                                               <div class="line line-dashed b-b line-lg pull-in"></div>
                                               <div class="checkbox m-t-lg">
                                               <button type="submit" class="btn btn-md btn-danger pull-right text-uc m-t-n-xs m-l-md" data-loading-text="取消中..."><strong>取消</strong></button>
                                               <button type="submit" class="btn btn-md btn-success pull-right text-uc m-t-n-xs" data-loading-text="保存中..."><strong>保存修改</strong></button>
                                               </div>
                                             </form>
                             </div>
             
           </div>          
         </div>
       </div><!-- /.modal-content -->
     </div><!-- /.modal-dialog -->
   </div> 

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>  
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  <script>
  $('.form_date').datetimepicker({
      language: 'zh-CN',
      format: 'yyyy-mm-dd',
      weekStart: 1,
      todayBtn: 1,
      autoclose: 1,
      todayHighlight: 1,
      startView: 2,
      minView: 2,
      forceParse: 0
  });
  
      var $container = $('#container').isotope({
          getSortData: {
              posttitlename: '.posttitlename',
              postedtime: '.postedtime'
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