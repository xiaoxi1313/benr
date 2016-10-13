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
body{  
font-family:'Microsoft Yahei',SimSun; 
font-family:'Microsoft Yahei',SimHei;
font-family:'Microsoft Yahei',SimKai; 
font-size:14px;  
}  
.colorbar0{
background: #ff0000;
}
.colorbar1{
background: #ff00f6;
}
.colorbar2{
background: #7200ff;
}
.colorbar3{
background: #0034ff;
}
.colorbar4{
background: #00d2ff;
}
.colorbar5{
background: #00ff6c;
}
.colorbar6{
background: #cdcf00;
}
.colorbar7{
background: #ff6000;
}
</style>
</head>
<body style="padding: 0;margin: 0;font-family:'Microsoft Yahei',SimHei;">
	<div class="colorbar<s:property value="article.parentCategoryId % 8"/>" style="height: 30px;"></div>  
        <div id="content" style="padding-top: 10px;padding-bottom:10px;">
            <div style="width: 100%;"> 
	            <div style="color: #999;font-size: 14px;width: 50%;float: left;position: relative;display: block;">
	            	<s:property value="article.parentCategory.name"/>
	            	<span style="color: #eee;"> | </span>
	            	<s:property value="article.childCategory.name"/>
	            </div>
	            <div style="text-align: right;width: 50%;float: right;position: relative;display: block;">
	            	<img src="http://www.origintrend.com/resources/common/images/pdf-header-logo.png" style="width: 120px;height:17px;" />
	            </div>

                 <div style="margin-top: 30px;position: relative;display: block;float: left;width: 100%;">
                 	<div style="font-size: 32px;"><s:property value="article.title" /> </div> 
                    <div style="height: 10px;border-bottom:1px dashed #ccc;"></div>
                     <p class="zhaiyao" style="line-height: 26px;font-size: 16px;color:#777;font-family:'Microsoft Yahei',SimSun;">
						<s:property value="article.summary"/>
					</p>
                 </div>
				<s:if test="article.titleImage != null && article.titleImage != '' ">
					<img src="<s:property value="article.titleImage"/>" style="width: 100%;position: relative;display: block;float: left;"/>
				</s:if>
             </div>
        </div>
</body>
</html>

