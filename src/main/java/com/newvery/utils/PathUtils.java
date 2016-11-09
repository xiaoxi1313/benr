package com.newvery.utils;

public class PathUtils {
	
	/**
	 * 得到用户类所在目录
	 * @param cls
	 * @return
	 */
	public static String getClassPath(Class cls) {
		if(cls == null) {
			throw new java.lang.IllegalArgumentException("无效的类文件");
		}
		
		ClassLoader loader = cls.getClassLoader();
		String clsName = cls.getName() + ".class";
		Package pack = cls.getPackage();
		String path = "";
		
		if(pack != null) {
			String packName = pack.getName();
			
			if(packName.startsWith("java.") || packName.startsWith("javax.")) {
				throw new java.lang.IllegalArgumentException("系统类，无法定位到具体的路径");
			}
			
			clsName = clsName.substring(packName.length()+1);
			
			if(packName.indexOf(".")<0) {
				path = packName + "/";
			}
			else {
				int start = 0, end = 0;
				end = packName.indexOf(".");
				while(end != -1) {
					path = path + packName.substring(start, end) + "/";
					start = end + 1;
					end = packName.indexOf(".", start);
				}
				path = path + packName.substring(start) + "/";
			}
		}
		
		java.net.URL url = loader.getResource(path + clsName);
		String realPath = url.getPath();
		
		int pos = realPath.indexOf("file:");
		if(pos > -1) {
			realPath = realPath.substring(pos + 5);
		}
		
		pos = realPath.indexOf(path + clsName);
		realPath = realPath.substring(0, pos-1);
		
		if(realPath.endsWith("!")) {
			realPath = realPath.substring(0, realPath.lastIndexOf("/"));
		}
		
		try {
			realPath = java.net.URLDecoder.decode(realPath, "utf-8");
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
		
		return realPath;
	}
	
	/**
	 * 得到应用所在目录
	 * @return
	 */
	public static String getWebAppPath() {
		String path = getClassPath(PathUtils.class);
		System.out.println("Class path = " + path);
		
		int pos = path.lastIndexOf("/WEB-INF/");
		String webAppPath = path.substring(0, pos + 1);
		System.out.println("WebAppPath path = " + webAppPath);
		
		return webAppPath;
	}
}
