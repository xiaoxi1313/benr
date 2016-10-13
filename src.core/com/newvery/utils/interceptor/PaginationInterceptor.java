package com.newvery.utils.interceptor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.executor.ErrorContext;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.ExecutorException;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.MappedStatement.Builder;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.property.PropertyTokenizer;
import org.apache.ibatis.scripting.xmltags.ForEachSqlNode;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.TypeHandler;
import org.apache.ibatis.type.TypeHandlerRegistry;

import com.newvery.utils.ReflectHelper;
import com.newvery.web.bean.Page;

//只拦截select部分  
@Intercepts({ @Signature(type = Executor.class, method = "query", args = {
		MappedStatement.class, Object.class, RowBounds.class,
		ResultHandler.class }) })
public class PaginationInterceptor implements Interceptor {

	private final static Log log = LogFactory
			.getLog(PaginationInterceptor.class);

	public Object intercept(Invocation invocation) throws Throwable {

		MappedStatement mappedStatement = (MappedStatement) invocation
				.getArgs()[0];
		Object parameter = invocation.getArgs()[1];
		BoundSql boundSql = mappedStatement.getBoundSql(parameter);
		String originalSql = boundSql.getSql().trim();

		Object parameterObject = boundSql.getParameterObject();
		if (boundSql == null || boundSql.getSql() == null
				|| "".equals(boundSql.getSql()))
			return null;
		// 分页参数--上下文传参
		Page page = null;
		if(parameterObject!=null)
			page = (Page)ReflectHelper.isPage(parameterObject,"page");
		if(page!=null) 			
		{
		int totpage = page.getTotalNum();
		// 得到总记录数,前提是前面未做数据的统计
		if (totpage == 0) {
			StringBuffer countSql = new StringBuffer(originalSql.length() + 100);
			countSql.append("select count(1) from (").append(originalSql)
					.append(") t");
			Connection connection = mappedStatement.getConfiguration()
					.getEnvironment().getDataSource().getConnection();
			PreparedStatement countStmt = connection.prepareStatement(countSql
					.toString());
			BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(),
					countSql.toString(), boundSql.getParameterMappings(),
					parameterObject);
			setParameters(countStmt, mappedStatement, countBS, parameterObject);
			ResultSet rs = countStmt.executeQuery();
			if (rs.next()) {
				totpage = rs.getInt(1);
			}
			rs.close();
			countStmt.close();
			connection.close();
		}

		// 分页查询 本地化对象 修改数据库注意修改实现
		String pagesql = getPageSql(originalSql,page.getStartIndex(), page.getNumPerPage());
		//invocation.getArgs()[2] = new RowBounds(page.getStartIndex(), page.getNumPerPage());
		BoundSql newBoundSql = new BoundSql(mappedStatement.getConfiguration(),
				pagesql, boundSql.getParameterMappings(),
				boundSql.getParameterObject());
		MappedStatement newMs = null;
		try{
			newMs = copyFromMappedStatement(mappedStatement,
					new BoundSqlSqlSource(newBoundSql));
		}catch(Exception e){
			e.printStackTrace();
		}
		

		invocation.getArgs()[0] = newMs;
		}
		return invocation.proceed();
		

	}
	public static  String getPageSql(String sql,int startIndex,int endIndex){
		StringBuffer newSql = new StringBuffer();
		newSql.append(sql).append(" limit ").append(startIndex).append(", ").append(endIndex);
		return newSql.toString();
	}
	public static class BoundSqlSqlSource implements SqlSource {
		BoundSql boundSql;

		public BoundSqlSqlSource(BoundSql boundSql) {
			this.boundSql = boundSql;
		}

		public BoundSql getBoundSql(Object parameterObject) {
			return boundSql;
		}
	}

	public Object plugin(Object arg0) {
		return Plugin.wrap(arg0, this);
	}

	public void setProperties(Properties arg0) {

	}

	/**
	 * 对SQL参数(?)设值,参考org.apache.ibatis.executor.parameter.
	 * DefaultParameterHandler
	 * 
	 * @param ps
	 * @param mappedStatement
	 * @param boundSql
	 * @param parameterObject
	 * @throws SQLException
	 */
	private void setParameters(PreparedStatement ps,
			MappedStatement mappedStatement, BoundSql boundSql,
			Object parameterObject) throws SQLException {
		ErrorContext.instance().activity("setting parameters")
				.object(mappedStatement.getParameterMap().getId());
		List<ParameterMapping> parameterMappings = boundSql
				.getParameterMappings();
		if (parameterMappings != null) {
			Configuration configuration = mappedStatement.getConfiguration();
			TypeHandlerRegistry typeHandlerRegistry = configuration
					.getTypeHandlerRegistry();
			MetaObject metaObject = parameterObject == null ? null
					: configuration.newMetaObject(parameterObject);
			for (int i = 0; i < parameterMappings.size(); i++) {
				ParameterMapping parameterMapping = parameterMappings.get(i);
				if (parameterMapping.getMode() != ParameterMode.OUT) {
					Object value;
					String propertyName = parameterMapping.getProperty();
					PropertyTokenizer prop = new PropertyTokenizer(propertyName);
					if (parameterObject == null) {
						value = null;
					} else if (typeHandlerRegistry
							.hasTypeHandler(parameterObject.getClass())) {
						value = parameterObject;
					} else if (boundSql.hasAdditionalParameter(propertyName)) {
						value = boundSql.getAdditionalParameter(propertyName);
					} else if (propertyName
							.startsWith(ForEachSqlNode.ITEM_PREFIX)
							&& boundSql.hasAdditionalParameter(prop.getName())) {
						value = boundSql.getAdditionalParameter(prop.getName());
						if (value != null) {
							value = configuration.newMetaObject(value)
									.getValue(
											propertyName.substring(prop
													.getName().length()));
						}
					} else {
						value = metaObject == null ? null : metaObject
								.getValue(propertyName);
					}
					TypeHandler typeHandler = parameterMapping.getTypeHandler();
					if (typeHandler == null) {
						throw new ExecutorException(
								"There was no TypeHandler found for parameter "
										+ propertyName + " of statement "
										+ mappedStatement.getId());
					}
					typeHandler.setParameter(ps, i + 1, value,
							parameterMapping.getJdbcType());
				}
			}
		}
	}

	private MappedStatement copyFromMappedStatement(MappedStatement ms,
			SqlSource newSqlSource) {
		Builder builder = new MappedStatement.Builder(ms.getConfiguration(),
				ms.getId(), newSqlSource, ms.getSqlCommandType());
		builder.resource(ms.getResource());
		builder.fetchSize(ms.getFetchSize());
		builder.statementType(ms.getStatementType());
		builder.keyGenerator(ms.getKeyGenerator());
		builder.timeout(ms.getTimeout());
		builder.parameterMap(ms.getParameterMap());
		builder.resultMaps(ms.getResultMaps());
		builder.cache(ms.getCache());
		MappedStatement newMs = builder.build();
		return newMs;
	}

}