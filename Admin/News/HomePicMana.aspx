<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePicMana.aspx.cs" Inherits="CulturalCenter.Admin.News.HomePicMana" Theme="GreenT" %>

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
                         <b>描述：</b>
                    </td>
                    <td class="tdbg">                       
                    <asp:TextBox ID="txtKeyword" runat="server"></asp:TextBox>
                   &nbsp;&nbsp;&nbsp;&nbsp;显示状态
                        <asp:DropDownList ID="ddlShow" runat="server">
                            <asp:ListItem Value="0" Text="全部" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="首页显示"></asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnSearch" runat="server" Text="查询"  OnClick="btnSearch_Click" >
                    </asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;                    
                     <asp:Button ID="Button" runat="server" Text="新增" PostBackUrl="~/Admin/News/HomePicAdd.aspx"/>   
                    </td>
                    <td class="tdbg">
                    </td>
                </tr>
            </table>
            <!--Search end-->
            <br />
            <asp:GridView ID="gridView" runat="server" AllowPaging="True" Width="100%" CellPadding="3"  OnPageIndexChanging ="gridView_PageIndexChanging"
                    BorderWidth="1px" DataKeyNames="ImgID" OnRowDataBound="gridView_RowDataBound"  CssClass="GVStyle"
                    AutoGenerateColumns="false" PageSize="8"  RowStyle-HorizontalAlign="Center" OnRowCreated="gridView_OnRowCreated" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ImgID" HeaderText="编号" ItemStyle-Width="40" />
                        <asp:TemplateField HeaderText="图片" ItemStyle-Width="90">
                            <ItemTemplate>
                               <img src='<%#Eval("ImgURL")==null?"":Maticsoft.Common.CommonFun.URLConverToServer("../../Image/News/"+Eval("ImgURL").ToString())%>' alt="图片" width="84" height="52" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ImgDesc" HeaderText="描述" SortExpression="ImgDesc" ItemStyle-HorizontalAlign="left"  /> 
                        <asp:TemplateField ControlStyle-Width="50" HeaderText="首页显示"  ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="60">
                                <ItemTemplate>
                                    <%#Eval("Status")==null?"":Eval("Status").ToString()== "2" ? "显示" : ""%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        <asp:TemplateField ControlStyle-Width="70" HeaderText="操作"  ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="60" >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server"  CommandName="HomePicShow"  CommandArgument='<%#Eval("ImgID") %>'
                                         Text='<%#Eval("Status")==null?"首页显示":Eval("Status").ToString() == "2" ? "取消显示" : "首页显示"%>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        <asp:HyperLinkField HeaderText="编辑" ItemStyle-HorizontalAlign="Center" ControlStyle-Width="50" DataNavigateUrlFields="ImgID" DataNavigateUrlFormatString="HomePicModify.aspx?id={0}&flag=1"
                                Text="编辑"   ItemStyle-Width="50"/>
                            <asp:TemplateField ControlStyle-Width="50" HeaderText="删除"  ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="50">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="HomePicDelete"  CommandArgument='<%#Eval("ImgID") %>'
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
