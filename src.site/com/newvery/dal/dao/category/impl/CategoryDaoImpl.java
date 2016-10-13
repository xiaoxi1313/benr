package com.newvery.dal.dao.category.impl;

import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;
import com.newvery.record.GroupCategoryRecord;
import com.newvery.record.UserCategoryRecord;
import com.newvery.web.bean.Page;

public class CategoryDaoImpl extends BaseDao implements ICategoryDao {
	
	/**
	 * Category
	 */
	@Override
	public CategoryRecord insertCategoryRecord(CategoryRecord category) throws ServiceException {
		getSqlTemplate().insert("insertCategory", category);
		return category;
	}

	@Override
	public CategoryRecord updateCategoryRecord(CategoryRecord category) throws ServiceException {
		getSqlTemplate().update("updateCategory", category);
		return category;
	}

	@Override
	public void deleteCategoryRecord(long categoryId) throws ServiceException {
		getSqlTemplate().delete("deleteCategory", categoryId);
	}

	@Override
	public List<CategoryRecord> findCategoryRecord() throws ServiceException {
		return getSqlTemplate().selectList("listCategory");
	}

	@Override
	public CategoryRecord findCategoryRecordByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findCategoryByPK", id);
	}

	@Override
	public int countCategoryRecord(String categoryName) throws ServiceException {
		return getSqlTemplate().selectOne("countCategoryRecord", categoryName);
	}
	
	@Override
	public int countCategoryByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countCategoryByPage", query);
	}

	@Override
	public List<CategoryRecord> findCategoryByPage(Map query, Page page)
			throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findCategoryByPage", query);
	}

	@Override
	public int countParentCategoryByPage(Map query) throws ServiceException {
		query.put("isParent", 1);
		return getSqlTemplate().selectOne("countCategoryByPage", query);
	}

	@Override
	public List<CategoryRecord> findParentCategoryByPage(Map query, Page page)
			throws ServiceException {
		query.put("isParent", 1);
		query.put("page", page);
		return getSqlTemplate().selectList("findCategoryByPage", query);
	}

	@Override
	public List<CategoryRecord> findChildrenByParentId(long parentId) throws ServiceException {
		return getSqlTemplate().selectList("listCategoryByParentId", parentId);
	}

	@Override
	public List<CategoryRecord> findAllParetnCategory() throws ServiceException {
		return getSqlTemplate().selectList("listAllParent");
	}

	@Override
	public List<CategoryRecord> findCategoryByParentId(long parentId) throws ServiceException {
		return getSqlTemplate().selectList("listCategoryByParentId", parentId);
	}

	@Override
	public void batchDeleteCategory(Map query) throws ServiceException {
		getSqlTemplate().update("batchDeleteCategory", query);
	}

	@Override
	public void updateArticle(long id, int articleNum) throws ServiceException {
		CategoryRecord category = new CategoryRecord();
		category.setId(id);
		category.setArticleNum(articleNum);
		
		getSqlTemplate().update("updateCategoryArticleNum", category);
	}
	
	@Override
	public CategoryRecord findCategoryByName(String name) throws ServiceException {
		return getSqlTemplate().selectOne("findCategoryByName", name);
	}
	
	@Override
	public void deleteGroupCategory(GroupCategoryRecord groupCategory) throws ServiceException {
		getSqlTemplate().delete("deleteGroupCategory",groupCategory);
	}
	
	@Override
	public void insertGroupCategory(GroupCategoryRecord groupCategory) throws ServiceException {
		getSqlTemplate().insert("insertGroupCategory", groupCategory);
	}
	
	@Override
	public void deleteUserCategory(UserCategoryRecord userCategory)throws ServiceException {
		getSqlTemplate().delete("deleteUserCategory",userCategory);
	}
	
	@Override
	public List<UserCategoryRecord> findUserCategoryRecordByUserId(long userId) throws ServiceException {
		return getSqlTemplate().selectList("findUserCategoryRecordByUserId", userId);
	}
	
	@Override
	public void insertUserCategory(UserCategoryRecord userCategory) throws ServiceException {
		getSqlTemplate().insert("insertUserCategory", userCategory);
	}
	
	@Override
	public List<GroupCategoryRecord> findGroupCategory(long groupId) throws ServiceException {
		return getSqlTemplate().selectList("findGroupCategory", groupId);
	}
}
