package com.qf.oa.service;

import com.qf.oa.entity.SysOrg;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring/applicationContext-*.xml")
public class ServiceTest {

    @Autowired
    private ISysOrgService sysOrgService;

    @Test
    public void query(){
        SysOrg sysOrg = sysOrgService.selectByPrimaryKey(1L);
        System.out.println(sysOrg);
    }
}
