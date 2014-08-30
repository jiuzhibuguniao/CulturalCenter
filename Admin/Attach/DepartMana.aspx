<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartMana.aspx.cs" Inherits="CulturalCenter.Admin.Attach.DepartMana" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--单位管理</title>
    <style>
        b {
            color:#0a480e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width: 95%;" cellpadding="2" cellspacing="1" class="border">
                <tr>
                    <td style="width: 80px" align="right" class="tdbg">
                         <b>名称：</b>
                    </td>
                    <td class="tdbg">                       
                    <asp:TextBox ID="txtKeyword" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;<b>状态</b>
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Selected="True" Value="0" Text="正常"></asp:ListItem>
                        <asp:ListItem Value="1" Text="删除"></asp:ListItem>
                        <asp:ListItem Value="2" Text="全部"></asp:ListItem>
                    </asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnSearch" runat="server" Text="查询"  OnClick="btnSearch_Click" >
                    </asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;                    
                     <asp:Button ID="Button" runat="server" Text="新增" PostBackUrl="~/Admin/Attach/DepartModify.aspx"/>   
                    </td>
                    <td class="tdbg">
                    </td>
                </tr>
            </table>
            <!--Search end-->
            <br />
            <asp:GridView ID="gridView" runat="server" AllowPaging="True" Width="100%" CellPadding="3"  OnPageIndexChanging ="gridView_PageIndexChanging"
                    BorderWidth="1px" DataKeyNames="DepartID" OnRowDataBound="gridView_RowDataBound"  CssClass="GVStyle"
                    AutoGenerateColumns="false" PageSize="20"  RowStyle-HorizontalAlign="Center" OnRowCreated="gridView_OnRowCreated" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="DepartID" HeaderText="编号"  ItemStyle-Width="40"   />
                        <asp:BoundField DataField="DepartName" HeaderText="单位名称" SortExpression="DepartName" ItemStyle-Width="200" ItemStyle-HorizontalAlign="Left"  /> 
		                <asp:BoundField DataField="MainCharge" HeaderText="负责人" SortExpression="MainCharge" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Center"  /> 
		                <asp:BoundField DataField="Phone" HeaderText="联系方式" SortExpression="Phone" ItemStyle-Width="150" ItemStyle-HorizontalAlign="Center"  /> 
                        <asp:TemplateField HeaderText="单位地址">
                            <ItemTemplate>
                                <%#Eval("Address")==null?"":Eval("Address").ToString().Length>25?Eval("Address").ToString().Substring(0,24)+"…":Eval("Address").ToString() %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="状态" ItemStyle-Width="40">
                            <ItemTemplate>
                                <%#Eval("Status")==null?"":Maticsoft.Common.CommonFun.TranslateString(Eval("Status").ToString(),Maticsoft.Common.CommonFun.classEnum.CommonStatus)%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="首页显示" ItemStyle-Width="60">
                            <ItemTemplate>
                                <%#Eval("Weight")==null?"":Maticsoft.Common.CommonFun.TranslateString(Eval("Weight").ToString(),Maticsoft.Common.CommonFun.classEnum.DepartShow)%>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:HyperLinkField HeaderText="详细" ItemStyle-Width="40" DataNavigateUrlFields="DepartID" DataNavigateUrlFormatString="ShowDepartSingle.aspx?id={0}"
                                Text="详细"  />
                            <asp:HyperLinkField HeaderText="编辑" ItemStyle-Width="40" DataNavigateUrlFields="DepartID" DataNavigateUrlFormatString="DepartModify.aspx?id={0}&flag=1"
                                Text="编辑"  />
                            <asp:TemplateField ItemStyle-Width="60" HeaderText="操作"   >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server"  CommandName="DepartTop"  CommandArgument='<%#Eval("DepartID") %>'
                                         Text='<%#Eval("Weight")==null?"置顶":Eval("Weight").ToString()=="9"?"取消置顶":"置顶" %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="40" HeaderText="删除"   >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="MemDelete"  CommandArgument='<%#Eval("DepartID") %>'
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
