package com.newvery.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public class ZipFileUtil {

	public static void unzip(String zipFileName, String outputDirectory) throws Exception  
    {  
        ZipInputStream in = new ZipInputStream(new FileInputStream(zipFileName));  
        ZipEntry z;  
          
        while ((z=in.getNextEntry())!=null)  
        {  
            if (z.isDirectory())  
            {  
                String name = z.getName();  
                name = name.substring(0, name.length() - 1);  
                File f = new File(outputDirectory + File.separator + name);  
                f.mkdir();  
            }  
            else  
            {  
                File f = new File(outputDirectory + File.separator  + z.getName());  
                f.createNewFile();  
                FileOutputStream out = new FileOutputStream(f);  
                int b;  
                while ((b = in.read()) != -1)  {
                	 out.write(b);  
                }
                out.close();  
            }  
        }  
        in.close();  
    } 
	
	public static void unzip(File zipFile, String outputDirectory) throws Exception  
    {  
		
		
        ZipInputStream in = new ZipInputStream(new FileInputStream(zipFile));  
        ZipEntry z;  
          
        while ((z=in.getNextEntry())!=null)  
        {  
            if (z.isDirectory())  
            {  
                String name = z.getName();  
                name = name.substring(0, name.length() - 1);  
                File f = new File(outputDirectory + File.separator + name);  
                f.mkdir();  
            }  
            else  
            {  
            	//System.out.println(outputDirectory + File.separator  + z.getName());
                File f = new File(outputDirectory + File.separator  + z.getName());  
                f.createNewFile();  
                FileOutputStream out = new FileOutputStream(f);  
                int b;  
                while ((b = in.read()) != -1)  {
                	 out.write(b);  
                }
                out.close();  
            }  
        }  
        in.close();  
    } 
	
	 /**  
     *<p>  
     *@param files    待压缩的文件列表 例如,src/zip/文件1.txt, src/zip/file2.txt  
     *@param zipfile 压缩后的文件名称 例如,src/zip/多个文件压缩.zip  
     *@return boolean  
     *@throws :Exception  
     *@Function: zipFiles  
     *@Description:多个文件的ZIP压缩  
     *@version : v1.0.0  
     *@author: pantp  
     *@Date:May 24, 2012  
     *</p>  
     *Modification History:  
     * Date                     Author          Version         Description  
     * ---------------------------------------------------------------------  
     * May 24, 2012        pantp           v1.0.0           Create  
     */  
    public static boolean zipFiles(String[] files, String zipfile)  
            throws Exception {  
        boolean bf = true;  
  
        // 根据文件路径构造一个文件实例  
        File ff = new File(zipfile);  
        // 判断目前文件是否存在,如果不存在,则新建一个  
        if (!ff.exists()) {  
            ff.createNewFile();  
        }  
        // 根据文件路径构造一个文件输出流  
        FileOutputStream out = new FileOutputStream(zipfile);  
        // 传入文件输出流对象,创建ZIP数据输出流对象  
        ZipOutputStream zipOut = new ZipOutputStream(out);  
  
        // 循环待压缩的文件列表  
        for (int i = 0; i < files.length; i++) {  
            File f = new File(files[i]);  
            if (!f.exists()) {  
                bf = false;  
            }  
            try {  
                // 创建文件输入流对象  
                FileInputStream in = new FileInputStream(files[i]);  
                // 得到当前文件的文件名称  
                String fileName = files[i].substring(  
                        files[i].lastIndexOf('/') + 1, files[i].length());  
                // 创建指向压缩原始文件的入口  
                ZipEntry entry = new ZipEntry(fileName);  
                zipOut.putNextEntry(entry);  
                // 向压缩文件中输出数据  
                int nNumber = 0;  
                byte[] buffer = new byte[512];  
                while ((nNumber = in.read(buffer)) != -1) {  
                    zipOut.write(buffer, 0, nNumber);  
                }  
                // 关闭创建的流对象  
                in.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
                bf = false;  
            }  
        }  
        zipOut.close();  
        out.close();  
        return bf;  
    }  
      
	
}
