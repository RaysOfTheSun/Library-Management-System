<%@ Page Title="Management" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="LMS.Management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Home</a>
                    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Profile</a>
                    <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Contact</a>
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

            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
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
            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                <div class="container">
                    <asp:GridView ID="GrdBooks" runat="server" AutoGenerateColumns="False" DataKeyNames="bookID" DataSourceID="SourceBooks"
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
                </div>
            </div>
            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                <div class="container">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SourcePublishers" AutoGenerateColumns="False" DataKeyNames="publisherID" CssClass="table">
                        <Columns>
                            <asp:BoundField DataField="publisherID" HeaderText="publisherID" ReadOnly="True" SortExpression="publisherID" />
                            <asp:BoundField DataField="publisherName" HeaderText="publisherName" SortExpression="publisherName" />
                            <asp:BoundField DataField="countryName" HeaderText="countryName" SortExpression="countryName" />
                        </Columns>
                    </asp:GridView>
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

                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="justify-content-center align-items-center">
                                        <div class="form-group mb-1">
                                            <asp:TextBox ID="TbxTitle" runat="server" CssClass="form-control"
                                                placeholder="title"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-1">
                                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="custom-select" DataSourceID="SourceAuthorNames"
                                                DataTextField="fullName" DataValueField="authorID" AppendDataBoundItems="true">
                                                <asp:ListItem Text="Select an Author..." Value="-99"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="modal-footer">
                        <asp:Button ID="BtnConfirmReset" runat="server" Text="Yes"
                            OnClientClick="this.form.reset(); return false;" CssClass="btn btn-danger" data-dismiss="modal" />
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
                <asp:Parameter Name="authorID" Type="Int32" />
                <asp:Parameter Name="publisherID" Type="Int32" />
                <asp:Parameter Name="title" Type="String" />
                <asp:Parameter Name="ISBN" Type="String" />
                <asp:Parameter Name="edition" Type="Int16" />
                <asp:Parameter Name="genre" Type="String" />
                <asp:Parameter Name="publishYr" Type="Int16" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthors" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BookAuthors]" InsertCommand="EXEC AddAuthor @first, @middle, @last">
            <InsertParameters>
                <asp:ControlParameter ControlID="TbxFirstname" Name="first" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxMiddleName" Name="middle" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TbxLastName" Name="last" PropertyName="Text" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceAuthorNames" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [AuthorNames]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SourcePublishers" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [PublisherWithCityName]" InsertCommand="EXEC AddPublisher @publisherName, @cityID">
            <InsertParameters>
                <asp:ControlParameter Name="publisherName" ControlID="TbxPublisherName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DrpCountry" Name="cityID" PropertyName="SelectedValue" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SourceCountries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>

    </div>


</asp:Content>
