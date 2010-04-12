<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>     
    <link href="<%=Url.Content("~/Themes/Default/tree.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%=Url.Content("~/Themes/home/home.css") %>" rel="stylesheet" type="text/css" />    
    <style type="text/css">
        .root .bbit-tree-node-icon
        {
            background-image:url("/images/icons/ico6.gif");    
        }
    </style>
</head>
<body>
    <div class="MainContainer">
        <div id="top" class="top">
            <div class="title">
                Hello ! 欢迎你来到假正经哥哥的控件示例
            </div>
            <div class="toolbar">
                <div class="leftc">                    
                </div>
                <div class="rightc">
                  <a id="back" class='back'><span>后退</span></a>
                  <a id="forward" class='forward'><span>前进</span></a>
                  <a id="reflash" class="reflash"><span>刷新</span></a>
                  <a id="signout" class="signout"><span>注销</span></a>
                </div>
            </div>
        </div>
        <div>
            <div id="left" class="left">               
            </div>
            <div class="center">
                <div class="t1"></div>
                <div class="t2"></div>
                <div id="center">
                <iframe id="ifm" name="ifm" style="width: 100%; height: 100%;" src="" frameborder="0">
                </iframe>
                </div>
                <div class="t2"></div>
                <div class="t1"></div>
            </div>
        </div>
    </div>
    <script src="<%=Url.Content("~/Javascripts/jquery.js") %>" type="text/javascript"></script>
    <script src="<%=Url.Content("~/Javascripts/common.js") %>" type="text/javascript"></script>
    <script src="<%=Url.Content("~/Javascripts/Plugins/jquery.tree.js") %>" type="text/javascript"></script>
    <script src="<%=Url.Content("~/SampleData/treedata.js") %>" type="text/javascript"></script>
  
    
    <script type="text/javascript">
        $(document).ready(function() {            
            var op = { data: menudata, onnodeclick: navi, theme: "bbit-tree-lines" };
            $("#left").treeview(op);
            function navi(item) {
                if (item.value) {
                    $("#ifm").attr("src", item.value);
                }
                else {
                    item.expand();
                }
            }
        });
        $("#back").click(function(){history.back();});
        $("#forward").click(function(){history.go(1);});
        $("#reflash").click(function() {document.location.reload(); });
        $("#signout").click(function(){ alert("你没登录啊！"); });
               
        $(document).ready(ReSize);
        $(window).resize(ReSize);
        function ReSize() {
            var mheight = document.documentElement.clientHeight;
            var theight = $("#top").height();
            var height = mheight - theight - 8;
            $("#left").height(height + 5);
            $("#center").height(height);
        }        
    </script>
</body>
</html>