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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.preimage.js"></script> 
  
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
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
</head>
<body class="" >
<%@include file="../head.jsp" %>
        <section id="content">
    <section class="vbox">
        <section class="scrollable padder">              
          <section class="row m-b-md col-md-9">
          <div class="row">
            <div class="col-sm-12">
              <h3 class="m-b-xs text-black">公司帐户信息</h3>
              <small>您可以在此查看此公司帐户的各项信息。</small>
            </div>
            </div>
          </section>
          <section class="col-md-12 row">
          
          <section class="panel panel-default list-show">
          <header class="panel-heading">
          公司帐户信息
          </div>
          </header>
          <div class="row wrapper p-t-none">
          <div class="table-responsive userdays">
            <table class="table table-striped b-b b-light m-b-xs">
              <thead>
                <tr>
                 
                  <th>公司帐户名称</th>
                  <th class="th-sortable" data-toggle="class">创立时间</th>
                  <th>剩余天数</th>
                  <th>公司帐户人数</th>
                  <th>文件夹权限数</th>
                  <th>数据分析权限数</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><s:property value="userGroup.groupName" /></td>
                  <td><s:date name="userGroup.registerDate" format="yyyy-MM-dd"/></td>
                  <td class="days"><span><s:property value="userGroup.vipRemains" /></span>天</td>
                  <td><s:property value="userGroup.members" /></td>
                  <td><s:property value="userGroup.folderTotal" /></td>
                  <td><s:property value="userGroup.categoryTotal" /></td>
                  
                </tr>
                                              
                </tbody>
            </table>
          </div>
          <div class="col-md-12 m-b-xs">
           <h5>您可以通过以下2种形式联系续费事宜：</h5>
           <b>1</b> 在下面的留言板中留言，我们的客服会在24小时内与您取得联系。<br />
          <!-- <b>2</b> 在工作日的上午9点至下午5点，拨打<span class=”phone”>4008-123-123</span><br /> -->
           <b>2</b> 发送邮件至<a href="mailto:ke.wang@originplus.com">ke.wang@originplus.com</a>          
          </div>
          <div class="panel-body p-b-none p-t-none">
          <div class="form-group">
            <h5><b>给系统管理员留言</b></h5>
            <textarea class="form-control" rows="6" data-minwords="6" data-required="true" placeholder="请输入..."></textarea>
          </div>
          <div class="text-right">
          <a type="submit" class="btn btn-success btn-s-xs">提交</a>
          </div>
          </div>
          
          </div>
                          
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