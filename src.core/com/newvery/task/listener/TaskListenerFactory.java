package com.newvery.task.listener;

public class TaskListenerFactory {
	public static ITaskListener createListener(String listenerClass) {
		ITaskListener listener = null;
		try {
			listener = (ITaskListener)(Class.forName(listenerClass).newInstance());
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return listener;
	}
	
}
