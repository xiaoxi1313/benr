<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%@page import="com.newvery.utils.TimeUtil"%>
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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.min.css" type="text/css"> 
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/multi-select.css" type="text/css" />

  <!--[if lt IE 9]>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/html5shiv.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/respond.min.js"></script>
    <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/ie/excanvas.js"></script>
  <![endif]-->  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.multi-select.js"></script>
  <!-- Bootstrap -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/bootstrap.js"></script>
  <!-- App -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.js"></script>  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
    <!-- Sparkline Chart -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>

  
  <script type="text/javascript">
$(document).ready(function(){
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
    
    $('#keep-order').multiSelect({ keepOrder: true });
    $('#select-all').click(function(){
      $('#keep-order').multiSelect('select_all');
      return false;
    });
    $('#deselect-all').click(function(){
      $('#keep-order').multiSelect('deselect_all');
      return false;
    });
    
    $('#keep-order-1').multiSelect({ keepOrder: true });
    $('#select-all-1').click(function(){
      $('#keep-order-1').multiSelect('select_all');
      return false;
    });
    $('#deselect-all-1').click(function(){
      $('#keep-order-1').multiSelect('deselect_all');
      return false;
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
    
    var $container = $('#container2').isotope({
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
        
        //showFavoriteParent();
});


// 显示收藏夹一级列表
function showFavoriteParent(year,id) {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'favorite_getParentFavoriteList.action',
		date : 'year=' + year,
		success : function(d) {
			$('#favoriteParent_'+id).empty();
			var option = "<option value='-1'>请选择</option>";
			$.each(d.favoriteList, function(i, item){
				option +=  "<option value='"+item.id+"'>"+item.name+"</option>";
				//option += "<li class=\"\"><a href=\"javacription:void(0)\" onclick=\"showFavoriteChildren('"+ item.id +"')\"><input name=\"parentFavorite.id\" class=\"parentFavorite\" type=\"radio\" value=\"" + item.id + "\" name=\"parentCategory\">" + item.name +"</a></li>";
			});
			
			$('#favoriteParent_'+id).append(option);
		},
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 显示收藏夹二级列表
function showFavoriteChildren(parentId) {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getFavoriteListByParentId.action?parentFavoriteId=' + parentId,
		success : function(d) {
			$('#childFavoriteList').empty();
			var option ="";
			
			$.each(d.favoriteList, function(i, item){
				option += "<li class=\"\"><a href=\"#\"><input type=\"radio\" value=\"" + item.id + "\" name=\"childFavorite.id\">" + item.name +"</a></li>";
			});
			
			if (parentId == '' || parentId == undefined) {
				option += "<li class=\"active\"><a href=\"#\"><input value=\"-1\" type=\"radio\" name=\"d-s-r\" checked=\"checked\">无子分类</a></li>";
			}
			$('#childFavoriteList').append(option);
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

function chart() {
	$('#showResult').val(true);
	$('#chartForm').submit();
}

function tagClick(tagId) {
	$('#showResult').val(true);
	$('#tagId').val(tagId);
	$('#chartForm').submit();
}

function articleDetail(articleId) {
	location.href = "article_show.action?article.id=" + articleId;
}
</script>
</head>
<body class="" >
  <%@include file="../head.jsp" %>
        <section id="content">

          <section class="vbox">

            <section class="scrollable padder">

              <div class="m-b-md">

                <div class="row">

                  <div class="col-sm-6">

                    <h3 class="m-b-none">热点分布</h3>

                    <small>您可以在这里查看您所指定的标签的热点分布</small>

                  </div>

                </div>

              </div>

              

              <section class="col-md-9 row">

              <section class="panel panel-default">

                  <header class="panel-heading">热点分布检索工具</header>

                  <div class="panel-body">
                  
                  <div class="row wrapper selectrow p-t-none">
                   <div class="m-b-xs prename">
                   <span class="selectname longname">分析数据来源</span>
                   
                   <div class="btn-group m-r">
                  <div class="radio">
                    <label>
                      <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                      指定特定文件夹作为数据分析来源
                    </label>
                  </div>
                  <div class="radio">
                    <label>
                      <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                      指定整个数据库中时间段内的资讯作为数据分析来源
                    </label>
                  </div>
                  </div>
                  </div>
                  </div>

                  <div id="selectfolder" class="row wrapper selectrow">
                   <div class="m-b-xs prename">
                   <span class="selectname longname">选择文件夹</span>
                   <table>
                   <tbody>
                   <tr>
                   <th>
                   <div class="btn-group m-r year">
                   <select class="chosen-select" id = "year_1">
                        <%
                       	int year = TimeUtil.getYear(new Date());
                       	for(int y = year; y > year - 5; y--) {
                       	%>
                           <option value='<%=y%>' onclick="showFavoriteParent(<%=y%>,1);"><%=y%></option>
                           <%
                       	}
                           %>
                   </select>
                   </div>
                   </th>
                   <th>
                   <div class="btn-group m-r">
                   <select  class="chosen-select" id = "favoriteParen_1">
                           <option value='-1'>请选择</option>
                   </select>
                   </div>
                   </th>
                   <th>

                   <div class="btn-group m-r">
                   <p>
                   <a href='#' id='select-all' class="btn btn-sm btn-default m-r-sm">全选</a>
                   <a href='#' id='deselect-all' class="btn btn-sm btn-default">取消全选</a>
                  </p>
                   <select id='keep-order' multiple='multiple'>
                     <option value='elem_1' selected>子文件夹 1</option>
                     <option value='elem_2'>子文件夹 2</option>
                     <option value='elem_3'>子文件夹 3</option>
                     <option value='elem_4'>子文件夹 4</option>
                     <option value='elem_5'>子文件夹 5</option>
                     <option value='elem_6'>子文件夹 6</option>
                     <option value='elem_7'>子文件夹 7</option>
                   </select>
                   </div>
                   </th>
                   
                   <th>
                   <button href="#" class="btn btn-sm btn-default plus-btn">
                       <i class="fa fa-plus text"></i></button>
                   </th>
                   
                    </tr>
                   </tbody>
                   </table>

                   </div>

                   </div>
                  
                  <div id="selectfolder-1" class="row wrapper selectrow">
                   <div class="m-b-xs prename">
                   <span class="selectname longname">选择文件夹</span>
                   
                   <table>
                   <tbody>
                   <tr>
                   <th>
                   <div class="btn-group m-r year">
                   <select class="chosen-select" id="year_2">
                        <%
                       	int year = TimeUtil.getYear(new Date());
                       	for(int y = year; y > year - 5; y--) {
                       	%>
                            <option ><%=y%></option>
                           <%
                       	}
                           %>
                   </select>
                   </div>
                   </th>
                  
                   <th>
                   <div class="btn-group m-r">
                   <select  class="chosen-select">
                           <option >文件夹A</option>
                           <option >文件夹B</option>
                           <option >文件夹C</option>
                           <option >文件夹D</option>
                           <option >文件夹E</option>
                           <option >文件夹F</option>
                   </select>
                   </div>
                   
                   </th>
                  
                   <th>
                   <div class="btn-group m-r">
                   <p>
                   <a href='#' id='select-all-1' class="btn btn-sm btn-default m-r-sm">全选</a>
                   <a href='#' id='deselect-all-1' class="btn btn-sm btn-default">取消全选</a>
                  </p>
                   <select id='keep-order-1' multiple='multiple'>
                     <option value='elem_1' selected>子文件夹 1</option>
                     <option value='elem_2'>子文件夹 2</option>
                     <option value='elem_3'>子文件夹 3</option>
                     <option value='elem_4'>子文件夹 4</option>
                     <option value='elem_5'>子文件夹 5</option>
                     <option value='elem_6'>子文件夹 6</option>
                     <option value='elem_7'>子文件夹 7</option>
                   </select>
                   </div>
                   
                   </th>
                   
                   <th>
                   <button href="#" class="btn btn-sm btn-default del-btn">
                       <i class="fa fa-trash-o text"></i></button>
                   </th>
                   
                    </tr>
                   </tbody>
                   </table>
                   </div>
                   </div>
                   

                  

                  <div id="selecttime" class="row wrapper selectrow">

                   <div class="m-b-xs prename">

                   <span class="selectname longname">选择时间段</span>

                   <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">

                    <input class="form-control" size="16" type="text" value="" readonly="">

                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>

                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>

                    </div>

                   <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">

                    <input class="form-control" size="16" type="text" value="" readonly="">

                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>

                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>

                    </div>

                   </div>

                   </div>

                  

                  <div class="row wrapper selectrow b-b" style="padding-bottom: 10px;">

                   <div class="m-b-xs prename">

                   <span class="selectname longname">标签分类</span>



                   <div class="btn-group m-r">

                   <select class="chosen-select">
                           <option >请选择</option>
                           <option >领域标签</option>
                           <option >行业标签</option>
                           <option >企业标签</option>
                           <option >内容标签</option>
                           <option >产品标签</option>
                   </select>

                   </div>                 

                   </div>

                   </div>



                  <div class="row wrapper selectrow search-btn">

                  <a href="#" class="btn btn-s-md btn-primary">开始计算</a>

                  <a href="#" class="btn btn-s-md btn-primary">重置</a>

                  </div>



                  </div>

                  </section>

                  <section class="panel panel-default list-show">
                  <header class="panel-heading">
                  分析结果             
                  </header>
                  <div class="row wrapper">
                  <div class="col-sm-3 m-b-xs"></div>
                  <div class="col-sm-6 text-center m-b-xs"></div>
                                    <div class="col-sm-3">
                                      <div class="input-group">
                                        <input type="text" class="input-sm form-control" placeholder="搜索标签名">
                                        <span class="input-group-btn">
                                          <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                                        </span>
                                      </div>
                                    </div>
                                  </div>
                                  
                                  <div class="table-responsive">
                                    <table class="table table-striped b-t b-light">
                                      <thead>
                                        <tr>
                                          <th>标签名</th>
                                          <th class="th-sortable" data-toggle="class">出现数量
                                          <span class="th-sort">
                                            <i class="fa fa-sort-down text"></i>
                                            <i class="fa fa-sort-up text-active"></i>
                                            <i class="fa fa-sort"></i>
                                          </span>
                                          </th>
                                          <th>查看文章</th>
                                        </tr>
                                      </thead>
                                      <tbody>
                                        <tr>
                                          <td>小家电</td>
                                          <td>26</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>24</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>22</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>21</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>19</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>17</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>14</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>13</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>12</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                        <tr>
                                          <td>小家电</td>
                                          <td>7</td>
                                          <td><a href="#modal-checkpost" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a></td>
                                        </tr>
                                      </tbody>
                                    </table>
                                  </div>
                                  <footer class="panel-footer">
                                    <div class="row">
                                      <div class="col-sm-4 hidden-xs">
                                                          
                                      </div>
                                      <div class="col-sm-4 text-center">
                                        <small class="text-muted inline m-t-sm m-b-sm">共50个条目，正在显示第1-10个</small>
                                      </div>
                                      <div class="col-sm-4 text-right text-center-xs">                
                                        <ul class="pagination pagination-sm m-t-none m-b-none">
                                          <li><a href="#"><i class="fa fa-chevron-left"></i></a></li>
                                          <li><a href="#">1</a></li>
                                          <li><a href="#">2</a></li>
                                          <li><a href="#">3</a></li>
                                          <li><a href="#">4</a></li>
                                          <li><a href="#">5</a></li>
                                          <li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
                                        </ul>
                                      </div>
                                    </div>
                                  </footer>
                     </section>

              </section>        

<section class="scrollable col-md-3 siderbar">

<ul class="list-group gutter list-group-lg list-group-sp sortable m-b-none">  

 <li class="list-group-item col-md-12 sortable p-t-none savepanel" draggable="true">

 <div class="panel panel-default portlet-item m-b-none">

 <header class="panel-heading">

 <ul class="nav nav-pills pull-right">

 <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>

 </ul>

 保存                    

 </header>

 <div class="panel-body">

 <a href="#modal-saveresult" data-toggle="modal" class="btn btn-success">保存</a>

 <a href="#" class="btn btn-success">导出</a>

 </div></div>

 </li> 

                        

 <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">

 <div class="panel panel-default portlet-item m-b-none">

 <header class="panel-heading">

 <ul class="nav nav-pills pull-right">

 <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>

 </ul>

 已保存的分析结果                    

 </header>



   <div class="panel-body project t-t" style="padding: 15px 0;">
   
   <table style="width: 100%;">
   			<thead>
   				<tr>
   					<th class="p-l-md">

   <div class="pull-right media-xs text-center text-muted">

   <strong class="h4">2014</strong><br>

   <small class="label bg-light">11月26日</small>

   </div>

   <a href="#" class="h5 text-success">oppo信息情报分析03</a>



   </div>
   </th>
<th width="30" style="text-align: center;"><a href="javascript:void(0)" onclick="deleteQuery(1)" class="iconbtn"><i class="fa fa-trash-o"></i></a></th>
</tr>
</thead>
</table>

   </div>



   <div class="panel-body project t-t" style="padding: 15px 0;">
   
   <table style="width: 100%;">
   			<thead>
   				<tr>
   					<th class="p-l-md">
   <div class="pull-right media-xs text-center text-muted">
   <strong class="h4">2014</strong><br>
   <small class="label bg-light">11月26日</small>
   </div>
   <a href="#" class="h5 text-success">oppo信息情报分析03</a>

   </div>
   </th>
<th width="30" style="text-align: center;"><a href="javascript:void(0)" onclick="deleteQuery(1)" class="iconbtn"><i class="fa fa-trash-o"></i></a></th>
</tr>
</thead>
</table>
   </div>
   
      <div class="panel-body project t-t" style="padding: 15px 0;">
      
      <table style="width: 100%;">
      			<thead>
      				<tr>
      					<th class="p-l-md">
      <div class="pull-right media-xs text-center text-muted">
      <strong class="h4">2014</strong><br>
      <small class="label bg-light">11月26日</small>
      </div>
      <a href="#" class="h5 text-success">oppo信息情报分析03</a>

      </div>
      </th>
   <th width="30" style="text-align: center;"><a href="javascript:void(0)" onclick="deleteQuery(1)" class="iconbtn"><i class="fa fa-trash-o"></i></a></th>
   </tr>
   </thead>
   </table>
      </div>



                                         

 </div>

 </li>

 </ul>    

 </section> 



            </section>

          </section>

          <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>

        </section>

      </section>

    </section>

  </section>

    <div class="modal fade" id="modal-checkpost" style="display: none;" aria-hidden="true">
        <div class="modal-dialog" style="min-width: 800px;">
          <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3 class="m-t-none">查看含该标签的资讯列表</h3>
            <small>您可以在此查看使用了该标签的资讯列表。</small>
          </div>
            <div class="modal-body no-padder">
             <div class="row wrapper">
             <div class="col-sm-3 m-b-xs"></div>
                               <div class="col-sm-6 text-center m-b-xs">
                               </div>
                               <div class="col-sm-3">
                                 <div class="input-group">
                                   <input type="text" class="input-sm form-control" placeholder="搜索">
                                   <span class="input-group-btn">
                                     <button class="btn btn-sm btn-default" type="button"><i class="fa fa-search"></i></button>
                                   </span>
                                 </div>
                               </div>
                             </div>
                             <div class="table-responsive  panel m-b-none">
                               <table class="table table-striped b-t b-light">
                                 <thead>
                                   <tr>
                                     <th>标题</th>
                                     <th class="th-sortable" data-toggle="class">时间
                                     <span class="th-sort">
                                       <i class="fa fa-sort-down text"></i>
                                       <i class="fa fa-sort-up text-active"></i>
                                       <i class="fa fa-sort"></i>
                                     </span>
                                     </th>
                                     <th class="th-sortable" data-toggle="class">一级类别
                                     <span class="th-sort">
                                       <i class="fa fa-sort-down text"></i>
                                       <i class="fa fa-sort-up text-active"></i>
                                       <i class="fa fa-sort"></i>
                                     </span>
                                     </th>
                                     <th class="th-sortable" data-toggle="class">二级类别
                                     <span class="th-sort">
                                       <i class="fa fa-sort-down text"></i>
                                       <i class="fa fa-sort-up text-active"></i>
                                       <i class="fa fa-sort"></i>
                                     </span>
                                     </th>
                                   </tr>
                                 </thead>
                                 <tbody>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                   <tr>
                                     <td><a class="row-title" href="#">标题标题标题</a></td>
                                     <td>2014-10-20</td>
                                     <td>小家电</td>
                                     <td>吸尘器</td>
                                   </tr>
                                 </tbody>
                                 
                               </table>
                               <footer class="panel-footer">
                                                                   <div class="row">
                                                                     <div class="col-sm-4 hidden-xs">
                                                                                        
                                                                     </div>
                                                                     <div class="col-sm-4 text-center">
                                                                       <small class="text-muted inline m-t-sm m-b-sm">共50个条目，正在显示第1-10个</small>
                                                                     </div>
                                                                     <div class="col-sm-4 text-right text-center-xs">                
                                                                       <ul class="pagination pagination-sm m-t-none m-b-none">
                                                                         <li><a href="#"><i class="fa fa-chevron-left"></i></a></li>
                                                                         <li><a href="#">1</a></li>
                                                                         <li><a href="#">2</a></li>
                                                                         <li><a href="#">3</a></li>
                                                                         <li><a href="#">4</a></li>
                                                                         <li><a href="#">5</a></li>
                                                                         <li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
                                                                       </ul>
                                                                     </div>
                                                                   </div>
                                                                 </footer>
                             </div>     
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div>
      
     <div class="modal fade" id="modal-saveresult" style="display: none;" aria-hidden="true">
         <div class="modal-dialog">
           <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
             <h3 class="m-t-none">保存当前数据分析结果</h3>
             <small>您可以在此保存刚才分析的结果。</small>
           </div>
             <div class="modal-body wrapper-lg">
               <div class="row">
                 <div class="col-sm-12">
                   <form class="form-horizontal" method="get">
                                          <div class="form-group">
                                          <label class="col-sm-2 control-label tagselectname">分析结果名</label>
                                          <div class="col-sm-9">
                                          <input type="text" class="form-control">
                                          <span class="help-block m-b-none">此项为必填，分析结果名不能和已有的重复，大小写不限，不能使用特殊符号。</span>
                                          </div>
                                          </div>
                                          <div class="line line-dashed b-b line-lg pull-in"></div>
                  <div class="checkbox m-t-lg">
                  <button type="submit" class="btn btn-sm btn-danger pull-right text-uc m-t-n-xs m-l-md" ><strong>取消</strong></button>
                  <button type="submit" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" ><strong>保存</strong></button>
                     
                  </div>
                  </form>
                  
                 </div>
                 
               </div>          
             </div>
           </div><!-- /.modal-content -->
         </div><!-- /.modal-dialog -->
       </div>
  

  <script type="text/javascript">

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
    
    $('#keep-order').multiSelect({ keepOrder: true });
    $('#select-all').click(function(){
      $('#keep-order').multiSelect('select_all');
      return false;
    });
    $('#deselect-all').click(function(){
      $('#keep-order').multiSelect('deselect_all');
      return false;
    });
    
    $('#keep-order-1').multiSelect({ keepOrder: true });
    $('#select-all-1').click(function(){
      $('#keep-order-1').multiSelect('select_all');
      return false;
    });
    $('#deselect-all-1').click(function(){
      $('#keep-order-1').multiSelect('deselect_all');
      return false;
    });
    

  </script>
  
</body>
</html>