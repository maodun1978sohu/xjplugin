using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace ControlsSample.Models
{
    public class SampleDataRepository:ISampleDataRepository
    {

       
        public SampleDataRepository()
        {
         
        }
        #region ISampleDataRepository 成员

        public AreaDivide GetRoot()
        {
            return new AreaDivide()
            {
                ID=0,
                AreaName="中国",
                ParentID=-1,
                AreaCode="86",
                HasChild=true
            };
        }

        public List<AreaDivide> GetChildAreaDivide(int pId)
        {

            string sql = @"SELECT A.ID,A.AreaName,A.AreaCode,A.ParentID
                                , case when isnull(B.c,0)>0 then 1 else 0 end as HasChild FROM AreaDivide as  A
                            LEFT JOIN 
                            ( SELECT COUNT(1) as c ,ParentID AS PID FROM AreaDivide AS MA GROUP BY ParentID) as B
                            ON A.ID=B.PID WHERE A.ParentID=@ParentID and len(A.AreaCode)<7
                            Order By A.AreaCode";

            List<AreaDivide> list =new List<AreaDivide>();
            using(SqlDataReader reader= SqlHelper.ExecuteReader(SqlHelper.dbConstr, System.Data.CommandType.Text,sql,new SqlParameter("@ParentID",pId)))
            {
                
                while(reader.Read())
                {
                    AreaDivide da =new AreaDivide();
                    da.ID= reader.GetInt32(0);
                    da.AreaName = reader.GetString(1);
                    da.AreaCode = reader.GetString(2);
                    da.ParentID = reader.GetInt32(3);
                    da.HasChild = reader.GetInt32(4)>0;
                    list.Add(da);
                }
            }
            return list;
        }
        /// <summary>
        /// Queries the complete person.
        /// </summary>
        /// <param name="q">The key word.</param>
        /// <param name="limit">The limit.</param>
        /// <returns></returns>
        public List<Person> QueryCompletePerson(string q, int limit)
        {
            q=q.Replace("'", "").Replace("--", "").Replace(";", "");
            string sql = "select top " + limit + " * from person where FullName like N'" + q + "%' or py like N'" + q + "%'";
            List<Person> list = new List<Person>();
            using (SqlDataReader reader = SqlHelper.ExecuteReader(SqlHelper.dbConstr, System.Data.CommandType.Text, sql))
            {

                while (reader.Read())
                {
                    Person p = new Person();
                    p.ID = reader.GetInt32(0);
                    p.FullName = reader.GetString(1);
                    p.PY = reader.GetString(2);
                  
                    list.Add(p);
                }
            }
            return list;
        }

        /// <summary>
        /// Queries all product.
        /// </summary>
        /// <param name="view">The view.</param>
        /// <param name="categoryid">The categoryid.</param>
        /// <returns></returns>
        public JsonFlexiGridData QueryAllProduct(PageView view,int categoryid)
        {
            string where = "";
            if (categoryid > 0)
            {
                where = " and CategoryId="+categoryid;
            }
            return QueryDataForFlexGridByPager("ProductID,ProductName,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder", "Products", "", "ProductID",where, view);
        }

        public List<AreaDivide> GetFullAreaDivideList()
        {
            return null;
        }

        public JsonFlexiGridData QueryAllCategories()
        {
            PageView view = new PageView();
            view.PageSize = 10000;
            view.PageIndex = 0;
            return QueryDataForFlexGridByPager("CategoryID,CategoryName", "Categories", "", "CategoryID", "", view);
        }

        public JsonFlexiGridData QueryDataForFlexGridByPager(string columns, string table, string order, string pk, string strparams,
                                       PageView view)
        {
            if (string.IsNullOrEmpty(order) && view.OrderBy != null && view.OrderBy.Count > 0)
            {
                order = view.OrderBy.ToString();
            }

            if (string.IsNullOrEmpty(strparams) && view.QuickLuanch != null)
            {
                strparams = view.QuickLuanch.ToString();
            }

            var Para = new SqlParameter[8];
            Para[0] = new SqlParameter("@SQLPARAMS", SqlDbType.NVarChar, 2000) { Value = strparams };
            Para[1] = new SqlParameter("@PAGESIZE", SqlDbType.Int, 4) { Value = view.PageSize };
            Para[2] = new SqlParameter("@PAGEINDEX", SqlDbType.Int, 4) { Value = view.PageIndex };
            Para[3] = new SqlParameter("@SQLTABLE", SqlDbType.VarChar, 1000) { Value = table };
            Para[4] = new SqlParameter("@SQLCOLUMNS", SqlDbType.VarChar, 4000) { Value = columns };
            Para[5] = new SqlParameter("@SQLPK", SqlDbType.VarChar, 50) { Value = pk };
            Para[6] = new SqlParameter("@SQLORDER", SqlDbType.VarChar, 200) { Value = order };
            Para[7] = new SqlParameter("@Count", SqlDbType.Int, 4) { Direction = ParameterDirection.Output };
           
            JsonFlexiGridData data = new JsonFlexiGridData { page = view.PageIndex + 1, total = view.RecordCount };
            using (SqlDataReader reader = SqlHelper.ExecuteReader(SqlHelper.dbConstr, System.Data.CommandType.StoredProcedure, "PAGESELECT",false, Para))
            {
                if (reader.HasRows)
                {
                    if (data.rows == null)
                    {
                        data.rows = new List<FlexiGridRow>();
                    }
                    while (reader.Read())
                    {
                        FlexiGridRow row = new FlexiGridRow { cell = new List<string>() };
                        for (int i = 0, l = reader.FieldCount; i < l; i++)
                        { 
                            string  v=  reader.IsDBNull(i)?"":reader.GetValue(i).ToString();
                            if( pk==reader.GetName(i))
                            {
                               row.id=v;
                            }
                            row.cell.Add(v);
                        }
                         data.rows.Add(row);
                    }
                }
               
            }
            data.total=view.RecordCount = Para[7].Value != null && Para[7].Value != DBNull.Value ? Convert.ToInt32(Para[7].Value) : -1;
            return data;
        }

        #endregion
    }
}
