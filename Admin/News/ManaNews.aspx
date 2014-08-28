<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManaNews.aspx.cs" Inherits="CulturalCenter.Admin.News.ManaNews" Theme="GreenT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>华中休闲文化研究中心--新闻公告管理</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:20px;">
          <table style="width: 80%;" cellpadding="2" cellspacing="1" class="border">
                <tr>
                    <td>
                        <b>一级栏目</b>
                        <asp:DropDownList ID="ddlBoard" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBoard_SelectedIndexChanged">
                    </asp:DropDownList>
                        <b>二级栏目</b><asp:DropDownList ID="ddlBoardSon" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBoardSon_SelectedIndexChanged">
                    </asp:DropDownList>
                    </td>
                    <td  class="tdbg">
                         <b>标题</b><asp:TextBox ID="txtKeyword" runat="server"></asp:TextBox>
                    </td>
                    <td class="tdbg">
                        <b>状态</b>
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Selected="True" Value="0" Text="正常"></asp:ListItem>
                        <asp:ListItem Value="1" Text="删除"></asp:ListItem>
                        <asp:ListItem Value="2" Text="全部"></asp:ListItem>
                    </asp:DropDownList></td>
                    <td>
                    <asp:Button ID="btnSearch" runat="server" Text="查询"  OnClick="btnSearch_Click" >
                    </asp:Button>&nbsp;&nbsp;&nbsp;&nbsp;                    
                     <asp:Button ID="Button" runat="server" Text="新增" PostBackUrl="~/Admin/News/AddNews.aspx"/>   
                    </td>
                    <td class="tdbg">
                    </td>
                </tr>
            </table>
            <!--Search end-->
            <br />
            <asp:GridView ID="gridView" runat="server" AllowPaging="True" Width="100%" CellPadding="3"  OnPageIndexChanging ="gridView_PageIndexChanging"
                    BorderWidth="1px" DataKeyNames="InfoID" OnRowDataBound="gridView_RowDataBound"  CssClass="GVStyle"
                    AutoGenerateColumns="false" PageSize="10"  RowStyle-HorizontalAlign="Center" OnRowCreated="gridView_OnRowCreated" OnRowCommand="gridView_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="InfoID" HeaderText="编号" ItemStyle-Width="40" />
                        <asp:BoundField DataField="Title" HeaderText="标题" SortExpression="Title" ItemStyle-HorizontalAlign="left" ItemStyle-VerticalAlign="Middle" ItemStyle-Width="250"  /> 
                        <asp:TemplateField HeaderText="内容" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%#Eval("Content")==null?"":Maticsoft.Common.CommonFun.ClearHtml(Eval("Content").ToString()).Length>60?(Maticsoft.Common.CommonFun.ClearHtml(Eval("Content").ToString()).Substring(0,59)+"…"):Maticsoft.Common.CommonFun.ClearHtml(Eval("Content").ToString()) %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="发布时间" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80">
                            <ItemTemplate>
                                <%#Eval("PubTime")==null?"":Eval("PubTime").ToString().Substring(0,10) %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="状态" ItemStyle-Width="40"  ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <%#Eval("Weight")==null?"":Maticsoft.Common.CommonFun.TranslateString(Eval("Weight").ToString(),Maticsoft.Common.CommonFun.classEnum.InfoShow)%>
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:HyperLinkField HeaderText="编辑" ItemStyle-Width="40" DataNavigateUrlFields="InfoID" DataNavigateUrlFormatString="NewsModify.aspx?id={0}&flag=1"
                                Text="编辑"  ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField  ItemStyle-Width="60" HeaderText="操作"   ItemStyle-HorizontalAlign="Center" >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server"  CommandName="InfoTop"  CommandArgument='<%#Eval("InfoID") %>'
                                         Text='<%#Eval("Weight")==null?"置顶":Eval("Weight").ToString()=="100"?"取消置顶":"置顶" %>'></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField  ItemStyle-Width="40" HeaderText="删除"   ItemStyle-HorizontalAlign="Center" >
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="InfoDelete"  CommandArgument='<%#Eval("InfoID") %>'
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
