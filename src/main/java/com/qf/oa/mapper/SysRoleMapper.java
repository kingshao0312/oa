package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysRoleMapper extends IBaseDao<SysRole> {

    List<SysRole> queryRolePageByCondition(SysRole sysRole);

    int updateRoleById(Long roleId);

    int batchDel(List<Long> idList);

    List<SysRole> queryAllRole();

    int batchAddUserToRole(@Param("idList") List<Long> idList, @Param("roleId") Long roleId);

    int delUserFormRole(@Param("userId") Long userId, @Param("roleId") Long roleId);
}