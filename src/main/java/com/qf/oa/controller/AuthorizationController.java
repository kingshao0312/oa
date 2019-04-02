package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysRole;
import com.qf.oa.entity.SysUser;
import com.qf.oa.service.ISysRoleService;
import com.qf.oa.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/authorization")
public class AuthorizationController {

    @Autowired
    private ISysRoleService sysRoleService;

    @Autowired
    private ISysUserService sysUserService;

    @RequestMapping("/showPage")
    public String toAuthorizationPage(ModelMap map) {
        //查询所有的角色
        List<SysRole> sysRoleList = sysRoleService.queryAllRole();
        map.put("sysRoleList", sysRoleList);
        return "authorization/authorization";
    }

    /**
     * 查询该角色下所有授权了的用户
     */
    @RequestMapping("/queryAuthUserByRoleId")
    public String queryAuthUserByRoleId(Long roleId, Page page, ModelMap map) {

        PageInfo<SysUser> pageInfo = sysUserService.queryAuthUserByRoleId(roleId, page);
        map.put("pageInfo", pageInfo);
        map.put("url", "authorization/queryAuthUserByRoleId");

        Gson gson = new Gson();
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("roleId", roleId);
        map.put("params", gson.toJson(paramMap));
        return "authorization/authorization_authUser_list";
    }

    /**
     * 查询该角色下没有授权的所有用户
     */
    @RequestMapping("/queryNoAuthUserByRoleId")
    public String queryNoAuthUserByRoleId(Long roleId, String userName, Page page, ModelMap map) {
        PageInfo<SysUser> pageInfo = sysUserService.queryNoAuthUserByRoleId(roleId, userName, page);
        map.put("pageInfo", pageInfo);
        map.put("roleId", roleId);
        map.put("userName", userName);
        map.put("url", "authorization/queryNoAuthUserByRoleId");

        Gson gson = new Gson();
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userName", userName);
        paramMap.put("roleId", roleId);
        map.put("params", gson.toJson(paramMap));
        return "authorization/authorization_noauthUser_list";
    }

    /**
     * 批量给某个角色授权用户,实际上要往角色用户关系表中添加用户ID和角色ID
     */
    @RequestMapping("/batchAddUserToRole")
    @ResponseBody
    public SysResult batchAddUserToRole(@RequestParam List<Long> idList, Long roleId) {
        return sysRoleService.batchAddUserToRole(idList, roleId);
    }

    /**
     * 解除用户和角色的关系
     */
    @RequestMapping("/delUserFormRole")
    @ResponseBody
    public SysResult delUserFormRole(Long userId,Long roleId){
        return sysRoleService.delUserFormRole(userId,roleId);
    }
}
