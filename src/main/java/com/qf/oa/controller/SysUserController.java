package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysUser;
import com.qf.oa.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/sysUser")
public class SysUserController {

    @Autowired
    private ISysUserService sysUserService;

    @RequestMapping("/selectByCondition")
    public String selectByCondition(Page page, SysUser sysUser, ModelMap map){
        //得到一个pageInfo对象
       PageInfo<SysUser> pageInfo = sysUserService.selectByCondition(page,sysUser);
        //装起来
        map.put("pageInfo",pageInfo);
        map.put("sysUser",sysUser);
        map.put("url","sysUser/selectByCondition");

        Gson gson = new Gson();
        Map<String,Object> paramMap = new HashMap<String,Object>();
        paramMap.put("userName",sysUser.getUserName());
        paramMap.put("flag",sysUser.getFlag());
        map.put("params",gson.toJson(paramMap));
        return "user/user_list";

    }

    /**
     *跳转到用户的添加页面
     */
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "user/user_add";
    }

    /**
     * 添加用户
     */
    @RequestMapping("/add")
    @ResponseBody
    public SysResult add(SysUser sysUser){
        SysResult sysResult = new SysResult();
        int count = sysUserService.insertSelective(sysUser);
        if (count > 0) {
            sysResult.setResult(true);
            sysResult.setData("添加成功!");
        } else {
            sysResult.setResult(false);
            sysResult.setData("添加失败!");
        }
        return sysResult;
    }

    /**
     * 修改，数据回显
     */
    @RequestMapping("/toUpdate")
    public String toUpdate(Long userId,ModelMap map){
        SysUser sysUser = sysUserService.selectByPrimaryKey(userId);
        map.put("sysUser",sysUser);
        return "user/user_update";
    }
}
