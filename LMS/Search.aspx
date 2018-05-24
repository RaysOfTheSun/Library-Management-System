<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="LMS.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="content-wrapper">
            <div class="container">
                <div class="jumbotron">
                    <p class="display-4">Number of matches goes here</p>
                </div>
                <div class="form-group">
                    <asp:Label ID="LblSearchBox" runat="server" Text="Search for" CssClass="lead col-form-label text-uppercase"></asp:Label>
                    <asp:TextBox ID="TbxSearchbox" runat="server" CssClass="form-control form-control-lg"
                        placeholder="Percy Jackson, Fiction, Biography...">
                    </asp:TextBox>
                </div>
                <div class="form-inline">
                    <asp:Label ID="Label3" runat="server" Text="Limit search to:" CssClass="mr-1 text-uppercase lead"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control mr-1">
                        <asp:ListItem>All Items</asp:ListItem>
                        <asp:ListItem>Book</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control mr-1">
                        <asp:ListItem>that begins with words from my query</asp:ListItem>
                        <asp:ListItem>that contain exact words from my query</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-control mr-1">
                        <asp:ListItem>anywhere in the database</asp:ListItem>
                        <asp:ListItem>in title</asp:ListItem>
                        <asp:ListItem>in author</asp:ListItem>
                        <asp:ListItem>in publisher</asp:ListItem>
                        <asp:ListItem>call number</asp:ListItem>
                        <asp:ListItem>ISBN</asp:ListItem>
                    </asp:DropDownList>
                    <div class="text-right ml-auto">
                        <asp:Button ID="Button1" runat="server" Text="SEARCH" CssClass="btn btn-library-10" Font-Size="18px" />
                    </div>
                </div>
                <asp:ListView ID="ListViewSearchResults" runat="server"></asp:ListView>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SourceBooks" runat="server"></asp:SqlDataSource>
</asp:Content>
