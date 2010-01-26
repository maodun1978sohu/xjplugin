using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ControlsSample.Models
{
    public class AreaDivide 
    {
        public int ID { get; set; }
        public string AreaName { get; set; }
        public string AreaCode { get; set; }
        public string SimpleCode { get; set; }
        public byte AreaType { get; set; }
        public int ParentID { get; set; }
        public bool IsValid { get; set; }
        public string UPUser { get; set; }
        public DateTime UPDateTime { get; set; }
        public string FullName { get; set; }
        public bool HasChild { get; set; }
    }
}
