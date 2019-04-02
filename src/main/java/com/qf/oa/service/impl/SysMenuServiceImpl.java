package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysMenuParent;
import com.qf.oa.mapper.SysMenuMapper;
import com.qf.oa.service.ISysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysMenuServiceImpl extends BaseServiceImpl<SysMenu> implements ISysMenuService {

    @Autowired
    private SysMenuMapper sysMenuMapper;

    @Override
    public IBaseDao<SysMenu> getDao() {
        return sysMenuMapper;
    }

    @Override
    public PageInfo<SysMenu> getMenuPageByCondition(Long roleId, Page page) {
        PageHelper.startPage(page.getCurrentPage(), page.getPageSize());
        //得到分页的数据
        List<SysMenu> orgList = sysMenuMapper.getMenuListByRoleId(roleId);
        //构造一个pageInfo返回
        PageInfo<SysMenu> pageInfo = new PageInfo<SysMenu>(orgList);
        return pageInfo;
    }

    @Override
    public PageInfo<SysMenu> queryMenuByCondition(Page page, SysMenu sysMenu) {
        PageHelper.startPage(page.getCurrentPage(), page.getPageSize());
        //得到分页的数据
        List<SysMenu> menuList = sysMenuMapper.getMenuListByCondition(sysMenu);
        PageInfo<SysMenu> pageInfo = new PageInfo<SysMenu>(menuList);
        return pageInfo;
    }

    @Override
    public List<SysMenu> queryMenuList() {
        return sysMenuMapper.queryMenuList();
    }

    @Override
    public SysResult addMenu(SysMenu sysMenu) {
        SysResult sysResult = new SysResult();
        int count = sysMenuMapper.insertSelective(sysMenu);
        if (count > 0) {
            sysResult.setResult(true);
            sysResult.setData("添加菜单成功！");
        } else {
            sysResult.setResult(false);
            sysResult.setData("添加菜单失败！");
        }
        return sysResult;
    }

    @Override
    public SysMenuParent selectSysMenuParentByMenuId(Long menuId) {
        return sysMenuMapper.selectSysMenuParentByMenuId(menuId);
    }

    @Override
    public SysResult updateMenu(SysMenu sysMenu) {
        SysResult sysResult = new SysResult();
        int count = sysMenuMapper.updateByPrimaryKeySelective(sysMenu);
        if (count > 0) {
            sysResult.setResult(true);
            sysResult.setData("修改菜单成功！");
        } else {
            sysResult.setResult(false);
            sysResult.setData("修改菜单失败！");
        }
        return sysResult;
    }

    @Override
    public SysResult delMenuByMenuId(Long menuId) {
        SysResult sysResult = new SysResult();
        int count = sysMenuMapper.selectCountByMenuId(menuId);
        if (count > 0) {
            sysResult.setResult(false);
        } else {
            //修改isPublish的值
            sysMenuMapper.updateMenuIsPublisByMenuId(menuId);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    //批量删除
    @Override
    public SysResult delMenuByidList(List<Long> idList) {
        SysResult sysResult = new SysResult();
        int count = sysMenuMapper.selectCountByidList(idList);
        if (count > 0) {
            sysResult.setResult(false);
        } else {
            sysMenuMapper.delMenuByidList(idList);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    @Override
    public PageInfo<SysMenu> getNoAuthMenusByRoleId(Page page, Long roleId, String menuName) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysMenu> menuList = sysMenuMapper.getNoAuthMenusByRoleId(roleId,menuName);
        PageInfo<SysMenu> pageInfo = new PageInfo<>(menuList);
        return pageInfo;
    }

    @Override
    public SysResult batchAddMenusToRole(List<Long> idList, Long roleId) {
        SysResult sysResult = new SysResult();
        int count = sysMenuMapper.batchAddMenusToRole(idList,roleId);
        if (count > 0) {
            sysResult.setResult(true);
        } else {
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public SysResult delMenuToRole(Long menuId, Long roleId) {
        SysResult sysResult = new SysResult();
        int count = sysMenuMapper.delMenuToRole(menuId,roleId);
        if (count > 0) {
            sysResult.setResult(true);
        } else {
            sysResult.setResult(false);
        }
        return sysResult;
    }


}
