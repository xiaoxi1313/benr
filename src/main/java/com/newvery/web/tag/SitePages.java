package com.newvery.web.tag;

import java.io.IOException;
import java.io.Writer;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.struts2.components.Component;

import com.newvery.web.bean.Page;
import com.opensymphony.xwork2.util.ValueStack;

public class SitePages extends Component {   
    
	private String page;
	private String params;
	private String pageTableId;
	
	private HttpServletRequest request;
	
    public SitePages(ValueStack arg0,HttpServletRequest request) {
        super(arg0);   
        this.request = request;
    }   
  
    @SuppressWarnings("unchecked")
	@Override  
    public boolean start(Writer writer) {   
        boolean result = super.start(writer);   
        try {   
        	Page pageBean = (Page)this.findValue(this.getPage());
        	Map<String,String> parameters = (Map<String, String>) this.findValue(this.getParams());
            String strHtml = buildHtml(pageBean,parameters,getPageTableId());
            writer.write(strHtml.toString());   
               
        } catch (IOException ex) {   
        	ex.printStackTrace();
            Logger.getLogger(SitePages.class.getName()).log(Level.ERROR, null, ex);   
        }   
        return result;   
    } 
    
    public String buildHtml(Page page,Map<String,String> params) {
    	return buildHtml(page,params,null);
    }
    
    /**
	 * 
	 * @param page		分页信息
	 * @param param	查询参数
	 */
    public String buildHtml(Page page,Map<String, String> params,String table_id) {
		//StringBuffer sb = new StringBuffer("<form action=\""+buildQueryString(params)+"\" method=\"post\" id=\"pageForm\">\n");
    	StringBuffer sb = new StringBuffer("\n");
		/*
            <div class="row">
              <div class="col-sm-4 hidden-xs">
                <div class="btn-group">
                <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle">
                <span class="dropdown-label">批量操作</span> 
                <span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-select">
                <li class="active"><a href="#"><input type="radio" name="d-s-r" checked="">编辑</a></li>
                <li class=""><a href="#"><input type="radio" name="d-s-r">删除</a></li>
                </ul>
                </div>
                <button class="btn btn-sm btn-default">应用</button>                  
              </div>
              <div class="col-sm-4 text-center">
                <small class="text-muted inline m-t-sm m-b-sm">共50个条目，正在显示第1-10个</small>
              </div>
              <div class="col-sm-4 text-right text-center-xs">                
                <ul class="pagination pagination-sm m-t-none m-b-none">
                  <li><a href="#"><i class="fa fa-chevron-left"></i></a></li>
                  <li><a href="#">1</a></li>
                  <li><a href="#">2</a></li>
                  <li><a href="#">3</a></li>
                  <li><a href="#">4</a></li>
                  <li><a href="#">5</a></li>
                  <li><a href="#"><i class="fa fa-chevron-right"></i></a></li>
                </ul>
              </div>
            </div>
		 */
		
		String s = "<div class=\"row\">" + 
				   		"<div class=\"col-sm-4 hidden-xs colpage1\" id=\"batchDiv\">" + 
			                "<div class=\"btn-group\">" + 
				                "<button data-toggle=\"dropdown\" class=\"btn btn-sm btn-default dropdown-toggle\">" + 
					                "<span class=\"dropdown-label\">批量操作</span>" + 
					                "<span class=\"caret\"></span>" + 
				                "</button>" + 
				                "<ul class=\"dropdown-menu dropdown-select\">" + 
				                	"<li class=\"\"><a href=\"#\"><input type=\"radio\" name=\"batchOperator\" value=\"1\">删除</a></li>" + 
				                "</ul>" + 
			                "</div>" + 
			                "<button class=\"btn btn-sm btn-default\" onclick=\"batchOperate()\">应用</button>" +                   
		                "</div>" + 
	                "<div class=\"col-sm-4 text-center colpage2\">";
		sb.append(s);
		sb.append("<small class=\"text-muted inline m-t-sm m-b-sm\">共");
		sb.append(page.getTotalNum()).append("个条目，正在显示第");
		sb.append(page.getCurPage()*page.getNumPerPage() - page.getNumPerPage() + 1).append("-").append(page.getCurPage()*page.getNumPerPage()).append("个</small></div>");
		
		//sb.append("<span>共").append(page.getTotalNum()).append("条记录，共").append(page.getTotalPage()) . append("页</span> ");;
		
		
		sb.append("<div class=\"col-sm-4 text-right text-center-xs colpage3\"><ul class=\"pagination pagination-sm m-t-none m-b-none\" >");
		//第一页
		//sb.append("<a href=\"").append(buildQueryString(params)) . append("\">首页</a>");
		
		//上一页
		if(page.getCurPage() > 1) {
			sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(page.getCurPage() - 1) . append("\"><i class=\"fa fa-chevron-left\"></i></a></li>");
		}
		
		
		if(page.getTotalPage() > 3)  {
			
			if(page.getCurPage() > 2) {
				//sb.append("<li><a href=\"#\">...</a></li> ");
				for(int i = page.getCurPage() - 1;i<page.getCurPage(); i++) {
					sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(i).append("&page.numPerPage=").append(page.getNumPerPage()) . append("\">" + (i)+"</a></li>");
				}
				sb.append("<li><a href=\"#\" class=\"cur\">" + page.getCurPage()+ "</a></li> ");
			} else {
				int startindex = page.getCurPage() - 1;
				if(startindex < 1) {
					startindex = 1;
				}
				for(int i = startindex;i<=page.getCurPage(); i++) {
					if(i == page.getCurPage()) {
						sb.append("<li><a href=\"#\" class=\"cur\">" + i + "</a></li> ");
					} else {
						sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(i) .append("&page.numPerPage=").append(page.getNumPerPage()). append("\">" + (i)+"</a></li>");
					}
				}
			}
			
			for(int i = page.getCurPage()+1;i<page.getCurPage()+2 && i <= page.getTotalPage(); i++) {
				sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(i) .append("&page.numPerPage=").append(page.getNumPerPage()). append("\">" + (i)+"</a></li>");
			}
			if(page.getCurPage() + 2 < page.getTotalPage()) {
				sb.append("<li><a href=\"#\">...</a></li> ");
			}
			
			
		} else {
			for(int i = 0; i<page.getTotalPage(); i++) {
				if(i+1 == page.getCurPage()) {
					sb.append("<li><a href=\"#\" class=\"cur\">" + page.getCurPage()+ "</a></li> ");
				}else{
					sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(i + 1) .append("&page.numPerPage=").append(page.getNumPerPage()). append("\">" + (i+1)+"</a></li>");
				}
				
			}
		}
		
		/**for(int i = 0; i<page.getTotalPage(); i++) {
			if(i+1 == page.getCurPage()) {
				sb.append("<li><a href=\"#\"" + page.getCurPage()+ "</a></li> ");
			}else{
				sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(i + 1) . append("\">" + (i+1)+"</a></li>");
			}
			sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(i + 1) . append("\">" + (i+1)+"</a></li>");
			
		}*/
		
		//下一页
		if(page.getCurPage() < page.getTotalPage()) {
			sb.append("<li><a href=\"").append(buildQueryString(params)).append("&page.curPage=").append(page.getCurPage() + 1) .append("&page.numPerPage=").append(page.getNumPerPage()). append("\"><i class=\"fa fa-chevron-right\"></i></a></li>");
		} 
		
		sb.append("<li><span >到第 <input type=\"text\" id=\"goPage\" action=\""+buildQueryString(params)+"\" name=\"page.curPage\" style=\"width: 30px;height: 17px;\"> 页</span></li><li><a href=\"javascript:void(0)\" class=\"btn btn-sm okbtn pageGoBtn\">确定</a></li>");
		
		sb.append("</ul></div></div>");
		sb.append("<script type=\"text/javascript\">$(document).ready(function(){$(\".pageGoBtn\").click(function(){ " +
				"if(isNaN($('#goPage').val())) {alert(\"无效页码\");return false;}$(this).parent().parent().find('#goPage').val(parseInt($(this).parent().parent().find('#goPage').val()));" +
				"location.href=$('#goPage').attr('action')+'&page.curPage='+$(this).parent().parent().find('#goPage').val()+'&page.numPerPage="+page.getNumPerPage()+"';});});</script>");
		//sb.append("</form>");
		
		return sb.toString();
	}
	
	/**
	 * 构造查询参数
	 * @param param
	 * @return String
	 */
	public String buildQueryString(Map<String, String> params) {
		if(params == null) {
			return "?";
		}
		
		StringBuffer sb = new StringBuffer("?");
		boolean firstFlag = false;
		for(Map.Entry<String, String> e : params.entrySet()) {
			if(firstFlag) {
				sb.append("&").append(e.getKey()).append("=").append(e.getValue());
			} else {
				sb.append(e.getKey()).append("=").append(e.getValue());
				firstFlag = true;
			}
		}
		return sb.toString();
	}

	public String getPageTableId() {
		return pageTableId;
	}

	public void setPageTableId(String pageTableId) {
		this.pageTableId = pageTableId;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}
    
	
	public static void main(String[] args) {
		String testStr = "<div class=high align=center><b><font color=#0066cc><p style=sdfsdfs>sdf</p><span class=high>婚姻状况</span></font></b></div>";   
		testStr = testStr.replaceAll("style=\"[.*]\"", "");   
		System.out.println(testStr);  
	}
}  

