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
     <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js" charset="UTF-8"></script>
    <!-- Bootstrap -->
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js" charset="UTF-8"></script>
    <!-- App -->
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
    <!--[if lt IE 9]>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/html5shiv.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/respond.min.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/excanvas.js"></script>
  <![endif]-->
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/markdown/epiceditor.min.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.js"></script>
	<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/demo.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/file-input/bootstrap-filestyle.min.js"></script>

    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
    
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.css" type="text/css" />
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/spinner/jquery.bootstrap-touchspin.min.js"></script>
    <script>
    $(document).ready(function(){
    	$('#thumbnailFileUpload').preimage();
    	
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
          
          
        $(".chosen").chosen();
      	
      	$('#pdfAddForm').ajaxForm({
      		dataType:'json',
      		beforeSend:function(){
      		},
      		success:function(d) {
      			//$('#loadingdiv').hide();
      			if(d.errorCode==0){
      				alert("添加成功！");
      				location.reload();
      			}else{
      				alert(d.errorMessage);
      			}
      		},
      		error:function(d) {
      			alert('error');
      		}
      	});
      	
      	
      	//删除操作
      	$(".btndelete").click(function(){
      		if(confirm('确定删除指定文件')) {
      			$.getJSON('pdf_delete.action?pid='+$(this).attr('pid'),function(d){
      				if(d.errorCode==0){
          				alert("操作成功！");
          				location.reload();
          			}else{
          				alert(d.errorMessage);
          			}
      			})
      		}
      	})
      	
    });

function batchOperate(){
	if($("input[name='pid']:checked").length == 0) {
		alert("请选择需要操作的记录");
		return false;
	}
	
	var param = '';
	$("input[name='pid']:checked").each(function(){
		param += "&pid="+$(this).val();
	})
	
	$.getJSON('pdf_delete.action?'+param,function(d){
		if(d.errorCode==0){
  				alert("操作成功！");
  				location.reload();
  			}else{
  				alert(d.errorMessage);
  			}
	})
}
    
    
// 添加PDF文件
function addPdf() {
	if ($('#pdfFileTitle').val() == "") {
		alert("请输入标题！");
		return false;
	}
	if ($('#createTime').val() == "") {
		alert("请输入上传日期！");
		return false;
	}

	var oFile = document.getElementById('thumbnailFileUpload');
    if(oFile.value == ""){
    	alert("请上传缩略图！");
    	return false;
    }
    
    if($('#pdfFileUpload').val() == ""){
    	alert("请上传PDF文件！");
    	return false;
    }
    if($('#pdffiletype').val() == '-1') {
    	alert("请选择分类！");
    	return false;
    }
    
	$('#pdfAddForm').submit();
}
    </script>
</head>

<body class="">
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
                                                    <div class="col-sm-12">
                                                        <h3 class="m-b-xs text-black">上传</h3>
                                                        <small>您可以在此上传显示在客户版创新趋势和创新情报中的PDF文档。</small>
                                                    </div>
                                                </div>
                                            </section>

											<form id="pdfAddForm" method="post" action="pdf_add.action" enctype ="multipart/form-data">
                                            <section class="col-md-12 row">
                                                <section class="panel panel-default">
                                                    <header class="panel-heading">上传文件</header>
                                                    <div class="panel-body">
													
                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname midname">标题</span>

                                                                <div class="btn-group m-r titleinput">
                                                                    <input type="text" id="pdfFileTitle" name="pdfFile.title" class="form-control">
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname midname">上传日期</span>
                                                                <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                                                                    <input class="form-control" id="createTime" name="pdfFile.createTime" size="16" type="text" value="" readonly>
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        
                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname midname">分类</span>
                                                       				<select name="pdfFile.type" class="chosen" id="pdffiletype">
                                                       					<option value="-1">请选择</option>
                                                       					<option value="1">创新趋势</option>
                                                       					<option value="2">创新情报</option>
                                                       				</select>
                                                           </div>
                                                       </div>
                                                       
                                                       <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname midname">指定群组</span>
                                                       				<select name="pdfFile.userGroup.id" class="chosen">
                                                       					<s:iterator value="userGroupList">
                                                       					<option value="<s:property value="id"/>"><s:property value="groupName"/></option>
                                                       					</s:iterator>
                                                       				</select>
                                                           </div>
                                                       </div>
														
                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname midname">缩略图</span>
                                                                <div class="m-b-sm">请上传图片比例为4：3的图片，图片宽度不要超过800像素：</div>
                                                                <div class="btn-group m-r titleinput">
                                                                	<img class="pdfthumb" />
                                                                    <input type="file" id="thumbnailFileUpload" name="thumbnailFileUpload" class="filestyle" data-classButton="btn btn-default" data-classInput="form-control inline v-middle input-s">
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="row wrapper selectrow">
                                                            <div class="m-b-xs prename">
                                                                <span class="selectname midname">上传PDF</span>

                                                                <div class="btn-group m-r titleinput">
                                                                    <div class="m-b-sm">选择您要上传的PDF文件：</div>
                                                                    <input type="file" id="pdfFileUpload" name="pdfFileUpload" class="filestyle" data-classButton="btn btn-default" data-classInput="form-control inline v-middle input-s">
                                                                </div>

                                                            </div>
                                                        </div>

								 						<div class="row wrapper selectrow search-btn">
								                  			<a href="javascript:void(0)" onclick="addPdf()" class="btn btn-s-md btn-primary">确定并上传</a>
								                 		</div>
                                                    </div>
                                                </section>
                                            </section>
                                            </form>

                                            <section class="col-md-12 row">

                                                <section class="panel panel-default list-show">
                                                    <header class="panel-heading">
                                                        已上传的文件
                                                        </div>
                                                    </header>
                                                    <div class="row wrapper">
                                                        <div class="col-sm-5 m-b-xs">
                                                            <div class="btn-group">
                                                                <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                                                                    <span class="dropdown-label">批量操作</span> 
                                                                    <span class="caret"></span>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-select">

                                                                    <li class="">
                                                                        <a href="#">
                                                                            <input type="radio" name="d-s-r">删除</a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <button class="btn btn-sm btn-default" onclick="batchOperate();">应用</button>
                                                        </div>
                                                        <div class="col-sm-4 m-b-xs">
                                                        </div>
                                                        <div class="col-sm-3">
                                                            <div class="input-group">
                                                                <input type="text" class="input-sm form-control" placeholder="搜索标题">
                                                                <span class="input-group-btn">
                                          <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                                        </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="table-responsive userpostlist">
                                                        <table class="table table-striped b-t b-light">
                                                            <thead>
                                                                <tr>
                                                                    <th width="20">
                                                                        <label class="checkbox m-l m-t-none m-b-none i-checks">
                                                                            <input type="checkbox"><i></i>
                                                                        </label>
                                                                    </th>
                                                                    <th class="th-sortable" data-toggle="class" style="width:70px;">ID
                                                                        <span class="th-sort">
						                                              <i class="fa fa-sort-down text"></i>
						                                              <i class="fa fa-sort-up text-active"></i>
						                                              <i class="fa fa-sort"></i>
						                                            </span>
                                                                    </th>
                                                                    <th>文件标题</th>
                                                                    <th>指定群组</th>
                                                                    <th class="th-sortable" data-toggle="class">上传时间
                                                                        <span class="th-sort">
                                            <i class="fa fa-sort-down text"></i>
                                            <i class="fa fa-sort-up text-active"></i>
                                            <i class="fa fa-sort"></i>
                                          </span>
                                                                    </th>
                                                                    <th class="th-sortable" data-toggle="class">分类
                                                                        <span class="th-sort">
						                                            <i class="fa fa-sort-down text"></i>
						                                            <i class="fa fa-sort-up text-active"></i>
						                                            <i class="fa fa-sort"></i>
						                                          </span>
                                                                    </th>
                                                                    <th style="width: 70px;">编辑</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            	<s:iterator value="pdfFileList" id="pdfFile" status="s">
                                                            		<tr>
	                                                                    <td>
	                                                                        <label class="checkbox m-l m-t-none m-b-none i-checks">
	                                                                            <input type="checkbox" name="pid" value="<s:property value="id" />"><i></i>
	                                                                        </label>
	                                                                    </td>
	                                                                    <td><s:property value="id" /></td>
	                                                                    <td>
	                                                                    	<a class="row-title" href="<%=UrlHelper.getHomeUrl()%><s:property value='pdf' />" target="_blank"><s:property value="title" /></a>
	                                                                    </td>
	                                                                    <td><s:property value="userGroup.groupName" /></td>
	                                                                    <td><s:date name="#pdfFile.createTime" format="yyyy-MM-dd" /> <span></span>
	                                                                    </td>
	                                                                    <td><s:property value="typeName" /></td>
	
	                                                                    <td>
	                                                                        <div class="btn-group open">
	                                                                            <a href="#" class="iconbtn btndelete" pid="<s:property value="id" />" data-toggle="tooltip" data-placement="top" title="" data-original-title="彻底删除"><i class="fa fa-trash-o"></i></a>
	                                                                        </div>
	                                                                    </td>
	                                                                </tr>
                                                            	</s:iterator>
                                                            </tbody>
                                                        </table>
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