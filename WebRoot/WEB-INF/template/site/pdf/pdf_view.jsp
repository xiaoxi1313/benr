<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="pages" uri="/WEB-INF/sitepage.tld"%>
<%@page import="com.newvery.web.helper.UrlHelper"%>
<%@page import="com.newvery.utils.TimeUtil"%>
<!DOCTYPE html>
<html lang="en" class="app topadminhome">
<head>  
<title></title>
<style type="text/css">
<!--

#pdf {
	width: 900px;
	height: 500px;
	margin: 2em auto;
	border: 10px solid #6699FF;
}

#pdf p {
   padding: 1em;
}

#pdf object {
   display: block;
   border: solid 1px #666;
}

-->
</style>
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/jquery.min.js" charset="UTF-8"></script>
<script src="<%=UrlHelper.getHomeUrl()%>resources/common/js/pdfobject.js"></script>
 <script type="text/javascript">
 alert(document.getElementById('pdfPath').value);
     window.onload = function () {
         var success = new PDFObject({
             url: "/apache-tomcat-6.0.41/webapps/benr/file/2014112910590935985.pdf",
             pdfOpenParams: {
                 scrollbars: '0',
                 toolbar: '0',
                 statusbar: '0'
                 }
          }).embed("pdf");
     };
 </script> 

    <a href="<s:property value='pdfFile.pdf' />"><s:property value="pdfFile.title"/>.pdf</a>
   	
</head>
<body>
<input type="hidden" id="pdfPath" name="pdfPath" value="<s:property value='pdfFile.pdf' />">
<div id="pdf"  > <a href=""></a></div>

</body>
</html>
