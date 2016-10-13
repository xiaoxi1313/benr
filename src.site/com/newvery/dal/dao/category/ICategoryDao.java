package com.newvery.dal.dao.category;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;
import com.newvery.record.GroupCategoryRecord;
import com.newvery.record.UserCategoryRecord;
import com.newvery.web.bean.Page;

public interface ICategoryDao {
	/* 分类 */
	public CategoryRecord insertCategoryRecord(CategoryRecord category) throws ServiceException;
	public CategoryRecord updateCategoryRecord(CategoryRecord category) throws ServiceException;
	
	public void updateArticle(long id, int articleNum) throws ServiceException;
	public void deleteCategoryRecord(long categoryId) throws ServiceException;
	
	/**
	 * 批量删除
	 * @param query
	 * @throws ServiceException
	 */
	public void batchDeleteCategory(Map query) throws ServiceException;
	
	public List<CategoryRecord> findCategoryRecord() throws ServiceException;
	public List<CategoryRecord> findChildrenByParentId(long parentId) throws ServiceException;
	public CategoryRecord findCategoryRecordByPK(long id) throws ServiceException;
	public int countCategoryRecord(String categoryName) throws ServiceException;
	
	public List<CategoryRecord> findAllParetnCategory() throws ServiceException;
	
	public List<CategoryRecord> findCategoryByParentId(long parentId) throws ServiceException;
	
	/**
	 * 查询分类总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countCategoryByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询分类分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<CategoryRecord> findCategoryByPage(Map query, Page page) throws ServiceException;
	
	/**
	 * 查询一级分类总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countParentCategoryByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询一级分类分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<CategoryRecord> findParentCategoryByPage(Map query, Page page) throws ServiceException;
	public CategoryRecord findCategoryByName(String name)throws ServiceException; 
	
	
	public void insertGroupCategory(GroupCategoryRecord groupCategory) throws ServiceException;
	public void deleteGroupCategory(GroupCategoryRecord groupCategory) throws ServiceException;
	
	
	public void insertUserCategory(UserCategoryRecord userCategory) throws ServiceException;
	public void deleteUserCategory(UserCategoryRecord userCategory) throws ServiceException;
	public List<UserCategoryRecord> findUserCategoryRecordByUserId(long userId) throws ServiceException;
	
	public List<GroupCategoryRecord> findGroupCategory(long groupId) throws ServiceException;
}
