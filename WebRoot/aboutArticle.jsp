<%@page import="com.newvery.record.ArticleTagRecord"%>
<%@page import="com.newvery.record.TagRecord"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.newvery.record.ArticleRecord"%>
<%@page import="com.newvery.bean.BeanFactory"%>
<%@page import="com.newvery.web.bean.Page"%>
<%

String articleId = request.getParameter("article.id");

/*
Map query = new HashMap();
query.put("id", Long.valueOf(articleId));
Page p = new Page();
p.setCurPage(0);
p.setNumPerPage(3);
*/
//List<ArticleRecord> aboutArticleList = BeanFactory.getArticleDao().findAboutArticleByPage(query, p);

//List<TagRecord> tagList = BeanFactory.getTagDao().listAllTagByArticleId(Long.valueOf(articleId));

List<ArticleTagRecord> atlist = BeanFactory.getArticleDao().findArticleTagByArticleId(Long.valueOf(articleId));
List<ArticleRecord> aboutArticleList = new ArrayList<ArticleRecord>();
for(ArticleTagRecord at : atlist) {
	Map q = new HashMap();
	q.put("tagId", at.getTagId());
	aboutArticleList.addAll(BeanFactory.getArticleDao().findArticleByConditionForChartDistribution(q));
}
%>
<article>
	<header class="panel-heading">
		<ul class="nav nav-pills pull-right">
			<li><a href="#" class="panel-toggle text-muted"><i class="fa fa-caret-down text-active"></i><i class="fa fa-caret-up text"></i></a></li>
		</ul>
		关联资讯                    
	</header>
<%
if(aboutArticleList != null && aboutArticleList.size() > 0) {
%>

	<%
	for(ArticleRecord ar : aboutArticleList) {
		if(ar.getId() == Long.valueOf(articleId)) continue;
	%>
       <div class="panel-body">
       	<span class="pull-left thumb m-r"><img src="<%=ar.getTitleImage()%>"></span>
	       <div class="media-body">
		       <a href="article_show.action?article.id=<%=ar.getId()%>" class="h5">
		       <%=ar.getTitle()%>
		       <i class="fa fa-star text-success p-l-sm"></i>
		       </a>
		       <small class="block"><%=ar.getSummary()%></small>
	       </div>
       </div>
	<%
	}
	%>
<%}%>
</article> 