<%@ Page Title="Books - Dynamic Link Administration" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="ManageBooks.aspx.cs" Inherits="LMS.Management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="form-group pt-3">
                        <asp:LinkButton runat="server"
                            CssClass="btn btn-library-10 align-middle text-center pr-3 pl-3"
                            data-toggle="modal" data-target="#AddBookModal" CausesValidation="false">
                                <i class="fas fa-book h3"></i>
                                <br />
                                Add a Book
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" CssClass="btn btn-library-10 text-center pr-3 pl-3"
                            data-toggle="modal" data-target="#AddAuthorModal" CausesValidation="false">
                                <i class="fas fa-user h3"></i>
                                <br />
                                Add an Author
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" CssClass="btn btn-library-10 text-center pr-3 pl-3"
                            data-toggle="modal" data-target="#AddPublisherModal" CausesValidation="false">
                    <i class="fas fa-print h3"></i>
                    <br />
                    Add a Publisher
                        </asp:LinkButton>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
        <div class="container" style="font-size: 1.3vw;">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-library-tab" data-toggle="tab" href="#nav-library" role="tab" aria-controls="nav-library" aria-selected="true">
                        <i class="fa fa-bookmark"></i>&nbsp;Library</a>
                    <a class="nav-item nav-link" id="nav-titles-tab" data-toggle="tab" href="#nav-titles" role="tab" aria-controls="nav-titles" aria-selected="false">
                        <i class="fas fa-book"></i>&nbsp;Books</a>
                    <a class="nav-item nav-link" id="nav-authors-tab" data-toggle="tab" href="#nav-authors" role="tab" aria-controls="nav-authors" aria-selected="false">
                        <i class="fas fa-user"></i>&nbsp;Authors</a>
                    <a class="nav-item nav-link" id="nav-publishers-tab" data-toggle="tab" href="#nav-publishers" role="tab" aria-controls="nav-publishers" aria-selected="false">
                        <i class="fas fa-print"></i>&nbsp;Publishers</a>
                    <asp:HiddenField ID="hiddenID" runat="server" />
                </div>
            </nav>
        </div>

        <div class="tab-content" id="nav-tabContent">
            <%-- Authors tab --%>
            <div class="tab-pane fade show active" id="nav-library" role="tabpanel" aria-labelledby="nav-library-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UpdatePanel9" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdLibraryIndex" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel4" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchIdxGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchIdx" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search books" OnTextChanged="TbxSearchBookGrid_TextChanged"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchIdxGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchIdxGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GrdLibraryIndex" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover" DataSourceID="SourceLibrary" DataKeyNames="indexID"
                                AllowPaging="True" PageSize="5" OnRowCommand="GrdPublishers_RowCommand"
                                GridLines="Horizontal" BorderStyle="None" UseAccessibleHeader="true" OnPreRender="Grd_PreRender">
                                <Columns>
                                    <asp:BoundField DataField="indexID" HeaderText="Index ID" ReadOnly="True" SortExpression="indexID" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" ReadOnly="True" SortExpression="fullName" />
                                    <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                                    <asp:BoundField DataField="callNumber" HeaderText="Call Number" SortExpression="callNumber" NullDisplayText="None Assigned" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnDeletePub" runat="server" Text="Edit" CssClass="btn btn-primary btn-block"
                                                CommandArgument='<%# Eval("indexID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#EditLibIndexModal" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There is currently nothing to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" Wrap="False" />
                                <RowStyle VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <%-- Titles tab --%>
            <div class="tab-pane fade" id="nav-titles" role="tabpanel" aria-labelledby="nav-titles-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPBooks" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdBooks" />
                            <asp:AsyncPostBackTrigger ControlID="TbxSearchBookGrid" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchBookGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchBookGrid" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search books" OnTextChanged="TbxSearchBookGrid_TextChanged"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchBookGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchBookGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GrdBooks" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="bookID" DataSourceID="SourceBooks" CssClass="table table-hover"
                                OnRowCommand="GrdBooks_RowCommand" BorderStyle="None" GridLines="Horizontal"
                                PageSize="5" AllowPaging="true" OnPreRender="Grd_PreRender">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There is currently nothing to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="bookID" HeaderText="ID" ReadOnly="True" SortExpression="bookID" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="author" HeaderText="Author" SortExpression="author" ReadOnly="True" />
                                    <asp:BoundField DataField="publisherName" HeaderText="Publisher" SortExpression="publisherName" />
                                    <asp:BoundField DataField="publishYear" HeaderText="Publication" SortExpression="publishYear" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                                    <asp:BoundField DataField="bookCount" HeaderText="Quantity" SortExpression="bookCount" />
                                    <asp:TemplateField HeaderText="Synopsis" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnViewSynopsis" runat="server" Text="View" CssClass="btn btn-info" CausesValidation="false"
                                                data-toggle="modal" data-target="#ViewBookSynopsisModal" CommandArgument='<%# Eval("bookID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnEditBook" runat="server" Text="Edit" CssClass="btn btn-primary" CommandName="editItem"
                                                CommandArgument='<%# Bind("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#EditBookModal" />
                                            <asp:Button ID="GrdBtnDeleteBook" runat="server" Text="Delete" CssClass="btn btn-danger" CommandName="deleteItem"
                                                CommandArgument='<%# Bind("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#DeleteBookModal" Enabled='<%# CanDelete(Eval("bookID")) %>' />
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
            <%-- Authors tab --%>
            <div class="tab-pane fade" id="nav-authors" role="tabpanel" aria-labelledby="nav-authors-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPLAddAuth" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:Panel ID="Panel3" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchAuthor">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchAuthor" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search authors" OnTextChanged="TbxSearchBookGrid_TextChanged"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchAuthor" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchAuthor_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GrdAuthors" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover" DataSourceID="SourceAuthors" DataKeyNames="authorID"
                                AllowPaging="True" PageSize="5" OnRowCommand="GrdPublishers_RowCommand"
                                GridLines="Horizontal" BorderStyle="None" OnPreRender="Grd_PreRender">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There is currently nothing to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="authorID" HeaderText="Author ID" InsertVisible="False" ReadOnly="True" SortExpression="authorID" />
                                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row no-gutters">
                                                <div class="col-sm-6 pr-1">
                                                    <asp:Button ID="GrdBtnEditAuth" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("authorID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#EditAuthorModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnDeleteAuth" runat="server" Text="Delete" CssClass="btn btn-danger btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("authorID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeleteAuthorModal" Enabled='<%# IsOwnerOfRentedBook(Eval("authorID")) %>' />
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
            <%-- Publishers tab --%>
            <div class="tab-pane fade" id="nav-publishers" role="tabpanel" aria-labelledby="nav-publishers-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPPub" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdPublishers" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel2" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchPubGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchPub" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search publishers"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchPubGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchPubGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:GridView ID="GrdPublishers" runat="server" DataSourceID="SourcePublishers"
                                AutoGenerateColumns="False" DataKeyNames="publisherID" CssClass="table table-hover"
                                OnRowCommand="GrdPublishers_RowCommand" BorderStyle="None" GridLines="Horizontal"
                                PageSize="5" AllowPaging="true" OnPreRender="Grd_PreRender">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There is currently nothing to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="publisherID" HeaderText="Publisher ID" ReadOnly="True" SortExpression="publisherID" />
                                    <asp:BoundField DataField="publisherName" HeaderText="Name" SortExpression="publisherName" />
                                    <asp:BoundField DataField="countryName" HeaderText="Location of Headquarters" SortExpression="countryName" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row no-gutters">
                                                <div class="col-sm-6 pr-1">
                                                    <asp:Button ID="GrdBtnEditPub" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("publisherID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#EditPublisherModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnDeletePub" runat="server" Text="Delete" CssClass="btn btn-danger btn-block"
                                                        CommandArgument='<%# Eval("publisherID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeletePublisher" Enabled='<%# IsPublisherOfRentedBook(Eval("publisherID")) %>' />
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

        <!-- View Book Synopsis modal -->
        <div class="modal fade" id="ViewBookSynopsisModal" tabindex="-1" role="dialog" aria-labelledby="ViewBookSynopsisModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewContactDetModalLongTitle"><strong>Synopsis</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwBookSynopsis" runat="server" DataSourceID="SourceBookSynopsis" CssClass="w-100">
                                    <ItemTemplate>
                                        <div class="form-group mb-1">
                                            <p class="h6">Title</p>
                                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("title") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Author</p>
                                            <asp:Label ID="AuthorLabel" runat="server" Text='<%# Bind("author") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Publisher</p>
                                            <asp:Label ID="PublisherNameLabel" runat="server" Text='<%# Bind("publisherName") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Synopsis</p>
                                            <asp:Label ID="SynopsisLabel" runat="server" Text='<%# Bind("bookSynopsis") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                    </ItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <%-- Add publisher modal --%>
        <div class="modal fade" id="AddBookModal" tabindex="-1" role="dialog" aria-labelledby="AddBookModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AddBookModalLabel"><strong>Add a Book</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="BtnAddBook" />
                        </Triggers>
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="justify-content-center align-items-center">
                                    <div class="form-group mb-1">
                                        <p class="h6">Title</p>
                                        <asp:TextBox ID="TbxTitle" runat="server" CssClass="form-control"
                                            placeholder="e.g. The Sea of Monsters"
                                            ValidationGroup="book"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqValTitle" runat="server"
                                            ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="TbxTitle" ValidationGroup="book"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ReqValNonExistentTitle" runat="server"
                                            ErrorMessage="This book already exists" ForeColor="Red"
                                            Display="Dynamic" ValidationGroup="book" ControlToValidate="TbxTitle"
                                            OnServerValidate="ReqValNonExistentTitle_ServerValidate"></asp:CustomValidator>
                                    </div>
                                    <div class="form-group mb-1">
                                        <p class="h6">Author</p>
                                        <asp:DropDownList ID="DrpAuthors" runat="server" CssClass="custom-select" DataSourceID="SourceAuthorNames"
                                            DataTextField="fullName" DataValueField="authorID" AppendDataBoundItems="true">
                                        </asp:DropDownList>
                                        <small>
                                            <asp:LinkButton ID="LBtnAddMissingAuthor" runat="server"
                                                data-toggle="modal" data-target="#AddAuthorModal" CausesValidation="false">
                                            Add a missing author</asp:LinkButton>
                                        </small>
                                    </div>
                                    <div class="form-group mb-1">
                                        <p class="h6">Publisher</p>
                                        <asp:DropDownList ID="DrpPublishers" runat="server" CssClass="custom-select" DataSourceID="SourcePublishers"
                                            DataTextField="publisherName" DataValueField="publisherID" AppendDataBoundItems="True">
                                        </asp:DropDownList>
                                        <small>
                                            <asp:LinkButton ID="LBtnAddMissingPub" runat="server"
                                                data-toggle="modal" data-target="#AddPublisherModal" CausesValidation="false">
                                            Add a missing publisher</asp:LinkButton>
                                        </small>
                                    </div>
                                    <div class="form-group mb-1">
                                        <p class="h6">Genre</p>
                                        <asp:DropDownList ID="DrpGenres" runat="server" CssClass="custom-select">
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
                                        <p class="h6">Year of Publication</p>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <asp:LinkButton ID="BtnSubPubYear" runat="server" CssClass="btn btn-danger"
                                                    OnClick="BtnSubPubYear_Click">
                                                    <i class="fas fa-minus"></i>
                                                </asp:LinkButton>
                                            </div>
                                            <asp:TextBox ID="TbxPubYearA" runat="server" Text='<%: DateTime.Now.Year %>' CssClass="form-control"
                                                TextMode="Number" max='<%# DateTime.Now.Year %>' ValidationGroup="book" placeholder="e.g. 2018"
                                                min="1970"></asp:TextBox>
                                            <div class="input-group-append">
                                                <asp:LinkButton ID="BtnAddPubYear" runat="server" CssClass="btn btn-success kill-spin"
                                                    OnClick="BtnAddPubYear_Click">
                                                    <i class="fas fa-plus"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator ID="ReqValPubYearA" runat="server"
                                            ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="TbxPubYearA" ValidationGroup="book"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ReqValPosYear" runat="server" ValidationGroup="book"
                                            ErrorMessage="This field cannot have a value that is less than 1" ControlToValidate="TbxPubYearA"
                                            OnServerValidate="ReqValPositive_ServerValidate" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                    </div>
                                    <div class="form-group mb-1">
                                        <p class="h6">ISBN</p>
                                        <asp:TextBox ID="TbxISBN" runat="server" CssClass="form-control"
                                            placeholder="e.g. 0-7868-5686-6" MaxLength="20" ValidationGroup="book"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqValISBN" runat="server"
                                            ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="TbxISBN" ValidationGroup="book"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group mb-1">
                                        <p class="h6">Edition</p>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <asp:LinkButton ID="BtnSubEd" runat="server" CssClass="btn btn-danger"
                                                    OnClick="BtnSubEd_Click">
                                                    <i class="fas fa-minus"></i>
                                                </asp:LinkButton>
                                            </div>
                                            <asp:TextBox ID="TbxEdition" runat="server" CssClass="nospinner form-control" TextMode="Number"
                                                placeholder="e.g. 1" min="1" ValidationGroup="book" Text="1"></asp:TextBox>
                                            <div class="input-group-append">
                                                <asp:LinkButton ID="BtnAddEd" runat="server" CssClass="btn btn-success kill-spin"
                                                    OnClick="BtnAddEd_Click">
                                                    <i class="fas fa-plus"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator ID="ReqValEdition" runat="server"
                                            ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="TbxEdition" ValidationGroup="book"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ReqValPositive" runat="server" ValidationGroup="book"
                                            ErrorMessage="This field cannot have a value that is less than 1" ControlToValidate="TbxEdition"
                                            OnServerValidate="ReqValPositive_ServerValidate" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                    </div>
                                </div>
                                <div class="form-group mb-1">
                                    <p class="h6">Quantity</p>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <asp:LinkButton ID="BtnSubtractQuant" runat="server" CssClass="btn btn-danger"
                                                OnClick="BtnSubtractQuant_Click">
                                                    <i class="fas fa-minus"></i>
                                            </asp:LinkButton>
                                        </div>
                                        <asp:TextBox ID="TbxQuantity" runat="server" CssClass="form-control" TextMode="Number"
                                            placeholder="e.g. 1" min="1" ValidationGroup="book" Text="1"></asp:TextBox>
                                        <div class="input-group-append">
                                            <asp:LinkButton ID="BtnAddQuant" runat="server" CssClass="btn btn-success kill-spin"
                                                OnClick="BtnAddQuant_Click">
                                                    <i class="fas fa-plus"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                    <asp:CustomValidator ID="ReqValPositiveQuant" runat="server" ValidationGroup="book"
                                        ErrorMessage="This field cannot have a value that is less than 1" ControlToValidate="TbxQuantity"
                                        OnServerValidate="ReqValPositive_ServerValidate" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                    <asp:RequiredFieldValidator ID="ReqValQuant" runat="server"
                                        ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxQuantity" ValidationGroup="book"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group mb-1">
                                    <p class="h6">Synopsis</p>
                                    <asp:TextBox ID="TbxBookSynopsis" runat="server" CssClass="form-control"
                                        TextMode="MultiLine" ValidationGroup="book"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValBookSynop" runat="server"
                                        ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxBookSynopsis" ValidationGroup="book"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnAddBook" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnAddBook_ServerClick"
                                    validationgroup="book">
                                    Add Book</button>
                                <button id="BtnResetBookFields" runat="server" type="button" class="btn btn-secondary" data-dismiss="modal"
                                    onserverclick="BtnResetBookFields_ServerClick">
                                    Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <%-- Add Book modal --%>
        <div class="modal fade" id="AddAuthorModal" tabindex="-1" role="dialog" aria-labelledby="AddAuthorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AddAuthorModalLabel"><strong>Add an Author</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="form-row">
                                    <div class="form-group col-sm-6 mb-1">
                                        <p class="h6">First Name</p>
                                        <asp:TextBox ID="TbxFirstname" runat="server" CssClass="form-control"
                                            placeholder="e.g. John"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqValFirstName" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxFirstname" Display="Dynamic"
                                            ValidationGroup="author"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ReqValNonExistentAuthor" runat="server"
                                            ErrorMessage="This author already exists" ForeColor="Red" ValidationGroup="author" Display="Dynamic"
                                            ControlToValidate="TbxFirstname" OnServerValidate="ReqValNonExistentAuthor_ServerValidate"></asp:CustomValidator>
                                    </div>
                                    <div class="form-group col-sm-6 mb-1">
                                        <p class="h6">Last Name</p>
                                        <asp:TextBox ID="TbxLastName" runat="server" CssClass="form-control"
                                            placeholder="e.g. Smith" ValidationGroup="author"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqValLastName" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxLastName" Display="Dynamic"
                                            ValidationGroup="author"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnAddAuthorB" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnAddAuthor_Click"
                                    validationgroup="author">
                                    Add Author</button>
                                <button id="BtnResetAuthorFields" type="button" runat="server"
                                    class="btn btn-secondary" data-dismiss="modal"
                                    onserverclick="BtnResetAuthorFields_ServerClick">
                                    Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <%-- Add publisher modal --%>
        <div class="modal fade" id="AddPublisherModal" tabindex="-1" role="dialog" aria-labelledby="AddPublisherModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AddPublisherModalLabel"><strong>Add a Publisher</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="form-row">
                                    <div class="form-group col-sm-6 mb-1">
                                        <p class="h6">Publisher Name</p>
                                        <asp:TextBox ID="TbxPublisherName" runat="server" CssClass="form-control"
                                            placeholder="Publisher Name" ValidationGroup="publisher"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqValPub" runat="server" ForeColor="Red"
                                            ErrorMessage="This field is required" ControlToValidate="TbxPublisherName"
                                            Display="Dynamic" ValidationGroup="publisher"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="ReqValNonExistingPublisher" runat="server" ErrorMessage="This publisher already exists"
                                            ForeColor="Red" ValidationGroup="publisher" Display="Dynamic"
                                            ControlToValidate="TbxPublisherName" OnServerValidate="ReqValNonExistingPublisher_ServerValidate"></asp:CustomValidator>
                                    </div>
                                    <div class="form-group col-sm-6 mb-1">
                                        <p class="h6">Location of Headquarters</p>
                                        <asp:DropDownList ID="DrpCountry" runat="server" DataSourceID="SourceCountries" DataTextField="countryName" DataValueField="countryID" CssClass="custom-select" AppendDataBoundItems="true" ValidationGroup="publisher">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnAddPublisher" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnAddPublisher_ServerClick"
                                    validationgroup="publisher">
                                    Add Publisher</button>
                                <button id="BtnResetPublisherFields" type="button" class="btn btn-secondary" runat="server"
                                    data-dismiss="modal" onserverclick="BtnResetPublisherFields_ServerClick">
                                    Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>


                </div>
            </div>
        </div>

        <%-- Edit Book modal --%>
        <div class="modal fade" id="EditBookModal" tabindex="-1" role="dialog" aria-labelledby="EditBookModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="EditBookModalLabel"><strong>Update Book Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Books" />
                        </Triggers>
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="Books" runat="server" DataKeyNames="bookID" DataSourceID="SourceBookEdit" DefaultMode="Edit" CssClass="w-100">
                                    <EditItemTemplate>
                                        <div class="justify-content-center align-items-center">
                                            <div class="form-group mb-1">
                                                <p class="h6">Title</p>
                                                <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'
                                                    CssClass="form-control" ValidationGroup="editBook" />
                                                <asp:RequiredFieldValidator ID="ReqValTitleU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="titleTextBox" ValidationGroup="editBook"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Author</p>
                                                <asp:DropDownList ID="DrpAuthors" runat="server" CssClass="custom-select" DataSourceID="SourceAuthorNames"
                                                    DataTextField="fullName" DataValueField="authorID" AppendDataBoundItems="true" SelectedValue='<%# Bind("authorID") %>'>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Publisher</p>
                                                <asp:DropDownList ID="DrpPublishersB" runat="server" CssClass="custom-select" DataSourceID="SourcePublishers"
                                                    DataTextField="publisherName" DataValueField="publisherID" AppendDataBoundItems="True" SelectedValue='<%# Bind("publisherID") %>'>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Genre</p>
                                                <asp:DropDownList ID="DrpGenresB" runat="server" CssClass="custom-select" SelectedValue='<%# Bind("genre") %>'>
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
                                                <p class="h6">Year of Publication</p>
                                                <asp:TextBox ID="TbxPubYear" runat="server" Text='<%# Bind("publishYear") %>' CssClass="form-control"
                                                    TextMode="Number" max='<%# DateTime.Now.Year %>'
                                                    min="1970"></asp:TextBox>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">ISBN</p>
                                                <asp:TextBox ID="ISBNTextBox" runat="server" Text='<%# Bind("ISBN") %>'
                                                    CssClass="form-control" ValidationGroup="editBook"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ReqValISBNU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="ISBNTextBox" ValidationGroup="editBook"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Edition</p>
                                                <asp:TextBox ID="editionTextBox" runat="server" Text='<%# Bind("edition") %>' CssClass="form-control"
                                                    TextMode="Number" ValidationGroup="editBook" min="1"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ReqValEditionU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="editionTextBox" ValidationGroup="editBook"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Quantity</p>
                                                <asp:TextBox ID="TbxQuantity" runat="server" Text='<%# Bind("bookCount") %>' CssClass="form-control"
                                                    TextMode="Number" ValidationGroup="editBook"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ReqValQuantU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="TbxQuantity" ValidationGroup="editBook"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Synopsis</p>
                                                <asp:TextBox ID="TbxSynopsis" runat="server" Text='<%# Bind("bookSynopsis") %>' CssClass="form-control"
                                                    TextMode="MultiLine" ValidationGroup="editBook"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="ReqValSynopsis" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="TbxSynopsis" ValidationGroup="editBook"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnEditBook" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnEditBook_ServerClick"
                                    validationgroup="editBook">
                                    Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <!-- Edit Author modal-->
        <div class="modal fade" id="EditAuthorModal" tabindex="-1" role="dialog" aria-labelledby="EditAuthorModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editAuthorlisherModalLabel"><strong>Update Author Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UPDLupAuth" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwAuthors" runat="server" DataKeyNames="authorID" DataSourceID="SourceAuthorEdit"
                                    DefaultMode="Edit" CssClass="w-100">
                                    <EditItemTemplate>
                                        <div class="form-row">
                                            <div class="form-group col-sm-6 mb-1">
                                                <p class="h6">First Name</p>
                                                <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'
                                                    CssClass="form-control" ValidationGroup="editAuth" />
                                                <asp:RequiredFieldValidator ID="ReqValFirstNameU" runat="server" ForeColor="Red"
                                                    ErrorMessage="This field is required" ControlToValidate="firstNameTextBox"
                                                    Display="Dynamic" ValidationGroup="editAuth"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group col-sm-6 mb-1">
                                                <p class="h6">Last Name</p>
                                                <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'
                                                    CssClass="form-control" ValidationGroup="editAuth" />
                                                <asp:RequiredFieldValidator ID="ReqValLastNameU" runat="server" ForeColor="Red"
                                                    ErrorMessage="This field is required" ControlToValidate="lastNameTextBox" Display="Dynamic"
                                                    ValidationGroup="editAuth"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="FvBtnUpdateAuth" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="FvBtnUpdateAuth_ServerClick"
                                    validationgroup="editAuth">
                                    Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Edit Publisher modal -->
        <div class="modal fade" id="EditPublisherModal" tabindex="-1" role="dialog" aria-labelledby="EditPublisherModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="EditPublisherModalLabel"><strong>Update Publisher Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FormView1" runat="server" DataSourceID="SourcePublisherEdit" DataKeyNames="publisherID"
                                    DefaultMode="Edit" CssClass="w-100">
                                    <EditItemTemplate>
                                        <div class="form-row">
                                            <div class="form-group col-sm-6 mb-1">
                                                <p class="h6">Publisher Name</p>
                                                <asp:TextBox ID="publisherNameTextBox" runat="server" Text='<%# Bind("publisherName") %>'
                                                    CssClass="form-control" ValidationGroup="editPub" />
                                                <asp:RequiredFieldValidator ID="ReqValPubU" runat="server" ForeColor="Red"
                                                    ErrorMessage="This field is required" ControlToValidate="publisherNameTextBox"
                                                    Display="Dynamic" ValidationGroup="editPub"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group col-sm-6 mb-1">
                                                <p class="h6">Location of Headquarters</p>
                                                <asp:DropDownList ID="DrpCountryB" runat="server" DataSourceID="SourceCountries" DataTextField="countryName" DataValueField="countryID"
                                                    CssClass="custom-select" AppendDataBoundItems="true" ValidationGroup="publisher" SelectedValue='<%# Bind("countryID") %>'>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="FvBtnUpdatePub" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="FvBtnUpdatePub_ServerClick"
                                    validationgroup="editPub">
                                    Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Edit LibIndex modal -->
        <div class="modal fade" id="EditLibIndexModal" tabindex="-1" role="dialog" aria-labelledby="EditLibIndexModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="EditLibIndexModalLabel"><strong>Edit Book Call Number</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwLibIndex" runat="server" DataKeyNames="indexID"
                                    DataSourceID="SourceLibraryEdit" CssClass="w-100" DefaultMode="Edit">
                                    <EditItemTemplate>
                                        <div class="justify-content-center align-items-center">
                                            <div class="form-group mb-1">
                                                <p class="h6">Title</p>
                                                <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'
                                                    CssClass="form-control" Enabled="false" />
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Author</p>
                                                <asp:TextBox ID="fullNameTextBox" runat="server" Text='<%# Bind("fullName") %>'
                                                    CssClass="form-control" Enabled="false" />
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Genre</p>
                                                <asp:TextBox ID="genreTextBox" runat="server" Text='<%# Bind("genre") %>'
                                                    CssClass="form-control" Enabled="false" />
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Call Number</p>
                                                <asp:TextBox ID="callNumberTextBox" runat="server" Text='<%# Bind("callNumber") %>'
                                                    CssClass="form-control" MaxLength="20" />
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="FvBtnUpdateCallNum" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="FvBtnUpdateCallNum_ServerClick"
                                    validationgroup="editPub">
                                    Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Delete Publisher modal -->
        <div class="modal fade" id="DeletePublisher" tabindex="-1" role="dialog" aria-labelledby="DeletePublisherLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeletePublisherLabel"><strong>Delete Publisher Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-question-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Are you sure you want to delete this publisher's information from the database? 
                                    Doing so will delete ALL associated books. This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnDeletePub" runat="server"
                                    onserverclick="BtnDeletePub_ServerClick" data-toggle="modal"
                                    data-target="#UpdateNotifModal">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Delete Author modal -->
        <div class="modal fade" id="DeleteAuthorModal" tabindex="-1" role="dialog" aria-labelledby="DeleteAuthorLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteAuthorLabel"><strong>Delete Author Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-question-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Are you sure you want to delete this author's information from the database? 
                                    Doing so will delete ALL associated books. This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnDeleteAuthor" runat="server"
                                    onserverclick="BtnDeleteAuthor_ServerClick" data-toggle="modal"
                                    data-target="#UpdateNotifModal">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Delete Book modal -->
        <div class="modal fade" id="DeleteBookModal" tabindex="-1" role="dialog" aria-labelledby="DeleteBookLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteBookLabel"><strong>Delete Book Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fa fa-question-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Are you sure you want to delete this Book's information from the database? 
                                    This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnDeleteBook" runat="server"
                                    onserverclick="BtnDeleteBook_ServerClick" data-toggle="modal"
                                    data-target="#UpdateNotifModal">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <!-- Update Notification modal -->
        <div class="modal fade" id="UpdateNotifModal" tabindex="-1" role="dialog" aria-labelledby="UpdateNotifLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="UpdateNotifLabel"><strong>Update Successful</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fas fa-info-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Records were updated successfully.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" id="BtnUpdateSuccess" runat="server"
                                    onserverclick="BtnUpdateSuccess_ServerClick">
                                    OK</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Record Addition Notification modal -->
        <div class="modal fade" id="AdditionNotifModal" tabindex="-1" role="dialog" aria-labelledby="AdditionNotifLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="AdditionNotifLabel"><strong>Addition Successfull</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col-sm-4 text-center">
                                <i class="fas fa-info-circle display-1" style="color: rgb(0, 172, 237) !important;"></i>
                            </div>
                            <div class="col-sm-8">
                                <p class="text-justify">
                                    Record added successfully.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" id="BtnAdditionSuccess" runat="server"
                                    onserverclick="BtnAdditionSuccess_ServerClick">
                                    OK</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookDisplay]" InsertCommand="EXEC AddBook @authorID, @publisherID, @title , @ISBN, @edition, @genre, @publishYr, @bookCount, @synopsis" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:ControlParameter ControlID="DrpAuthors" Name="authorID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DrpPublishers" Name="publisherID" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TbxTitle" Name="title" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxISBN" Name="ISBN" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxEdition" Name="edition" PropertyName="Text" Type="Int16" />
                <asp:ControlParameter ControlID="DrpGenres" Name="genre" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="TbxPubYearA" Name="publishYr" PropertyName="Text" Type="Int16" />
                <asp:ControlParameter Name="bookCount" Type="Int16" ControlID="TbxQuantity" PropertyName="Text" />
                <asp:ControlParameter ControlID="TbxBookSynopsis" Name="synopsis" PropertyName="Text" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthors" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookAuthors]" InsertCommand="EXEC AddAuthor @first, @last" DeleteCommand="EXEC DeleteAuthor @id" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
            <DeleteParameters>
                <asp:SessionParameter Name="id" SessionField="keys" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TbxFirstname" Name="first" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxLastName" Name="last" PropertyName="Text" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourcePublishers" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [PublisherWithCountryName]" InsertCommand="EXEC AddPublisher @publisherName, @cityID" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
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
        <asp:SqlDataSource ID="SourceBookEdit" runat="server" SelectCommand="SELECT * FROM EditBookView WHERE bookID = @id" UpdateCommand="EXEC UpdateBook @authorID, @publisherID, @title , @ISBN, @edition, @genre, @publishYear, @bookCount, @bookSynopsis, @bookID" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" DeleteCommand="EXEC DeleteBook @id" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
            <DeleteParameters>
                <asp:SessionParameter Name="id" SessionField="keys" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookAuthors] WHERE authorID = @id" UpdateCommand="EXEC UpdateAuthor @firstName, @lastName, @authorID" DeleteCommand="EXEC DeleteAuthor @id" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
            <DeleteParameters>
                <asp:SessionParameter Name="id" SessionField="keys" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceBookSynopsis" runat="server" SelectCommand="SELECT title, author, publisherName, genre, bookSynopsis FROM BookDisplay WHERE bookID = @id" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceLibrary" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM LibraryIndexNamed"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceLibraryEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM LibraryIndexNamed WHERE indexID = @id" UpdateCommand="EXEC UpdateCallNumber @indexID, @callNumber">
            <SelectParameters>
                <asp:SessionParameter Name="id" SessionField="keys" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorNames" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [AuthorNames]" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceCountries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
    </div>


</asp:Content>
