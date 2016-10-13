package com.newvery.web.action;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.newvery.task.SecurityExecutor;
import com.newvery.web.BaseAction;


public class BaseWebAction extends BaseAction {

	private static final long serialVersionUID = -2185509424245248298L;
	
	private Map session;
	protected long id;
	protected long[] ids;
	protected String logInfo;// 日志记录信息
	protected String redirectionUrl;// 操作提示后的跳转URL,为null则返回前一页
	
	protected SecurityExecutor securityExecutor;
	
	protected int pageNo;				//分页
	
	
	@Override
	public String input() {
		return null;
	}
	
	// 输出JSON成功消息，返回null
	@Override
	public String ajaxJsonSuccessMessage(String message) {
		Map<String, String> jsonMap = new HashMap<String, String>();
		jsonMap.put(STATUS, SUCCESS);
		jsonMap.put(MESSAGE, message);
		JSONObject jsonObject = JSONObject.fromObject(jsonMap);
		return ajax(jsonObject.toString(), "text/html");
	}
	
	public String outputSerialNumber(String prestr, String currentNumber){
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 5-(currentNumber).length(); i++) {
			sb.append("0");
		}
		sb.append(currentNumber);
		return prestr+""+sb.toString();
	}
	
	public SecurityExecutor getSecurityExecutor() {
		return securityExecutor;
	}

	public void setSecurityExecutor(SecurityExecutor securityExecutor) {
		this.securityExecutor = securityExecutor;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public Map getSession() {
		return session;
	}

	public void setSession(Map session) {
		this.session = session;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public long[] getIds() {
		return ids;
	}

	public void setIds(long[] ids) {
		this.ids = ids;
	}

	
	
}
