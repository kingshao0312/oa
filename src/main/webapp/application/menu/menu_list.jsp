<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/2/9
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>

</head>
<body id="menuBody">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span
        class="c-gray en">&gt;</span> 菜单管理 <a class="btn btn-success radius r mr-20"
                                              style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
        <%--加入搜索功能--%>
            <div class="text-c">
                <div class="row cl ">
                    <div class="formControls col-4">
                        菜单名称: <input type="text" value="${sysMenu.menuName}" class="input-text" style="width: 250px" id="menuName" name="menuName"/>
                    </div>
                    <div class="formControls col-4">
                    是否有效：
                        <span class="select-box" style="width:150px">
                         <select class="select" name="brandclass" size="1" id="isPublish">
                                <c:choose>
                                    <c:when test="${sysMenu.isPublish}">
                                        <option value="0">否</option>
                                        <option value="1" selected="selected">是</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="0" selected="selected">否</option>
                                        <option value="1">是</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </span>
                    </div>
                </div>
                <div class="row cl">
                    <div class="cl pd-5">
                        <button type="button"
                                class="btn btn-success radius" id="" name="" onclick="queryOrgInfo()">
                            <i class="Hui-iconfont">&#xe665;</i> 搜索
                        </button>
                    </div>
                </div>
            </div>

    <div class="cl pd-5 bg-1 bk-gray"> <span class="l">
        <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
        <a class="btn btn-primary radius" href="javascript:;" onclick="admin_menu_add('添加菜单','sysMenu/toAdd','800')"><i
                class="Hui-iconfont">&#xe600;</i> 添加菜单</a> </span>
        <span class="r">共有数据：<strong>${pageInfo.total}</strong> 条</span></div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">菜单管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">ID</th>
            <th width="100">菜单名</th>
            <th width="100">父级菜单ID</th>
            <th width="100">菜单路径</th>
            <th width="100">是否发布</th>
            <th width="10">操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${pageInfo.list}" var="menu">
            <tr class="text-c">
                <td><input type="checkbox" value="${menu.menuId}" name="" class="delBox"></td>
                <td>${menu.menuId}</td>
                <td>${menu.menuName}</td>
                <td>${menu.menuParentId}</td>
                <td>${menu.menuPath}</td>
                <c:choose>
                    <c:when test="${menu.isPublish}">
                         <td>是</td>
                    </c:when>
                    <c:otherwise>
                         <td>否</td>
                    </c:otherwise>
                 </c:choose>
                <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_menu_edit('菜单编辑','sysMenu/updateMenu/${menu.menuId}','600')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a title="删除" href="javascript:;" onclick="admin_menu_del(this,${menu.menuId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                </tr>
        </c:forEach>
        </tbody>
    </table>

    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="menuBody"/>
    </jsp:include>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>


<script type="text/javascript">
    /*管理员-菜单-添加*/
    function admin_menu_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-菜单-编辑*/
    function admin_menu_edit(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-菜单-删除*/
    function admin_menu_del(obj, id) {
        layer.confirm('菜单删除须谨慎，确认要删除吗？', function (index) {
            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                url: "sysMenu/delMenu",
                data: "menuId=" + id,
                success: function (data) {
                    if (data.result) {
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', {icon: 1, time: 2000},function () {
                            location.reload();
                        });
                    } else {
                        layer.msg('删除失败，该节点下有子节点!', {icon: 2, time: 2000});
                    }
                }
            })


        });
    }

    /*批量删除*/
    function batchDel() {
        var checkedBox = $(".delBox:checked");
        if (checkedBox.length == 0) {
            return;
        }
        //获取到选中的复选框的id值
        var ids = [];
        for (var i = 0; i < checkedBox.length; i++) {
            ids.push(checkedBox[i].value);
        }
        //发送异步请求去删除数据
        layer.confirm('菜单删除须谨慎，确认要删除吗？', function (index) {
            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                url: "sysMenu/batchDel",
                data: "idList=" + ids,
                success: function (data) {
                    //返回删除成功与否的标识
                    if (data.result) {
                        layer.msg('已删除!', {icon: 1, time: 2000},function () {
                            location.reload();
                        });

                    } else {
                        layer.msg('删除失败，该节点下有子节点!', {icon: 2, time: 2000});
                    }
                }
            })
        });
    }

    /**
     * 查询菜单信息
     */
    function queryOrgInfo() {
        var menuName = $("#menuName").val();
        var isPublish = $("#isPublish").val();

        /*加载有查询条件的分页页面数据*/
        $("#menuBody").load("sysMenu/queryMenuByCondition",{"menuName":menuName,"isPublish":isPublish},function () {});
    }
</script>
</body>
</html>
