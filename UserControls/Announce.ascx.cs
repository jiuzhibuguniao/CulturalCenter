using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.ComponentModel;

namespace CulturalCenter
{
    public partial class Announce : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string FormatDate(object o)
        {
            if (o == null)
            {
                return "";
            }
            else
            {
                //DateTime dt = (DateTime)o;
                DateTime dt = new DateTime();
                    DateTime.TryParse(o.ToString(),out dt);
                    if (dt != null)
                    {
                        return string.Format("{0}-{1}-{2}", dt.Year, dt.Month, dt.Day);
                    }
                    else
                    {
                        return "";
                    }
            }
        }

        public string CutString(string text)
        {
            if (text.Length > 16)
            {
                return text.Substring(0, 15) + "…";
            }
            else
            {
                return text;
            }
        }
       
    }
     
}