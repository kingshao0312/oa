package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysRole;
import com.qf.oa.mapper.SysRoleMapper;
import com.qf.oa.service.ISysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements ISysRoleService {

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Override
    public IBaseDao<SysRole> getDao() {
        return sysRoleMapper;
    }

    @Override
    public PageInfo<SysRole> queryRolePageByCondition(Page page, SysRole sysRole) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysRole> roleList = sysRoleMapper.queryRolePageByCondition(sysRole);
        PageInfo<SysRole> pageInfo = new PageInfo<>(roleList);
        return pageInfo;
    }

    @Override
    public SysResult addRole(SysRole sysRole) {
        SysResult sysResult = new SysResult();
        int count = sysRoleMapper.insertSelective(sysRole);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("添加角色成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("添加角色失败!");
        }
        return sysResult;
    }

    @Override
    public SysResult update(SysRole sysRole) {
        SysResult sysResult = new SysResult();
        int count = sysRoleMapper.updateByPrimaryKeySelective(sysRole);
        if(count>0){
            sysResult.setResult(true);
            sysResult.setData("修改角色成功!");
        }else{
            sysResult.setResult(false);
            sysResult.setData("修改角色失败!");
        }
        return sysResult;
    }

    @Override
    public SysResult delRole(Long roleId) {
        SysResult sysResult = new SysResult();
        int count = sysRoleMapper.updateRoleById(roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public SysResult batchDel(List<Long> idList) {
        SysResult sysResult = new SysResult();
        int count = sysRoleMapper.batchDel(idList);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public List<SysRole> queryAllRole() {
        return sysRoleMapper.queryAllRole();
    }

    @Override
    public SysResult batchAddUserToRole(List<Long> idList, Long roleId) {
        SysResult sysResult = new SysResult();
        int count = sysRoleMapper.batchAddUserToRole(idList,roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }

    @Override
    public SysResult delUserFormRole(Long userId, Long roleId) {
        SysResult sysResult = new SysResult();
        int count = sysRoleMapper.delUserFormRole(userId,roleId);
        if(count>0){
            sysResult.setResult(true);
        }else{
            sysResult.setResult(false);
        }
        return sysResult;
    }
}
