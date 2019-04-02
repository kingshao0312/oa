package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysOrg;

import java.util.List;

public interface ISysOrgService extends IBaseService<SysOrg> {
    PageInfo<SysOrg> getPage(Page page);

    List<SysOrg> getOrgList();

    SysResult updateFlagByOrgId(Long orgId);

    SysResult updateFlagByIdList(List<Long> idList);

    PageInfo<SysOrg> selectByCondition(SysOrg sysOrg, Page page);
}
