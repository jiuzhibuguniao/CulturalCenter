<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyMember.aspx.cs" Inherits="CulturalCenter.Admin.Member.ModifyMember" EnableTheming="true" Theme="GreenT"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--人员信息修改</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width: 95%;" cellpadding="2" cellspacing="1" class="border">
                <tr>
                    <td style="width: 80px" align="right" class="tdbg">
                         <b>关键字：</b>
                    </td>
                    <td class="tdbg">                       
                    <asp:TextBox ID="txtKeyword" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnSearch" runat="server" Text="查询"  OnClick="btnSearch_Click" >
                    </asp:Button>                    
                        
                    </td>
                    <td class="tdbg">
                    </td>
                </tr>
            </table>
            <!--Search end-->
            <br />
            <asp:GridView ID="gridView" runat="server" AllowPaging="True" Width="100%" CellPadding="3"  OnPageIndexChanging ="gridView_PageIndexChanging"
                    BorderWidth="1px" DataKeyNames="MemberID" OnRowDataBound="gridView_RowDataBound"  CssClass="GVStyle"
                    AutoGenerateColumns="false" PageSize="20"  RowStyle-HorizontalAlign="Center" OnRowCreated="gridView_OnRowCreated" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="MemberID" HeaderText="编号"  ItemStyle-Width="40px" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="MembName" HeaderText="姓名" SortExpression="MembName"  ItemStyle-Width="70px" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"/> 
		                <asp:BoundField DataField="LoginID" HeaderText="登录名" SortExpression="LoginID"   ItemStyle-Width="100px" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left" /> 
		                <asp:BoundField DataField="Gender" HeaderText="性别" SortExpression="Gender"  ItemStyle-Width="40px" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center" /> 
		                <asp:BoundField DataField="JobName" HeaderText="职务" SortExpression="JobName"   ItemStyle-Width="80px" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"/> 
		                <asp:BoundField DataField="Phone" HeaderText="电话" SortExpression="Phone"   ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left"  /> 
		                <asp:BoundField DataField="Email" HeaderText="邮箱" SortExpression="Email"   ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left"  /> 
                        <asp:TemplateField HeaderText="地址">
                            <ItemTemplate>
                                <%#Eval("Address")==null?"":Eval("Address").ToString().Length>18?Eval("Address").ToString().Substring(0,16)+"":Eval("Address").ToString() %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="类型"   ItemStyle-Width="80px">
                            <ItemTemplate>
                                <%#Eval("Status")==null?"":Maticsoft.Common.CommonFun.TranslateString(Eval("Status").ToString(),Maticsoft.Common.CommonFun.classEnum.MemStatus)%>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:HyperLinkField HeaderText="详细" ItemStyle-Width="40px" DataNavigateUrlFields="MemberID" DataNavigateUrlFormatString="ShowSingle.aspx?id={0}"
                                Text="详细"  />
                            <asp:HyperLinkField HeaderText="编辑" ItemStyle-Width="40px" DataNavigateUrlFields="MemberID" DataNavigateUrlFormatString="SelfInfoModify.aspx?id={0}&flag=1"
                                Text="编辑"  />
                            <asp:TemplateField  ItemStyle-Width="40px" HeaderText="删除"   Visible="false"  >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="MemDelete"  CommandArgument='<%#Eval("MemberID") %>'
                                         Text="删除"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField> </Columns>
                        <EmptyDataTemplate>
                        <table>
                            <tr style="background-color: #D6E7FF; line-height: 24px; font-weight: bolder; color: #11449E;
                                text-align: center;">
                                <td>
                                    当前没有数据！
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <PagerTemplate>
                        <div class="pageIndex">
                        <asp:LinkButton ID="lbnFirst" runat="Server" Text="首页<<" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>'
                            CommandName="Page" CommandArgument="First"></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="lbnPrev" runat="server" Text="上一页" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>'
                            CommandName="Page" CommandArgument="Prev"></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="lbnNext" runat="Server" Text="下一页" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != (((GridView)Container.NamingContainer).PageCount - 1) %>'
                            CommandName="Page" CommandArgument="Next"></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="lbnLast" runat="Server" Text=">>尾页" Enabled='<%# ((GridView)Container.NamingContainer).PageIndex != (((GridView)Container.NamingContainer).PageCount - 1) %>'
                            CommandName="Page" CommandArgument="Last"></asp:LinkButton>
                        <asp:Label ID="lblCurrentPage" runat="server" Text='<%# "第" + (((GridView)Container.NamingContainer).PageIndex + 1).ToString() + "页" %>'></asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblPageCount" runat="server" Text='<%# "共" + ((GridView)Container.NamingContainer).PageCount.ToString() + "页"%>'></asp:Label>&nbsp;&nbsp;
                    </div>
                            </PagerTemplate>
                       
                </asp:GridView>
    </div>
    </form>
</body>
</html>
