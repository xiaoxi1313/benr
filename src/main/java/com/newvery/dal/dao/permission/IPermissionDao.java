package com.newvery.dal.dao.permission;

import java.util.List;

import com.newvery.exception.ServiceException;
import com.newvery.record.AdminRole;
import com.newvery.record.MenuRecord;
import com.newvery.record.RoleMenu;
import com.newvery.record.RoleRecord;


public interface IPermissionDao {
	
	/*
	 * 菜单   
	 */
	public MenuRecord findMenuRecordByPK(long acid) throws ServiceException;
	public List<MenuRecord> findAllMenuList() throws ServiceException;
	public List<MenuRecord> findTopLevelMenuList() throws ServiceException;
	public List<MenuRecord> findMenuListByPK(long id) throws ServiceException;
	public MenuRecord insertMenuRecord(MenuRecord menu) throws ServiceException;
	public MenuRecord updateMenuRecord(MenuRecord menu) throws ServiceException;
	public void deleteMenuRecord(long acid) throws ServiceException;
	public int countMenuRecord(String name,long parentId) throws ServiceException;
	
	/*
	 * 角色
	 */
	public long insertRoleRecord(RoleRecord role) throws ServiceException;
	public RoleRecord updateRoleRecord(RoleRecord role) throws ServiceException;
	public void deleteRoleRecord(long acid) throws ServiceException;
	public List<RoleRecord> findRoleRecord() throws ServiceException;
	public RoleRecord findRoleRecordByPK(long rid) throws ServiceException;
	public int countRoleRecord(String name) throws ServiceException;
	
	/*AdminRole*/
	public AdminRole insertAdminRole(AdminRole adminrole) throws ServiceException;
	public void deleteAdminRole(long acid) throws ServiceException;
	public AdminRole findAdminRoleByAdmin(long aid) throws ServiceException;
	
	/*RoleMenu*/
	public RoleMenu insertRoleMenu(RoleMenu adminrole) throws ServiceException;
	public void deleteRoleMenu(long rid) throws ServiceException;
	public List<RoleMenu> findRoleMenuByRole(long rid) throws ServiceException;
	public void deleteRoleByUserId(long id) throws ServiceException;
}
