<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../../Themes/Default/main.css" rel="stylesheet" type="text/css" />
    <link href="../../Themes/Default/contextmenu.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .target
        {
            position:absolute;
            left:200px;
            top:400px;
            border:solid 1px #ffccee;   
            padding:5px;
            background-color:Blue;
            color:#fff;
         }
    </style>
    <script src="../../Javascripts/jquery.js" type="text/javascript"></script>
    <script src="../../Javascripts/Plugins/jquery.contextmenu.js" type="text/javascript"></script>  
    <script type="text/javascript">
        $().ready(function() {
            var option = { width: 150, items: [
                            { text: "第一项", icon: "/images/icons/ico1.gif", alias: "1-1", action: menuAction },
                            { text: "第二项", icon: "/images/icons/ico2.gif", alias: "1-2", action: menuAction },
                            { text: "第三项", icon: "/images/icons/ico3.gif", alias: "1-3", action: menuAction },
                            { type: "splitLine" },
                            { text: "组一集合", icon: "/images/icons/ico4.gif", alias: "1-4", type: "group", width: 170, items: [
	                            { text: "组三集合", icon: "/images/icons/ico4-1.gif", alias: "2-2", type: "group", width: 190, items: [
		                            { text: "组3一项", icon: "/images/icons/ico4-1-1.gif", alias: "3-1", action: menuAction },
		                            { text: "组3二项", icon: "/images/icons/ico4-1-1.gif", alias: "3-2", action: menuAction }
	                            ]
	                            },
	                            { text: "组1一项", icon: "/images/icons/ico4-2.gif", alias: "2-1", action: menuAction },
	                            { text: "组1二项", icon: "/images/icons/ico4-3.gif", alias: "2-3", action: menuAction },
	                            { text: "组1三项", icon: "/images/icons/ico4-4.gif", alias: "2-4", action: menuAction }
                            ]
                            },
                            { type: "splitLine" },
                            { text: "第四项", icon: "/images/icons/ico5.gif", alias: "1-5", action: menuAction },
                            { text: "组二集合", icon: "/images/icons/ico6.gif", alias: "1-6", type: "group", width: 180, items: [
	                            { text: "组2一项", icon: "/images/icons/ico6-1.gif", alias: "4-1", action: menuAction },
	                            { text: "组2二项", icon: "/images/icons/ico6-2.gif", alias: "4-2", action: menuAction }
                            ]
                            }
                            ], onShow: applyrule,
                onContextMenu: BeforeContextMenu
            };
            function menuAction() {
                alert(this.data.alias);
            }
            function applyrule(menu) {               
                if (this.id == "target2") {
                    menu.applyrule({ name: "target2",
                        disable: true,
                        items: ["1-2", "2-3", "2-4", "1-6"]
                    });
                }
                else {
                    menu.applyrule({ name: "all",
                        disable: true,
                        items: []
                    });
                }
            }
            function BeforeContextMenu() {
                return this.id != "target3";
            }
            $("#target,#target2,#target3").contextmenu(option);

            var option2 = { width: 150,alias:"new", items: [
                            { text: "第一项", icon: "/images/icons/ico1.gif", alias: "1-1", action: menuAction },
                            { text: "第二项", icon: "/images/icons/ico2.gif", alias: "1-2", action: menuAction },
                            { text: "第三项", icon: "/images/icons/ico3.gif", alias: "1-3", action: menuAction },
                              { text: "组二集合", icon: "/images/icons/ico6.gif", alias: "1-6", type: "group", width: 180, items: [
	                            { text: "组2一项", icon: "/images/icons/ico6-1.gif", alias: "4-1", action: menuAction },
	                            { text: "组2二项", icon: "/images/icons/ico6-2.gif", alias: "4-2", action: menuAction }
                            ]
                            }                     
                ]
            };
             $("#target4").contextmenu(option2);
        });
    </script>
</head>
<body>
      <div class="info">右键菜单示例</div>
        <div id="target"  class="target">在这里右击[所有菜单]</div>
        <div id="target2"  class="target" style="left:600px;top:100px;">在这里右击[disable某些项]</div>
        <div id="target3"  class="target" style="left:400px;top:500px;">在这里右击[这个右键不能显示]</div>
        <div id="target4"  class="target" style="left:300px;top:200px;">第二个右键</div>
</body>
</html>

