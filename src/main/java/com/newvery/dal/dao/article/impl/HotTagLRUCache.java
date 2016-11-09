package com.newvery.dal.dao.article.impl;

import java.util.LinkedHashMap;
import java.util.Map;

public class HotTagLRUCache <K, V> extends LinkedHashMap<K, V> {

	private static final long serialVersionUID = 1L;
	
	private static final int MAX_CACHE_SIZE = 3000;

	private static HotTagLRUCache _instance;
	
	public static HotTagLRUCache getInstance() {
		if(_instance == null) {
			_instance = new HotTagLRUCache();
		}
		return _instance;
	}
	
	
    private HotTagLRUCache () {
        super((int) Math.ceil(MAX_CACHE_SIZE / 0.75) + 1, 0.75f, true);
    }

    @Override
    protected boolean removeEldestEntry(Map.Entry eldest) {
        return size() > MAX_CACHE_SIZE;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<K, V> entry : entrySet()) {
            sb.append(String.format("%s:%s ", entry.getKey(), entry.getValue()));
        }
        return sb.toString();
    }
	
}
