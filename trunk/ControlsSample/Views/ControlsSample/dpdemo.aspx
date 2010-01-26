<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../../Themes/Default/main.css" rel="stylesheet" type="text/css" />
    <link href="../../Themes/Default/dp.css" rel="stylesheet" type="text/css" />
    
    
    <script src="../../Javascripts/jquery.js" type="text/javascript"></script>
    <script src="../../Javascripts/Plugins/jquery.datepicker.js" type="text/javascript"></script>
    
    <!--语法高亮显示的部分，实际项目中不需要该段-->
    <script src="../../highlighter/scripts/shCore.js" type="text/javascript"></script>
    <script src="../../highlighter/scripts/shBrushJScript.js" type="text/javascript"></script>
    <script src="../../highlighter/scripts/shBrushCss.js" type="text/javascript"></script>  
    <link href="../../highlighter/styles/shCore.css" rel="stylesheet" type="text/css" />
    <link href="../../highlighter/styles/shThemeDefault.css" rel="stylesheet" type="text/css" /> 
    <script type="text/javascript">
        SyntaxHighlighter.config.clipboardSwf = '../../highlighter/scripts/clipboard.swf';
    	    SyntaxHighlighter.all();
	</script>
	<style type="text/css">
	.picker
	{
	    height:16px;
	    width:16px;
	    background:url("/images/icons/cal.gif") no-repeat;
	    margin-left:-19px;
	    cursor:pointer;
	    border:none;		  
	}
	</style>
    <!--语法高亮显示的部分，实际项目中不需要该段end-->
    <script type="text/javascript">
        $(document).ready(function() {           
            $("#datetime").datepicker({ picker: "<button>选择</button>", applyrule: rule });
            $("#endtime").datepicker({ picker: "<button>选择</button>", applyrule: rule });
            $("#temptime").datepicker({ picker: "<img class='picker' align='middle' src='/themes/shared/images/s.gif' alt=''/>" });
            $("#hdobj").datepicker({ picker: "#handler", showtarget: $("#target"), onReturn: function(d) { alert(d.Format("yyyy年M月d日")); } });
            function rule(id) {
                if (id == 'datetime') {
                    var v = $("#endtime").val();
                    if (v == "") {
                        return null;
                    }
                    else {
                        var d = v.match(/^(\d{1,4})(-|\/|.)(\d{1,2})\2(\d{1,2})$/);
                        if (d != null) {
                            var nd = new Date(parseInt(d[1], 10), parseInt(d[3], 10) - 1, parseInt(d[4], 10));
                            return { enddate: nd };
                        }
                        else {
                            return null;
                        }
                    }
                }
                else {
                    var v = $("#datetime").val();
                    if (v == "") {
                        return null;
                    }
                    else {
                        var d = v.match(/^(\d{1,4})(-|\/|.)(\d{1,2})\2(\d{1,2})$/);
                        if (d != null) {
                            var nd = new Date(parseInt(d[1], 10), parseInt(d[3], 10) - 1, parseInt(d[4], 10));
                            return { startdate: nd };
                        }
                        else {
                            return null;
                        }
                    }

                }
            }
        });
    </script>
</head>
<body>     
    <div style="padding:10px;"> 
    <h1>日期选择控件使用样例</h1>
    <h2>样例</h2> 
   
    <fieldset>
        <legend>示例1：普通日期选择</legend>
        <div>
            <input type="text" id="temptime" />
        </div>
        <div class="tip">
            简单的日期选择，只需设定picker即可;
        </div>
        <pre class="brush:js;">
           $(&quot;#temptime&quot;).datepicker({ 
             picker: &quot;<img class='picker' align='middle' src='/themes/shared/images/s.gif' alt=''/>&quot; 
           });
        </pre>
         <pre class="brush:css;">
            .picker
	        {
	            height:16px;
	            width:16px;
	            background:url("/images/icons/cal.gif") no-repeat;
	            margin-left:-19px;
	            cursor:pointer;
	            border:none;		  
	        }
        </pre>
    </fieldset>
    <fieldset>
        <legend>示例2：日期范围选择</legend>
        <div>
            <input type="text"  id='datetime'/>
            <input type="text"  id='endtime'/>
        </div>
        <div class="tip">
            日期范围选择，可在每次展开日历框前应用applyrule函数;返回{startdate:'date',enddate:'date'};
        </div>
        <pre class="brush:js;">
            $("#datetime").datepicker({ picker: "<button>选择</button>", applyrule: rule });
            $("#endtime").datepicker({ picker: "<button>选择</button>", applyrule: rule });
            
            function rule(id) {
                if (id == 'datetime') { //因为这是多个input框一起设置为日期选择框所以要区分一下是哪个展开了。
                    var v = $("#endtime").val();
                    if (v == "") {
                        return null;
                    }
                    else {
                        //获取结束时间，开始时间不能大于结束时间
                        var d = v.match(/^(\d{1,4})(-|\/|.)(\d{1,2})\2(\d{1,2})$/);
                        if (d != null) {
                            var nd = new Date(parseInt(d[1], 10), parseInt(d[3], 10) - 1, parseInt(d[4], 10));
                            return { enddate: nd };
                        }
                        else {
                            return null;
                        }
                    }
                }
                else {
                    var v = $("#datetime").val();
                    if (v == "") {
                        return null;
                    }
                    else {
                       //获取开始时间，结束时间不能大于开始时间
                        var d = v.match(/^(\d{1,4})(-|\/|.)(\d{1,2})\2(\d{1,2})$/);
                        if (d != null) {
                            var nd = new Date(parseInt(d[1], 10), parseInt(d[3], 10) - 1, parseInt(d[4], 10));
                            return { startdate: nd };
                        }
                        else {
                            return null;
                        }
                    }

                }
            }
        </pre>
    </fieldset>
     <fieldset>
        <legend>示例3：附加到非input的控件上</legend>
        <p></p>
         <p></p>
        <div id="target">
            <a id='handler' href='javascript:void'>点我</a>
            <input  type="hidden" id="hdobj"/>
        </div>
        <pre class="brush:js;">
            $("#hdobj").datepicker({ 
                                    picker: "#handler",  //设置点击事件的载体，
                                    showtarget: $("#target"),//设置日期框依附位置的载体，可以和picker是同一个;
                                    onReturn:function(d){ //选择日期后的回调事件
                                                alert(d.Format("yyyy年M月d日"));
                                              } 
                                    });
        </pre>
    </fieldset>
    </div>
</body>
</html>