package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysRole;
import com.qf.oa.service.ISysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sysRole")
public class SysRoleController {
    @Autowired
    private ISysRoleService sysRoleService;

    @RequestMapping("/queryRolePageByCondition")
    public String queryRolePageByCondition(Page page, ModelMap map, SysRole sysRole){
        PageInfo<SysRole> pageInfo = sysRoleService.queryRolePageByCondition(page,sysRole);
        map.put("pageInfo",pageInfo);
        map.put("sysRole",sysRole);
        //分页跳转地址
        map.put("url","sysRole/queryRolePageByCondition");

        //加条件查询时，分页跳转地址加的查询条件
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("roleName",sysRole.getRoleName());
        map.put("params",new Gson().toJson(paramMap));
        return "role/role_list";
    }

    /**
     * 跳转到角色添加页面
     */
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "role/role_add";
    }

    /**
     * 添加角色
     */
    @RequestMapping("/add")
    @ResponseBody
    public SysResult add(SysRole sysRole){
        return sysRoleService.addRole(sysRole);
    }

    /**
     * 修改角色，数据回显
     */
    @RequestMapping("/updateRole/{roleId}")
    public String toUpdate(@PathVariable Long roleId, ModelMap map){
        SysRole sysRole = sysRoleService.selectByPrimaryKey(roleId);
        map.put("sysRole",sysRole);
        return "role/role_update";
    }

    /**
     * 修改角色
     */
    @RequestMapping("/update")
    @ResponseBody
    public SysResult update(SysRole sysRole){
        return sysRoleService.update(sysRole);
    }

    /**
     * 删除单个角色
     */
    @RequestMapping("/delRole")
    @ResponseBody
    public SysResult delRole(Long roleId){
        return sysRoleService.delRole(roleId);
    }

    /**
     * 批量删除角色
     */
    @RequestMapping("/batchDel")
    @ResponseBody
    public SysResult batchDel(@RequestParam List<Long> idList){
        return sysRoleService.batchDel(idList);
    }

    @InitBinder
    public void initBinder(WebDataBinder binder, WebRequest request) {
        //转换日期格式
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //注册自定义的编辑器
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

}
