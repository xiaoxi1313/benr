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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/jquery.autocomplete.css" type="text/css" />
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
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.js" charset="UTF-8"></script> 
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/datepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/sortable/jquery.sortable.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.multi-select.js"></script>
  <!-- Sparkline Chart -->
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
<!-- Easy Pie Chart -->
<!-- Flot -->

  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/isotope.pkgd.min.js"></script>
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/highcharts.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.autocomplete.js"></script>
  
<script type="text/javascript">
function changePie(obj) {
	var objv = obj.value;
	//if(obj.value > 0) {
		$.getJSON('relationPie.action?tagCategoryId='+obj.value +"&"+$('#chartForm').serialize(),function(d){
			
			if(d.tagCategoryList != undefined && d.tagCategoryList.length > 0) {
				$(obj).html('<option value="-1">所有分类</option>');
				
				$.each(d.tagCategoryList, function(i, item){
					if(item != null) {
						var setld = item.id == objv ? "selected":"";//有默认值
						$("<option value=\"" + item.id + "\" " + setld +">" + item.name + "</option>").appendTo($(obj));
					}
				});
			}
			
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
		                events:{
		                	click:function(e) {
			                	tov(e.point.name);
			                }
		                },
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
		        }],
		        turboThreshold:1500
		    });
			
			
		});
	//}
}

$(document).ready(function(){
	
	$('#tagName').autocomplete('tag_listAllTag.action', {
		minChars: 1,
        remoteDataType: 'json',
        processData: function(data) {
			var processed = [];
			if(data.tagList != undefined) {
				for (var i=0; i < data.tagList.length; i++) {
					processed.push([data.tagList[i].name]);
				}
				$("#modal-add-tag-new").show();
			}
			return processed;
        },
        formatItem: function(row, i, n) {
	   		return row;     
       	},
       	onItemSelect: function(item) {
       		$(ob).attr('val',item.value);
        }
 	});
	
	//初始化表单
	 $('select').each(function(){
		if($(this).attr('val') != undefined && $(this).attr('val') != '' && $(this).attr('val') > 0) {
			$(this).val($(this).attr('val'));
		} 
	 });
	 $('input[name="optionsRadio"]:checked').click();
	 $('select[name="fid"]').change();
	
	var $container = $('#container').isotope({
	    getSortData: {
	        posttitlename: '.posttitlename',
	        postedtime: '.postedtime'
	    }
	});
	
	//没有查询条件不计算图表
	<%if(request.getParameter("optionsRadio") != null || request.getParameter("queryChart.id") != null){%>
	$('#selectpie').change();
	<%}%>
	
	
	
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
	
	$('.select-all').click(function(){
      $(this).parent().parent().find('select').multiSelect('select_all');
      return false;
    });
    $('.deselect-all').click(function(){
      $(this).parent().parent().find('select').multiSelect('deselect_all');
      return false;
    });

});

function chart() {
	if($.trim($('#tagName').val()) == '') {
		alert("请输入标签名称！");
		return false;
	}
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
			
				//$("<option value=\"-1\">请选择</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
				$.each(data.favoriteList, function(i, item){
					var setld = checkcid(item.id) ? "selected":"";//有默认值
					$("<option value=\"" + item.id + "\">" + item.name + "</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
				});
				
				var o = $(obj).parent().parent().parent().find("select[c='ccc']");
				$(o).multiSelect('refresh');
			}
	}, "json");
}

//用于检查提交后， 子类是否被选中
function checkcid(childrenid) {
	   if($('#_cid') != undefined && $('#_cid').length > 0) {
		   var a_cid = $('#_cid').val().split(",");
		   for(var i=0;i<a_cid.length;i++) {
			   if(a_cid[i] == childrenid) {
				   return true;
			   }
		   }
	   }
	   return false;
}


//查询条件相关
// 删除
   function deleteQuery(id) {
   	if (confirm("确定删除吗？")) {
   		$.post("chart_deleteQueryChart.action?queryChart.id="+id, 
   	         function(data){
   	        	if(data.errorCode==0){
   		        	location.reload();
   	        	}
           },'json');
   		}
   }
 	
 	//保存查询条件
   function saveQuery() {
   	if ($('#title').val() == '') {
   		alert("请输入标题！");
   		return ;
   	}
   	
   
   	var jsonq = $('#chartForm').serializeJson();
   	if(typeof(jsonq.fid) != Object) {
   		jsonq.fid = [jsonq.fid];
   	}
   	if(jsonq.cid != null) {
   		if(typeof(jsonq.cid) != Object) {
   	   		jsonq.cid = [jsonq.cid];
   	   	}
   	}
   	
   	if(typeof(jsonq.yid) != Object) {
   		jsonq.yid = [jsonq.yid];
   	}
   	var jsq = JSON.stringify(jsonq);
   	$.post('chart_saveQuery.action?queryChart.type=2',{'queryChart.title':$('#title').val(),'queryChart.content':jsq},function(d){
   		d = eval('(' + d + ')');
   		if(d.errorCode == 0) {
   			$(".modal").find(".close").click();
   			alert("保存成功");
   			location.reload();
   		} else {
   			alert(d.errorMessage);
   		}
   	})
   	
   }
 
 
   (function($){  
       $.fn.serializeJson=function(){  
           var serializeObj={};  
           var array=this.serializeArray();  
           var str=this.serialize();  
           $(array).each(function(){  
               if(serializeObj[this.name]){  
                   if($.isArray(serializeObj[this.name])){  
                       serializeObj[this.name].push(this.value);  
                   }else{  
                       serializeObj[this.name]=[serializeObj[this.name],this.value];  
                   }  
               }else{  
                   serializeObj[this.name]=this.value;   
               }  
           });  
           return serializeObj;  
       };  
   })(jQuery);  

   function tov(name) {
		 //$('#tagarticle').attr('src','chart_tagArticle.action?tagId='+id);
		 window.open('chart_tagArticle.action?tagName=' + name);
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
		                  <input type="text" class="form-control" id="tagName" name="tagName" value="<s:property value="tagName"/>">
		                  </div>
		                  
		                  </div>
		                  </div>
	
	                   <div class="m-b-xs prename">
	                   <span class="selectname longname">分析数据来源</span>
	                   
	                   <div class="btn-group m-r">
	                   	  <div class="radio">
		                    <label>
		                      <input type="radio" <s:if test="optionsRadio != 2 && optionsRadio != 1">checked</s:if> value="0" name="optionsRadio" onclick="selectsource(this)">
		                      全局数据来源
		                    </label>
		                  </div>
		                  <div class="radio">
		                    <label>
		                      <input type="radio" name="optionsRadio" <s:if test="optionsRadio == 1">checked</s:if> value="1" onclick="selectsource(this)">
		                      指定特定文件夹作为数据分析来源
		                    </label>
		                  </div>
		                  <div class="radio">
		                    <label>
		                      <input type="radio" name="optionsRadio" <s:if test="optionsRadio == 2">checked</s:if> value="2" onclick="selectsource(this)">
		                      指定整个数据库中时间段内的资讯作为数据分析来源
		                    </label>
		                  </div>
	                  </div>
	                  </div>
	                   
	                   <s:if test="yid == null || yid.length==0">
	                   		<s:set name="yid" value="{2015}"></s:set>
	                   	</s:if>
	                   	<s:else>
	                   		<input type="hidden" id="_cid" value="<s:property value="cid"/>"/>
	                   	</s:else>
	                   		
	                   	<s:iterator value="yid" id="yr" status="idx">
	                   
	                   <div class="row wrapper selectrow selectr1 selectfolder">
	                    <div class="m-b-xs prename">
	                    <span class="selectname longname">选择文件夹</span>
	                    
	                    <table class="table-responsive innertable">
		                    <tbody>
		                    <tr>
		                    <th>
		                    <div class="btn-group m-r year">
		                    <select class="chosen-select" name="yid" val="<s:property value="#yr"/>">
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
			          			<select a="aaa" class="chosen-select" name="fid" <s:property value="fid[#idx.index]"/> onchange="getChildrenByParentFavoriteId(this)">
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
					                    <a href='#' s='sss' class="btn btn-sm btn-default m-r-sm select-all">全选</a>
					                    <a href='#' d='ddd' class="btn btn-sm btn-default deselect-all">取消全选</a>
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
	                    </s:iterator>
	                   
	                   <div class="row wrapper selectrow selectr2">
		                    <div class="m-b-xs prename">
			                   <span class="selectname longname">选择时间段</span>
			                   <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
			                    <input class="form-control" size="16" type="text" value="<s:property value="beginDate"/>" readonly="" name="beginDate">
			                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
			                    </div>
			                   <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
			                    <input class="form-control" size="16" type="text" value="<s:property value="endDate"/>" readonly="" name="endDate">
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
                  <!-- <a href="#" class="btn btn-s-md btn-primary">重置</a> -->
                  </div>

                  </div>
                  </section>
                  <input type="hidden" id="showResult" name="showResult" value="<s:property value='showResult' />"/>
                  </form>              
                 
                  <section class="panel panel-default">
                      <header class="panel-heading">饼状图分析结果</header>
                        <div class="panel-body">
                        <div class="btn-group m-r">
                        <select id="selectpie" class="chosen-select" onchange="changePie(this)">
                        	<option value="-1">所有分类</option>
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
                                              		<li class="list-group-item">
                                              			<a class="lefttag" tagid="<s:property value='tagId' />" tagname="<s:property value="tagName" />">
                                              			<i class="fa fa-chevron-right pull-right m-t-xs text-xs icon-muted"></i><s:property value="tagName" />
                                              			<span class="badge bg-danger m-l-sm"><s:property value="num" /></span>
                                              			</a>
                                              		</li>
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
                                    <div class="col-sm-9 no-padder"><h5 class="m-b-xs text-black">使用标签：<span id="titletag"><s:property value="tag.name" /></span></h5></div>
                                    <div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共<span id="csize"></span>篇资讯</small></div>
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
                                   <script type="text/javascript">
                                   $(document).ready(function(){
                                	   var $container = $('#container').isotope({
                                           itemSelector: '.item'
                                       });
                                	  $(".lefttag").click(function(){
                                		  $('#titletag').html($(this).attr('tagname'));
                                		  $.ajax({
                                              cache:false,
                                              url: 'chart_listTagArticle.action?tagId=' + $(this).attr('tagid') + "&" + $('#chartForm').serialize(),
                                              success: function(data,exception){
                                            	  if(exception === "success") {
                                            		  $container.empty();
                                            		  $container.isotope('insert',$(data));
                                            		  $('#csize').html($container.find('.item').length);
                                            	  }
                                            	}
                                          });
                                	  }) 
                                	  if( $(".lefttag").length > 0) {
                                		  $( $(".lefttag")[0]).click();
                                	  }
                                   });
                                   function showright(tagid,tagname) {
                                	   var $container2 = $('#container2').isotope({
                                           itemSelector: '.item'
                                       });
                                	   $('#titleright').html(tagname);
                             		  $.ajax({
                                           cache:false,
                                           url: 'chart_listTagArticle.action?viewRegion=right&tagId=' + tagid + "&" + $('#chartForm').serialize(),
                                           success: function(data,exception){
                                         	  if(exception === "success") {
                                         		  $container2.empty();
                                         		  $container2.isotope('insert',$(data));
													
                                         		  $('#rightsize').html($container2.find('.item').length);
                                         	  }
                                         	}
                                       });
                                   }
                                   </script>
                                                                         <div id="container" class="block-fl m-t-sm">
                                                                         
                                                                         
                                                                         
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
        
  <li class="list-group-item col-md-12 sortable p-t-none savepanel" draggable="true">
			 <div class="panel panel-default portlet-item m-b-none">
			 <header class="panel-heading">
			 <ul class="nav nav-pills pull-right">
			 <li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
			 </ul>
			 保存                    
			 </header>
			 <div class="panel-body">
			 <a href="#modal-saveresult" data-toggle="modal" class="btn btn-success savebtn">保存</a>
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

	<s:iterator value="queryChartList" status="u">
 	<div class="panel-body project t-t" style="padding: 15px 0;">
		<table style="width: 100%;">
			<thead>
				<tr >
					<th class="p-l-md">
					<div class="pull-right media-xs text-center text-muted">
					<strong class="h4"><s:date name="createTime" format="yyyy" /></strong><br>
					<small class="label bg-light"><s:date name="createTime" format="MM月dd日" /></small>
					</div>
					<a href="chart_distribution.action?menuUrl=chart_distribution&queryChart.id=<s:property value='id' />" class="h5 text-success"><s:property value='title' /></a>
					<div>
					</div>
				</th>
				<th width="30" style="text-align: center;"><a href="javascript:void(0)" onclick="deleteQuery(<s:property value='id' />)" class="iconbtn"><i class="fa fa-trash-o"></i></a></th>
				</tr>
			</thead>
		</table>
	</div>
   </s:iterator>
   
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
                                    <div class="col-sm-9 no-padder"><h5 class="m-b-xs text-black">使用标签：<span id="titleright"></span></h5></div>
                                    <div class="col-sm-3 no-padder"><small class="text-muted inline m-t-sm m-b-sm pull-right">共<span id="rightsize">0</span>篇资讯</small></div>
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
                                                                         
                                                                         
                                                                         
                                                                         </div>
                                                                         <!-- end container2 -->
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
  
  
  <div class="modal fade" id="modal-checkpost" style="display: none;" aria-hidden="true">
    	<div class="modal-dialog" style="min-width: 800px;">
        <iframe src="" id="tagarticle" width="800" border="0" height="600"></iframe>
        </div>
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
                    <div class="form-group">
                    	<label class="col-sm-2 control-label tagselectname">分析结果名</label>
                    	<div class="col-sm-9">
                    	<input type="text" class="form-control" id="title">
                    	<span class="help-block m-b-none">此项为必填，分析结果名不能和已有的重复，大小写不限，不能使用特殊符号。</span>
                    </div>
                 </div>
                                          <div class="line line-dashed b-b line-lg pull-in"></div>
                  <div class="checkbox m-t-lg">
                  	<button type="button" class="btn btn-sm btn-success pull-right text-uc m-t-n-xs" onclick="saveQuery();"><strong>保存</strong></button>
                  </div>
                 </div>
                 
               </div>          
             </div>
           </div><!-- /.modal-content -->
         </div><!-- /.modal-dialog -->
       </div>
  
</body>
</html>

