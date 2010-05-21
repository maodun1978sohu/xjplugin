<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>TabPanel</title>
    <link href="/Themes/Default/main.css" rel="stylesheet" type="text/css" />
    <link href="/Themes/Default/tabpanel.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .icon_home
        {
            background-image:url("/images/icons/home.png");
        }
    </style>
    <script src="../../Javascripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../Javascripts/common.js" type="text/javascript"></script>
    <script src="../../Javascripts/Plugins/jquery.tabpanel.js" type="text/javascript"></script>
      <script type="text/javascript">
          $(document).ready(function(e) {
              var items = [{ id: "home", text: "��ҳ", classes: "icon_home", isactive: true, content: "��ӭ����" },
            { id: "baidu", text: "�ٶ�", closeable: true, url: "http://www.baidu.com/" },
            { id: "tab3", text: "tab3", disabled: true, content: "tab3" },
            { id: "tab4", text: "tab4", closeable: true, cuscall: tabitem_cuscall },
            { id: "tab5", text: "tab5", closeable: true, content: "tab5", onactive: tabitem_onactive },
            { id: "tab6", text: "tab6", closeable: true, content: "tab6" },
            { id: "tab7", text: "tab7", closeable: true, content: "tab7" },
            { id: "tab8", text: "tab8", closeable: true, content: "tab8" }
            ];

              $("#tabs").tabpanel({ items: items, width: 300 });
              var l = items.length + 1;
              $("#btnaddtab").click(function(e) {
                  var tabtitle = "tab" + l;
                  $("#tabs").addtabitem({ id: new Date().getTime(), text: tabtitle, isactive: true, closeable: true, content: "this is " + tabtitle });
                  l++;
              });
              $("#btnopenhometab").click(function(e) {
                  $("#tabs").opentabitem({ id: "home" });
              });
              function tabitem_cuscall(item, contenpanel) { //contenpanel ��tab body ��������������첽��������ͨ����������䷵������
                  //contenpanel.html("�����Զ�����ʾ������"); //���÷�������һ��Ч��һ��
                  return "�����Զ�����ʾ������";
              }
              function tabitem_onactive(item) {
                  alert("����" + item.text);
              }
              $("#btnresize").click(function(e) {
                  $("#tabs").resizetabpanel(600, 500);
              });
          });
    </script>
</head>
<body>
     <div style="padding: 15px;">
        <div id="tabs">
        </div>
        <div>
            <button id="btnaddtab">add tab</button>
            <button id="btnopenhometab">ѡ��Home</button>
            <button id="btnresize">�����趨��СΪ600*500</button>
        </div>
    </div>
</body>
</html>
