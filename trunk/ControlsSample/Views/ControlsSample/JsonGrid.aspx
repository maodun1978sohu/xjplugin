<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="/Themes/Default/main.css" rel="stylesheet" type="text/css" />
    <link href="/Themes/Default/flexigrid.css" rel="stylesheet" type="text/css" />    
    <link href="/Themes/Default/contextmenu.css" rel="stylesheet" type="text/css" />
    <link href="/Themes/Shared/blackbird.css" rel="stylesheet" type="text/css" />  
</head>
<body>
    <div>    
        <div id="info" class="info important">由于该示例没有访问数据库而是模拟数据，排序和动态调整每页记录数无法演示 ,按F2显示Trace信息</div>
        <div id="ptable" style="margin:10px">
         <table id="productlist" style="display:none"></table>
        </div>  
        
    </div>
    <!--如果是部署到虚拟目录的项目，请使用Url.Content()-->
    <script src="/Javascripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/Javascripts/Plugins/jquery.flexigrid.trace.js" type="text/javascript"></script> 
    <script src="/Javascripts/Plugins/jquery.contextmenu.js" type="text/javascript"></script>
    <script src="/Javascripts/lib/blackbird.js" type="text/javascript"></script>
  
    <script type="text/javascript">
        $(document).ready(function() {
            var maiheight = document.documentElement.clientHeight;
            var w = $("#ptable").width() - 3;
            var infoheight = $("#info").height() + 30;
            var otherpm = 150; //GridHead，toolbar，footer,gridmargin
            var gh = maiheight - infoheight - otherpm;
            var option = {
                height: gh, //flexigrid插件的高度，单位为px
                width: w,
                url: '<%=Url.Action("GetJsonGridData")%>', //ajax url,ajax方式对应的url地址
                colModel: [
			        { display: '商品编码', name: 'ProductID', width: 60, sortable: true, align: 'left',hide:true },
			        { display: '商品名称', name: 'ProductName', width: 100, sortable: true, align: 'left' },
			        { display: '规格', name: 'QuantityPerUnit', width: 120, sortable: false, align: 'left' },
			        { display: '单价', name: 'UnitPrice', width: 100, sortable: true, align: 'right', process: formatMoney },
			        { display: '库存', name: 'UnitsInStock', width: 100, sortable: true, align: 'left' },
			        { display: '已订购', name: 'UnitsOnOrder', width: 100, sortable: true, align: 'left' }
				],
                buttons: [
                  { name: 'Add', displayname: "新增", bclass: 'Add', onpress: toolbarItem_onclick },
                  { name: 'Delete', displayname: "删除", bclass: 'Delete', onpress: toolbarItem_onclick }
                ],
                sortname: "ProductID",
                sortorder: "asc",
                title: "所有商品列表",
                usepager: true,
                useRp: false,
                rowbinddata: true,
                showcheckbox: true,
                rowhandler: contextmenu,
				selectedonclick: true,
                singleselected:false
            };
            var grid = $("#productlist").flexigrid(option);
            /*
            $(window).resize(function() {
                var maiheight = document.documentElement.clientHeight;
                var w = $("#ptable").width() - 3;
                var infoheight = $("#info").height() + 30;
                var otherpm = 150;
                var gh = maiheight - infoheight - otherpm;
                $("#productlist").flexResize(w, gh);
            });*/
            function formatMoney(value, pid) {
                return "￥" + parseFloat(value).toFixed(2);
            }

            function contextmenu(row) {
                var menu = { width: 150, items: [
                     { text: "查看", icon: "/images/icons/view.png", alias: "contextmenu-edit", action: contextMenuItem_click },
                     { text: "编辑", icon: "/images/icons/edit.png", alias: "contextmenu-view", action: contextMenuItem_click },
                     { text: "删除", icon: "/images/icons/rowdelete.png", alias: "contextmenu-delete", action: contextMenuItem_click },
                     { text: "刷新", icon: "/images/icons/table_refresh.png", alias: "contextmenu-reflash", action: contextMenuItem_click }
                ]
                };
            function contextMenuItem_click(target) {
                    var id = $(target).attr("id").substr(3);
                    var cmd = this.data.alias;
                    var ch = $.browser.msie ? target.ch : target.getAttribute("ch");
                    var cell = ch.split("_FG$SP_");
                    if (cmd == "contextmenu-edit") {
                        alert("编辑，产品编号=" + id);
                    }
                    else if (cmd == "contextmenu-view") {
                        alert("编辑，产品编号=" + id);
                    }
                    else if (cmd == "contextmenu-delete") {
                        var name = cell[1];
                        if (confirm("你确认要删除商品 [" + name + "] 吗？")) {
                            alert("删除，产品编号=" + id);
                        }
                    }
                    else {
                        $("#productlist").flexReload();
                    }
                }
                $(row).contextmenu(menu);
            }

            function toolbarItem_onclick(cmd, grid) {
                if (cmd == "Add") {
                    alert("cmd add is excuted");
                }
                else if (cmd == "Delete") {
                    alert("cmd Delete is excuted");
                }
            }

        });
    </script>
</body>
</html>
