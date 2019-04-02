package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysUserMapper extends IBaseDao<SysUser> {

    List<SysUser> selectByCondition(SysUser sysUser);

    List<SysUser> queryAuthUserByRoleId(Long roleId);

    List<SysUser> queryNoAuthUserByRoleId(@Param("roleId") Long roleId,@Param("userName") String userName);
}