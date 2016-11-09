package com.newvery.dal.dao.article;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteGroupRecord;
import com.newvery.record.ArticleFavoriteRecord;
import com.newvery.record.ArticleImageRecord;
import com.newvery.record.ArticlePraiseRecord;
import com.newvery.record.ArticleRecord;
import com.newvery.record.ArticleTagRecord;
import com.newvery.record.ChartDistributionRecord;
import com.newvery.record.ChartRecord;
import com.newvery.record.ChartTagRecord;
import com.newvery.record.TagRecord;
import com.newvery.web.bean.Page;

public interface IArticleDao {
	/* 文章 */
	public ArticleRecord insertArticleRecord(ArticleRecord article) throws ServiceException;
	public ArticleRecord updateArticleRecord(ArticleRecord article) throws ServiceException;
	
	/**
	 * 修改状态
	 * @param articleId
	 * @param status
	 * @return
	 * @throws ServiceException
	 */
	public ArticleRecord updateArticleStatus(long articleId, int status) throws ServiceException;
	
	/*
	 * 更新文章摘要
	 */
	public ArticleRecord updateArticleSummary(long articleId, String summary) throws ServiceException;
	
	/**
	 * 移到回收站
	 * @param articleId
	 * @throws ServiceException
	 */
	public void deleteArticleRecord(long articleId) throws ServiceException;
	
	/**
	 * 物理删除
	 * @param id
	 * @throws ServiceException
	 */
	public void physicsDeleteArticleRecord(long id) throws ServiceException; 
	
	/**
	 * 批量移入回收站
	 * @param query
	 * @throws ServiceException
	 */
	public void batchDeleteArticleRecord(Map query) throws ServiceException;
	
	/**
	 * 批量物理删除
	 * @param query
	 * @throws ServiceException
	 */
	public void batchPhysicsDeleteArticleRecord(Map query) throws ServiceException;
	
	public List<ArticleRecord> findArticleRecord() throws ServiceException;
	public List<ArticleRecord> findChildrenByParentId(long parentId) throws ServiceException;
	public ArticleRecord findArticleRecordByPK(long id) throws ServiceException;
	public int countArticleRecord(String articleName) throws ServiceException;
	
	public List<ArticleRecord> findAboutArticleByPage(Map query, Page page) throws ServiceException;
	
	/**
	 * 查询文章总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countArticleByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询文章分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<ArticleRecord> findArticleByPage(Map query, Page page) throws ServiceException;
	
	/**
	 * 查询收藏家内文章总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countFavoriteArticleByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询收藏家内文章分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<ArticleRecord> findFavoriteArticleByPage(Map query, Page page) throws ServiceException;
	
	
	
	/**
	 * 根据收藏夹查询文章
	 * @param favoriteId
	 * @return
	 * @throws ServiceException
	 */
	public List<ArticleRecord> findArticleByFavoriteId(long favoriteId) throws ServiceException;
	
	/**
	 * 根据状态查询文章
	 * @param status
	 * @return
	 * @throws ServiceException
	 */
	public List<ArticleRecord> findArticleByStatus(int status) throws ServiceException;
	
	public int countArticleByConditionForChartDistribution(Map query) throws ServiceException ;
	
	public List<ArticleRecord> findArticleByConditionForChartDistribution(Map query) throws ServiceException;
	
	public List<ArticleRecord> findArticleByConditionForChartDistribution(Map query,Page page) throws ServiceException;
	
	/**
	 * 根据收藏夹ID查询该收藏夹下未分组的文章列表
	 * @param favoriteId
	 * @return
	 * @throws ServiceException
	 */
	public List<ArticleRecord> listUnGroupedArticleByFavoriteId(long favoriteId) throws ServiceException;
	
	
	/**
	 * ArticleImage
	 */
	public ArticleImageRecord insertArticleImage(ArticleImageRecord articleImage) throws ServiceException;
	
	public ArticleImageRecord updateArticleImage(ArticleImageRecord articleImage) throws ServiceException;
	
	public ArticleImageRecord findArticleImageById(long id) throws ServiceException;
	
	public List<ArticleImageRecord> findArticleImageByArticleId(long articleId) throws ServiceException;
	
	public void deleteArticleImage(long id) throws ServiceException;
	
	public long getNextAritcleId(long aid) throws ServiceException;
	
	
	/**
	 * ArticleTag
	 */
	public ArticleTagRecord insertArticleTag(ArticleTagRecord articleTag) throws ServiceException;
	
	public List<ArticleTagRecord> findArticleTagByArticleId(long articleId) throws ServiceException;
	
	public void deleteArticleTag(long id) throws ServiceException;
	
	public void deleteArticleTagByArticleId(long articleId) throws ServiceException;
	
	public void deleteArticleTagByArticleAndTagId(long articleId,long tagId) throws ServiceException;
	
	public ArticleTagRecord findArticleTagByArticleAndTagId(long articleId,long tagId) throws ServiceException;
	
	/**
	 * ArticleFavorite
	 */
	public ArticleFavoriteRecord insertArticleFavorite(ArticleFavoriteRecord articleFavorite) throws ServiceException;
	
	public ArticleFavoriteRecord updateArticleFavorite(ArticleFavoriteRecord articleFavorite) throws ServiceException;
	
	public List<ArticleFavoriteRecord> findArticleFavoriteByArticleId(long articleId) throws ServiceException;
	
	public List<ArticleFavoriteRecord> findArticleFavoriteByPK(long id) throws ServiceException;
	
	public void deleteArticleFavorite(long articleId,long userId) throws ServiceException;
	public void deleteArticleFavorite(long id) throws ServiceException;
	
	public ArticleFavoriteRecord findArticleFavorite(ArticleFavoriteRecord articleFavorite) throws ServiceException;
	
	/**
	 * Chart
	 */
	public List<ChartRecord> findChartByCondition(Map query) throws ServiceException;
	
	public int countTotalChartByCondition(Map query) throws ServiceException;
	
	public int countMaxChartByCondition(Map query) throws ServiceException;
	
	public List<ChartDistributionRecord> findChartDistributionByCondition(Map query) throws ServiceException; 
	
	public List<ArticleRecord> findArticleChartByCondition(Map query) throws ServiceException; 

	public List<ChartTagRecord> findChartTagByCondition(Map query) throws ServiceException; 

	/**
	 * ArticlePraise  点赞
	 */
	public ArticlePraiseRecord insertArticlePraise(ArticlePraiseRecord articlePraise) throws ServiceException;
	
	public void deleteArticlePraise(long id) throws ServiceException;
	
	public ArticlePraiseRecord findArticlePraise(ArticlePraiseRecord articlePraise) throws ServiceException;
	public List<ArticleRecord> beforeAfterArticleList(long id) throws ServiceException;
	
	/**
	 * ArticleFavoriteGroup 用户收藏夹分组
	 */
	public ArticleFavoriteGroupRecord insertArticleFavoriteGroup(ArticleFavoriteGroupRecord articleFavoriteGroup) throws ServiceException;
	
	public ArticleFavoriteGroupRecord updateArticleFavoriteGroup(ArticleFavoriteGroupRecord articleFavoriteGroup) throws ServiceException;
	
	public List<ArticleFavoriteGroupRecord> findArticleFavoriteGroupByGroupId(long favoriteGroupId) throws ServiceException;
	
	public void deleteArticleFavoriteGroup(long id) throws ServiceException;
	
	public void deleteArticleFavoriteGroupByfavoriteGroupId(long favoriteGroupId) throws ServiceException;
	
	
	/**
	 * 获取文章的三个所在标签
	 * @param articleId
	 * @return
	 * @throws ServiceException
	 */
	public List<TagRecord> findLast3BuyArticle(long articleId) throws ServiceException;
	
	public List<ArticleFavoriteRecord> findArticleFavoriteByUserAndArticle(long userId, long articleId) throws ServiceException;
	
	public void deleteArticleGroupFavorite(long articleId,long favoriteGroupId) throws ServiceException;
	
	
	public ArticleFavoriteGroupRecord selectFavoriteGroupSingleOjbect(long articleId,long favoriteGroupId ) throws ServiceException;
}
