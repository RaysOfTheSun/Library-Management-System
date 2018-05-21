﻿<%@ Page Title="Management" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="LMS.Management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link" id="nav-titles-tab" data-toggle="tab" href="#nav-titles" role="tab" aria-controls="nav-titles" aria-selected="false">Titles</a>
                    <a class="nav-item nav-link active" id="nav-authors-tab" data-toggle="tab" href="#nav-authors" role="tab" aria-controls="nav-authors" aria-selected="true">Authors</a>
                    <a class="nav-item nav-link" id="nav-publishers-tab" data-toggle="tab" href="#nav-publishers" role="tab" aria-controls="nav-publishers" aria-selected="false">Publishers</a>
                </div>
            </nav>
        </div>
        <div class="tab-content" id="nav-tabContent">
            <div class="container">
                <div class="jumbotron">
                    <p class="display-4">Stats</p>
                </div>
                <div class="form-group">
                    <asp:Button ID="Button1" runat="server" Text="Add a Book" CssClass="btn btn-library-10"
                        OnClientClick="return false;" data-toggle="modal" data-target="#AddBookModal" CausesValidation="false" />
                    <asp:Button ID="Button2" runat="server" Text="Add an Author" CssClass="btn btn-library-10"
                        OnClientClick="return false;" data-toggle="modal" data-target="#AddAuthorModal" CausesValidation="false" />
                    <asp:Button ID="Button3" runat="server" Text="Add a Publisher" CssClass="btn btn-library-10"
                        OnClientClick="return false;" data-toggle="modal" data-target="#AddPublisherModal" CausesValidation="false" />
                </div>
            </div>
            <div class="tab-pane fade" id="nav-titles" role="tabpanel" aria-labelledby="nav-titles-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:GridView ID="GrdBooks" runat="server" AutoGenerateColumns="False" DataKeyNames="bookID" DataSourceID="SourceBooks" CssClass="table"
                                ShowHeaderWhenEmpty="true">
                                <Columns>
                                    <asp:BoundField DataField="bookID" HeaderText="bookID" InsertVisible="False" ReadOnly="True" SortExpression="bookID" />
                                    <asp:BoundField DataField="title" HeaderText="title" SortExpression="title" />
                                    <asp:BoundField DataField="authorID" HeaderText="authorID" SortExpression="authorID" />
                                    <asp:BoundField DataField="publisherID" HeaderText="publisherID" SortExpression="publisherID" />
                                    <asp:BoundField DataField="publishYear" HeaderText="publishYear" SortExpression="publishYear" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="edition" HeaderText="edition" SortExpression="edition" />
                                    <asp:BoundField DataField="genre" HeaderText="genre" SortExpression="genre" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
            <div class="tab-pane fade show active" id="nav-authors" role="tabpanel" aria-labelledby="nav-authors-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:GridView ID="GrdAuthors" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" CssClass="table" DataSourceID="SourceAuthors" DataKeyNames="authorID" AllowPaging="True" PageSize="6">
                                <Columns>
                                    <asp:BoundField DataField="authorID" HeaderText="authorID" InsertVisible="False" ReadOnly="True" SortExpression="authorID" />
                                    <asp:BoundField DataField="firstName" HeaderText="firstName" SortExpression="firstName" />
                                    <asp:BoundField DataField="middleName" HeaderText="middleName" SortExpression="middleName" />
                                    <asp:BoundField DataField="lastName" HeaderText="lastName" SortExpression="lastName" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>

            </div>
            <div class="tab-pane fade" id="nav-publishers" role="tabpanel" aria-labelledby="nav-publishers-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UpdatePanel6" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="SourcePublishers" AutoGenerateColumns="False" DataKeyNames="publisherID" CssClass="table">
                                <Columns>
                                    <asp:BoundField DataField="publisherID" HeaderText="publisherID" ReadOnly="True" SortExpression="publisherID" />
                                    <asp:BoundField DataField="publisherName" HeaderText="publisherName" SortExpression="publisherName" />
                                    <asp:BoundField DataField="countryName" HeaderText="countryName" SortExpression="countryName" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <%--Add book modal--%>
        <div class="modal" id="AddBookModal" tabindex="-1" role="dialog" aria-labelledby="AddBookModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AddBookModalLabel">Add a Book</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="justify-content-center align-items-center">
                                    <div class="form-group mb-1">
                                        <asp:TextBox ID="TbxTitle" runat="server" CssClass="form-control"
                                            placeholder="title"></asp:TextBox>
                                    </div>
                                    <div class="form-group mb-1">
                                        <asp:DropDownList ID="DrpAuthors" runat="server" CssClass="custom-select" DataSourceID="SourceAuthorNames"
                                            DataTextField="fullName" DataValueField="authorID" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select an Author..." Value="-99"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group mb-1">
                                        <asp:DropDownList ID="DrpPublishers" runat="server" CssClass="custom-select" DataSourceID="SourcePublishers"
                                            DataTextField="publisherName" DataValueField="publisherID" AppendDataBoundItems="True">
                                            <asp:ListItem Value="-99">Select a publisher...</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group mb-1">
                                        <asp:DropDownList ID="DrpGenres" runat="server" CssClass="custom-select">
                                            <asp:ListItem>Select a genre...</asp:ListItem>
                                            <asp:ListItem>Science fiction</asp:ListItem>
                                            <asp:ListItem>Drama</asp:ListItem>
                                            <asp:ListItem>Action and Adventure</asp:ListItem>
                                            <asp:ListItem>Romance</asp:ListItem>
                                            <asp:ListItem>Mystery</asp:ListItem>
                                            <asp:ListItem>Horror</asp:ListItem>
                                            <asp:ListItem>Self help</asp:ListItem>
                                            <asp:ListItem>Travel</asp:ListItem>
                                            <asp:ListItem>Biographies</asp:ListItem>
                                            <asp:ListItem>Autobiographies</asp:ListItem>
                                            <asp:ListItem>Fantasy</asp:ListItem>
                                            <asp:ListItem>Science</asp:ListItem>
                                            <asp:ListItem>Art</asp:ListItem>
                                            <asp:ListItem>Encyclopedias</asp:ListItem>
                                            <asp:ListItem>Dictionaries</asp:ListItem>
                                            <asp:ListItem>History</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group mb-1">
                                        <asp:DropDownList ID="DrpPubYear" runat="server" CssClass="custom-select"></asp:DropDownList>
                                    </div>
                                    <div class="form-group mb-1">
                                        <asp:TextBox ID="TbxISBN" runat="server" CssClass="form-control"
                                            placeholder="ISBN" MaxLength="20"></asp:TextBox>
                                    </div>
                                    <div class="form-group mb-1">
                                        <asp:TextBox ID="TbxEdition" runat="server" CssClass="form-control" TextMode="Number"
                                            placeholder="Edition" min="1"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="modal-footer">
                        <button id="BtnAddBook" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="BtnAddBook_ServerClick" validationgroup="book">
                            Add Book</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Add author modal --%>
        <div class="modal" id="AddAuthorModal" tabindex="-1" role="dialog" aria-labelledby="AddAuthorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AddAuthorModalLabel">Add an Author</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="form-row">
                                    <div class="form-group col-sm-4 mb-1">
                                        <asp:TextBox ID="TbxFirstname" runat="server" CssClass="form-control"
                                            placeholder="first name"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxFirstname" Display="Dynamic" ValidationGroup="author"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-sm-4 mb-1">
                                        <asp:TextBox ID="TbxMiddleName" runat="server" CssClass="form-control"
                                            placeholder="middle name" ValidationGroup="author"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxMiddleName" Display="Dynamic" ValidationGroup="author"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-sm-4 mb-1">
                                        <asp:TextBox ID="TbxLastName" runat="server" CssClass="form-control "
                                            placeholder="last name" ValidationGroup="author"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxLastName" Display="Dynamic" ValidationGroup="author"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="modal-footer">
                        <button id="BtnAddAuthorB" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="BtnAddAuthor_Click" validationgroup="author">
                            Add Author</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Add publisher modal --%>
        <div class="modal" id="AddPublisherModal" tabindex="-1" role="dialog" aria-labelledby="AddPublisherModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AddPublisherModalLabel">Add a Publisher</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="form-row">
                                    <div class="form-group col-sm-6 mb-1">
                                        <asp:TextBox ID="TbxPublisherName" runat="server" CssClass="form-control"
                                            placeholder="Publisher Name" ValidationGroup="publisher"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxPublisherName" Display="Dynamic" ValidationGroup="publisher"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-sm-6 mb-1">
                                        <asp:DropDownList ID="DrpCountry" runat="server" DataSourceID="SourceCountries" DataTextField="countryName" DataValueField="countryID" CssClass="custom-select" AppendDataBoundItems="true" ValidationGroup="publisher">
                                            <asp:ListItem Selected="True" Value="-99">Select the country of origin...</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="modal-footer">
                        <button id="BtnAddPublisher" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="BtnAddPublisher_ServerClick" validationgroup="publisher">
                            Add Publisher</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>


        <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Books]" InsertCommand="EXEC AddBook @authorID, @publisherID, @title , @ISBN, @edition, @genre, @publishYr">
            <InsertParameters>
                <asp:ControlParameter ControlID="DrpAuthors" Name="authorID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DrpPublishers" Name="publisherID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TbxTitle" Name="title" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxISBN" Name="ISBN" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxEdition" Name="edition" PropertyName="Text" Type="Int16" />
                <asp:ControlParameter ControlID="DrpGenres" Name="genre" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="DrpPubYear" Name="publishYr" PropertyName="SelectedValue" Type="Int16" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthors" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookAuthors]" InsertCommand="EXEC AddAuthor @first, @middle, @last">
            <InsertParameters>
                <asp:ControlParameter ControlID="TbxFirstname" Name="first" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxMiddleName" Name="middle" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxLastName" Name="last" PropertyName="Text" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourcePublishers" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [PublisherWithCityName]" InsertCommand="EXEC AddPublisher @publisherName, @cityID">
            <InsertParameters>
                <asp:ControlParameter Name="publisherName" ControlID="TbxPublisherName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DrpCountry" Name="cityID" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceCountries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorNames" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [AuthorNames]"></asp:SqlDataSource>

    </div>


</asp:Content>
