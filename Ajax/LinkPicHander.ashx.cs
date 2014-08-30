using System;
using System.Collections.Generic;
using System.IO;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// LinkPicHander 的摘要说明
    /// </summary>
    public class LinkPicHander : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpPostedFile file = context.Request.Files["Filedata"];
            string uploadPath =
                HttpContext.Current.Server.MapPath(@context.Request["folder"]) + "\\";
            string MemName = context.Request.Params["LinkName"];
            if (MemName != null && MemName != "")
            {
                if (file != null)
                {
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    //file.SaveAs(uploadPath + file.FileName);  邹瑶注释
                    string FileName = string.Format("{0}-{1}-{2}-{3}.jpg", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'), MemName.Trim());//, file.FileName.Substring(file.FileName.LastIndexOf('.'), file.FileName.Length - file.FileName.LastIndexOf('.')));
                    file.SaveAs(uploadPath + FileName);  //邹瑶修改
                    //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            else
            {
                context.Response.Write("0");
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