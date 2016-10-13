package com.newvery.utils;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

public class PoiExcelUtil {

	/**
	 * 以字符形式数据读取
	 * @param cell
	 * @return
	 */
	public static String getStringCellValue(Cell cell) {
		if (cell == null) {
			return "";
		}
		String strCell = "";
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_STRING:
			strCell = cell.getStringCellValue();
			break;
		case HSSFCell.CELL_TYPE_NUMERIC:
			strCell = String.valueOf(cell.getNumericCellValue());
			break;
		case HSSFCell.CELL_TYPE_BOOLEAN:
			strCell = String.valueOf(cell.getBooleanCellValue());
			break;
		case HSSFCell.CELL_TYPE_BLANK:
			return "";
		default:
			return "";
		}
		return strCell;
	}
	
	/**
	 * 取数值型数据
	 * @param cell
	 * @return
	 */
	public static double getDoubleCellValue(Cell cell) {
		if(cell == null) return 0;
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_NUMERIC:
			return cell.getNumericCellValue();
		default:
			return 0;
		}
	}
	
	/**
	 * 取整型数据
	 * @param cell
	 * @return
	 */
	public static int getIntegerCellValue(Cell cell) {
		if(cell == null) return 0;
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_NUMERIC:
			return new Double(cell.getNumericCellValue()).intValue();
		default:
			return 0;
		}
	}
	
	/**
	 * 创建列
	 * @param sheet
	 * @param rowIndex
	 * @param cellIndex
	 * @return
	 */
	public static Cell createCell(Sheet sheet,int rowIndex,int cellIndex) {
		Row row = sheet.getRow(rowIndex);
		if(row == null) {
			sheet.createRow(rowIndex);
		}
		Cell cell = row.getCell(cellIndex);
		if(cell == null) {
			cell = row.createCell(cellIndex);
		}
		return cell;
	}
	
	public static Cell createCell(Sheet sheet,int rowIndex,int cellIndex,String value) {
		Row row = sheet.getRow(rowIndex);
		if(row == null) {
			row = sheet.createRow(rowIndex);
		}
		Cell cell = row.getCell(cellIndex);
		if(cell == null) {
			cell = row.createCell(cellIndex);
		}
		
		cell.setCellValue(value);
		
		return cell;
	}
	
	public static Cell createCell(Sheet sheet,int rowIndex,int cellIndex,double value) {
		Row row = sheet.getRow(rowIndex);
		if(row == null) {
			row = sheet.createRow(rowIndex);
		}
		Cell cell = row.getCell(cellIndex);
		if(cell == null) {
			cell = row.createCell(cellIndex);
		}
		
		cell.setCellValue(value);
		return cell;
	}
	
	public static Cell createCell(Sheet sheet,int rowIndex,int cellIndex,int value) {
		Row row = sheet.getRow(rowIndex);
		if(row == null) {
			row = sheet.createRow(rowIndex);
		}
		Cell cell = row.getCell(cellIndex);
		if(cell == null) {
			cell = row.createCell(cellIndex);
		}
		
		cell.setCellValue(String.valueOf(value));
		return cell;
	}
	
}
