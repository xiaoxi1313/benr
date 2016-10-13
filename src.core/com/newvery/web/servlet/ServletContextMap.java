package com.newvery.web.servlet;

import java.util.HashMap;
import java.util.Map;

public class ServletContextMap {

	private static Map<String, Class<?>> contextMap;
	
	static {
		contextMap = new HashMap<String, Class<?>>();
//		contextMap.put("/index", IndexAction.class);						//用户注册
//		contextMap.put("/check_register_name",CheckRegisterNameServlet.class);	//检查用户名是否存在
//		contextMap.put("/login", LoginServlet.class);							//登录
//		contextMap.put("/loginAjax", LoginAjaxServlet.class);							//登录
//		contextMap.put("/main", MainServlet.class);								//管理中心
//		contextMap.put("/dir_info", GroupDirInfoServlet.class);					//文件夹下文件信息
//		contextMap.put("/files", GetDirTreeServlet.class);
//		contextMap.put("/search", SearchServlet.class);
//		contextMap.put("/createGroup", CreateGroupServlet.class);
//		contextMap.put("/searchGroup", SearchGroupServlet.class);
//		contextMap.put("/joinGroup", JoinGroupServlet.class);
//		
//		contextMap.put("/createDir", CreateDirServlet.class);
//		contextMap.put("/history", FileHistoryServlet.class);
//		contextMap.put("/deleteFile", DeleteFileServlet.class);
//		contextMap.put("/rename", RenameFileServlet.class);
//		contextMap.put("/getfileacl", FileAclGetServlet.class);
//		contextMap.put("/setfileacl", FileAclSetServlet.class);
//		
//		/**-- added by mi_xb start --*/
//		contextMap.put("/getGroupInfo", GetGroupInfoServlet.class);
//		contextMap.put("/updateGroup", UpdateGroupServlet.class);
//		contextMap.put("/borad", BoradServlet.class);
//		contextMap.put("/groupClose", GroupCloseServlet.class);
//		contextMap.put("/getGroupFlags", GetGroupFlagsServlet.class);
//		contextMap.put("/groupOption", GroupOptionServlet.class);
//		contextMap.put("/getGroupUserList", GetGroupUserListServlet.class);
//		contextMap.put("/groupUserManage", GroupUserManageServlet.class);
//		contextMap.put("/mail_invert", InvertMailServlet.class);
//		contextMap.put("/checkgroupname", CheckGroupNameServlet.class);
//		
//		contextMap.put("/getFileCommnets", GetFileCommentsServlet.class);
//		contextMap.put("/fileCommentCommit", FileCommentCommitServlet.class);
//		contextMap.put("/deleteFileComment", DeleteFileCommentServlet.class);
//		/**-- added by mi_xb end --*/
//		
//		contextMap.put("/modifyPassword", ModifyPasswordServlet.class);
//		contextMap.put("/forget", ForgetServlet.class);
//		contextMap.put("/client_login", ClientLoginServlet.class);
//		
//		contextMap.put("/mymessagecount", MyMessageCountServlet.class);
//		contextMap.put("/mymessage", MyMessageServlet.class);
//		contextMap.put("/set_message", MyMessageSetServlet.class);
//		
//		contextMap.put("/group_statics", GroupStaticsServlet.class);
	}
	
	public static Class<?> get(String jsonName) {
		return contextMap.get(jsonName);
	}
	
}
