<%@page import="com.newvery.utils.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="com.newvery.bean.BeanFactory"%>
<%@page import="com.newvery.utils.PoiExcelUtil"%>
<%@page import="com.newvery.record.CategoryRecord"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%

Workbook wb = null;

String excelfile = request.getSession().getServletContext().getRealPath("./category.xls");

try {
	wb = new XSSFWorkbook(new FileInputStream(excelfile));
} catch (Exception ex) {
	wb = new HSSFWorkbook(new FileInputStream(excelfile));
}

Sheet sheet = wb.getSheetAt(0);
int rows = sheet.getLastRowNum();


CategoryRecord currentParent = null;
long currentParentId = 0;
for (int i = 0; i <= rows; i++) {
	int j = 0;
	Row row = sheet.getRow(i);

	if(row == null) {
		break;
	}

	Cell cell = null;
	//如果前三列全部为空，结束
	
	if(StringUtil.isNull(PoiExcelUtil.getStringCellValue(row.getCell(0)).trim()) == null 
			&& StringUtil.isNull(PoiExcelUtil.getStringCellValue(row.getCell(1)).trim()) == null 
			&& StringUtil.isNull(PoiExcelUtil.getStringCellValue(row.getCell(2)).trim()) == null  ) {
		
		out.print(i);
		break;
	}
	
	boolean isParent = false;
	cell = row.getCell(2);
	if(!"".equals(PoiExcelUtil.getStringCellValue(row.getCell(0)).trim()) 
			) {
		isParent = true;
	}
	
	if(isParent) {		//如果是第一级
		currentParent = new CategoryRecord();
		currentParent.setName(PoiExcelUtil.getStringCellValue(row.getCell(0)).trim());
		currentParent.setAlias(PoiExcelUtil.getStringCellValue(row.getCell(1)).trim());
		currentParent = BeanFactory.getCategoryDao().insertCategoryRecord(currentParent);
		
		out.println(""+currentParent.getName()+" id = " + currentParent.getId() +"<br/>");
	} else {
		if(currentParent == null) {
			out.println("数据结构错误");
		}
		
		CategoryRecord child = new CategoryRecord();
		child.setName(PoiExcelUtil.getStringCellValue(row.getCell(1)).trim());
		child.setAlias(PoiExcelUtil.getStringCellValue(row.getCell(2)).trim());
		child.setParentId(currentParent.getId());
		child = BeanFactory.getCategoryDao().insertCategoryRecord(child);
		out.println("&nbsp;&nbsp;" + child.getName() +" id = " + child.getId()+"<br/>");
	}
}

out.println(rows);
  


%>