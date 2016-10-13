<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:iterator value="articleList" id="article" status="u">
<div class="item col-sm-12 col-md-12 post hulianwang">
	<section class="panel b-a">
		<div class="clearfix text-center m-b-sm title-pic">
			<div class="picframe">
				<a href="#">
					<img src="<s:property value='titleImage' />" class="thumb-o">
				</a>
				<div class="hover-content">
					<div class="overlay"></div>
					<div class="link-contianer">
						<a href="#">查看详情</a>
					</div>
				</div>
			</div>
			<div class="h5 m-t m-b-xs posttitlename">
				<a href="#"><s:property value="title" /></a>
			</div>
			<div class="text-danger postedtime"><s:date name="#article.createTime" format="yyyy年MM月dd日" /></div>
			<div class="label bg-success m-b-xs">
				分类：<span><s:property value="parentCategory.name" /></span>
			</div>
			<div class="text-muted p-b-md p-t-xs m-b-sm b-b">
				收藏至：<span><s:property value="childFavorite.name" /></span>
			</div>
			<div class="text-left abs-text"><s:property value="summary" escape="false" /></div>
		</div>
		<div class="clearfix panel-footer">
			<s:iterator value="chartDistributionList" id="chartDistribution" status="s">
				<a href="#" class="tag bg-success r-coner-lg font-sm">
					<s:property value="#chartDistribution.tagName" />
					<span class="badge bg-danger m-l-xs">
						<s:property value="#chartDistribution.num" />
					</span>
				</a>
			</s:iterator>
		</div>
	</section>
</div>
</s:iterator>
