using Maticsoft.Common;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CulturalCenter.Admin.Member
{
    public partial class ModifyPW : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (Session[Common.Session_MemID] != null && Session[Common.Session_MemID].ToString() != "")
            {
                Cultural.Model.Member member = new Cultural.Model.Member();
                Cultural.BLL.Member memBLL = new Cultural.BLL.Member();
                member = memBLL.GetModel(Convert.ToInt32(Session[Common.Session_MemID]));
                if (member != null)
                {
                    if (member.Password == txtOldPW.Text.Trim())
                    {
                        if (txtNewPW.Text.Trim() == txtPWRe.Text.Trim())
                        {
                            if (txtNewPW.Text.Trim().Length >= 3 && txtNewPW.Text.Trim().Length <= 20)
                            {
                                member.Password = txtNewPW.Text.Trim();
                                try
                                {
                                    memBLL.Update(member);
                                    Maticsoft.Common.MessageBox.Show(this.Page, "修改成功！");
                                }
                                catch
                                {
                                    Maticsoft.Common.MessageBox.Show(this.Page, "网络出错！请重试！");
                                }
                            }
                            else
                            {
                                Maticsoft.Common.MessageBox.Show(this.Page, "密码长度必须为3-20位！请重试！");
                            }
                        }
                        else
                        {
                            Maticsoft.Common.MessageBox.Show(this.Page, "两次新密码不同！请重试！");
                        }
                    }
                    else
                    {
                        Maticsoft.Common.MessageBox.Show(this.Page,"旧密码错误！请重试！");
                    }
                }
            }
        }
    }
}