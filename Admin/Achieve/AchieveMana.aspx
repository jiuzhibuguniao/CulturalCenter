<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AchieveMana.aspx.cs" Inherits="CulturalCenter.Admin.Achieve.AchieveMana" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
                     &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnAdd" runat="server" Text="新增" PostBackUrl="~/Admin/Achieve/AchieveAdd.aspx" ></asp:Button>
                    </td>
                </tr>
            </table>
            <!--Search end-->
            <br />
            <asp:GridView ID="gridView" runat="server" AllowPaging="True" Width="100%" CellPadding="3"  OnPageIndexChanging ="gridView_PageIndexChanging"
                    BorderWidth="1px" DataKeyNames="AchieveID" OnRowDataBound="gridView_RowDataBound"  CssClass="GVStyle"
                    AutoGenerateColumns="false" PageSize="15"  RowStyle-HorizontalAlign="Center" OnRowCreated="gridView_OnRowCreated" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="AchieveID" HeaderText="编号"  ItemStyle-Width="40" />
                        <asp:BoundField DataField="AchieveName" HeaderText="项目名" SortExpression="AchieveName" ItemStyle-Width="250"  ItemStyle-HorizontalAlign="Left"  /> 
		                <asp:BoundField DataField="MainCharge" HeaderText="负责人" SortExpression="MainCharge" ItemStyle-Width="80"  ItemStyle-HorizontalAlign="Center"  /> 
		                <asp:BoundField DataField="Origon" HeaderText="项目来源" SortExpression="Origon" ItemStyle-Width="150"  ItemStyle-HorizontalAlign="Left"  /> 
		                <asp:BoundField DataField="Publish" HeaderText="出版机构" SortExpression="Publish" ItemStyle-Width="150"  ItemStyle-HorizontalAlign="Center"  /> 
                        <asp:TemplateField HeaderText="主要内容">
                            <ItemTemplate>
                                <%#Eval("Content")==null?"":Eval("Content").ToString().Length>50?Eval("Content").ToString().Substring(0,49)+"…":Eval("Content").ToString() %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        
                            <asp:HyperLinkField HeaderText="详细" ItemStyle-Width="40"  DataNavigateUrlFields="AchieveID" DataNavigateUrlFormatString="AchieveShow.aspx?id={0}"
                                Text="详细"  />
                            <asp:HyperLinkField HeaderText="编辑" ItemStyle-Width="40"  DataNavigateUrlFields="AchieveID" DataNavigateUrlFormatString="AchieveModify.aspx?id={0}"
                                Text="编辑"  />
                            <asp:TemplateField ItemStyle-Width="40"  HeaderText="删除"  >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="AchDelete"  CommandArgument='<%#Eval("AchieveID") %>'
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
