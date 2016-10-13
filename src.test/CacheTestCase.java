import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;

import junit.framework.TestCase;


public class CacheTestCase extends TestCase {

	
	public void testCa() {
		
		try {
			BeanFactory.getCategoryDao().findCategoryRecordByPK(15);
			BeanFactory.getCategoryDao().findCategoryRecordByPK(15);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			fail();
		}
		
		
	}
}
