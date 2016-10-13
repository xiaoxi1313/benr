package com.newvery.dal.dao.permission.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.permission.IPermissionDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.AdminRole;
import com.newvery.record.MenuRecord;
import com.newvery.record.RoleMenu;
import com.newvery.record.RoleRecord;

public class PermissionDaoImpl extends BaseDao implements IPermissionDao {

	/*
	 * 菜单
	 */
	public List<MenuRecord> findAllMenuList() throws ServiceException {
		return getSqlTemplate().selectList("listMenu");
	}
	
	public MenuRecord findMenuRecordByPK(long acid) throws ServiceException {
		return getSqlTemplate().selectOne("findMenuByPK",acid);
	}

	public List<MenuRecord> findTopLevelMenuList() throws ServiceException {
		return getSqlTemplate().selectList("findMenulistByParent", 0);
	}


	public List<MenuRecord> findMenuListByPK(long id) throws ServiceException {
		return getSqlTemplate().selectList("findMenulistByParent", id);
	}
	
	public MenuRecord insertMenuRecord(MenuRecord menu) throws ServiceException {
		getSqlTemplate().insert("insertMenu", menu);
		return menu;
	}

	public MenuRecord updateMenuRecord(MenuRecord menu) throws ServiceException {
		getSqlTemplate().update("updateMenu",menu);
		return menu;
	}

	public void deleteMenuRecord(long acid) throws ServiceException {
		getSqlTemplate().delete("deleteMenu",acid);
	}

	public int countMenuRecord(String name,long parentId) throws ServiceException{
		Map<String, String> keys = new HashMap<String, String>();
		keys.put("menu_name", name);
		keys.put("parent_id", parentId+"");
		return getSqlTemplate().selectOne("countMenuRecord",keys);
	}
	
	
	
	/*
	 * 角色
	 */
	public long insertRoleRecord(RoleRecord role) throws ServiceException {
		getSqlTemplate().insert("insertRole", role);
		return role.getId();
	}

	public RoleRecord updateRoleRecord(RoleRecord role) throws ServiceException {
		getSqlTemplate().update("updateRole",role);
		return role;
	}

	public void deleteRoleRecord(long rid) throws ServiceException {
		getSqlTemplate().delete("deleteRole",rid);
	}

	public List<RoleRecord> findRoleRecord() throws ServiceException {
		return getSqlTemplate().selectList("listRole");
	}

	public RoleRecord findRoleRecordByPK(long rid) throws ServiceException {
		return getSqlTemplate().selectOne("findRoleByPK",rid);
	}
	public int countRoleRecord(String name) throws ServiceException{
		return getSqlTemplate().selectOne("countRoleRecord",name);
	}
	
	/*AdminRole*/
	public AdminRole insertAdminRole(AdminRole adminrole)throws ServiceException {
		getSqlTemplate().insert("insertAdminRole", adminrole);
		return adminrole;
	}

	public void deleteAdminRole(long acid) throws ServiceException {
		getSqlTemplate().delete("deleteAdminRoleByAdmin",acid);
	}

	public AdminRole findAdminRoleByAdmin(long aid)throws ServiceException {
		return getSqlTemplate().selectOne("findAdminRoleByAdmin",aid);
	}
	
	/*RoleMenu*/
	public RoleMenu insertRoleMenu(RoleMenu adminrole) throws ServiceException {
		getSqlTemplate().insert("insertRoleMenu", adminrole);
		return adminrole;
	}

	public void deleteRoleMenu(long rid) throws ServiceException {
		getSqlTemplate().delete("deleteRoleMenuByRole",rid);
	}

	public List<RoleMenu> findRoleMenuByRole(long rid) throws ServiceException {
		return getSqlTemplate().selectList("findRoleMenuByRole",rid);
	}
	
	@Override
	public void deleteRoleByUserId(long id) throws ServiceException {
		getSqlTemplate().delete("deleteRoleByUserId", id);
	}
}
