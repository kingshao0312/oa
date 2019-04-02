package com.qf.oa.service;

import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysMenuParent;

import java.util.List;

public interface ISysMenuService extends IBaseService<SysMenu> {
    PageInfo<SysMenu> getMenuPageByCondition(Long roleId, Page page);

    PageInfo<SysMenu> queryMenuByCondition(Page page, SysMenu sysMenu);

    List<SysMenu> queryMenuList();

    SysResult addMenu(SysMenu sysMenu);

    SysMenuParent selectSysMenuParentByMenuId(Long menuId);

    SysResult updateMenu(SysMenu sysMenu);

    SysResult delMenuByMenuId(Long menuId);

    SysResult delMenuByidList(List<Long> idList);

    PageInfo<SysMenu> getNoAuthMenusByRoleId(Page page, Long roleId, String menuName);

    SysResult batchAddMenusToRole(List<Long> idList, Long roleId);

    SysResult delMenuToRole(Long menuId, Long roleId);
}
