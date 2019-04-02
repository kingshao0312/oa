package com.qf.oa.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.dao.IBaseDao;
import com.qf.oa.entity.SysOrg;
import com.qf.oa.mapper.SysOrgMapper;
import com.qf.oa.service.ISysOrgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysOrgServiceImpl extends BaseServiceImpl<SysOrg> implements ISysOrgService {

    @Autowired
    private SysOrgMapper sysOrgMapper;

    public IBaseDao<SysOrg> getDao() {
        return sysOrgMapper;
    }

    public PageInfo<SysOrg> getPage(Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysOrg> sysOrgList = sysOrgMapper.getOrgList();
        PageInfo<SysOrg> pageInfo = new PageInfo<SysOrg>(sysOrgList);
        return pageInfo;
    }

    public List<SysOrg> getOrgList() {
        return sysOrgMapper.getOrgList();
    }

    public SysResult updateFlagByOrgId(Long orgId) {
        //查询一下该组织下有没有子组织
        SysResult sysResult = new SysResult();
        int count = sysOrgMapper.queryCountByOrgParentId(orgId);
        if(count>0){
            //有子组织，不能删除
            sysResult.setResult(false);
        }else{
            //没有子组织
            //更新该组织的flag的值  0
            SysOrg sysOrg = new SysOrg();
            sysOrg.setOrgId(orgId);
            sysOrg.setFlag(false);
            sysOrgMapper.updateByPrimaryKeySelective(sysOrg);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    public SysResult updateFlagByIdList(List<Long> idList) {
        SysResult sysResult = new SysResult();
        int count = sysOrgMapper.queryCountByIdList(idList);
        if(count>0){
            //有子组织，不能删除
            sysResult.setResult(false);
        }else{
            //没有子组织
            //更新该组织的flag的值  0
            sysOrgMapper.batchUpdateFlagByIdList(idList);
            sysResult.setResult(true);
        }
        return sysResult;
    }

    public PageInfo<SysOrg> selectByCondition(SysOrg sysOrg, Page page) {
        PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
        List<SysOrg> sysOrgList = sysOrgMapper.selectByCondition(sysOrg);
        PageInfo<SysOrg> pageInfo = new PageInfo<SysOrg>(sysOrgList);
        return pageInfo;
    }
}
