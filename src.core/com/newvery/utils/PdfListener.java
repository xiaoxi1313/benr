package com.newvery.utils;

import java.io.IOException;

import org.xhtmlrenderer.pdf.ITextRenderer;
import org.xhtmlrenderer.pdf.PDFCreationListener;

import com.lowagie.text.Chunk;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfDocument;
import com.lowagie.text.pdf.PdfWriter;

public class PdfListener implements PDFCreationListener{
	
	 //String sheader= "上海本然研创咨询有限公司<br>www.origintrend.com";
	//"/n/n/n上海本然研创咨询有限公司<br>www.origintrend.com"
	//"\n      \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t上海本然研创咨询有限公司\n      \t\t\t\t\t\t\t\t\t\t\t\t\t\t\twww.origintrend.com\n"
	String sheader= "";
	String sfooter= "上海本然研创咨询有限公司														www.origintrend.com";
	 //String sfooter = "专有机密文件                                                         版权所有  本然创启™  创新源数据库";
	
	 PdfDocument pdfDoc = null;
	
	 public void onClose(ITextRenderer itextrenderer){
	    pdfDoc.close();
	 }

	 public void preOpen(ITextRenderer itextrenderer){
  	   
/*	   Image imageFooter = null;
	   Image imageHeader = null;
		try {
			imageFooter = Image.getInstance(footer );
			imageHeader  = Image.getInstance(header);
		} catch (BadElementException e) {					
			e.printStackTrace();
		} catch (MalformedURLException e) {					
			e.printStackTrace();
		} catch (IOException e) {					
			e.printStackTrace();
		}*/
	   BaseFont fontChinese=null;  
	   try {  
	       fontChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);//设置中文字体  
	   } catch (IOException e) {  
	       e.printStackTrace();  
	   } catch (DocumentException e) {
		e.printStackTrace();
	}  
	   
	   Font chinese = new Font(fontChinese, 10, Font.NORMAL);   

	   PdfWriter pdfWriter = itextrenderer.getWriter();
	   pdfWriter.open();
	   pdfDoc = pdfWriter.getDirectContent().getPdfDocument();
	  
	   //Header
	   Phrase phraseHeader = new Phrase();
//	   phraseHeader.add(new Chunk(imageCabecalho, 0, 0));
	   phraseHeader.add(new Chunk(sheader, FontFactory.getFont(FontFactory.HELVETICA, 8)));   
	   
	   HeaderFooter header = new HeaderFooter(new Phrase(sheader,chinese), false);
	   header.setBorder(Rectangle.BOTTOM);
	   header.setAlignment(Element.ALIGN_LEFT);
	   pdfDoc.setHeader(header);

	   /* 底部
	   //Footer	     
	   Phrase phrase = new Phrase();
	   //phrase.add(new Chunk(imageRodape, 0, 0));
	   phrase.add(new Chunk(sfooter, FontFactory.getFont(FontFactory.HELVETICA, 8)));
	   
	   HeaderFooter footer = new HeaderFooter(new Phrase(sfooter,chinese), false);
	   header.setBorder(Rectangle.TOP);
	   footer.setAlignment(Element.ALIGN_CENTER);
	   pdfDoc.setFooter(footer);	   
	   */
	 }	 
}
