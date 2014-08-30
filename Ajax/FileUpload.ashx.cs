using System;
using System.Collections.Generic;
using System.IO;
using System.Web;

namespace CulturalCenter.Ajax
{
    /// <summary>
    /// FileUpload 的摘要说明
    /// </summary>
    public class FileUpload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpPostedFile file = context.Request.Files["Filedata"];
            string pathAdd = string.Format("{0}{1}{2}", 
                                                    DateTime.Now.Year, 
                                                    DateTime.Now.Month.ToString().PadLeft(2, '0'), 
                                                    DateTime.Now.Day.ToString().PadLeft(2, '0'));
            string filePath = context.Request["folder"] + pathAdd + "/";
            string uploadPath = HttpContext.Current.Server.MapPath(@filePath) + "\\";
            if (file != null)
            {
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                String exc = file.FileName.Substring(file.FileName.LastIndexOf('.'));
                //file.SaveAs(uploadPath + file.FileName);  邹瑶注释
                string FileName = string.Format("{0}{1}{2}{3}{4}{5}{6}{7}", 
                                                DateTime.Now.Year, 
                                                DateTime.Now.Month.ToString().PadLeft(2, '0'), 
                                                DateTime.Now.Day.ToString().PadLeft(2, '0'), 
                                                DateTime.Now.Hour.ToString().PadLeft(2, '0'), 
                                                DateTime.Now.Minute.ToString().PadLeft(2, '0'), 
                                                DateTime.Now.Second.ToString().PadLeft(2, '0'),
                                                file.ContentLength, 
                                                exc);//, file.FileName.Substring(file.FileName.LastIndexOf('.'), file.FileName.Length - file.FileName.LastIndexOf('.')));
                file.SaveAs(uploadPath + FileName);  //邹瑶修改
                //下面这句代码缺少的话，上传成功后上传队列的显示不会自动消失
                context.Response.Write(string.Format("{0}/{1}",pathAdd,FileName));
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