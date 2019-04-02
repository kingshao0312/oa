package com.qf.oa.service.impl;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.service.IBaseService;

public abstract  class BaseServiceImpl<T> implements IBaseService<T> {

   public abstract IBaseDao<T> getDao();

    public int deleteByPrimaryKey(Long orgId) {
        return getDao().deleteByPrimaryKey(orgId);
    }

    public int insert(T t) {
        return getDao().insert(t);
    }

    public int insertSelective(T t) {
        return getDao().insertSelective(t);
    }

    public T selectByPrimaryKey(Long orgId) {
        return getDao().selectByPrimaryKey(orgId);
    }

    public int updateByPrimaryKeySelective(T t) {
        return getDao().updateByPrimaryKeySelective(t);
    }

    public int updateByPrimaryKey(T t) {
        return getDao().updateByPrimaryKey(t);
    }
}
