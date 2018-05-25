﻿<%@ Page Title="Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="LMS.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="content-wrapper">
            <div class="container">
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

            </div>

            <div class="container">
                <div class="wrap">
                    <asp:ListView ID="ListViewSearchResults" runat="server" DataKeyNames="bookID" DataSourceID="SourceBooks">
                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <br />
                            <div class="container">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="container">
                                            <div class="row align-items-center">
                                                <div class="col col-md-2">
                                                    <img src="Images/Books/sea_of_monsters/01.jpg" class="img-thumbnail" />
                                                </div>
                                                <div class="col col-sm-8">
                                                    <div class="container">
                                                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>'
                                                            CssClass="display-4" />
                                                        <br />
                                                        <p class="h5">
                                                            <strong>By
                                                    <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("author") %>' />
                                                            </strong>
                                                        </p>
                                                        <p class="h6">
                                                            Published by 
                                                        <asp:Label ID="publisherNameLabel" runat="server" Text='<%# Eval("publisherName") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            Published on 
                                                        <asp:Label ID="publishYearLabel" runat="server" Text='<%# Eval("publishYear") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            ISBN: 
                                                        <asp:Label ID="ISBNLabel" runat="server" Text='<%# Eval("ISBN") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            Edition: 
                                                        <asp:Label ID="editionLabel" runat="server" Text='<%# Eval("edition") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            Genre: 
                                                        <asp:Label ID="genreLabel" runat="server" Text='<%# Eval("genre") %>' />
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col-sm-2 align-self-center">
                                                    <asp:Button ID="Button2" runat="server" Text="Request" CssClass="btn btn-library btn-block" />
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <span style=""></span>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server" style="">
                                <span runat="server" id="itemPlaceholder" />
                            </div>
                            <div class="wrap">
                                <div style="">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>

                        </LayoutTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookDisplay]"></asp:SqlDataSource>
</asp:Content>
