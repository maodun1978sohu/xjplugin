using System;
using System.Collections.Generic;
using System.Collections.Specialized;

namespace ControlsSample.Models
{
    public class PageView
    {
        public Orderby _orderby;

        public PageView()
        {
        }

        public PageView(NameValueCollection nvc)
        {
            if (!string.IsNullOrEmpty(nvc["page"]))
            {
                PageIndex = Convert.ToInt32(nvc["page"]) - 1;
            }
            else
            {
                PageIndex = 0;
            }
            PageSize = !string.IsNullOrEmpty(nvc["rp"]) ? Convert.ToInt32(nvc["rp"]) : 35;

            if (!string.IsNullOrEmpty(nvc["sortname"]) && nvc["sortname"] != "undefined")
            {
                OrderByType type = nvc["sortorder"] == "desc" ? OrderByType.Desc : OrderByType.Asc;
                OrderBy.Add(nvc["sortname"], type);
            }
            if (!string.IsNullOrEmpty(nvc["qtype"]))
            {
                QuickLuanch = new QuickLuanch
                                  {
                                      FieldName = nvc["qtype"],
                                      Operator = (nvc["qop"] == "Eq" ? Operator.Eq : Operator.Like),
                                      Value = nvc["query"]
                                  };
            }
        }

        /// <summary>
        /// 每页记录数
        /// </summary>
        /// <value>The size of the page.</value>
        /// <Author>xuanye 2008/12/30</Author>
        public int PageSize { get; set; }

        /// <summary>
        /// 当前页码，从0开始计数
        /// </summary>
        /// <value>The index of the page.</value>
        /// <Author>xuanye 2008/12/30</Author>
        public int PageIndex { get; set; }

        /// <summary>
        /// 排序
        /// </summary>
        /// <value>The order by.</value>
        /// <Author>xuanye 2008/12/30</Author>
        public Orderby OrderBy
        {
            get
            {
                if (_orderby == null)
                {
                    _orderby = new Orderby();
                }
                return _orderby;
            }
        }

        public QuickLuanch QuickLuanch { get; set; }

        /// <summary>
        ///总记录数
        /// </summary>
        /// <value>The record count.</value>
        /// <Author>xuanye 2008/12/30</Author>
        public int RecordCount { get; set; }
    }

    /// <summary>
    /// 快速检索
    /// </summary>
    /// <Author>xuanye 2008/12/30</Author>
    public class QuickLuanch
    {
        public string FieldName { get; set; }

        public Operator Operator { get; set; }

        public string Value { get; set; }

        public override string ToString()
        {
            if (!string.IsNullOrEmpty(Value))
            {
                if (Operator == Operator.Eq)
                {
                    return " And " + FieldName + "=N'"+Value+"'";
                }
                if (Operator == Operator.Like)
                {
                    return " And " + FieldName + " Like N'%"+Value+"%'";
                }
            }
            return "";
        }
    }

    public enum Operator
    {
        Eq,
        Like
    }

    /// <summary>
    /// 排序类
    /// </summary>
    /// <Author>xuanye 2008/12/30</Author>
    public class Orderby : Dictionary<string, OrderByType>
    {
        public override string ToString()
        {
            if (Count > 0)
            {
                string temp = "";
                foreach (var kv in this)
                {
                    if (temp != "") temp += ",";
                    temp += kv.Key + " " + kv.Value;
                }
                return " Order by " + temp;
            }
            return "";
        }
    }

    public enum OrderByType
    {
        Asc,
        Desc
    }
}