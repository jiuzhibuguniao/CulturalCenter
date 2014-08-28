using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter
{
    public partial class SelfInfoModify : System.Web.UI.Page
    {
        public static  string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string Httpid = Request.QueryString["id"];
                string flag = Request.QueryString["flag"];
                if (flag != "" && flag == "1")
                {
                    id = Httpid;
                }
                else
                {
                    id = Session[Common.Session_MemID].ToString();
                }

                if (id != null & id != "")
                {
                    BinInfo(int.Parse(id));
                }
                else
                {
                    Maticsoft.Common.MessageBox.ShowAndRedirect(this, "出错！请重试！", "../Main.aspx");
                }
                if (Session[Common.Session_MemStatus] != null)
                {
                    if (Session[Common.Session_MemStatus].ToString() == "5")
                    {
                        ddlType.Enabled = true;
                    }
                    else if (Session[Common.Session_MemStatus].ToString() == "4")
                    {
                        ddlType.Enabled = true;
                        ddlType.Items.Remove(ddlType.Items.FindByText("超级管理员"));
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Cultural.Model.Member member = new Cultural.Model.Member();
            Cultural.BLL.Member bll = new Cultural.BLL.Member();
            try
            {
                member = bll.GetModel(int.Parse(id.Trim()));
                if (member != null)
                {
                    member.Gender = ddlGender.SelectedItem.Text.Trim();
                    member.Phone = this.txtPhone.Text;
                    member.Email = this.txtEmail.Text;
                    member.Address = this.txtAddress.Text;
                    member.JobName = this.txtJob.Text;
                    member.Resume = this.txtResume.Text.Trim();
                    Cultural.BLL.Department dbll = new Cultural.BLL.Department();
                    Cultural.Model.Department depart = new Cultural.Model.Department();
                    List<Cultural.Model.Department> departList = dbll.GetModelList(string.Format(" DepartName = '{0}'", txtDepartID.Text.Trim()));
                    depart = departList.Count > 0 ? departList[0] : null;
                    int departID = 0;
                    if (depart == null)
                    {
                        depart = new Cultural.Model.Department();
                        depart.DepartName = txtDepartID.Text.Trim();
                        dbll.Add(depart);
                        departID = dbll.GetModelList(string.Format(" DepartName like '%{0}%'", txtDepartID.Text.Trim()))[0].DepartID;
                    }
                    else
                    {
                        departID = depart.DepartID;
                    }
                    member.DepartID = departID;
                    member.Status = ddlType.SelectedValue;
                    if (hidFilePath.Value != "")
                    {
                        member.PhotoURL = hidFilePath.Value;
                    }
                    bll.Update(member);
                    Maticsoft.Common.MessageBox.Show(this.Page, "保存成功！");
                    BinInfo(int.Parse(id));
                }
            }
            catch
            {
                Maticsoft.Common.MessageBox.Show(this.Page, "保存失败，请重试！");
            }
            
        }

        public void BinInfo(int id)
        {
            Cultural.Model.Member member = new Cultural.Model.Member();
            Cultural.BLL.Member bll = new Cultural.BLL.Member();
            Cultural.BLL.Department dbll = new Cultural.BLL.Department();
            Cultural.Model.Department dmodel = new Cultural.Model.Department();
            member = bll.GetModel(id);

            if (member != null)
            {
                if (member.DepartID != 0 && member.DepartID != null)
                {
                    dmodel = dbll.GetModel(int.Parse(member.DepartID.ToString()));
                }
                txtLoginID.Text = member.LoginID;
                txtPassword.Text = member.Password;
                txtStaffName.Text = member.MembName;
                ddlGender.SelectedIndex = ddlGender.Items.IndexOf(ddlGender.Items.FindByText(member.Gender));
                txtPhone.Text = member.Phone;
                txtEmail.Text = member.Email;
                txtAddress.Text = member.Address;
                txtJob.Text = member.JobName;
                txtDepartID.Text = dmodel == null ? "" : dmodel.DepartName;
                txtResume.Text = member.Resume;
                ddlType.SelectedIndex = int.Parse(member.Status == "" ? "0" : member.Status == null ? "0" : member.Status);
                lblRegtime.Text = member.RegTime.ToString();
                Photo.ImageUrl =CommonFun.URLConverToServer( "../../Image/Photo/" + member.PhotoURL);
            }
            else
            {
                Maticsoft.Common.MessageBox.ShowAndRedirect(this, "出错！请重试！", "../Main.aspx");
            }
        }
    }
}