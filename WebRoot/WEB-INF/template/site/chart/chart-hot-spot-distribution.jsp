<%@page import="com.opensymphony.xwork2.util.ValueStack"%>
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
  
  <script type="text/javascript" src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.form.js"></script>
  <script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/charts/highcharts.js"></script>
  
  <script type="text/javascript">
  
  $(document).ready(function(){
	 $('#batchDiv').html('');
	 
	 //初始化表单
	 $('select').each(function(){
		if($(this).attr('val') != undefined && $(this).attr('val') != '' && $(this).attr('val') > 0) {
			$(this).val($(this).attr('val'));
		} 
	 });
	 $('input[name="optionsRadio"]:checked').click();
	 $('select[name="fid"]').change();
	 
	 
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
	    
	    
	    //加载饼图
	    <s:if test="pieDataContent != null">
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
		                	tov2(e.point.name);
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
	            data: <s:property value="pieDataContent" escape="false"/>
	        }]
	    });
	    </s:if>
	    
	    
  });
    
   function getChildrenByParentFavoriteId(obj) {
	   if($(obj).val() > 0) {
		   $.post("favorite_getFavoriteListByParentId.action?parentId=" + $(obj).val(),
					function (data, textStatus) {
						if (data.errorCode == 0) {
							$(obj).parent().parent().parent().find("select[c='ccc']").empty();
						
							//$("<option value=\"-1\">请选择</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
							$.each(data.favoriteList, function(i, item){
								var setld = checkcid(item.id) ? "selected":"";//有默认值
								$("<option " + setld +" value=\"" + item.id + "\">" + item.name + "</option>").appendTo($(obj).parent().parent().parent().find("select[c='ccc']"));
							});
							
							var o = $(obj).parent().parent().parent().find("select[c='ccc']");
							$(o).multiSelect('refresh');
						}
				}, "json");
	   }
	
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
   
   function addfloderrown(obj) {
   	var o = $('#selectfolder').clone();
   	$(o).removeAttr("id");
   	$(o).removeAttr("style");
   	$(o).find(".opfolder").html('<a href="javascript:void(0)" onclick="deletefloderrow(this)" class="iconbtn"><i class="fa fa-trash-o"></i></a>');
   	var obj = $('<div>').append($(o)).html();
   	$('#selectfolder').after(obj);
   	
   }
   function deletefloderrow(obj) {
   	$(obj).parent().parent().parent().parent().parent().remove();
   }
   $(document).ready(function(){
   	
   	$('input[name="optionsRadio"]:checked').click();
   })
   
   function selectsource(obj) {
	var o = $(obj).parent().parent().parent().parent().parent().parent();
	if( obj.value == 1) {
		$(o).find(".selectr1").show();
		$(o).find(".selectr2").hide();
	} else {
		$(o).find(".selectr2").show();
		$(o).find(".selectr1").hide();
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
   	$.post('chart_saveQuery.action?queryChart.type=0',{'queryChart.title':$('#title').val(),'queryChart.content':jsq},function(d){
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
	
 function tov(id) {
	 //$('#tagarticle').attr('src','chart_tagArticle.action?tagId='+id);
	 
	 window.open('chart_tagArticle.action?tagId='+id);
 }
 
 function tov2(name) {
	 //$('#tagarticle').attr('src','chart_tagArticle.action?tagId='+id);
	 window.open('chart_tagArticle.action?tagName=' + name);
 }
 
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
                    <h3 class="m-b-none">热点发现</h3>
                    <small>您可以在这里查看您所指定的标签的热点分布</small>
                  </div>
                </div>
              </div>
              
              <section class="col-md-9 row">
              <form id="chartForm" method="post" action="chart_init.action?menuUrl=chart_init">
              <section class="panel panel-default">
                  <header class="panel-heading">热点发现检索工具</header>
                  <div id="searchcontent">
                  
                  <!-- 查询条件内容 -->
                  <div class="panel-body">
                  
	                  <div class="row wrapper selectrow p-t-none">
	                   <div class="m-b-xs prename">
	                   <span class="selectname longname">分析数据来源</span>
	                   
	                   <div class="btn-group m-r">
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="optionsRadio" value="1" <s:if test="optionsRadio != 2">checked</s:if> onclick="selectsource(this)">
	                      指定特定文件夹作为数据分析来源
	                    </label>
	                  </div>
	                  <div class="radio">
	                    <label>
	                      <input type="radio" name="optionsRadio" value="2" <s:if test="optionsRadio == 2">checked</s:if> onclick="selectsource(this)">
	                      指定整个数据库中时间段内的资讯作为数据分析来源
	                    </label>
	                  </div>
	                  </div>
	                  </div>
	                  </div>
	                  
	                  <!-- 选择时间 -->
	                  
	                  <div id="selectfolder" class="row wrapper selectrow selectr1">
	                   	<s:if test="yid == null || yid.length==0">
	                   		<s:set name="yid" value="{2015}"></s:set>
	                   	</s:if>
	                   	<s:else>
	                   		<input type="hidden" id="_cid" value="<s:property value="cid"/>"/>
	                   	</s:else>
	                   		
	                   	<s:iterator value="yid" id="yr" status="idx">
		                   <div class="m-b-xs prename">
			                   <span class="selectname longname">选择文件夹</span>
			                   <table>
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
					                   <select a="aaa" class="chosen-select" val="<s:property value="fid[#idx.index]"/>" name="fid" onchange="getChildrenByParentFavoriteId(this)">
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
					                   <a href='#' class="btn btn-sm btn-default m-r-sm select-all">全选</a>
					                   <a href='#' class="btn btn-sm btn-default deselect-all">取消全选</a>
					               	</p>
				                    <select c="ccc" multiple='multiple' name="cid">
								    	<option value="-1">请选择</option>
								    </select>
				                   </div>
			                   </th>
			                   <th class="opfolder">
			                   		<s:if test="#idx.index > 0">
			                   			<a href="javascript:void(0)" onclick="deletefloderrow(this)" class="iconbtn"><i class="fa fa-trash-o"></i></a>
			                   		</s:if>
			                   		<s:else>
			                   			<a href="javascript:void(0)" class="btn btn-sm btn-default plus-btn" onclick="addfloderrown(this)">
							            	<i class="fa fa-plus text"></i>
							            </a>
			                   		</s:else>
			                   </th>
			                   
			                    </tr>
			                   </tbody>
			                   </table>
		                   </div>
	                   		</s:iterator>
	                   </div>
	                   
	                  
	                  <div id="selecttime" class="row wrapper selectrow selectr2">
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
	                  
	                  <div class="row wrapper selectrow b-b" style="padding-bottom: 10px;">
	                   <div class="m-b-xs prename">
	                   <span class="selectname longname">标签分类</span>
	
	                   <div class="btn-group m-r">
	                   <select class="chosen-select" name="tagCategoryId" val="<s:property value="tagCategoryId"/>">
	                           <option value="-1">请选择</option>
	                           <s:iterator value="tagCategoryList">
	                           <option value="<s:property value="id"/>"><s:property value="name"/></option>
	                           </s:iterator>
	                   </select>
	                   </div>                 
	                   </div>
	                   </div>
				  	</div>
				  	<!-- 查询内容 -->
				  </div>
                  <div class="row wrapper selectrow search-btn p-t-none" style="padding-bottom:15px;">
                  	<button type="submit" class="btn btn-s-md btn-primary">开始计算</button>
                  	<!-- <button type="submit" class="btn btn-s-md btn-primary">重置</button> -->
                  </div>

                  
                  </section>
                  </form>
                  <section class="panel panel-default list-show">
                  <header class="panel-heading">
                  分析结果             
                  </header>
                  <div class="row wrapper">
                  <s:if test="pieDataContent != null">
                  <div id="pieChart"  style="height:240px"></div>
                  </s:if>
                  
                  <div class="col-sm-3 m-b-xs"></div>
                  <div class="col-sm-6 text-center m-b-xs"></div>
                                    <form action="chart_init.action?menuUrl=chart_init" method="post">
                                    <div class="col-sm-3">
                                      <div class="input-group">
                                        <input type="text" name="title" value="<s:property value="title" />" class="input-sm form-control" placeholder="搜索标签名">
                                        <span class="input-group-btn">
                                          <button class="btn btn-sm btn-default" type="submit"><i class="fa fa-search"></i></button>
                                        </span>
                                      </div>
                                    </div>
                                    </form>
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
                                      	<s:iterator value="tagList">
                                        <tr>
                                          <td><s:property value="name"/></td>
                                          <td><s:property value="articleNum"/></td>
                                          <td>
                                          	<s:if test="articleNum>0">
                                          		<!-- href="#modal-checkpost" -->
                                          		<a href="javascript:void(0)" onclick="tov(<s:property value="id"/>)" data-toggle="modal" class="iconbtn"><i class="fa fa-eye"></i> 查看文章</a>
                                          	</s:if>
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
								<a href="chart_init.action?menuUrl=chart_init&queryChart.id=<s:property value='id' />" class="h5 text-success"><s:property value='title' /></a>
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