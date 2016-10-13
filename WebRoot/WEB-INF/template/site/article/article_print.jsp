<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@ page import="com.newvery.web.helper.UrlHelper"%>
<%@ page import="com.newvery.utils.TimeUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"></meta>
  <title>本然创新研究服务平台</title>
  <style>
  @page{
	size: 38cm 18.74cm;
	padding:0;
	margin：0；
  }
  body{  
	font-family:'Microsoft Yahei',SimSun; 
	font-family:'Microsoft Yahei',SimHei;
	font-family:'Microsoft Yahei',SimKai; 
	font-size:14px;  
	} 
  .pdftags .graytag {
  	padding: 5px 10px;
  	font-size: 14px;
  	min-width:8em;
  	width: auto;
  	position: relative;
  	display: block;
  	float: left;
  	margin: 15px 30px 0px 0px;
  	border-radius: 3px;
  	-moz-border-radius: 3px;
    -webkit-border-radius: 3px;
  }

  </style>
 </head>
<body id="pdfmode2" style="font-family:'Microsoft Yahei','SimHei','SimSun';padding: 0;margin: 0;">
<div id="content" style="padding:0px;">
                
                  <div style="width: 100%;">
                  <div style="color: #999;font-size: 12px;width: 100%;float: left;position: relative;display: block;margin-bottom: 5px;"><span ><s:date name="article.createTime" format="yyyy年MM月dd日" /></span></div>
                  <div style="color: #999;font-size: 13px;width: 100%;float: left;position: relative;display: block;font-family:'Microsoft Yahei','SimSun';">
                  	<s:property value="article.parentCategory.name"/>&nbsp;>&nbsp;<s:property value="article.childCategory.name"/></div>


                          <div style="margin-top: 90px;position: relative;display: block;float: left;width: 50%;">
                          <div style="font-size: 28px;margin-bottom:15px;"> <s:property value="article.title" /> </div> 
                          
                          <div style="" class="pdftags">
                          	<s:iterator value="tagList" id="tag" status="u">
                             <div class="graytag" style="border-radius:3px;"><s:property value="name" /></div>
                             </s:iterator>
                          </div>
                                        
                                          <div style="height: 10px;border-bottom:1px dashed #ccc;width: 93.5%;position: relative;display: block;float: left;margin-top:5px;margin-bottom:10px;"></div>
                                           <div class="zhaiyao" style="font-family:'Microsoft Yahei','SimSun';color:#777;line-height: 24px;font-size: 16px;width: 94.5%;position: relative;display: block;float: left;margin: 10px 0;">
											<s:property value="article.summary"/>
                                          </div>
                             </div> 
   										<s:if test="article.titleImage != null && article.titleImage != '' ">
   										<div class="titleimg" style="margin-top: 90px;width: 40%;margin-left: 10%;position: relative;display: block;float: left;">
											<img src="<s:property value="article.titleImage"/>"  />
										</div>
										</s:if>
                                        


                                <div style="text-align: left;width: 50%;float:left;position: fixed;display: block;bottom:0;"><img src="http://www.origintrend.com/resources/common/images/pdf-header-logo.png" style="width: 120px;height: 17px;" /></div>        


</div>
</div>


</body>
</html>