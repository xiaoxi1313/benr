package com.newvery.dal.dao;

import org.mybatis.spring.SqlSessionTemplate;

public abstract class BaseDao {
	
	private SqlSessionTemplate sqlTemplate;

	public SqlSessionTemplate getSqlTemplate() {
		return sqlTemplate;
	}

	public void setSqlTemplate(SqlSessionTemplate sqlTemplate) {
		this.sqlTemplate = sqlTemplate;
	}
}
