<%@ Page Title="Management" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="LMS.Management" %>

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
            <div class="tab-pane fade" id="nav-titles" role="tabpanel" aria-labelledby="nav-titles-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPBooks" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdBooks" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GrdBooks" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="bookID" DataSourceID="SourceBooks" CssClass="table table-hover table-borderless" ShowHeaderWhenEmpty="True">
                                <Columns>
                                    <asp:BoundField DataField="bookID" HeaderText="Book ID" ReadOnly="True" SortExpression="bookID" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="author" HeaderText="Author" SortExpression="author" ReadOnly="True" />
                                    <asp:BoundField DataField="publisherName" HeaderText="Publisher" SortExpression="publisherName" />
                                    <asp:BoundField DataField="publishYear" HeaderText="Year of Publication" SortExpression="publishYear" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                                </Columns>
                                <RowStyle CssClass="row-bottom-only" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
            <div class="tab-pane fade show active" id="nav-authors" role="tabpanel" aria-labelledby="nav-authors-tab">
                <div class="container">


                    <asp:UpdatePanel ID="UPAuth" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <asp:GridView ID="GrdAuthors" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" CssClass="table" DataSourceID="SourceAuthors" DataKeyNames="authorID" AllowPaging="True" PageSize="6">
                                <Columns>
                                    <asp:BoundField DataField="authorID" HeaderText="Author ID" InsertVisible="False" ReadOnly="True" SortExpression="authorID" />
                                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                                    <asp:BoundField DataField="middleName" HeaderText="Middle Name" SortExpression="middleName" />
                                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>

            </div>
            <div class="tab-pane fade" id="nav-publishers" role="tabpanel" aria-labelledby="nav-publishers-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPPub" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GrdPublishers" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GrdPublishers" runat="server" DataSourceID="SourcePublishers" AutoGenerateColumns="False" DataKeyNames="publisherID" CssClass="table" OnRowCommand="GrdPublishers_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="publisherID" HeaderText="Publisher ID" ReadOnly="True" SortExpression="publisherID" />
                                    <asp:BoundField DataField="publisherName" HeaderText="Name" SortExpression="publisherName" />
                                    <asp:BoundField DataField="countryName" HeaderText="Location of Headquarters" SortExpression="countryName" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnEditPub" runat="server" Text="Edit" CssClass="btn btn-primary" CommandName="editItem"
                                                CommandArgument='<%# Eval("publisherID") %>' CausesValidation="false" data-toggle="modal" data-target="#EditPublisherModal" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
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

        <%-- Edit Publisher modal --%>
        <div class="modal" id="EditPublisherModal" tabindex="-1" role="dialog" aria-labelledby="EditPublisherModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="EditPublisherModalLabel">Add an editPub</h5>
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
                                                    CssClass="custom-select" AppendDataBoundItems="true" ValidationGroup="publisher" SelectedValue='<%# Bind("city") %>'>
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
        <asp:SqlDataSource ID="SourcePublishers" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [PublisherWithCityName]" InsertCommand="EXEC AddPublisher @publisherName, @cityID">
            <InsertParameters>
                <asp:ControlParameter Name="publisherName" ControlID="TbxPublisherName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DrpCountry" Name="cityID" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceCountries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SourcePublisherEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM BookPublishers WHERE publisherID=@id" UpdateCommand="EXEC UpdatePublisher @publisherName, @city, @publisherID">
            <SelectParameters>
                <asp:ControlParameter ControlID="hiddenID" Name="id" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorNames" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [AuthorNames]"></asp:SqlDataSource>

    </div>


</asp:Content>
