package com.qf.oa.service;

import com.qf.oa.entity.SysOrg;

public interface IBaseService<T> {
    int deleteByPrimaryKey(Long orgId);

    int insert(T t);

    int insertSelective(T t);

    T selectByPrimaryKey(Long orgId);

    int updateByPrimaryKeySelective(T t);

    int updateByPrimaryKey(T t);
}
