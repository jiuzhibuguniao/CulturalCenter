<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DownLoadMana.aspx.cs" Inherits="CulturalCenter.Admin.DownLoad.DownLoadMana" Theme="GreenT" %>

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
                         <b>标题：</b>
                    </td>
                    <td class="tdbg">                       
                    <asp:TextBox ID="txtKeyword" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;<b>板块：</b>
                    <asp:DropDownList ID="ddlBoard" runat="server">
                    </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnSearch" runat="server" Text="查询"  OnClick="btnSearch_Click" >
                    </asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;                    
                     <asp:Button ID="Button" runat="server" Text="新增" PostBackUrl="~/Admin/DownLoad/DownLoadAdd.aspx"/>   
                    </td>
                    <td class="tdbg">
                    </td>
                </tr>
            </table>
            <!--Search end-->
            <br />
            <asp:GridView ID="gridView" runat="server" AllowPaging="True" Width="100%" CellPadding="3"  OnPageIndexChanging ="gridView_PageIndexChanging"
                    BorderWidth="1px" DataKeyNames="DownID" OnRowDataBound="gridView_RowDataBound"  CssClass="GVStyle"
                    AutoGenerateColumns="false" PageSize="10"  RowStyle-HorizontalAlign="Center" OnRowCreated="gridView_OnRowCreated" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="DownID" HeaderText="编号" ItemStyle-Width="40" />
                        <asp:BoundField DataField="DownTitle" HeaderText="标题" SortExpression="DownTitle" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="250"  /> 
                        <asp:TemplateField HeaderText="描述" >
                            <ItemTemplate>
                                <%#Eval("DownDesc") == null ? "" : Eval("DownDesc").ToString().Trim().Length > 50 ? Eval("DownDesc").ToString().Substring(0, 50) : Eval("DownDesc") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="附件" ItemStyle-Font-Size="Small"  ItemStyle-Width="300">
                            <ItemTemplate>
                                <%#GetAttachment(Eval("DownID")) %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                            <asp:HyperLinkField HeaderText="详细" ControlStyle-Width="40" DataNavigateUrlFields="DownID" DataNavigateUrlFormatString="DownLoadShow.aspx?id={0}"
                                Text="详细"  />
                            <asp:HyperLinkField HeaderText="编辑" ControlStyle-Width="40" DataNavigateUrlFields="DownID" DataNavigateUrlFormatString="DownLoadModify.aspx?id={0}"
                                Text="编辑"  />
                            <asp:TemplateField ControlStyle-Width="40" HeaderText="删除"   >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="DownDelete"  CommandArgument='<%#Eval("DownID") %>'
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
    <br />
    </form>
</body>
</html>
