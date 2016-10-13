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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/multi-select.css" type="text/css" />

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

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.multi-select.js"></script>
  <!-- Sparkline Chart -->
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
<!-- Easy Pie Chart -->
<!-- Flot -->
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.min.js"></script>
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/flot/jquery.flot.pie.min.js"></script>

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/highcharts.js"></script>
  
<script type="text/javascript">
function changePie(obj) {
	if(obj.value > 0) {
		$.getJSON('relationPie.action?tagCategoryId='+obj.value,function(d){
			
			$('#pieChart').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: 0,//null,
		            plotShadow: false
		        },
		        title: {
		            text: null
		        },
		        tooltip: {
		            pointFormat: ' <b>{point.y}</b>'
		        },
		        credits: { enabled: false },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: null,
		            data: d.data
		        }]
		    });
			
			
		});
	}
}

$(document).ready(function(){
	var $container = $('#container').isotope({
	    getSortData: {
	        posttitlename: '.posttitlename',
	        postedtime: '.postedtime'
	    }
	});
	
	$('#selectpie').change();
	
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
	
	var $container = $('#container2').isotope({
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

});

function chart() {
	$('#showResult').val(true);
	$('#chartForm').submit();
}

//删除比较源
function delTr(dom){
	$(dom).parent().parent().remove();
}
function selectsource(obj) {
	var o = $(obj).parent().parent().parent().parent().parent();
	if( obj.value == 1) {
		$(o).find(".selectr1").show();
		$(o).find(".selectr2").hide();
	} else if(obj.value == 2) {
		$(o).find(".selectr2").show();
		$(o).find(".selectr1").hide();
	} else {
		$(o).find(".selectr1").show();
		$(o).find(".selectr2").show();
	}
}
function deleterow(obj) {
  $(obj).parent().parent().remove();
  
  $("input[name='selectidx']").each(function(idx,o){
	  $(this).val(idx);
  })
  return false;
}

function addfloderrown(obj) {
	var targeretobj = $(obj).parent().parent().parent().parent().parent().parent().parent().find(".selectfolder");
	var o = $(targeretobj).clone();
	$(o).removeClass("selectfolder");
	
	$(o).find(".opfolder").html('<a href="javascript:void(0)" onclick="deletefloderrow(this)" class="iconbtn"><i class="fa fa-trash-o"></i></a>');
	$(o).find('select[name="cid"]').removeAttr('id');
	$(o).find('select[name="cid"]').removeAttr('style');
	$(o).find('.ms-container').remove();
	
	var obj = $('<div>').append($(o)).html();
	$(targeretobj).after(obj);
	
	$('input[name="optionsRadios"]:checked').click();
}
function deletefloderrow(obj) {
$(obj).parent().parent().parent().parent().parent().remove();
}

function getChildrenByParentFavoriteId(obj) {
	$.post("favorite_getFavoriteListByParentId.action?parentId=" + $(obj).val(),
		function (data, textStatus) {
			if (data.errorCode == 0) {
				$(obj).parent().parent().parent().find("select[c='ccc']").empty();
			
				$("<option value=\"-1\">请选择</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
				$.each(data.favoriteList, function(i, item){
					$("<option value=\"" + item.id + "\">" + item.name + "</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
				});
				
				var o = $(obj).parent().parent().parent().find("select[c='ccc']");
				$(o).multiSelect('refresh');
			}
	}, "json");
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
                    <h3 class="m-b-none">热点剖析
                    </h3>
                    <small>您可以通过输入标签来分析热点之间的关联</small>
                  </div>
                </div>
              </div>
              
              <section class="col-md-9 row">
              <form id="chartForm" method="post" action="chart_distribution.action">
              <section class="panel panel-default">
                  <header class="panel-heading">走向比较工具</header>
                  <div class="panel-body panel-table p-t-none">
                  
                  
                  
                  <div class="table-responsive selecttable">
                  <table style="width:100%;" class="b-t">
                  <thead>
	                  <tr class="chooselist" id="selectTr">
	                  <th style="padding:15px 0;">
	                  
	                  	<div class="row wrapper selectrow">
		                  <div class="m-b-xs prename">
		                  <span class="selectname longname">标签名</span>
		                  
		                  <div class="btn-group m-r titleinput">
		                  <input type="text" class="form-control" name="tagName">
		                  </div>
		                  
		                  </div>
		                  </div>
	
	                   <div class="m-b-xs prename">
	                   <span class="selectname longname">分析数据来源</span>
	                   
	                   <div class="btn-group m-r">
	                   	  <div class="radio">
		                    <label>
		                      <input type="radio" checked value="0" name="optionsRadio" onclick="selectsource(this)">
		                      全局数据来源
		                    </label>
		                  </div>
		                  <div class="radio">
		                    <label>
		                      <input type="radio" name="optionsRadio" value="1" onclick="selectsource(this)">
		                      指定特定文件夹作为数据分析来源
		                    </label>
		                  </div>
		                  <div class="radio">
		                    <label>
		                      <input type="radio" name="optionsRadio" value="2" onclick="selectsource(this)">
		                      指定整个数据库中时间段内的资讯作为数据分析来源
		                    </label>
		                  </div>
	                  </div>
	                  </div>
	                   
	                   <div class="row wrapper selectrow selectr1 selectfolder">
	                    <div class="m-b-xs prename">
	                    <span class="selectname longname">选择文件夹</span>
	                    
	                    <table class="table-responsive innertable">
		                    <tbody>
		                    <tr>
		                    <th>
		                    <div class="btn-group m-r year">
		                    <select class="chosen-select" name="yid">
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
			          			<select a="aaa" class="chosen-select" name="fid" onchange="getChildrenByParentFavoriteId(this)">
			                     	<option value="-1">请选择</option>
			                        <s:iterator value="favoriteList" id="favorite" status="u">
			                        	<option value="<s:property value='id' />"><s:property value="name" /></option>
			                        </s:iterator> 
			                     </select>
			                    </div>
		                    </th>
		                    <th>
			                    <div class="btn-group m-r">
				                    <p>
					                    <a href='#' s='sss' class="btn btn-sm btn-default m-r-sm">全选</a>
					                    <a href='#' d='ddd' class="btn btn-sm btn-default">取消全选</a>
				                    </p>
				                    <select c="ccc" multiple='multiple' name="cid">
				                    	<option value="-1">请选择</option>
				                    </select>
			                    </div>
		                    </th>
		                    <th class="opfolder">
		                   		<a href="javascript:void(0)" class="btn btn-sm btn-default plus-btn" onclick="addfloderrown(this)">
		                       		<i class="fa fa-plus text"></i>
		                       	</a>
		                   </th>
		                   </tr>
		                  </tbody>
	                    </table>
	                    </div>
	                    </div>
	                   
	                   <div class="row wrapper selectrow selectr2">
		                    <div class="m-b-xs prename">
			                    <span class="selectname longname">选择时间段</span>
			                    <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
			                     	<input class="form-control" size="16" type="text" value="" readonly=""  name="beginDate">
			                     	<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			                    	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
			                     </div>
			                    <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
			                     	<input class="form-control" size="16" type="text" value="" readonly="" name="endDate">
			                     	<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			                    	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
			                    </div>
		                    </div>
	                    </div>
	                   </th>
                   </tr>
                   </thead>
                   </table>
                   </div>
                   
                  

                  <div class="row wrapper selectrow search-btn">
                  <a href="javascript:void(0);" class="btn btn-s-md btn-primary" onclick="chart()">开始计算</a>
                  <a href="#" class="btn btn-s-md btn-primary">重置</a>
                  </div>

                  </div>
                  </section>
                  <input type="hidden" id="tagId" name="tagId" value="<s:property value='tagId' />" />
                  <input type="hidden" id="showResult" name="showResult" value="<s:property value='showResult' />"/>
                  </form>              
                 
                  <section class="panel panel-default">
                      <header class="panel-heading">饼状图分析结果</header>
                        <div class="panel-body">
                        <div class="btn-group m-r">
                        <select id="selectpie" class="chosen-select" onchange="changePie(this)">
                                <s:iterator value="tagCategoryList">
                                <option value="<s:property value="id"/>"><s:property value="name"/></option>
                                </s:iterator>
                        </select>
                        </div>
                        <div class="btn-group pull-right">
                        </div>
                          <div id="pieChart"  style="height:240px"></div>
                        </div>
                  </section>
                      
                  
                  <section class="panel panel-default">
                                  <header class="panel-heading font-bold">分析结果</header>
                                  <section class="hbox stretch">
                                  <aside class="aside-sm bg-success lt b-r" id="taglist">
                                              <div class="wrapper dker header">
                                              范围内所有标签
                                              </div>
                                              <ul class="nav list-group auto list-group-alt no-radius no-borders m-b-none">
                                              	<s:iterator value="chartDistributionList" id="chartDistribution" status="u">
                                              		<li class="list-group-item"><a href="chart_distribution.action?showResult=true&chartDistribution.tagId=<s:property value='tagId' />"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><s:property value="tagName" /><span class="badge bg-danger m-l-sm"><s:property value="num" /></span></a></li>
                                              	</s:iterator>
                                                <!--  <li class="list-group-item active"><a href="#"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i>可穿戴<span class="badge bg-danger m-l-sm">15</span></a></li>
                                                <li class="list-group-item"><a href="#"><i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i>情绪感知<span class="badge bg-danger m-l-sm">18</span></a></li>
                                                 -->
                                              </ul>
                                            </aside> 
                                            
                                    <section class="panel-default favsec">
                                                   
                                                   <section class="col-md-12 favsec no-padder"> 
                                                                  <section class="hbox stretch">
                                                                   <aside class="padder p-b-none">              
                                                   
                                                                        <section class="vbox">
                                                                        <section style="position: relative;">
                                                                         <div class="row wrapper p-r-lg p-b-none clearfix">
                                    <div class="col-sm-12 text-left text-left-xs no-padder"> 
                                    <div class="col-sm-9 no-padder"><h5 class="m-b-xs text-black">使用标签：<s:property value="tag.name" /></h5></div>
                                    <div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共<s:property value="rightArticleList.size()" />篇资讯</small></div>
                                    </div> 
                                    <div class="col-sm-12 text-right text-left-xs no-padder">
                                    
                                        <!-- <div class="btn-group">
                                            <button data-toggle="dropdown" class="btn btn-sm  btn-default dropdown-toggle p-r-lg">
                                                <span class="dropdown-label">按发布时间排序</span>
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
                                                <li class="sort active" data-sort-by="postedtime">
                                                    <a href="#"><input type="radio" name="d-s-r" checked="">按发布时间排序</a>
                                                </li>
                                                <li class="sort" data-sort-by="posttitlename"><a href="#"><input type="radio" name="d-s-r">按资讯名排序</a>
                                                </li>
                                            </ul>
                                        </div> -->
                                    </div>
                                   
                                                                         <div id="container" class="block-fl m-t-sm">
                                                                         
                                                                         <s:iterator value="rightArticleList" id="article" status="u">
                                                                         	<div class="item col-sm-12 col-md-6 post hulianwang" >
	                                                                         <section class="panel b-a">
	                                                                             <div class="clearfix text-center m-b-sm title-pic">
	                                                                                  <div class="picframe">
	                                                                                      <a href="#"><img src="<s:property value='titleImage' />" class="thumb-o"></a>
	                                                                                      <div class="hover-content">
	                                                                                      <div class="overlay"></div>
	                                                                                      <div class="link-contianer">
	                                                                                      <a href="javascript:void(0)" onclick="articleDetail(<s:property value='id' />)">查看详情</a>
	                                                                                      </div>
	                                                                                      </div>
	                                                                                  </div>
	                                                                                     <a href="javascript:void(0)" onclick="articleDetail(<s:property value='id' />)"><s:property value="title" /></a>
	                                                                                     <div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
	                                                                                     <div class="label bg-success m-b-xs">分类：<span><s:property value="parentCategory.name" /></span></div>
	                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span><s:property value="childFavorite.name" /></span></div>
	                                                                                   <div class="text-left abs-text"><s:property value="contentSubStr" escape="false"/></div> 
	                                                                             
	                                                                             </div>
	                                                                             <div class="clearfix panel-footer">
	                                                                             	 <s:iterator value="chartDistributionList" id="chartDistribution" status="s">
	                                                                             	 	<a href="chart_distribution.action?chartDistribution.tagId=<s:property value='#chartDistribution.tagId' />" class="tag bg-success r-coner-lg font-sm"><s:property value="#chartDistribution.tagName" /><span class="badge bg-danger m-l-xs"><s:property value="#chartDistribution.num" /></span></a>
	                                                                             	 </s:iterator>
	                                                                             </div>
	                                                                         </section>
	                                                                         
	                                                                         </div>
                                                                         </s:iterator>
                                                                         
                                                                         </div>
                                                                         <!-- end container -->
                                                                         </div>
                                                                         </section>
                                                                        </section>
                                                   
                                                                                                        
                                                                   </aside>
                                                                  </section>
                                                                  </section>

                                    
                                                  </section>
                  
                                    </section>
                                  </footer>
                                </section>
              </section>        
<section class="col-md-3 scrollable siderbar">

<ul class="list-group gutter list-group-lg list-group-sp sortable m-b-none">   
                        
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
  
 <li class="list-group-item col-md-12 sortable p-t-none" draggable="true">
<section class="panel panel-default favsec">
        <section class="col-md-12 favsec no-padder"> 
             <section class="hbox stretch">
                   <aside class="padder p-b-none">              
                                                   
                                                                        <section class="vbox">
                                                                        <section style="position: relative;">
                                                                         <div class="row wrapper p-r-lg p-b-none clearfix">
                                    <div class="col-sm-12 text-left text-left-xs no-padder"> 
                                    <div class="col-sm-9 no-padder"><h5 class="m-b-xs text-black">使用标签：情绪感知的资讯</h5></div>
                                    <div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共18篇资讯</small></div>
                                    </div> 
                                                                      
                                    <div class="col-sm-12 text-right text-left-xs no-padder">
                                    
                                        <div class="btn-group">
                                            <button data-toggle="dropdown" class="btn btn-sm  btn-default dropdown-toggle p-r-lg">
                                                <span class="dropdown-label">按发布时间排序</span>
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu dropdown-select text-left pull-right pull-none-xs">
                                                <li class="sort active" data-sort-by="postedtime">
                                                    <a href="#"><input type="radio" name="d-s-r" checked="">按发布时间排序</a>
                                                </li>
                                                <li class="sort" data-sort-by="posttitlename"><a href="#"><input type="radio" name="d-s-r">按资讯名排序</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    
                                                                         <div id="container2" class="block-fl m-t-sm">
                                                                         
                                                                         <div class="item col-sm-12 col-md-12 post hulianwang" >
                                                                         <section class="panel b-a">
                                                                             <div class="clearfix text-center m-b-sm title-pic">
                                                                                  <div class="picframe">
                                                                                      <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p1.jpg" class="thumb-o"></a>
                                                                                      <div class="hover-content">
                                                                                      <div class="overlay"></div>
                                                                                      <div class="link-contianer">
                                                                                      <a href="#">查看详情</a>
                                                                                      </div>
                                                                                      </div>
                                                                                  </div>
                                                                                     <div class="h5 m-t m-b-xs posttitlename"><a href="#">小米4发布</a></div>
                                                                                     <div class="text-danger postedtime">2014年10月11日</div>
                                                                                     <div class="label bg-success m-b-xs">分类：<span>互联网</span></div>
                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span>子收藏夹 -第1期</span></div>
                                                                                   <div class="text-left abs-text">全文内容全文内容全文内容全文内容全文内容全文全文全文全文全文内容全文全文.........</div> 
                                                                             
                                                                             </div>
                                                                             <div class="clearfix panel-footer">
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">可穿戴<span class="badge bg-danger m-l-xs">15</span></a>
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">情绪感知<span class="badge bg-danger m-l-xs">18</span></a>
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">柔性玻璃<span class="badge bg-danger m-l-xs">21</span></a>
                                                                             </div>
                                                                         </section>
                                                                         
                                                                         </div>
                                                                         
                                                                         <div class="item col-sm-12 col-md-12 post hulianwang">
                                                                         <section class="panel b-a">
                                                                             <div class="clearfix text-center m-b-sm title-pic">
                                                                                  <div class="picframe">
                                                                                      <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p2.jpg" class="thumb-o"></a>
                                                                                      <div class="hover-content">
                                                                                      <div class="overlay"></div>
                                                                                      <div class="link-contianer">
                                                                                      <a href="#">查看详情</a>
                                                                                      </div>
                                                                                      </div>
                                                                                  </div>
                                                                                     <div class="h5 m-t m-b-xs posttitlename"><a href="#">锤子的困惑</a></div>
                                                                                     <div class="text-danger postedtime">2014年12月11日</div>
                                                                                     <div class="label bg-success m-b-xs">分类：<span>互联网</span></div>
                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span>子收藏夹 -第1期</span></div>
                                                                                   <div class="text-left abs-text">全文内容全文内容全文内容全文内容全文内容全文全文全文全文全文内容全文全文.........</div> 
                                                                             
                                                                             </div>
                                                                             <div class="clearfix panel-footer">
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">可穿戴<span class="badge bg-danger m-l-xs">15</span></a>
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">情绪感知<span class="badge bg-danger m-l-xs">18</span></a>
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">柔性玻璃<span class="badge bg-danger m-l-xs">21</span></a>
                                                                             </div>
                                                                         </section>
                                                                         
                                                                         </div>
                                                                         
                                                                         <div class="item col-sm-12 col-md-12 post xiaofeidianzi">
                                                                         <section class="panel b-a">
                                                                             <div class="clearfix text-center m-b-sm title-pic">
                                                                                  <div class="picframe">
                                                                                      <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p3.jpg" class="thumb-o"></a>
                                                                                      <div class="hover-content">
                                                                                      <div class="overlay"></div>
                                                                                      <div class="link-contianer">
                                                                                      <a href="#">查看详情</a>
                                                                                      </div>
                                                                                      </div>
                                                                                  </div>
                                                                                     <div class="h5 m-t m-b-xs posttitlename"><a href="#">可穿戴设备的春天</a></div>
                                                                                     <div class="text-danger postedtime">2014年08月15日</div>
                                                                                     <div class="label bg-success m-b-xs">分类：<span>消费电子</span></div>
                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span>子收藏夹 -第1期</span></div>
                                                                                   <div class="text-left abs-text">全文内容全文内容全文内容全文内容全文内容全文全文全文全文全文内容全文全文.........</div> 
                                                                             
                                                                             </div>
                                                                             <div class="clearfix panel-footer">
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">可穿戴<span class="badge bg-danger m-l-xs">15</span></a>
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">情绪感知<span class="badge bg-danger m-l-xs">18</span></a>
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">柔性玻璃<span class="badge bg-danger m-l-xs">21</span></a>
                                                                             </div>
                                                                         </section>
                                                                         
                                                                         </div>
                                                                         
                                                                         <div class="item col-sm-12 col-md-12 post xiaofeidianzi">
                                                                         <section class="panel b-a">
                                                                             <div class="clearfix text-center m-b-sm title-pic">
                                                                                  <div class="picframe">
                                                                                      <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p4.jpg" class="thumb-o"></a>
                                                                                      <div class="hover-content">
                                                                                      <div class="overlay"></div>
                                                                                      <div class="link-contianer">
                                                                                      <a href="#">查看详情</a>
                                                                                      </div>
                                                                                      </div>
                                                                                  </div>
                                                                                     <div class="h5 m-t m-b-xs posttitlename"><a href="#">摄影设备</a></div>
                                                                                     <div class="text-danger postedtime">2014年02月18日</div>
                                                                                     <div class="label bg-success m-b-xs">分类：<span>消费电子</span></div>
                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span>子收藏夹 -第1期</span></div>
                                                                                   <div class="text-left abs-text">全文内容全文内容全文内容全文内容全文内容全文全文全文全文全文内容全文全文.........</div> 
                                                                             
                                                                             </div>
                                                                             <div class="clearfix panel-footer">
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">可穿戴<span class="badge bg-danger m-l-xs">15</span></a>
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">情绪感知<span class="badge bg-danger m-l-xs">18</span></a>
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">柔性玻璃<span class="badge bg-danger m-l-xs">21</span></a>
                                                                             </div>
                                                                         </section>
                                                                         
                                                                         </div>
                                                                         
                                                                         <div class="item col-sm-12 col-md-12 post xiaofeidianzi">
                                                                         <section class="panel b-a">
                                                                             <div class="clearfix text-center m-b-sm title-pic">
                                                                                  <div class="picframe">
                                                                                      <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p5.jpg" class="thumb-o"></a>
                                                                                      <div class="hover-content">
                                                                                      <div class="overlay"></div>
                                                                                      <div class="link-contianer">
                                                                                      <a href="#">查看详情</a>
                                                                                      </div>
                                                                                      </div>
                                                                                  </div>
                                                                                     <div class="h5 m-t m-b-xs posttitlename"><a href="#">完美的加工工艺</a></div>
                                                                                     <div class="text-danger postedtime">2014年04月11日</div>
                                                                                     <div class="label bg-success m-b-xs">分类：<span>消费电子</span></div>
                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span>子收藏夹 -第1期</span></div>
                                                                                   <div class="text-left abs-text">全文内容全文内容全文内容全文内容全文内容全文全文全文全文全文内容全文全文.........</div> 
                                                                             
                                                                             </div>
                                                                             <div class="clearfix panel-footer">
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">可穿戴<span class="badge bg-danger m-l-xs">15</span></a>
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">情绪感知<span class="badge bg-danger m-l-xs">18</span></a>
                                                                                 <a href="#" class="tag bg-success r-coner-lg font-sm">柔性玻璃<span class="badge bg-danger m-l-xs">21</span></a>
                                                                             </div>
                                                                         </section>
                                                                         
                                                                         </div>
                                                                         
                                                                         <div class="item col-sm-12 col-md-12 post hulianwang">
                                                                         <section class="panel b-a">
                                                                             <div class="clearfix text-center m-b-sm title-pic">
                                                                                  <div class="picframe">
                                                                                      <a href="#"><img src="<%=UrlHelper.getHomeUrl()%>resources/common/images/p6.jpg" class="thumb-o"></a>
                                                                                      <div class="hover-content">
                                                                                      <div class="overlay"></div>
                                                                                      <div class="link-contianer">
                                                                                      <a href="#">查看详情</a>
                                                                                      </div>
                                                                                      </div>
                                                                                  </div>
                                                                                     <div class="h5 m-t m-b-xs posttitlename"><a href="#">新的手机应用</a></div>
                                                                                     <div class="text-danger postedtime">2014年05月16日</div>
                                                                                     <div class="label bg-success m-b-xs">分类：<span>互联网</span></div>
                                                                                     <div class="text-muted p-b-md p-t-xs m-b-sm b-b">收藏至：<span>子收藏夹 -第1期</span></div>
                                                                                   <div class="text-left abs-text">全文内容全文内容全文内容全文内容全文内容全文全文全文全文全文内容全文全文.........</div> 
                                                                             
                                                                             </div>
                                                                             <div class="clearfix panel-footer">
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">可穿戴<span class="badge bg-danger m-l-xs">15</span></a>
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">情绪感知<span class="badge bg-danger m-l-xs">18</span></a>
                                                                                <a href="#" class="tag bg-success r-coner-lg font-sm">柔性玻璃<span class="badge bg-danger m-l-xs">21</span></a>
                                                                             </div>
                                                                         </section>
                                                                         
                                                                         </div>
                                                                         
                                                                         </div>
                                                                         </div>
                                                                         </section>
                                                                        </section>
                                                   
                                                                                                        
                                                                   </aside>
                                                                  </section>
                                                                  </section>

                                    
                                                  </section>  
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
  
</body>
</html>