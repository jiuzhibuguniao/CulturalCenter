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
using System.Collections.Generic;
using System.Text;
using Maticsoft.Common;

namespace STDecisionSys
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Cultural.BLL.Member bll = new Cultural.BLL.Member();
            string strErr = "";
            if (this.txtStaffName.Text.Trim().Length == 0)
            {
                strErr += "姓名不能为空！\\n";
            }
            if (this.txtLoginID.Text.Trim().Length == 0)
            {
                strErr += "注册名不能为空！\\n";
            }
            if (this.txtPassword.Text.Trim().Length == 0)
            {
                strErr += "密码不能为空！\\n";
            }
            if (this.txtPassConfirm.Text.Trim().Length == 0)
            {
                strErr += "必须确认密码！\\n";
            }
            if (this.txtPassConfirm.Text.Trim() != this.txtPassword.Text.Trim())
            {
                strErr += "两次密码不同！\\n";
            }
            if(bll.GetList(string.Format(" LoginID = '{0}' ",txtLoginID.Text.Trim())).Tables[0].Rows.Count>0)
            {
                strErr += "登录名已被使用！\\n";
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
            member.Status = "6";
            member.PhotoURL = "";
            member.Resume = resume;

            
            bll.Add(member);
            Maticsoft.Common.MessageBox.ShowAndRedirect(this, "注册成功，请等待管理员审核！","../login.aspx");
           
        }

        public void btnCancle_Click(object sender, EventArgs e)
        {
            Response.Redirect("../../Default.aspx");
        }

        
    }
}
