package com.newvery.utils;

import java.util.Date;

public class FileUtils {

	public static final String[] DOC_EXTENSIONS = new String[]{"doc","docx"};
	public static final String[] XLS_EXTENSIONS = new String[]{"xls","xlsx"};
	public static final String[] PPT_EXTENSIONS = new String[]{"ppt","pptx"};
	public static final String[] VIDEO_EXTENSIONS = new String[]{"rm","mpeg","avi","rmvb"};
	public static final String[] MUSIC_EXTENSIONS = new String[]{"mp3","wav","mid","mp4"};
	public static final String[] ZIP_EXTENSIONS = new String[]{"zip","rar","jar","tar","gz"};
	public static final String[] IMAGE_EXTENSIONS = new String[]{"jpg","jpeg","gif","bmp","png"};
	public static final String[] PDF_EXTENSIONS = new String[]{"pdf"};
	public static final String[] TXT_EXTENSIONS = new String[]{"txt","sql"};
	
	public static String getFileExtension(String file) {
		
		int index = file.lastIndexOf(".");
		if(index == -1) {
			//System.out.println("无文件后缀名的调用"+file);
			return "";
		}
		
		return file.substring(index+1);
	}
	
	public static String getFileName(String file) {
		int index = file.lastIndexOf(".");
		if(index == -1) {
			//System.out.println("无文件后缀名的调用"+file);
			return "";
		}
		return file.substring(0,index);
	}
	
	private static boolean search(String[] extensions,String ext) {
		for (String s : extensions) {
			if(s.equals(ext)) return true;
		}
		return false;
	}
	
	public static String getFileTypeImages(String file) {
		String extension = getFileExtension(file).toLowerCase();
		if(search(DOC_EXTENSIONS, extension)) {
			return "doc.png";
		}
		if(search(XLS_EXTENSIONS, extension)) {
			return "xls.png";
		}
		/*if(search(PPT_EXTENSIONS, extension)) {
			return "ppt.png";
		}*/
		if(search(PPT_EXTENSIONS, extension)) {
			return "ppt.png";
		}
		if(search(ZIP_EXTENSIONS, extension)) {
			return "zip.png";
		}
		if(search(IMAGE_EXTENSIONS, extension)) {
			return "image.png";
		}
		if(search(MUSIC_EXTENSIONS, extension)) {
			return "music.png";
		}
		if(search(VIDEO_EXTENSIONS, extension)) {
			return "video.png";
		}
		if(search(PDF_EXTENSIONS, extension)) {
			return "pdf.png";
		}
		if(search(TXT_EXTENSIONS, extension)) {
			return "txt.png";
		}
		return "file.png";
	}
	
	public boolean isExists(String s,String[] infos) {
		search(infos, s);
		for (String string : infos) {
			if(s.equals(string)) {
				return true;
			}
		}
		return false;
	}
	
	public static void main(String[] args) {
		System.out.println(new Date(1344669314810L - 12989177370L * 1000));
		System.out.println(1344669314810L - 12989177370L*1000);
	}
}
