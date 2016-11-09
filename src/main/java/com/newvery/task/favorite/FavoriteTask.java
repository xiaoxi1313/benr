package com.newvery.task.favorite;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.record.FavoriteRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class FavoriteTask implements SecurityTask {
	private FavoriteRecord favorite;
	private String operatorIP;
	private IDaoManagerFactory daoManagerFactory;

	public String getOperatorIP() {
		return operatorIP;
	}

	public void setOperatorIP(String operatorIP) {
		this.operatorIP = operatorIP;
	}

	public IDaoManagerFactory getDaoManagerFactory() {
		return daoManagerFactory;
	}

	public void setDaoManagerFactory(IDaoManagerFactory daoManagerFactory) {
		this.daoManagerFactory = daoManagerFactory;
	}

	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao)getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}

	public FavoriteRecord getFavorite() {
		return favorite;
	}

	public void setFavorite(FavoriteRecord favorite) {
		this.favorite = favorite;
	}
}
