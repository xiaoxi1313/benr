package com.newvery.utils;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;

import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class HtmlToPdf {
	
	static public final String MAC_FONT = "/library/fonts/Arial Unicode.ttf";
	static public final String LINUX_FONT = "/usr/share/fonts/TTF/ARIALUNI.TTF";
	static public final String WINDOWS_FONT = "C:/Windows/Fonts/ARIALUNI.TTF";
	
	public static void htmlToPdf(String inputFile,String generatorFilePath,String fileSaveName,String[] font,String baseUrl){
		OutputStream os = null;
		try {
	        // 生成PDF路径  
	        File generatorFoldPath = new File(generatorFilePath);  
	        if (!generatorFoldPath.exists()) {  
	            generatorFoldPath.mkdirs();  
	        }  
	          
	        String outputFile = generatorFilePath + File.separator +fileSaveName;  
	          
	        os = new FileOutputStream(outputFile);  
	        ITextRenderer renderer = new ITextRenderer();
	        //加入页眉、页脚
	        PdfListener pdfListener = new PdfListener();
	        renderer.setListener(pdfListener);
	        renderer.setDocument(inputFile);  
	        
	        // 解决中文支持问题  
	        ITextFontResolver fontResolver = renderer.getFontResolver();  
//	        fontResolver.addFont(WINDOWS_FONT,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
	        fontResolver.addFont("C:/Windows/Fonts/simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED); 
	        fontResolver.addFont("C:/Windows/Fonts/simhei.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
	        fontResolver.addFont("C:/Windows/Fonts/simkai.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
	        fontResolver.addFont("C:/Windows/Fonts/msyh.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
	        
	        // 解决图片的相对路径问题  
	        if(null!=baseUrl&&!baseUrl.equals("")){
	        	renderer.getSharedContext().setBaseURL(baseUrl);
	        }    
	        renderer.layout();  
	        renderer.createPDF(os);  

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if(null!=os){
				 try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}  
			}
		}
	}
	
	public static void writePdf(String outputFile){
		 Document doc=null;  
		 OutputStream os = null;
	        try {  
	        	doc = new Document();
	        	os =  new FileOutputStream(outputFile);
	            PdfWriter.getInstance(doc, os);  
	            BaseFont fontChinese=null;  
	            try {  
	                fontChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);//设置中文字体  
	            } catch (IOException e) {  
	                e.printStackTrace();  
	            }  
	          
	            Font chinese = new Font(fontChinese, 10, Font.NORMAL);   
	              
	            /** 
	             * HeaderFooter的第2个参数为非false时代表打印页码 
	             * 页眉页脚中也可以加入图片，并非只能是文字 
	             */  
	            HeaderFooter header=new HeaderFooter(new Phrase("这仅仅是个页眉，页码在页脚处",chinese),false);  
	              
	            //设置是否有边框等  
//	          header.setBorder(Rectangle.NO_BORDER);  
	            header.setBorder(Rectangle.BOTTOM);  
	            header.setAlignment(1);  
	            header.setBorderColor(Color.red);  
	            doc.setHeader(header);  
	              
	            HeaderFooter footer=new HeaderFooter(new Phrase("-",chinese),new Phrase("-",chinese));  
	            /** 
	             * 0是靠左 
	             * 1是居中 
	             * 2是居右 
	             */  
	            footer.setAlignment(1);  
	            footer.setBorderColor(Color.red);  
	            footer.setBorder(Rectangle.BOX);  
	            doc.setFooter(footer);  
	          
	            /** 
	             * 页眉页脚的设置一定要在open前设置好 
	             */  
	            doc.open();  
	              
	           // doc.close();  
	        } catch (FileNotFoundException e) {  
	            e.printStackTrace();  
	        } catch (DocumentException e) {  
	            e.printStackTrace();  
	        } finally{
				if(null!=os){
					 try {
						os.close();
					} catch (IOException e) {
						e.printStackTrace();
					}  
				}
				if(null!=doc){
					doc.close();
				}
			}
	}
	

}
