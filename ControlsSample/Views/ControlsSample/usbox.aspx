<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../../Themes/Default/main.css" rel="stylesheet" type="text/css" />
    <link href="../../Themes/Default/usbox.css" rel="stylesheet" type="text/css" />
    <link href="../../Themes/Default/autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="../../Javascripts/jquery.js" type="text/javascript"></script>
    <script src="../../Javascripts/Plugins/jquery.autocomplete.js" type="text/javascript"></script>
    <script src="../../Javascripts/Plugins/jquery.usbox.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#usbox").usbox({
                width: 430,
                urlOrData:"<%=Url.Action("QueryComplete")%>",
                addItem: function(data) {
                   var length=data.length;
                    var t = $("#hdtext").val();
                    var v = $("#hdvalue").val();
                    var t1 = t != "" ? t.split(",") : [];
                    var v1 = v != "" ? v.split(",") : [];
                    for(var i=0;i<length;i++)
                    {
                        t1.push(data[i][0]);
                        v1.push(data[i][2]);
                    }
                    $("#hdtext").val(t1.join(","));
                    $("#hdvalue").val(v1.join(","));
                    return true;
                },
                removeItem: function(data) {
                    var t = $("#hdtext").val();
                    var v = $("#hdvalue").val();
                    var t1 = t.split(",");
                    var v1 = v.split(",");                   
                    var index = -1;
                    for (var i = v1.length - 1; i >= 0; i--) {
                        if (data[2] == v1[i]) {
                            index = i;
                            break;
                        }
                    }
                    if (index > -1) {
                        t1.splice(index, 1);
                        v1.splice(index, 1);
                        $("#hdtext").val(t1.join(","));
                        $("#hdvalue").val(v1.join(","));
                    }

                }
            });
            var tempdata = [["假正经哥哥", "xuanye","001"]];         
            $("#usbox").addboxitem(tempdata);
        });
    </script>
</head>

<body>
<div id="usbox" class="bbit-usbox"> 
</div>
<input id="hdtext" type="text"/>
<input id="hdvalue" type="text"/>
输入框在实际项目中可能是隐藏域，默认我加上了假正经哥哥
</body>
</html>
