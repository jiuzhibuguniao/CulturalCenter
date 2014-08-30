using System;
using System.Collections.Generic;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// Login 的摘要说明
    /// </summary>
    public class Login : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string name = context.Request["MemName"];
            Cultural.BLL.Member bll = new Cultural.BLL.Member();
            if (name.Trim().Length < 3 || name.Trim().Length>20 || bll.GetList(string.Format(" LoginID = '{0}' ", name)).Tables[0].Rows.Count > 0)
            {
                context.Response.Write("Exist");
            }
            else
            {
                context.Response.Write("None");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}