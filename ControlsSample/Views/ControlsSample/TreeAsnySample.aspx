<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>TreeAsnySample</title>
     <link href="../../Themes/Default/tree.css" rel="stylesheet" type="text/css" />
   
</head>
<body>
    <div style="margin-bottom:5px;">
        <button id="showchecked">获取选中的节点</button>
        <button id="showcurrent">获取当前节点</button>
        <button id="reflashshanghai">刷新上海节点</button>
        <button id="expandshanghai">刷新上海节点</button>
        <button id="btnSelectAll">全选</button>
        <button id="btnUnSelectAll">全不选</button>
    </div>
    <div style="border-bottom: #c3daf9 1px solid; border-left: #c3daf9 1px solid; width: 250px; height: 500px; overflow: auto; border-top: #c3daf9 1px solid; border-right: #c3daf9 1px solid;">
        <div id="tree">
            
        </div>
        
    </div>
    <script src="../../Javascripts/jquery.js" type="text/javascript"></script>
    <script src="../../Javascripts/common.js" type="text/javascript"></script>
    <script src="../../Javascripts/Plugins/jquery.tree.js" type="text/javascript"></script>
    <script src="../../SampleData/tree1.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        var userAgent = window.navigator.userAgent.toLowerCase();
        $.browser.msie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
        $.browser.msie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
        $.browser.msie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
        function load() {        
            var o = { showcheck: true,
            //onnodeclick:function(item){alert(item.text);},          
            url: "<%=Url.Action("GetChildData")%>" 
            };
            o.data = treedata;                  
            $("#tree").treeview(o);            
            $("#showchecked").click(function(e){
                var s=$("#tree").getTSVs();
                if(s !=null)
                alert(s.join(","));
                else
                alert("NULL");
            });
             $("#showcurrent").click(function(e){
                var s=$("#tree").getTCT();
                if(s !=null)
                    alert(s.text);
                else
                    alert("NULL");
             });
            $("#reflashshanghai").click(function(e) {
                $("#tree").reflash("9"); //9 为节点的ID
            });
            $("#expandshanghai").click(function(e) {
                $("#tree").toggleItem("9"); //9 为节点的ID 展开
            });
            
            //全选
            $("#btnSelectAll").click(function(e) {
                $("#tree").checkAll(); 
            });
            //全不选
            $("#btnUnSelectAll").click(function(e) {
                $("#tree").unCheckAll();
            });

        }   
        if( $.browser.msie6)
        {
            load();
        }
        else{
            $(document).ready(load);
        }
    </script>
</body>
</html>
