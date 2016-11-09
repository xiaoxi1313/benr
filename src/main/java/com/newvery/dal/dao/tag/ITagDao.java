package com.newvery.dal.dao.tag;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.TagCategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.web.bean.Page;

public interface ITagDao {
	/* 标签 */
	public TagRecord insertTagRecord(TagRecord tag) throws ServiceException;
	public TagRecord updateTagRecord(TagRecord tag) throws ServiceException;
	
	public TagRecord updateTagStatus(long id, int status) throws ServiceException;
	
	public TagRecord updateArticleNum(long id, int articleNum) throws ServiceException;
	
	public void deleteTagRecord(long tagId) throws ServiceException;
	public void deleteTagArticle(long tagId) throws ServiceException;
	
	/**
	 * 批量删除
	 * @param query
	 * @throws ServiceException
	 */
	public void batchDeleteTag(Map query) throws ServiceException;
	public List<TagRecord> findTagRecord() throws ServiceException;
	
	public List<TagRecord> findTagRecordByStatus(int status) throws ServiceException;
	
	public List<TagRecord> findTagRecordByUserIdAndStatus(long userId, int status) throws ServiceException;
	
	public TagRecord findTagRecordByPK(long id) throws ServiceException;
	public int countTagRecord(String tagName) throws ServiceException;
	
	public TagRecord findTagRecordByName(String name) throws ServiceException;
	
	/**
	 * 查询标签总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countTagByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询标签分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<TagRecord> findTagByPage(Map query, Page page) throws ServiceException;
	
	public List<TagRecord> findAllTagByArticleId(long articleId) throws ServiceException;
	
	public List<TagRecord> findCommonTagByArticleId(long articleId) throws ServiceException;
	
	public List<TagRecord> findHotTagByArticleId(long articleId) throws ServiceException;
	
	/**
	 * 查询用户今日创建的标签
	 * @param userId
	 * @return
	 * @throws ServiceException
	 */
	public List<TagRecord> findTodayTagByUserId(long userId) throws ServiceException;
	
	
	/* 标签category */
	public long insertTagCategoryRecord(TagCategoryRecord tagCategory) throws ServiceException;
	public TagCategoryRecord updateTagCategoryRecord(TagCategoryRecord tagCategory) throws ServiceException;
	public void deleteTagCategoryRecord(long tagCategoryId) throws ServiceException;
	public List<TagCategoryRecord> findTagCategoryRecord() throws ServiceException;
	public TagCategoryRecord findTagCategoryRecordByPK(long id) throws ServiceException;
	public TagCategoryRecord findTagCategoryRecordByName(String name) throws ServiceException;
	public int countTagCategoryRecord(String tagCategoryName) throws ServiceException;
	
	
	//图表统计
	public List<Long> findTagArticleCondition(Map query) throws ServiceException;
}
