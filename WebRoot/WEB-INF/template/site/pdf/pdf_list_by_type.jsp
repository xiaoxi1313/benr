<%@page import="com.newvery.Constants"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%@page import="com.newvery.utils.TimeUtil"%>
<!DOCTYPE html>
<html lang="en" class="app topadminhome">
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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
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
  <!-- wysiwyg -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/wysiwyg/demo.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script>
  
  $(document).ready(function(){
	  
	  $('select').each(function(){
			if($(this).attr('val') != undefined && $(this).attr('val') != '0') {
				$(this).val($(this).attr('val'));
			}
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
	  
	 $("#batchDiv").html(''); 
  });
      
function searchByYear(year, type) {
	location.href = "pdf_listByType.action?type=" + type + "&year=" + year+"&menuUrl="+'<%=request.getParameter("menuUrl")%>';
} 
</script>
</head>
<body class="" >
	<%@include file="../head.jsp" %>
  <section id="content">
          <section class="hbox stretch">

              <section class="panel-default userfav">

               <section class="hbox stretch">
                           <section>
                             <section class="vbox">
                               <section class="scrollable padder">              
                                 <section class="row m-b-md col-md-9">
                                 <div class="row">
                                   <div class="col-sm-6">
                                     <h3 class="m-b-xs text-black">
                                     	<s:if test="type == 1">创新趋势</s:if>
                                     	<s:elseif test="type == 2">创新情报</s:elseif>
                                     </h3>
                                     <small>如果您已安装了PDF浏览器，您就可以在此直接查看创新情报。</small>
                                   </div>
                                   </div>
                                 </section>
                                 <section class="col-md-12 row">
                                 
                                 <section class="panel panel-default list-show">
                                 <header class="panel-heading">
                                 	<s:if test="year > 0">
                                 		<s:property value="year"/>年
                                 	</s:if><s:if test="type == 1">创新趋势</s:if><s:elseif test="type == 2">创新情报</s:elseif>下载
                                 </header>

                                <div class="panel-body p-b-none"> 
                                                                    
                                  <div class="col-sm-12 text-right text-left-xs no-padder">
                                 
                                      <div class="btn-group">
                                          <span class="dropdown-label">请选择年份</span>
                                          <select name="year" onchange="searchByYear(this.value, '<s:property value='type' />')" val="<s:property value="year"/>">
                                          	  <%
                                          		Calendar a = Calendar.getInstance();
                                          	  	for (int i=a.get(Calendar.YEAR);i>Constants.START_YEAR-1;i--) {
                                          	  %>
                                          	  		<option class="sort" value="<%=i%>">
                                          	  			<%=i%>
                                          	  		</option>
                                          	  <%
                                          	  	}
                                          	  %>
                                          </select>
                                      </div>
                                  </div>
                                  
                                                                       <div id="container" class="block-fl m-t-sm">
	                                                                       <s:iterator value="pdfFileList" id="pdfFile" status="s">
	                                                                           <div class="item col-sm-6 col-md-3 post">
		                                                                           <section class="panel b-a">
			                                                                           <div class="clearfix text-center title-pic">
			                                                                                <div class="picframe">
			                                                                                    <a href="#"><img src="<%=UrlHelper.getHomeUrl()%><s:property value='thumbnail'/>" class="thumb-o"></a>
			                                                                                    <div class="hover-content">
			                                                                                    <div class="overlay"></div>
			                                                                                    <div class="link-contianer">
			                                                                                    	<a class="row-title" href="<%=UrlHelper.getHomeUrl()%><s:property value='pdf' />" target="_blank">查看文档</a>
			                                                                                    </div>
			                                                                                    </div>
			                                                                                </div>
			                                                                                <div class="infopart">
			                                                                                   <div class="h5 m-t m-b-xs posttitlename"><a href="#"><s:property value="title" /></a></div>
			                                                                                   <div class="text-danger postedtime p-b-sm"><s:date name="#pdfFile.createTime" format="yyyy年MM月dd日" /></div>
			                                                                                  
			                                                                                   </div>
			                                                                                   
			                                                                                 <div class="clearfix panel-footer text-center">
			                                                                                 	
			                                                                                     <a href="<%=UrlHelper.getHomeUrl()%><s:property value='pdf' />" target="_blank" class="btn btn-success m-r-xs"><i class="fa fa-eye"></i> 在线查看</a>
			                                                                                     <a href="viewImg.action?imageUrl=<s:property value='pdf' />" class="btn btn-success"><i class="fa fa-download"></i> 下载</a>
			                                                                                 </div> 
			                                                                           
			                                                                           </div>
			
			                                                                       </section>
		                                                                       </div>
	                                                                       </s:iterator>
                                                                       </div>
                                                                       </div>
                                                 <footer class="panel-footer">
                                                     <pages:pages page="page" params="params"/>
                                                 </footer>
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
</body>
</html>