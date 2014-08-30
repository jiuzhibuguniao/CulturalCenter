using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Member
{
    public partial class ShowSingle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (id != null & id != "")
            {
                Cultural.Model.Member member = new Cultural.Model.Member();
                Cultural.BLL.Member bll = new Cultural.BLL.Member();
                Cultural.BLL.Department dbll = new Cultural.BLL.Department();
                Cultural.Model.Department dmodel = new Cultural.Model.Department();
                if (member.DepartID != 0 && member.DepartID!=null)
                {
                    dmodel = dbll.GetModel(int.Parse(member.DepartID.ToString()));
                }
                member = bll.GetModel(int.Parse(id.Trim()));
                if (member != null)
                {
                    txtLoginID.Text = member.LoginID;
                    txtPassword.Text = member.Password;
                    txtStaffName.Text = member.MembName;
                    lblGender.Text = member.Gender;
                    txtPhone.Text = member.Phone;
                    txtEmail.Text = member.Email;
                    txtAddress.Text = member.Address;
                    txtJob.Text = member.JobName;
                    txtDepartID.Text = dmodel == null ? "" : dmodel.DepartName;
                    txtResume.Text = member.Resume;
                    ddlType.SelectedIndex = int.Parse(member.Status == "" ? "0" : member.Status == null ? "0" : member.Status);
                    lblRegtime.Text = member.RegTime.ToString();
                    Photo.ImageUrl = "../../Image/Photo/"+member.PhotoURL;
                }
                else
                {
                    Maticsoft.Common.MessageBox.ShowAndRedirect(this, "出错！请重试！", "../Main.aspx");
                }
            }
            else
            {
                Maticsoft.Common.MessageBox.ShowAndRedirect(this, "出错！请重试！", "../Main.aspx");
            }
        }
    }
}