<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="LMS.Management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <p class="display-4">Books</p>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="#">View <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Titles</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Authors</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Publishers</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="container">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bookID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="bookID" HeaderText="bookID" InsertVisible="False" ReadOnly="True" SortExpression="bookID" />
                    <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
                    <asp:BoundField DataField="authorID" HeaderText="authorID" SortExpression="authorID" />
                    <asp:BoundField DataField="publisherID" HeaderText="publisherID" SortExpression="publisherID" />
                    <asp:BoundField DataField="publishYear" HeaderText="publishYear" SortExpression="publishYear" />
                    <asp:BoundField DataField="genre" HeaderText="genre" SortExpression="genre" />
                </Columns>
            </asp:GridView>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Books]"></asp:SqlDataSource>

    </div>
</asp:Content>
