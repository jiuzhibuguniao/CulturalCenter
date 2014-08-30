using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Member
{
    public partial class AddMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session[Common.Session_MemStatus] != null)
                {
                    string Mtype = Session[Common.Session_MemStatus].ToString();
                    if (Mtype != "5")
                    {
                        if (Mtype == "4")
                        {
                            ddlType.Items.Remove(ddlType.Items.FindByText("超级管理员"));
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            string strErr = "";
            if (this.txtStaffName.Text.Trim().Length == 0)
            {
                strErr += "姓名不能为空！\\n";
            }

            if (strErr != "")
            {
                MessageBox.Show(this, strErr);
                return;
            }
            string LoginID = this.txtLoginID.Text;
            string Password = this.txtPassword.Text;
            string StaffName = this.txtStaffName.Text;
            string Gender = ddlGender.SelectedItem.Text.Trim();
            string Phone = this.txtPhone.Text;
            string Email = this.txtEmail.Text;
            string Address = this.txtAddress.Text;
            string Job = this.txtJob.Text;
            string resume = this.txtResume.Text.Trim();
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
                departID = dbll.GetMaxId() - 1;
            }
            else
            {
                departID = depart.DepartID;
            }

            string Roles = ddlType.SelectedItem.Value.Trim();

            Cultural.Model.Member member = new Cultural.Model.Member();
            member.LoginID = LoginID;
            member.Password = Password;
            member.MembName = StaffName;
            member.Gender = Gender;
            member.Phone = Phone;
            member.Email = Email;
            member.Address = Address;
            member.JobName = Job;
            member.DepartID = departID;
            member.RegTime = string.Format("{0}-{1}-{2}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'));
            member.Status = Roles;
            member.PhotoURL = string.Format("{0}-{1}.jpg", member.RegTime, member.MembName);
            member.Resume = resume;

            Cultural.BLL.Member bll = new Cultural.BLL.Member();
            bll.Add(member);
            int id = bll.GetMaxId() - 1;
            if (id != null)
            {
                Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "ShowSingle.aspx?id=" + id.ToString());
            }

        }

        public void btnCancle_Click(object sender, EventArgs e)
        {
            Response.Redirect("list.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string strErr = "";
            if (this.txtStaffName.Text.Trim().Length == 0)
            {
                strErr += "姓名不能为空！\\n";
            }

            if (strErr != "")
            {
                MessageBox.Show(this, strErr);
                return;
            }
            string LoginID = this.txtLoginID.Text;
            string Password = this.txtPassword.Text;
            string StaffName = this.txtStaffName.Text;
            string Gender = ddlGender.SelectedItem.Text.Trim();
            string Phone = this.txtPhone.Text;
            string Email = this.txtEmail.Text;
            string Address = this.txtAddress.Text;
            string Job = this.txtJob.Text;
            string resume = this.txtResume.Text.Trim();
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
                departID = dbll.GetMaxId()-1;
            }
            else
            {
                departID = 0;
            }
            string EntryTime = this.txtResume.Text;
            string Roles = ddlType.SelectedItem.Value.Trim();

            Cultural.Model.Member member = new Cultural.Model.Member();
            member.LoginID = LoginID;
            member.Password = Password;
            member.MembName = StaffName;
            member.Gender = Gender;
            member.Phone = Phone;
            member.Email = Email;
            member.Address = Address;
            member.JobName = Job;
            member.DepartID = departID;
            member.RegTime = string.Format("{0}-{1}-{2}", DateTime.Now.Year, DateTime.Now.Month.ToString().PadLeft(2, '0'), DateTime.Now.Day.ToString().PadLeft(2, '0'));
            member.Status = Roles;
            member.PhotoURL = hidFilePath.Value;
            member.Resume = resume;
            Cultural.BLL.Member bll = new Cultural.BLL.Member();
            bll.Add(member);
            Maticsoft.Common.MessageBox.ShowAndRedirect(this, "保存成功！", "AddMember.aspx");
        }
    }
}