package com.newvery.dal.dao.article.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.article.IArticleDao;
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

public class ArticleDaoImpl extends BaseDao implements IArticleDao {
	
	/**
	 * Article
	 */
	@Override
	public ArticleRecord insertArticleRecord(ArticleRecord article) throws ServiceException {
		getSqlTemplate().insert("insertArticle", article);
		return article;
	}

	@Override
	public ArticleRecord updateArticleRecord(ArticleRecord article) throws ServiceException {
		getSqlTemplate().update("updateArticle", article);
		return article;
	}
	
	@Override
	public ArticleRecord updateArticleStatus(long articleId, int status) throws ServiceException {
		ArticleRecord article = new ArticleRecord();
		article.setId(articleId);
		article.setStatus(status);
		
		getSqlTemplate().update("updateArticleStatus", article);
		return article;
	}
	
	@Override
	public ArticleRecord updateArticleSummary(long articleId, String summary) throws ServiceException {
		ArticleRecord article = new ArticleRecord();
		article.setId(articleId);
		article.setSummary(summary);
		
		getSqlTemplate().update("updateArticleSummary", article);
		return article;
	}
	
	@Override
	public long getNextAritcleId(long aid) throws ServiceException {
		Object o= getSqlTemplate().selectOne("getNextAritcleId",aid);
		if(o != null) {
			return (Long)o;
		}
		return 0;
	}

	@Override
	public void deleteArticleRecord(long articleId) throws ServiceException {
		getSqlTemplate().update("deleteArticle", articleId);
	}
	
	@Override
	public void physicsDeleteArticleRecord(long id) throws ServiceException {
		getSqlTemplate().update("physicsDeleteArticle", id);
	}
	
	@Override
	public void batchDeleteArticleRecord(Map query) throws ServiceException {
		getSqlTemplate().update("batchDeleteArticle", query);
	}
	
	@Override
	public void batchPhysicsDeleteArticleRecord(Map query) throws ServiceException {
		getSqlTemplate().update("batchPhysicsDeleteArticle", query);
	}

	@Override
	public List<ArticleRecord> findArticleRecord() throws ServiceException {
		return getSqlTemplate().selectList("listArticle");
	}

	@Override
	public ArticleRecord findArticleRecordByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findArticleByPK", id);
	}

	@Override
	public int countArticleRecord(String articleName) throws ServiceException {
		return getSqlTemplate().selectOne("countArticleRecord", articleName);
	}
	
	@Override
	public int countArticleByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countArticleByPage", query);
	}

	@Override
	public List<ArticleRecord> findArticleByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findArticleByPage", query);
	}

	@Override
	public List<ArticleRecord> findChildrenByParentId(long parentId) throws ServiceException {
		return getSqlTemplate().selectList("listArticleByParentId", parentId);
	}
	
	@Override
	public int countArticleByConditionForChartDistribution(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countArticleByConditionForChartDistribution", query);
	}
	
	@Override
	public List<ArticleRecord> findArticleByConditionForChartDistribution(Map query) throws ServiceException {
		return getSqlTemplate().selectList("findArticleByConditionForChartDistribution", query);
	}
	
	@Override
	public List<ArticleRecord> findArticleByConditionForChartDistribution(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findArticleByConditionForChartDistribution", query);
	}
	
	@Override
	public List<ArticleRecord> listUnGroupedArticleByFavoriteId(long favoriteId) throws ServiceException {
		return getSqlTemplate().selectList("listUnGroupedArticleByFavoriteId", favoriteId);
	}
	
	@Override
	public List<ArticleRecord> findArticleByStatus(int status) throws ServiceException {
		return getSqlTemplate().selectList("listArticleByStatus", status);
	}

	/**
	 * ArticleImage
	 */
	@Override
	public List<ArticleImageRecord> findArticleImageByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("findArticleImageByArticleId", articleId);
	}

	@Override
	public void deleteArticleImage(long id) throws ServiceException {
		getSqlTemplate().update("deleteArticleImageById", id);
	}

	@Override
	public ArticleImageRecord insertArticleImage(ArticleImageRecord articleImage) throws ServiceException {
		getSqlTemplate().insert("insertArticleImage", articleImage);
		return articleImage;
	}
	
	@Override
	public List<ArticleRecord> findArticleByFavoriteId(long favoriteId) throws ServiceException {
		return getSqlTemplate().selectList("listArticleByFavoriteId", favoriteId);
	}
	
	@Override
	public ArticleImageRecord updateArticleImage(ArticleImageRecord articleImage) throws ServiceException {
		getSqlTemplate().update("updateArticleImage", articleImage);
		return articleImage;
	}

	@Override
	public ArticleImageRecord findArticleImageById(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findArticleImageByPK", id);
	}
	
	/**
	 * ArticleTag
	 */
	
	@Override
	public List<ArticleTagRecord> findArticleTagByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("findArticleTagByArticleId", articleId);
	}

	@Override
	public void deleteArticleTag(long id) throws ServiceException {
		getSqlTemplate().update("deleteArticleTagById", id);
	}

	@Override
	public ArticleTagRecord insertArticleTag(ArticleTagRecord articleTag) throws ServiceException {
		getSqlTemplate().insert("insertArticleTag", articleTag);
		return articleTag;
	}
	
	@Override
	public void deleteArticleTagByArticleId(long articleId) throws ServiceException {
		getSqlTemplate().delete("deleteArticleTagByArticleId", articleId);
	}
	
	@Override
	public void deleteArticleTagByArticleAndTagId(long articleId, long tagId)
			throws ServiceException {
		Map query = new HashMap();
		query.put("articleId", articleId);
		query.put("tagId", tagId);
		getSqlTemplate().delete("deleteArticleTagByArticleAndTagId", query);
	}

	@Override
	public ArticleTagRecord findArticleTagByArticleAndTagId(long articleId,
			long tagId) throws ServiceException {
		Map query = new HashMap();
		query.put("articleId", articleId);
		query.put("tagId", tagId);
		return getSqlTemplate().selectOne("findArticleTagByArticleAndTagId", query);
	}
	/**
	 * ArticleFavorite
	 */

	@Override
	public ArticleFavoriteRecord insertArticleFavorite(ArticleFavoriteRecord articleFavorite) throws ServiceException {
		getSqlTemplate().insert("insertArticleFavorite", articleFavorite);
		return articleFavorite;
	}

	@Override
	public List<ArticleFavoriteRecord> findArticleFavoriteByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("findArticleFavoriteByArticleId", articleId);
	}

	@Override
	public void deleteArticleFavorite(long articleId,long userId) throws ServiceException {
		Map query = new HashMap();
		query.put("userId", userId);
		query.put("articleId", articleId);
		getSqlTemplate().delete("deleteArticleFavoriteAndUserById", query);
	}
	
	@Override
	public void deleteArticleFavorite(long id) throws ServiceException {
		getSqlTemplate().delete("deleteArticleFavoriteById", id);
	}
	
	@Override
	public void deleteArticleGroupFavorite(long articleId,long favoriteGroupId) throws ServiceException {
		Map query = new HashMap();
		query.put("favoriteGroupId", favoriteGroupId);
		query.put("articleId", articleId);
		getSqlTemplate().delete("deleteGroupArticleUser", query);
	}
	
	@Override
	public ArticleFavoriteRecord updateArticleFavorite(ArticleFavoriteRecord articleFavorite) throws ServiceException {
		getSqlTemplate().update("updateArticleFavorite", articleFavorite);
		return articleFavorite;
	}

	/**
	 * Chart
	 */
	@Override
	public List<ChartRecord> findChartByCondition(Map query) throws ServiceException {
		return getSqlTemplate().selectList("findChartByCondition", query);
	}

	@Override
	public int countTotalChartByCondition(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countTotalChartByCondition", query);
	}

	@Override
	public int countMaxChartByCondition(Map query) throws ServiceException {
		Integer num = getSqlTemplate().selectOne("countMaxChartByCondition", query);
		return num==null?0:num;
	}
	
	@Override
	public List<ChartDistributionRecord> findChartDistributionByCondition(Map query) throws ServiceException {
		return getSqlTemplate().selectList("findChartDistributionByCondition", query);
	}

	@Override
	public ArticleFavoriteRecord findArticleFavorite(ArticleFavoriteRecord articleFavorite) throws ServiceException {
		return getSqlTemplate().selectOne("findArticleFavorite", articleFavorite);
	}

	@Override
	public int countFavoriteArticleByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countFavoriteArticleByPage", query);
	}

	@Override
	public List<ArticleRecord> findFavoriteArticleByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findFavoriteArticleByPage", query);
	}

	@Override
	public List<ArticleRecord> findAboutArticleByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findAboutArticleByPage", query);
	}
	
	@Override
	public List<ArticleFavoriteRecord> findArticleFavoriteByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findArticleFavoriteById", id);
	}

	@Override
	public List<ArticleRecord> findArticleChartByCondition(Map query)
			throws ServiceException {
		return getSqlTemplate().selectList("findArticleChartByCondition", query);
	}

	/**
	 * ArticlePraise  点赞
	 */
	
	@Override
	public ArticlePraiseRecord insertArticlePraise(ArticlePraiseRecord articlePraise) throws ServiceException {
		getSqlTemplate().insert("insertArticlePraise", articlePraise);
		return articlePraise;
	}

	@Override
	public void deleteArticlePraise(long id) throws ServiceException {
		getSqlTemplate().delete("deleteArticlePraiseById", id);
	}

	@Override
	public ArticlePraiseRecord findArticlePraise(ArticlePraiseRecord articlePraise) throws ServiceException {
		return getSqlTemplate().selectOne("findArticlePraise", articlePraise);
	}
	
	@Override
	public List<ArticleRecord> beforeAfterArticleList(long id) throws ServiceException {
		return getSqlTemplate().selectList("beforeAfterArticleList", id);
	}

	/**
	 * ArticleFavoriteGroup 用户收藏夹分组
	 */
	
	@Override
	public ArticleFavoriteGroupRecord insertArticleFavoriteGroup(ArticleFavoriteGroupRecord articleFavoriteGroup) throws ServiceException {
		getSqlTemplate().insert("insertArticleFavoriteGroup", articleFavoriteGroup);
		return articleFavoriteGroup;
	}

	@Override
	public ArticleFavoriteGroupRecord updateArticleFavoriteGroup(ArticleFavoriteGroupRecord articleFavoriteGroup) throws ServiceException {
		return null;
	}

	@Override
	public List<ArticleFavoriteGroupRecord> findArticleFavoriteGroupByGroupId(long favoriteGroupId) throws ServiceException {
		return getSqlTemplate().selectList("findArticleFavoriteGroupByGroupId", favoriteGroupId);
	}

	@Override
	public void deleteArticleFavoriteGroup(long id) throws ServiceException {
		getSqlTemplate().delete("deleteArticleFavoriteGroupByGroupId", id);
	}

	@Override
	public void deleteArticleFavoriteGroupByfavoriteGroupId(long favoriteGroupId) throws ServiceException {
		getSqlTemplate().delete("deleteArticleFavoriteGroupByGroupId", favoriteGroupId);
	}
	
	@Override
	public List<TagRecord> findLast3BuyArticle(long articleId) throws ServiceException {
		if(HotTagLRUCache.getInstance().get(articleId) != null ) {
			return (List<TagRecord>) HotTagLRUCache.getInstance().get(articleId);
		}
		
		
		List<TagRecord> results = new ArrayList<TagRecord>();
		List<ArticleTagRecord> atlist = getSqlTemplate().selectList("findLast3BuyArticle",articleId);
		for (ArticleTagRecord atr : atlist) {
			TagRecord tr = getSqlTemplate().selectOne("findTagByPK",atr.getTagId());
			results.add(tr);
		}
		
		HotTagLRUCache.getInstance().put(articleId, results);
		return results;
	}

	@Override
	public List<ChartTagRecord> findChartTagByCondition(Map query)
			throws ServiceException {
		return getSqlTemplate().selectList("findChartTagByCondition", query);
	}
	
	@Override
	public List<ArticleFavoriteRecord> findArticleFavoriteByUserAndArticle( long userId, long articleId) throws ServiceException {
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("articleId", articleId);
		return getSqlTemplate().selectList("findArticleFavoriteByUserAndArticle",map);
	}
	
	@Override
	public ArticleFavoriteGroupRecord selectFavoriteGroupSingleOjbect( long articleId, long favoriteGroupId) throws ServiceException {
		Map map = new HashMap();
		map.put("articleId", articleId);
		map.put("favoriteGroupId", favoriteGroupId);
		
		return getSqlTemplate().selectOne("selectFavoriteGroupSingleOjbect", map);
	}
}
