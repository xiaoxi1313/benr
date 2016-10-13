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
  <link rel="stylesheet" href="<%=UrlHelper.getHomeUrl()%>resources/common/css/jquery.autocomplete.css" type="text/css" />
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
  <!-- HightCharts -->
   <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/highcharts.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/modules/exporting.js"></script>
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/chosen/chosen.jquery.min.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.autocomplete.js"></script>
  
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/app.plugin.js"></script>
    
  <style type="text/css">
	.legendLabel
	{
	    color:#000000;
	}
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
  
  function addrow() {
		var o = $('#selectTr').clone();
		var idnum = Number($("#idnum").val()) + 1;
		$("#idnum").val(idnum);
		$(o).find("input[name='selectidx']").val(idnum);
		$(o).removeAttr("id");
		$(o).removeAttr("style");
		var obj = $('<div>').append($(o)).html();
		$('#selectTr').after(obj);
		
		$('#selectTr').next().find(".chosen-container").remove();
		$('#selectTr').next().find("select[name='yid']").chosen();
		$('#selectTr').next().find("select[name='yid']").prop('disabled', false).trigger("chosen:updated");
		$('#selectTr').next().find("select[name='fid']").chosen();
		$('#selectTr').next().find("select[name='fid']").prop('disabled', false).trigger("chosen:updated");
		
		return false;
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
	
	var obj = $('<div>').append($(o)).html();
	$(targeretobj).after(obj);
	
	$(targeretobj).next().find(".chosen-container").remove();
	$(targeretobj).next().find("select[name='yid']").chosen();
	$(targeretobj).next().find("select[name='yid']").prop('disabled', false).trigger("chosen:updated");
	$(targeretobj).next().find("select[name='fid']").chosen();
	$(targeretobj).next().find("select[name='fid']").prop('disabled', false).trigger("chosen:updated");
	
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
	
	$(".chosen-container-single").each(function(){
		 if($(this).next().hasClass("chosen-container-single")) {
			 $(this).remove();
		 }
	 })
	  
	$(document.body).click(function(){
		$('#reporting').hide();
	});
	$(".parent-select").change(function(){
		var sel = $(this).val();
		if(sel!=null && sel!=''&&sel!='0'){
			var ix = $(this).attr('id');
			var ixs = ix.split("_") ;
			ix = ixs[1];
			showFavoriteChildren(ix,sel);
		}
		
	});
	$(".parent-select").change();
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
	 
	$('input[name="optionsRadios"]:checked').click();
	
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
				  var lb = "";
				  var d1 = [];
				  var d2 = [];
				  var data = [];
				  
				  var parentMap = {};
				  var childMap = {};
				  for (var i=0;i<d.chartResList.length;i++) {
				  		var c = d.chartResList[i];
				  		var ds = [];
				  		for (var j=0;j<c.chartList.length;j++) {
				  			var s = c.chartList[j];
				  			//alert(s.date);
				  			ds.push([s.date+8*60*60*1000, s.sum]);
				  		}
				  		data.push({"name":c.tagName,"data":ds});
				  		parentMap[c.tagName] = c.parentFavoriteId;//.put(c.tagName,c.parentFavoriteId);
				  		childMap[c.tagName] = c.childFavoriteIds;//childMap.put(c.tagName,c.childFavoriteIds);
				  }
				  $('#flot-chart').highcharts({
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
		                        return '';
		                    },
		                    style:{
		                        display:'none' //通过样式表控制不显示tooltip数据提示框
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
                                            var parentFavoriteId = parentMap[tagName];//.get(this.series.name);
                                            var childFavoriteIds = childMap[tagName];//.get(this.series.name);
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
		                series: data
				  });
			}else{
				if(d.errorCode == 3) {//连接丢失，重新加载数据库连接
					$('#chartForm').submit();
				} else {
					alert(d.errorMessage);
				}
				
			}
		}    	
	});
	$("#flot-chart div.legend table").css("border", "1px solid #888888");
	 	 
});

function showTooltip(x, y, color, contents) {  
    $('<div id="tooltip">' + contents + '</div>').css({  
        position: 'absolute',  
        display: 'none',  
        top: y - 5,  
        left: x + 5,  
        border: '2px solid' + color,  
        padding: '3px',  
        'font-size': '9px',  
        'border-radius': '5px',  
        'background-color': '#fff',  
        'font-family': 'Verdana, Arial, Helvetica, Tahoma, sans-serif',  
        opacity: 0.8  
    }).appendTo("body").fadeIn(200);  
}

//计算图表
function chart() {
	
	var s = "";
	$('select[name="cid"]').each(function(){
		s+= $(this).val() + ",";
	});
	var chenked=$("input[name='selectidx']:checked").val([]); 
	
	var chk = ""; 
	for(var i=0;i<chenked.length;i++){ 
		chk += chenked[i].value +","; 
	} 
    if (chk.length > 0) { 
	    //得到选中的checkbox值序列 
	    chk = chk.substring(0,chk.length - 1); 
	}else{
		alert('你还没有选择任何内容！'); 
		return ;
	} 
    $('#chk').val(chk);
	var url = 'chart_compare.action';
	$('#chartForm').attr('action',url);
	$('#chartForm').submit();
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

//保存查询条件
function saveQuery() {
	if ($('#title').val() == '') {
		alert("请输入标题！");
		return ;
	}
	
	if ($('#tagNames').val() == '') {
		alert("请输入标签！");
		return ;
	}
	
	$.post('chart_saveQuery.action?queryChart.type=1',{'queryChart.title':$('#title').val(),'queryChart.content':$(".table-responsive").html(),'tagNames':$('#tagNames').val()},function(d){
		d = eval('(' + d + ')');
		if(d.errorCode == 0) {
			alert("保存成功");
		} else {
			alert(d.errorMessage);
		}
	})
	
}

//删除比较源
function delTr(dom){
	$(dom).parent().parent().remove();
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
                    <small>您可以通过输入标签和制定范围来查看热点的走向</small>
                  </div>
                </div>
              </div>
              
              <section class="col-md-9 row">
              <form id="chartForm" method="post" action="chart_compare.action">
              <input type="hidden" id="queryChartId" name="queryChart.id" value="<s:property value="queryChart.id"/>"/>
              <input type="hidden" id="chk" name="chk" value="<s:property value="chk"/>"/>
              <input type="hidden" id="idnum" name="idnum" value="0"/>
              <section class="panel panel-default">
                  <header class="panel-heading">走向比较工具</header>
                  <div class="panel-body panel-table p-t-none">
                  
                  <div class="row wrapper selectrow" style="padding-bottom: 10px;">
                  <div class="m-b-xs prename" style="padding-left: 15px;">
                  <span class="selectname longname">比较源</span>
                  
                  <div class="btn-group m-r titleinput">
                  <button class="btn btn-s-md btn-success btn-preset" style="margin-left: 15px;" href="javascript:void(0)" onclick="addrow(); return false;">
                  <i class="fa fa-plus text"></i>
                  <span class="text">添加比较源</span>
                  </button>
                  </div>
                  
                  </div>
                  </div>
                  
                  <div class="table-responsive selecttable">
                  <s:if test="queryChart != null">
                  	<s:property value="queryChart.content" escapeHtml="false"/>
                   </s:if>
                   <s:else>
                   <!-- 查询条件 -->
                  <table style="width:100%;" class="b-t">
                  <thead>
	                  <tr class="chooselist" id="selectTr">
	                  <th width="30"><label class="checkbox m-t-none m-b-none i-checks" style="margin-left: 6px;">
	                  	<input type="checkbox" name="selectidx" value="0"><i style="margin-left: 0px;"></i></label></th>
	                  <th style="padding:15px 0;">
	                  
	
	                   <div class="m-b-xs prename">
	                   <span class="selectname longname">分析数据来源</span>
	                   
	                   <div class="btn-group m-r">
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="optionsRadios" value="1" checked onclick="selectsource(this)">
	                      指定特定文件夹作为数据分析来源
	                    </label>
	                  </div>
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="optionsRadios" value="2" onclick="selectsource(this)">
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
		                    
		                     </tr>
		                    </tbody>
	                    </table>
	                    </div>
	                    </div>
	                   
	                   
	                   
	                   
	                   <div class="row wrapper selectrow selectr2">
	                    <div class="m-b-xs prename">
	                    <span class="selectname longname">选择时间段</span>
	                    <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
	                     <input class="form-control" size="16" type="text" value="" readonly=""  name="beginDates">
	                     <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
	                    	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                     </div>
	                    <div class="btn-group m-r input-group date form_date" data-date="" data-date-format="" data-link-field="" data-link-format="yyyy-mm-dd">
	                     <input class="form-control" size="16" type="text" value="" readonly="" name="endDates">
	                     <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
	                    	<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	                     </div>
	                    </div>
	                    </div>
	                   
	                   <div class="row wrapper selectrow" >
	                   <div class="m-b-xs prename" style="margin-bottom: 0;">
	                   <span class="selectname longname">标签</span>
	                   <div class="btn-group m-r titleinput">
	                   <input type="text" class="form-control ac1" name="tagNames" autocomplete="off">
	                   </div>                 
	                   </div>
	                   </div>
	                   
	                   </th>
	                   <th style="text-align: center;"><a class="iconbtn"  onclick="deleterow(this)" href="javascript:void(0)"><i class="fa fa-trash-o"></i></a></th>
                   </tr>
                   </thead>
                   </table>
                   
                   <!-- 查询条件 -->
                   </s:else>
                   </div>
                   
                  

                  <div class="row wrapper selectrow search-btn">
                  <a href="javascript:void(0);" class="btn btn-s-md btn-primary" onclick="chart()">开始计算</a>
                  <a href="#" class="btn btn-s-md btn-primary">重置</a>
                  </div>

                  </div>
                  </section>
                  <section class="panel panel-default">
                   <header class="panel-heading font-bold">比较结果</header>
                   <div class="panel-body">
                   <div id="flot-chart"  style="height:240px"></div>
                   </div>                                                
                  </section>
              </section>  

                  </form>

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
 <a href="#modal-saveresult" data-toggle="modal" class="btn btn-success savebtn">保存</a>
 <!-- <a href="#" class="btn btn-success" onclick="exportJpeg();">导出</a> -->
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
						<a href="chart_initCompare.action?menuUrl=chart_initCompare&queryChart.id=<s:property value='id' />" class="h5 text-success"><s:property value='title' /></a>
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