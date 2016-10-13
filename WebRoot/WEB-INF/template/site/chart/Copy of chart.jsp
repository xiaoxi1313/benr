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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/calendar/bootstrap_calendar.css" type="text/css" />
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.css" type="text/css" />
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
    <!-- Sparkline Chart -->
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/sparkline/jquery.sparkline.min.js"></script>
  <!-- Flot -->
  <!-- <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>-->
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/highcharts.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/modules/exporting.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.autocomplete.js"></script>
   <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
   <style type="text/css">
   #reporting {
    position: absolute;
text-align:left;
border:1px solid #c7bf93;
border-radius:4px;
-moz-border-radius:4px;
-webkit-border-radius:4px;
padding:6px 8px;
min-width:100px;
max-width:425px;
color:#000;
background-color:#fff9c9;
z-index:9999999;
}
   </style>
<script type="text/javascript">
var chart; 
$(document).ready(function(){
	$(document.body).click(function(){
		$('#reporting').hide();
	});
	
	Highcharts.setOptions({
		lang: {
			downloadJPEG:'导出JPEG图片',
			downloadPDF:'导出PDF',
			downloadPNG:'导出PNG图片',
			downloadPNG:'导出PNG图片',
			downloadSVG:'导出SVG'
		}
	});
	$("#parentFavoriteId").change(function(){
		var sel = $(this).val();
		if(sel!=null && sel!=''&&sel!='0'){
			showFavoriteChildren(sel);
		}
		
	});
	$("parentFavoriteId").change();
	
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
	 $('.ac1').autocomplete('tag_listAllTag.action', {
			minChars: 1,
	        remoteDataType: 'json',
	        processData: function(data) {
				var processed = [];
				for (var i=0; i < data.tagList.length; i++) {
					processed.push([data.tagList[i].name]);
				}
				$("#modal-add-tag-new").show();
				return processed;
	        },
	        formatItem: function(row, i, n) {
		   		return row;     
	       	},
	       	selectedItem: function(event, ui) {
	            //alert(ui.item.value);
	        }
	 });
    //showFavoriteParent();
    
    /******* 计算图表 *******/
	//$('#loadingdiv').hide();
	$('#chartForm').ajaxForm({
		dataType:'json',
		beforeSend:function(){
			//$('#loadingdiv').show();
		},
		success:function(d) {
			if(d.errorCode==0){
				$('#container').show();
				
				  var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
				  var d1 = [];
				  for (var i=0;i<d.chartList.length;i++) {
				  		var c = d.chartList[i];
						d1.push([c.date+8*60*60*1000, c.sum]);
				  }
				  var seriesName = $('#tagName').val();
				  $('#flot-1ine').highcharts({
					  chart: {
		                    type: 'line'
		                },title: {  
		                    text: '',  
		                    style:{  
		                        fontSize: '20px'  
		                    },  
		                    x: -20 //center  
		                },  subtitle: {  
		                    text: '',  
		                    x: -20  
		                }, credits: { enabled: false },  
		                xAxis: {  
		                    type: 'datetime',  
		                    labels: {  
		                        formatter: function () {  
		                            return Highcharts.dateFormat('%m/%d', this.value);  
		                        }  
		                    }  
		                },  
		                yAxis: {  
		                    title: {  
		                        text: '数量'  
		                    },  
		                    plotLines: [{  
		                        value: 0,  
		                        width: 1,  
		                        color: '#808080'  
		                    }]  
		                }, tooltip: {  
		                    formatter: function () {  
		                        //return '<b>' + this.series.name + '</b><br/>' +  
		                        //Highcharts.dateFormat('%Y-%m-%d', this.x) + ': ' + this.y +'个';  
		                        return null;
		                    }  
		                },  
		                plotOptions: {
		                    line: {
		                        dataLabels: {
		                            enabled: true
		                        },
		                        enableMouseTracking: true,
		                        point:{
		                        	events:{
		                        		mouseOver: function() {
                                            var tagName = this.series.name;
                                            var parentFavoriteId = $('#parentFavoriteId').val();//.get(this.series.name);
                                            var childFavoriteIds = $('#childFavoriteId').val();//.get(this.series.name);
									        var pointer = this;
									        //var tooltip = pointer.series.tooltipPoints;
									        $.post("chart_pointCompare.action", 
									             {tagName :tagName,queryDate : Highcharts.dateFormat('%Y-%m-%d', this.x),parentFavoriteId:parentFavoriteId,childFavoriteIds:childFavoriteIds }, 
									             function(data){
									            	if(data.errorCode==0){
									            		var li = "";
									            		$("#reportul").empty();
									            		var inx = 0;
									            		for (inx;inx<data.articleList.length;inx++) {
									 				  		var cli = data.articleList[inx];
									 				  		li += "<li><a href='article_show.action?article.id="+cli.id+"' target='_blank'>"+cli.title+"</a></li>";
									 				  	}
									            		$("#reportul").append(li);
										                var left = pointer.plotX+150;
										                if(left <0){
										                    left =0;
										                }
										                $("#reporting").css("left",left + "px"); 
										                $("#reporting").css("top",pointer.plotY+370 + "px");
										                $("#reporting").show();
									            	}
									            },'json');
									    },
									    mouseOut: function() {
									         //$("#reporting").hide();
									    }
		                        	}
		                        }
		                    }
		                },
		                series: [{
		                    name: seriesName,
		                    data: d1
		                }]
				  });
				  $('#chartTotalNum').html(d.totalNum);
				  $('#chartMaxNum').html(d.maxNum);
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#chartForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	/******* 计算图表 *******/
	init();
});

// 显示收藏夹一级列表
function showFavoriteParent() {
	$.ajax({
		type : 'POST',
		dataType:'json',
		url : 'article_getParentFavoriteList.action',
		date : 'id=' + 0,
		success : function(d) {
			$('#parentFavoriteList').empty();
			var option = "";
			$.each(d.favoriteList, function(i, item){
				option += "<li class=\"\"><a href=\"javacription:void(0)\" onclick=\"showFavoriteChildren('"+ item.id +"')\"><input name=\"parentFavoriteId\" class=\"parentFavorite\" type=\"radio\" value=\"" + item.id + "\" name=\"parentCategory\">" + item.name +"</a></li>";
			});
			
			$('#parentFavoriteList').append(option);
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
			var childFavorite = $("#childFavoriteId");
			childFavorite.empty();
			var option ="";
			if (parentId == '' || parentId == undefined) {
				option +="<option value='0'>无子分类</option>";
				//option += "<li class=\"active\"><a href=\"#\"><input value=\"-1\" type=\"radio\" name=\"d-s-r\" checked=\"checked\">无子分类</a></li>";
			}else{
				option +="<option value='0'>请选择子收藏夹</option>";
				$.each(d.favoriteList, function(i, item){
					option +="<option value='"+item.id+"'>"+item.name+"</option>";
					//option += "<li class=\"\"><a href=\"#\"><input type=\"radio\" value=\"" + item.id + "\" name=\"childFavoriteId\">" + item.name +"</a></li>";
				});
			}
			childFavorite.append(option);
		} ,
		error : function(msg, testStatus, e) {
			alert(e);
		}
	});
}

// 计算图表
function chart() {
	/* if ($("input[name='articleFavorite.childFavoriteId']:checked").val() <= 0) {
		alert("请选择收藏夹！");
		return ;
	} */
	
	if ($('#tagName').val() == '') {
		alert("请输入标签！");
		return ;
	}
	var url = 'chart_chart.action';
	$('#chartForm').attr('action',url);
	$('#chartForm').submit();
}

//保存查询条件
function saveQuery() {
	if ($('#title').val() == '') {
		alert("请输入标题！");
		return ;
	}
	if ($('#tagName').val() == '') {
		alert("请输入标签！");
		return ;
	}
	$('#chartForm').attr('action','chart_saveQuery.action?queryChart.type=2');
	$('#chartForm').submit();
}

function init(){
	var queryChartId = $('#queryChartId').val() * 1;
	if(queryChartId!=null&&queryChartId > 0){
		var url = 'chart_chart.action';
		$('#chartForm').attr('action',url);
		$('#chartForm').submit();
	}
}

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
                    <h3 class="m-b-none">热点走向</h3>
                    <small>您可以通过输入标签来分析热点走向</small>
                  </div>
                </div>
              </div>
              
              <section class="col-md-9 row">
              <form id="chartForm" method="post" action="chart_chart.action">
              <input type="hidden" id="queryChartId" name="queryChart.id" value="<s:property value="queryChart.id"/>"/>
              <section class="panel panel-default">
                  <header class="panel-heading">热点分析工具</header>
                  <div class="panel-body">
                  <div class="row wrapper selectrow">
                  <div class="m-b-xs prename">
                  <span class="selectname longname">标题</span>
                  
                  <div class="btn-group m-r titleinput">
                  <input type="text" class="form-control" id="title" name="queryChart.title" value="<s:property value="queryChart.title"/>"/>
                  </div>
                  
                  </div>
                  </div>
                  
                  <div class="row wrapper selectrow">
                   <div class="m-b-xs prename">
                   <span class="selectname longname">分析范围选择</span>
                   
                   <div class="btn-group m-r">
                   <select class="chosen-select" id = "parentFavoriteId" name="parentFavoriteId">
                   		<option value="0" onclick="showFavoriteChildren(0);">请选择收藏夹</option>
                   		<s:iterator value="favoriteList" status="u">
                   			<option value="<s:property value='id' />" onclick="showFavoriteChildren(<s:property value='id' />);" <s:if test="queryChartBean.parentFavoriteId == id ">selected="selected"</s:if>><s:property value='name'/></option>
                   		</s:iterator>
                   	</select>
                   </div>
                   
                   <div class="clear"></div>
                   <div class="gap"></div>
                   
                   <div class="btn-group m-r">
                   <select class="chosen-select" id = "childFavoriteId" name="childFavoriteId">
                   <option value="0" >请选择子收藏夹</option>
                   </select>
                   </div>
                   </div>
                   </div>
                  
                  <div class="row wrapper selectrow">
                   <div class="m-b-xs prename col-md-12 no-padder">
                   <span class="selectname longname">分析时间段</span>
                   <div class="col-md-5 f-left btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" name="beginDate" size="16" type="text" value="<s:property value="queryChartBean.beginDate"/>" readonly="">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                   <div class="col-md-5 f-left btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
                    <input class="form-control" name="endDate" size="16" type="text" value="<s:property value="queryChartBean.endDate"/>" readonly="">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                   	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                   </div>
                   </div>
                  
                  <div class="row wrapper selectrow b-b" style="padding-bottom: 10px;">
                   <div class="m-b-xs prename">
                   <span class="selectname longname">标签</span>

                   <div class="btn-group m-r titleinput">
                   <input type="text" class="form-control ac1" name="tagName" id="tagName" value="<s:property value="queryChartBean.tagName"/>">
                   </div>                 
                   </div>
                   </div>

                  <div class="row wrapper selectrow search-btn">
                  <a href="javascript:void(0)" onclick="chart()" class="btn btn-s-md btn-primary">开始计算</a>
                  <a href="#" class="btn btn-s-md btn-primary">重置</a> 
                  </div>

                  </div>
                  </section>
                  </form>
                  <section class="panel panel-default">
                                  <header class="panel-heading font-bold">分析结果</header>
                                  <div class="panel-body">
                                  <div id="flot-1ine" style="height:250px"></div>
                                  </div>
                                  <footer class="panel-footer bg-white">
                                    <div class="row text-center no-gutter">
                                      <div class="col-xs-6 b-r b-light">
                                        <p class="h3 font-bold m-t" id="chartTotalNum">0</p>
                                        <p class="text-muted">总出现次数</p>
                                      </div>
                                      <div class="col-xs-6">
                                        <p class="h3 font-bold m-t" id="chartMaxNum">0</p>
                                        <p class="text-muted">最高单日出现次数</p>
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
 <a href="#" class="btn btn-success savebtn" onclick="saveQuery();">保存</a>
 <!-- <a href="#" class="btn btn-success">导出</a>-->
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
 <s:iterator value="queryChartResList" status="u" id="">
 	<div class="panel-body project t-t" style="padding: 15px 0;">
		<table style="width: 100%;">
			<thead>
				<tr >
					<th class="p-l-md">
					<div class="pull-right media-xs text-center text-muted">
					<strong class="h4"><s:date name="queryChart.createTime" format="yyyy" /></strong><br>
					<small class="label bg-light"><s:date name="queryChart.createTime" format="MM月dd日" /></small>
					</div>
					<a href="chart_initCompare.action?queryChart.id=<s:property value='queryChart.id' />" class="h5 text-success"><s:property value='queryChart.title' /></a>
					<div>
					<a class="label label-info tag"><s:property value='tagName' /></a>
					</div>
				</th>
				<th width="30" style="text-align: center;"><a href="javascript:void(0)" onclick="deleteQuery(<s:property value='queryChart.id' />)" class="iconbtn"><i class="fa fa-trash-o"></i></a></th>
				</tr>
			</thead>
		</table>
	</div>
	 	
   </s:iterator>
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
  <div class="panel-body" id="reporting">
		<ul id="reportul"></ul>
	</div>
</body>
</html>