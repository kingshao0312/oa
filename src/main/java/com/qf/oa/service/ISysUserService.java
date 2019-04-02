package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.entity.SysUser;

public interface ISysUserService extends IBaseService<SysUser> {
    PageInfo<SysUser> selectByCondition(Page page, SysUser sysUser);

    PageInfo<SysUser> queryAuthUserByRoleId(Long roleId, Page page);

    PageInfo<SysUser> queryNoAuthUserByRoleId(Long roleId, String userName, Page page);
}
