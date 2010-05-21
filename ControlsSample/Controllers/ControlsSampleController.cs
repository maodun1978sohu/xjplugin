using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using ControlsSample.Models;
using System.Text;
using System.IO;

namespace ControlsSample.Controllers
{
    public class ControlsSampleController : Controller
    {

        private ISampleDataRepository _respository;
        public ControlsSampleController()
        {
            _respository = new SampleDataRepository();
        }

        public ControlsSampleController(ISampleDataRepository respository)
        {
            _respository = respository;
        }

        /// <summary>
        /// Trees the asny sample.
        /// </summary>
        /// <returns></returns>
        public ActionResult TreeAsnySample()
        {
            return View();
        }
        /// <summary>
        /// Dpdemoes this instance.
        /// </summary>
        /// <returns></returns>
        public ActionResult dpdemo()
        {
            return View();
        }
        /// <summary>
        /// CMs this instance.
        /// </summary>
        /// <returns></returns>
        public ActionResult CM()
        {
            return View();
        }
        /// <summary>
        /// Usboxes this instance.
        /// </summary>
        /// <returns></returns>
        public ActionResult usbox()
        {
            return View();
        }
        /// <summary>
        /// Bigs the tree sample.
        /// </summary>
        /// <returns></returns>
        public ActionResult BigTreeSample()
        {
            return View();
        }
        /// <summary>
        /// Jsons the grid.
        /// </summary>
        /// <returns></returns>
        public ActionResult JsonGrid()
        {
            return View();
        }
        /// <summary>
        /// XMLs the grid.
        /// </summary>
        /// <returns></returns>
        public ActionResult XmlGrid()
        {
            return View();
        }
        /// <summary>
        /// Formats the grid.
        /// </summary>
        /// <returns></returns>
        public ActionResult FormatGrid()
        {
            return View();
        }
        /// <summary>
        /// Dbs the grid.
        /// </summary>
        /// <returns></returns>
        public ActionResult DbGrid()
        {
            return View();
        }

        public ActionResult OldGrid()
        {
            return View();
        }
        public ActionResult TwoGridInOnePage()
        {
            return View();
        }

        [AcceptVerbs( HttpVerbs.Post)]
        public ContentResult GetJsonGridData(FormCollection form)
        {
            string page = form["page"];
            string datafilename = base.Server.MapPath("~/SampleData/page" + page + ".js");
            StreamReader reader = System.IO.File.OpenText(datafilename);
            string json = reader.ReadToEnd();
            reader.Close();
            return Content(json, "application/json");       
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ContentResult GetXmlGridData(FormCollection form)
        {
            string page = form["page"];
            string datafilename = base.Server.MapPath("~/SampleData/GridDataPage" + page + ".xml");
            StreamReader reader = System.IO.File.OpenText(datafilename);
            string xml = reader.ReadToEnd();
            reader.Close();
            return Content(xml, "text/xml");          
        }
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetDBGridData(FormCollection form)
        {
            var strcategoryid = form["categoryId"];
            int categoryId=-1;
            if(!string.IsNullOrEmpty(strcategoryid))
            {
                categoryId = Convert.ToInt32(strcategoryid);
            }
            var view = new PageView(form);
            JsonFlexiGridData data = _respository.QueryAllProduct(view, categoryId);
            return Json(data);
        }
        /// <summary>
        /// Gets the category list data.
        /// </summary>
        /// <param name="form">虽然没用的，但是必须的参数呵呵！ASP.NET MVC的bug？</param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult GetCategoryListData(FormCollection form )
        {
            JsonFlexiGridData data = _respository.QueryAllCategories();
            return Json(data);
        }

        public ActionResult TabPanel()
        {
            return View();
        }

        /// <summary>
        /// Gets the tree root.
        /// </summary>
        /// <returns></returns>
        public JsonResult GetTreeRoot()
        {
            var root = _respository.GetRoot();
            JsonTreeNode rootnode = new JsonTreeNode();
            rootnode.id = root.ID.ToString();
            rootnode.text = root.AreaName;
            rootnode.value = root.AreaCode;
            rootnode.showcheck = true;
            rootnode.isexpand = true;             
                
            var cl=_respository.GetChildAreaDivide(root.ID);
            rootnode.ChildNodes = buildTreeNodeFromAreaDivide(cl);
            rootnode.hasChildren = rootnode.ChildNodes != null && rootnode.ChildNodes.Count > 0;
            List<JsonTreeNode> list = new List<JsonTreeNode>();
            list.Add(rootnode);
            return Json(list);
        }

        /// <summary>
        /// Builds the tree node from area divide.
        /// </summary>
        /// <param name="ad">The ad.</param>
        /// <returns></returns>
        private List<JsonTreeNode> buildTreeNodeFromAreaDivide(List<AreaDivide> ad)
        {
            return buildTreeNodeFromAreaDivide(ad, 0);
        }

        /// <summary>
        /// Builds the tree node from area divide.
        /// </summary>
        /// <param name="ad">The ad.</param>
        /// <param name="state">The state.</param>
        /// <returns></returns>
        private List<JsonTreeNode> buildTreeNodeFromAreaDivide(List<AreaDivide> ad,byte state)
        {
            return ad.ConvertAll<JsonTreeNode>(x =>
            {
                return new JsonTreeNode()
                {
                    id = x.ID.ToString(),
                    text = x.AreaName,
                    value = x.AreaCode,
                    showcheck = true,
                    isexpand = false,
                    checkstate =state,
                    hasChildren = x.HasChild
                };
            });
         
        }

        /// <summary>
        /// Gets all data.
        /// </summary>
        /// <returns></returns>
        public JsonResult GetAllData()
        {
            var root = _respository.GetRoot();
            JsonTreeNode rootnode = new JsonTreeNode();
            rootnode.id = root.ID.ToString();
            rootnode.text = root.AreaName;
            rootnode.value = root.AreaCode;
            rootnode.showcheck = true;
            rootnode.isexpand = true;

            rootnode.ChildNodes =  buildIt(root.ID);
            rootnode.hasChildren = true;
            List<JsonTreeNode> list = new List<JsonTreeNode>();
            list.Add(rootnode);
            return Json(list);
        }

        /// <summary>
        /// Builds it.
        /// </summary>
        /// <param name="parentId">The parent id.</param>
        /// <returns></returns>
        private List<JsonTreeNode> buildIt(int parentId)
        {
            var cl = _respository.GetChildAreaDivide(parentId);
           if (cl != null)
           {
               var list = buildTreeNodeFromAreaDivide(cl);
               if (list.Count > 0)
               {
                   for (var i = 0; i < list.Count; i++)
                   {
                       if (list[i].hasChildren)
                       {
                          list[i].ChildNodes =buildIt(int.Parse(list[i].id));
                          list[i].complete = true;
                          list[i].hasChildren = list[i].ChildNodes != null && list[i].ChildNodes.Count > 0;                          
                       }
                   }
               }
               return list;
           }
           else
           {
               return null;
           }
        }
        [AcceptVerbs( HttpVerbs.Post)]
        public JsonResult GetChildData(FormCollection form)
        {
            int id = Convert.ToInt32(form["id"]);
            byte state = Convert.ToByte(form["checkstate"]);
            var list = _respository.GetChildAreaDivide(id);
            return Json(buildTreeNodeFromAreaDivide(list, state));
        }

        public ContentResult QueryComplete(string q, int limit)
        {
            string ret = "";
            if (q != "" && limit >0)
            {
               List<Person> list=_respository.QueryCompletePerson(q, limit);
               if (list != null)
               {
                   StringBuilder sb = new StringBuilder();
                   foreach (Person person in list)
                   {
                       sb.AppendLine(person.FullName + "|" + person.PY+"|"+person.ID);
                   }
                   ret = sb.ToString();
               }                
            }
            return Content(ret);
        }
     
    }
}
