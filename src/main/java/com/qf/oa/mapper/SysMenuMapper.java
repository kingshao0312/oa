package com.qf.oa.mapper;

import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysMenuParent;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysMenuMapper extends IBaseDao<SysMenu> {

    List<SysMenu> getMenuListByRoleId(Long roleId);

    List<SysMenu> getMenuListByCondition(SysMenu sysMenu);

    List<SysMenu> queryMenuList();

    SysMenuParent selectSysMenuParentByMenuId(Long menuId);

    int selectCountByMenuId(Long menuId);

    void updateMenuIsPublisByMenuId(Long menuId);

    int delMenuByidList(List<Long> idList);

    int selectCountByidList(List<Long> idList);

    List<SysMenu> getNoAuthMenusByRoleId(@Param("roleId") Long roleId, @Param("menuName") String menuName);

    int batchAddMenusToRole(@Param("idList") List<Long> idList, @Param("roleId") Long roleId);

    int delMenuToRole(@Param("menuId") Long menuId, @Param("roleId") Long roleId);
}