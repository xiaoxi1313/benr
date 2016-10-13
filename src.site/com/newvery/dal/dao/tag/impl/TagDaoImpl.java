package com.newvery.dal.dao.tag.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.tag.ITagDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagCategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.web.bean.Page;

public class TagDaoImpl extends BaseDao implements ITagDao {
	
	/**
	 * Tag
	 */
	@Override
	public TagRecord insertTagRecord(TagRecord tag) throws ServiceException {
		getSqlTemplate().insert("insertTag", tag);
		return tag;
	}

	@Override
	public TagRecord updateTagRecord(TagRecord tag) throws ServiceException {
		getSqlTemplate().update("updateTag", tag);
		return tag;
	}

	@Override
	public void deleteTagRecord(long tagId) throws ServiceException {
		getSqlTemplate().delete("deleteTag", tagId);
	}

	@Override
	public void deleteTagArticle(long tagId) throws ServiceException {
		getSqlTemplate().delete("deleteTagArticle", tagId);
	}
	
	@Override
	public List<TagRecord> findTagRecord() throws ServiceException {
		return getSqlTemplate().selectList("listTag");
	}

	@Override
	public TagRecord findTagRecordByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findTagByPK", id);
	}

	@Override
	public int countTagRecord(String tagName) throws ServiceException {
		return getSqlTemplate().selectOne("countTagRecord", tagName);
	}
	
	@Override
	public int countTagByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countTagByPage", query);
	}

	@Override
	public List<TagRecord> findTagByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findTagByPage", query);
	}
	
	@Override
	public TagRecord findTagRecordByName(String name) throws ServiceException {
		return getSqlTemplate().selectOne("findTagByName", name);
	}
	
	@Override
	public List<TagRecord> findAllTagByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("listAllTagByArticleId", articleId);
	}
	
	@Override
	public List<TagRecord> findCommonTagByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("listCommonTagByArticleId", articleId);
	}

	@Override
	public List<TagRecord> findHotTagByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("listHotTagByArticleId", articleId);
	}
	
	@Override
	public List<TagRecord> findTodayTagByUserId(long userId) throws ServiceException {
		return getSqlTemplate().selectList("listTodayTagByUserId", userId);
	}


	/**
	 * TagCategory
	 */
	@Override
	public long insertTagCategoryRecord(TagCategoryRecord tagCategory) throws ServiceException {
		return getSqlTemplate().insert("insertTagCategory", tagCategory);
	}

	@Override
	public TagCategoryRecord updateTagCategoryRecord(TagCategoryRecord tagCategory) throws ServiceException {
		getSqlTemplate().update("updateTagCategory", tagCategory);
		return tagCategory;
	}

	@Override
	public void deleteTagCategoryRecord(long tagCategoryId) throws ServiceException {
		getSqlTemplate().delete("deleteTagCategory", tagCategoryId);
	}

	@Override
	public List<TagCategoryRecord> findTagCategoryRecord() throws ServiceException {
		return getSqlTemplate().selectList("listTagCategory");
	}

	@Override
	public TagCategoryRecord findTagCategoryRecordByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findTagCategoryByPK", id);
	}

	@Override
	public int countTagCategoryRecord(String tagCategoryName) throws ServiceException {
		return getSqlTemplate().selectOne("countTagCategoryRecord", tagCategoryName);
	}

	@Override
	public TagCategoryRecord findTagCategoryRecordByName(String name) throws ServiceException {
		return getSqlTemplate().selectOne("findTagCategoryByName", name);
	}

	@Override
	public void batchDeleteTag(Map query) throws ServiceException {
		getSqlTemplate().update("batchDeleteTag", query);
	}

	@Override
	public List<TagRecord> findTagRecordByStatus(int status) throws ServiceException {
		Map query = new HashMap();
		query.put("status", status);
		return getSqlTemplate().selectList("listTagByStatus", query);
	}

	@Override
	public TagRecord updateTagStatus(long id, int status) throws ServiceException {
		TagRecord t = new TagRecord();
		t.setId(id);
		t.setStatus(status);
		t.setModifyTime(new Date());
		
		getSqlTemplate().update("updateTagStatus", t);
		
		return t;
	}

	@Override
	public List<TagRecord> findTagRecordByUserIdAndStatus(long userId, int status) throws ServiceException {
		Map query = new HashMap();
		query.put("userId", userId);
		query.put("status", status);
		
		return getSqlTemplate().selectList("listTagByStatus", query);
	}

	@Override
	public TagRecord updateArticleNum(long id, int articleNum) throws ServiceException {
		TagRecord tag = new TagRecord();
		tag.setId(id);
		tag.setArticleNum(articleNum);
		
		getSqlTemplate().update("updateTagArticleNum" ,tag);
		return tag;
	}
	
	
	@Override
	public List<Long> findTagArticleCondition(Map query) throws ServiceException {
		return getSqlTemplate().selectList("findTagArticleCondition", query);
	}
}
