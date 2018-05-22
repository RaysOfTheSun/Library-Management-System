﻿<%@ Page Title="Management" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="LMS.Management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link" id="nav-titles-tab" data-toggle="tab" href="#nav-titles" role="tab" aria-controls="nav-titles" aria-selected="false">
                        <i class="fas fa-book"></i>&nbsp;Titles</a>
                    <a class="nav-item nav-link active" id="nav-authors-tab" data-toggle="tab" href="#nav-authors" role="tab" aria-controls="nav-authors" aria-selected="true">
                        <i class="fas fa-user"></i>&nbsp;Authors</a>
                    <a class="nav-item nav-link" id="nav-publishers-tab" data-toggle="tab" href="#nav-publishers" role="tab" aria-controls="nav-publishers" aria-selected="false">
                        <i class="fas fa-print"></i>&nbsp;Publishers</a>
                    <asp:HiddenField ID="hiddenID" runat="server" />
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
            <%-- Books Tab --%>
            <div class="tab-pane fade" id="nav-titles" role="tabpanel" aria-labelledby="nav-titles-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPBooks" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdBooks" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GrdBooks" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="bookID" DataSourceID="SourceBooks" CssClass="table" ShowHeaderWhenEmpty="True" OnRowCommand="GrdBooks_RowCommand" BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="bookID" HeaderText="Book ID" ReadOnly="True" SortExpression="bookID" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="author" HeaderText="Author" SortExpression="author" ReadOnly="True" />
                                    <asp:BoundField DataField="publisherName" HeaderText="Publisher" SortExpression="publisherName" />
                                    <asp:BoundField DataField="publishYear" HeaderText="Publication" SortExpression="publishYear" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnEditBook" runat="server" Text="Edit" CssClass="btn btn-primary" CommandName="editItem"
                                                CommandArgument='<%# Eval("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#EditBookModal" />
                                            <asp:Button ID="GrdBtnDeleteBook" runat="server" Text="Delete" CssClass="btn btn-danger" CommandName="deleteItem"
                                                CommandArgument='<%# Eval("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#EditBookModal" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" Wrap="False" />
                                <RowStyle VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <%-- Authors Tab --%>
            <div class="tab-pane fade show active" id="nav-authors" role="tabpanel" aria-labelledby="nav-authors-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPLAddAuth" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:GridView ID="GrdAuthors" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                                CssClass="table" DataSourceID="SourceAuthors" DataKeyNames="authorID" AllowPaging="True" PageSize="6" OnRowCommand="GrdPublishers_RowCommand" GridLines="Horizontal" BorderStyle="None">
                                <Columns>
                                    <asp:BoundField DataField="authorID" HeaderText="Author ID" InsertVisible="False" ReadOnly="True" SortExpression="authorID" />
                                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                                    <asp:BoundField DataField="middleName" HeaderText="Middle Name" SortExpression="middleName" />
                                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnEditAuth" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("authorID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#EditAuthorModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnDeleteAuth" runat="server" Text="Delete" CssClass="btn btn-danger btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("authorID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#EditAuthorModal" />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" Wrap="False" />
                                <RowStyle VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>

            </div>
            <%-- Publishers Tab --%>
            <div class="tab-pane fade" id="nav-publishers" role="tabpanel" aria-labelledby="nav-publishers-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPPub" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdPublishers" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GrdPublishers" runat="server" DataSourceID="SourcePublishers" AutoGenerateColumns="False" DataKeyNames="publisherID" CssClass="table" OnRowCommand="GrdPublishers_RowCommand" BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="publisherID" HeaderText="Publisher ID" ReadOnly="True" SortExpression="publisherID" />
                                    <asp:BoundField DataField="publisherName" HeaderText="Name" SortExpression="publisherName" />
                                    <asp:BoundField DataField="countryName" HeaderText="Location of Headquarters" SortExpression="countryName" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnEditPub" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("publisherID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#EditPublisherModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnDeletePub" runat="server" Text="Delete" CssClass="btn btn-danger btn-block"
                                                        CommandArgument='<%# Eval("publisherID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeletePublisher" />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" />
                                <RowStyle VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>



        <%--Add Book modal--%>
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

        <%-- Add Author modal --%>
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

        <%-- Edit Book modal --%>
        <div class="modal" id="EditBookModal" tabindex="-1" role="dialog" aria-labelledby="EditBookModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="EditBookModalLabel">Update Book Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwBooks" runat="server" DataKeyNames="bookID" DataSourceID="SourceBookEdit" DefaultMode="Edit">
                                    <EditItemTemplate>
                                        <div class="justify-content-center align-items-center">
                                            <div class="form-group mb-1">
                                                <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' CssClass="form-control" />
                                            </div>
                                            <div class="form-group mb-1">
                                                <asp:DropDownList ID="DrpAuthors" runat="server" CssClass="custom-select" DataSourceID="SourceAuthorNames"
                                                    DataTextField="fullName" DataValueField="authorID" AppendDataBoundItems="true" SelectedValue='<%# Bind("authorID") %>'>
                                                    <asp:ListItem Text="Select an Author..." Value="-99"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group mb-1">
                                                <asp:DropDownList ID="DrpPublishersB" runat="server" CssClass="custom-select" DataSourceID="SourcePublishers"
                                                    DataTextField="publisherName" DataValueField="publisherID" AppendDataBoundItems="True" SelectedValue='<%# Bind("publisherID") %>'>
                                                    <asp:ListItem Value="-99">Select a publisher...</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group mb-1">
                                                <asp:DropDownList ID="DrpGenresB" runat="server" CssClass="custom-select" SelectedValue='<%# Bind("genre") %>'>
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
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("publishYear") %>' CssClass="form-control"
                                                    TextMode="Number"
                                                    min="1970"></asp:TextBox>
                                            </div>
                                            <div class="form-group mb-1">
                                                <asp:TextBox ID="ISBNTextBox" runat="server" Text='<%# Bind("ISBN") %>' CssClass="form-control"></asp:TextBox>
                                            </div>
                                            <div class="form-group mb-1">
                                                <asp:TextBox ID="editionTextBox" runat="server" Text='<%# Bind("edition") %>' CssClass="form-control"
                                                    TextMode="Number"
                                                    min="1"></asp:TextBox>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="modal-footer">
                        <button id="BtnEditBook" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="BtnEditBook_ServerClick" validationgroup="editBook">
                            Add Author</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <%--Edit Author modal--%>
        <div class="modal" id="EditAuthorModal" tabindex="-1" role="dialog" aria-labelledby="EditAuthorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editAuthorlisherModalLabel">Update Author Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UPDLupAuth" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwAuthors" runat="server" DataKeyNames="authorID" DataSourceID="SourceAuthorEdit" DefaultMode="Edit">
                                    <EditItemTemplate>
                                        <div class="form-row">
                                            <div class="form-group col-sm-4 mb-1">
                                                <p class="h6">First Name</p>
                                                <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>' CssClass="form-control" />
                                            </div>
                                            <div class="form-group col-sm-4 mb-1">
                                                <p class="h6">Middle Name</p>
                                                <asp:TextBox ID="middleNameTextBox" runat="server" Text='<%# Bind("middleName") %>' CssClass="form-control" />
                                            </div>
                                            <div class="form-group col-sm-4 mb-1">
                                                <p class="h6">Last Name</p>
                                                <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="modal-footer">
                        <button id="FvBtnUpdateAuth" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="FvBtnUpdateAuth_ServerClick" validationgroup="editAuthor">
                            Add Publisher</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Edit Publisher modal --%>
        <div class="modal" id="EditPublisherModal" tabindex="-1" role="dialog" aria-labelledby="EditPublisherModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="EditPublisherModalLabel">Update Publisher Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FormView1" runat="server" DataSourceID="SourcePublisherEdit" DataKeyNames="publisherID" DefaultMode="Edit">
                                    <EditItemTemplate>
                                        <div class="form-row">
                                            <div class="form-group col-sm-6 mb-1">
                                                <p class="h6">Publisher Name</p>
                                                <asp:TextBox ID="publisherNameTextBox" runat="server" Text='<%# Bind("publisherName") %>' CssClass="form-control" />
                                            </div>
                                            <div class="form-group col-sm-6 mb-1">
                                                <p class="h6">Location of Headquarters</p>
                                                <asp:DropDownList ID="DrpCountryB" runat="server" DataSourceID="SourceCountries" DataTextField="countryName" DataValueField="countryID"
                                                    CssClass="custom-select" AppendDataBoundItems="true" ValidationGroup="publisher" SelectedValue='<%# Bind("countryID") %>'>
                                                    <asp:ListItem Selected="True" Value="-99">Select the country of origin...</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="modal-footer">
                        <button id="FvBtnUpdatePub" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="FvBtnUpdatePub_ServerClick" validationgroup="editPub">
                            Add Publisher</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Publisher modal -->
        <div class="modal" id="DeletePublisher" tabindex="-1" role="dialog" aria-labelledby="DeletePublisherLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeletePublisherLabel">Delete Publisher Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-question-circle display-1" style="color:rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Are you sure you want to delete this publisher's information from the database? 
                                    Doing so will delete ALL associated books. This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="BtnDeletePub" runat="server" onserverclick="BtnDeletePub_ServerClick">Yes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>

                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Author modal -->
        <div class="modal" id="DeleteAuthor" tabindex="-1" role="dialog" aria-labelledby="DeleteAuthorLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteAuthorLabel">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        ...
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Book modal -->
        <div class="modal" id="DeleteBook" tabindex="-1" role="dialog" aria-labelledby="DeleteBookLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteBookLabel">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookDisplay]" InsertCommand="EXEC AddBook @authorID, @publisherID, @title , @ISBN, @edition, @genre, @publishYr">
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
        <asp:SqlDataSource ID="SourcePublishers" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [PublisherWithCountryName]" InsertCommand="EXEC AddPublisher @publisherName, @cityID">
            <InsertParameters>
                <asp:ControlParameter Name="publisherName" ControlID="TbxPublisherName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DrpCountry" Name="cityID" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourcePublisherEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM BookPublishers WHERE publisherID=@id" UpdateCommand="EXEC UpdatePublisher @publisherName, @countryID, @publisherID" DeleteCommand="EXEC DeletePublisher @id">
            <DeleteParameters>
                <asp:SessionParameter Name="id" SessionField="keys" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceBookEdit" runat="server" SelectCommand="SELECT * FROM Books WHERE bookID = @id" UpdateCommand="EXEC UpdateBook @authorID, @publisherID, @title , @ISBN, @edition, @genre, @publishYear, @bookID" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookAuthors] WHERE authorID = @id" UpdateCommand="EXEC UpdateAuthor @firstName, @middleName, @lastName, @authorID">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorNames" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [AuthorNames]" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceCountries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
    </div>


</asp:Content>