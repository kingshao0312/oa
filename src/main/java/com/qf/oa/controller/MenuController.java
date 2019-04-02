package com.qf.oa.controller;

import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.qf.oa.common.Page;
import com.qf.oa.common.SysResult;
import com.qf.oa.entity.SysMenu;
import com.qf.oa.entity.SysMenuParent;
import com.qf.oa.service.ISysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sysMenu")
public class MenuController {

    @Autowired
    private ISysMenuService menuService;

    @RequestMapping("/queryMenuByCondition")
    public String queryMenuByCondition(Page page, ModelMap map, SysMenu sysMenu) {
        PageInfo<SysMenu> pageInfo = menuService.queryMenuByCondition(page, sysMenu);
        map.put("pageInfo", pageInfo);
        map.put("sysMenu",sysMenu);
        map.put("url", "sysMenu/queryMenuByCondition");

        Map<String,Object> paramsMap = new HashMap<String,Object>();
        paramsMap.put("menuName",sysMenu.getMenuName());
        paramsMap.put("isPublish",sysMenu.getIsPublish());
        map.put("params",new Gson().toJson(paramsMap));
        return "menu/menu_list";
    }

    /**
     * 跳转到添加菜单的页面
     * @return
     */
    @RequestMapping("/toAdd")
    public String toAdd(){
        return "menu/menu_add";
    }

    /**
     * 查询树要加载的菜单集合数据
     */
    @RequestMapping("/list")
    @ResponseBody
    public List<SysMenu> queryMenuList(){
        return  menuService.queryMenuList();
    }

    /**
     * 添加菜单
     */
    @RequestMapping("/add")
    @ResponseBody
    public SysResult addMenu(SysMenu sysMenu){
       return menuService.addMenu(sysMenu);
    }

    /**
     * 修改菜单，数据回显,并携带菜单所属父ID
     */
    @RequestMapping("/updateMenu/{menuId}")
    public String toUpdate(@PathVariable Long menuId, ModelMap map){
        SysMenuParent sysMenu = menuService.selectSysMenuParentByMenuId(menuId);
        map.put("sysMenu",sysMenu);
        return "menu/menu_update";
    }

    /**
     * 修改菜单
     */
    @RequestMapping("/update")
    @ResponseBody
    public SysResult updateMenu(SysMenu sysMenu){
        return menuService.updateMenu(sysMenu);
    }

    /**
     * 删除单个菜单，实质是修改isPusblish的值
     */
    @RequestMapping("/delMenu")
    @ResponseBody
    public SysResult delMenu(Long menuId){
        return menuService.delMenuByMenuId(menuId);
    }

    /**
     * 批量删除
     */
    @RequestMapping("/batchDel")
    @ResponseBody
    public SysResult batchDel(@RequestParam List<Long> idList){
        return menuService.delMenuByidList(idList);
    }

}
