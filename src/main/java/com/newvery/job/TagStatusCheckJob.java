package com.newvery.job;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagRecord;
import com.newvery.task.tag.TagStatusUpdateTask;
import com.newvery.utils.TimeUtil;

/**
 * 标签状态检查
 * @author mi_xb
 *
 */
public class TagStatusCheckJob {
	private Log logger = LogFactory.getLog(TagStatusCheckJob.class);
	
	public void checkStatus() {
		try {
			List<TagRecord> tagList = BeanFactory.getTagDao().findTagRecordByStatus(Constants.TAG_STATUS_NEW);
			for (TagRecord tag : tagList) {
				Date now = new Date();
				if ((now.getTime() - tag.getCreateTime().getTime())/(1000*60*60*24) >= 30) {	//超过30天
					logger.info(tag.getName() + " - " + TimeUtil.format(tag.getCreateTime(), TimeUtil.FORMAT_NORMAL) + " - 超过30天！");
					tag.setStatus(Constants.TAG_STATUS_NORMAL);
					
					TagStatusUpdateTask task = new TagStatusUpdateTask();
					task.setTagId(tag.getId());
					task.setStatus(Constants.TAG_STATUS_NORMAL);
					
					BeanFactory.getSecurityExecutor().exec(task);
				}
			}
		} catch (ServiceException e) {
			logger.error(e.getMessage());
		}
	}
}
