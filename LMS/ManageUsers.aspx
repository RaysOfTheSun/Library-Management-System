<%@ Page Title="Accounts - Dynamic Link Administration" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="LMS.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-accounts-tab" data-toggle="tab" href="#nav-accounts" role="tab" aria-controls="nav-accounts" aria-selected="true">
                        <i class="fas fa-user"></i>&nbsp;Borrower Accounts<asp:HiddenField ID="hideenID" runat="server" />
                    </a>
                    <a class="nav-item nav-link" id="nav-users-tab" data-toggle="tab" href="#nav-users" role="tab" aria-controls="nav-users" aria-selected="false">
                        <i class="fa fa-address-card"></i>&nbsp;Borrowers
                    </a>
                </div>
            </nav>
        </div>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="nav-accounts" role="tabpanel" aria-labelledby="nav-accounts-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwAccounts" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchAccountGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchAccountlGrid" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search accounts"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchAccountGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchAccountGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GvwAccounts" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="borrowerID" DataSourceID="SourceAccounts"
                                GridLines="Horizontal" OnRowCommand="GvwDetails_RowCommand">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There is currently nothing to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="borrowerID" HeaderText="Borrower ID" ReadOnly="True" SortExpression="borrowerID" />
                                    <asp:BoundField DataField="accountOwner" HeaderText="Owner" ReadOnly="True" SortExpression="accountOwner" />
                                    <asp:BoundField DataField="userName" HeaderText="Username" SortExpression="userName" />
                                    <asp:BoundField DataField="accountPassword" HeaderText="Password" SortExpression="accountPassword" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row no-gutters">
                                                <div class="col-sm-6 pr-1">
                                                    <asp:Button ID="GrdBtnEditaccountDet" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#editAccountModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnDeleteaccountDet" runat="server" Text="Delete" CssClass="btn btn-danger btn-block" CommandName="deleteItem"
                                                        CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeleteAccountModal" Enabled='<%# IsRenting(Eval("borrowerID")) %>' />
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
            <div class="tab-pane fade" id="nav-users" role="tabpanel" aria-labelledby="nav-users-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPDLdet" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwDetails" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel2" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchUserlGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchUserlGrid" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search borrowers"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchUserlGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchUserlGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GvwDetails" runat="server" AutoGenerateColumns="False" BorderStyle="None"
                                CssClass="table" DataKeyNames="borrowerID" DataSourceID="SourceUsers" GridLines="Horizontal"
                                OnRowCommand="GvwDetails_RowCommand1" HeaderStyle-Wrap="false">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There is currently nothing to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="borrowerID" HeaderText="Borrower ID" ReadOnly="True" SortExpression="borrowerID" />
                                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                                    <asp:BoundField DataField="middleName" HeaderText="Middle Name" SortExpression="middleName" />
                                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                                    <%--<asp:BoundField DataField="mail" HeaderText="E-mail Address" SortExpression="mail" />--%>
                                    <%--<asp:BoundField DataField="phoneNumber" HeaderText="Contact Number" SortExpression="phoneNumber" />--%>
                                    <asp:TemplateField HeaderText="Contact Details">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnShowUserContactDet" runat="server" Text="View" CssClass="btn btn-info btn-block" CommandName="editItem"
                                                CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#viewContactDetModal" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="countryName" HeaderText="Home Country" SortExpression="countryName" />
                                    <asp:BoundField DataField="cityName" HeaderText="Home City" SortExpression="cityName" />
                                    <%--<asp:BoundField DataField="street" HeaderText="Street Address" SortExpression="street" />--%>
                                    <%--<asp:BoundField DataField="zipCode" HeaderText="Zip Code" SortExpression="zipCode" />--%>
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnEditUserDet" runat="server" Text="Edit" CssClass="btn btn-primary" CommandName="editItem"
                                                CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#editUserModal" />
                                            <asp:Button ID="GrdBtnDeleteUserDet" runat="server" Text="Delete" CssClass="btn btn-danger" CommandName="deleteItem"
                                                CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#DeleteUserDetModal" Enabled='<%# IsRenting(Eval("borrowerID")) %>' />
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


        <!-- Edit User Details modal -->
        <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editUserModalLongTitle"><strong>Update User Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwUserDet" runat="server" DataKeyNames="borrowerID" DataSourceID="SourceUsersEdit" DefaultMode="Edit" CssClass="w-100">
                                    <EditItemTemplate>
                                        <div class="justify-content-center align-items-center">
                                            <div class="form-group mb-1">
                                                <p class="h6">First Name</p>
                                                <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:RequiredFieldValidator ID="ReqValFirstNameU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="firstNameTextBox" ValidationGroup="updateUser"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Middle Name</p>
                                                <asp:TextBox ID="middleNameTextBox" runat="server" Text='<%# Bind("middleName") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:RequiredFieldValidator ID="ReqValMiddleNameU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="firstNameTextBox" ValidationGroup="updateUser"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Last Name</p>
                                                <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:RequiredFieldValidator ID="ReqValLastNameU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="firstNameTextBox" ValidationGroup="updateUser"></asp:RequiredFieldValidator>

                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">E-mail</p>
                                                <asp:TextBox ID="mailTextBox" runat="server" Text='<%# Bind("mail") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:RequiredFieldValidator ID="ReqValMailU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="firstNameTextBox" ValidationGroup="updateUser"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Home Country</p>
                                                <asp:DropDownList ID="DrpCountry" runat="server" DataSourceID="SourceCountries" DataTextField="countryName"
                                                    DataValueField="countryID" CssClass="custom-select" AppendDataBoundItems="true" SelectedValue='<%# Bind("countryID") %>'>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Home City</p>
                                                <asp:DropDownList ID="DrpCity" runat="server" DataSourceID="Cities" DataTextField="cityName" DataValueField="cityID" CssClass="custom-select"
                                                    AppendDataBoundItems="True" SelectedValue='<%# Bind("cityID") %>'>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Street Address</p>
                                                <asp:TextBox ID="streetTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("street") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:RequiredFieldValidator ID="ReqValStreetU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="streetTextBox" ValidationGroup="updateUser"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Phone Number</p>
                                                <asp:TextBox ID="phoneNumberTextbox" runat="server" TextMode="Number" Text='<%# Bind("phoneNumber") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:Label ID="numberIDLabel" runat="server" Text='<%# Bind("numberID") %>' Visible="false" />
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Zip Code</p>
                                                <asp:TextBox ID="zipCodeTextBox" runat="server" Text='<%# Bind("zipCode") %>'
                                                    CssClass="form-control" ValidationGroup="updateUser" />
                                                <asp:RequiredFieldValidator ID="ReqValZipU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="zipCodeTextBox" ValidationGroup="updateUser"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("addressID") %>' CssClass="form-control" Visible="false" />
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnUpdateUserDet" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnUpdateUserDet_ServerClick" validationgroup="editDet">
                                    Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- View Contact Details modal -->
        <div class="modal fade" id="viewContactDetModal" tabindex="-1" role="dialog" aria-labelledby="viewContactDetModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewContactDetModalLongTitle"><strong>Contact Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwUserContactDet" runat="server" DataSourceID="SourceContactDet" CssClass="w-100">
                                    <ItemTemplate>
                                        <div class="form-group mb-1">
                                            <p class="h6">Name</p>
                                            <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">E-mail Address</p>
                                            <asp:Label ID="MailLabel" runat="server" Text='<%# Bind("mail") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Contact Number</p>
                                            <asp:Label ID="PhoneNumberLabel" runat="server" Text='<%# Bind("phoneNumber") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Address</p>
                                            <asp:Label ID="AddressLabel" runat="server" Text='<%# Bind("Address") %>' CssClass="text-justify form-control border-0" Enabled="false" />
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

        <!-- Edit User Account modal -->
        <div class="modal fade" id="editAccountModal" tabindex="-1" role="dialog" aria-labelledby="editAccountModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editAccountModalLongTitle"><strong>Update User Account Information</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwAccounts" runat="server" DataKeyNames="borrowerID" DataSourceID="SourceAccountsEdit" DefaultMode="Edit" CssClass="w-100">
                                    <EditItemTemplate>
                                        <div class="justify-content-center align-items-center">
                                            <div class="form-group mb-1">
                                                <p class="h6">Account Owner</p>
                                                <asp:TextBox ID="accountOwnerTextBox" runat="server" Text='<%# Bind("accountOwner") %>'
                                                    CssClass="form-control" Enabled="false" />
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Username</p>
                                                <asp:TextBox ID="userNameTextBox" runat="server" Text='<%# Bind("userName") %>'
                                                    CssClass="form-control" ValidationGroup="updateAccount" />
                                                <asp:RequiredFieldValidator ID="ReqValUsernameU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="userNameTextBox" ValidationGroup="updateAccount"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-group mb-1">
                                                <p class="h6">Password</p>
                                                <asp:TextBox ID="accountPasswordTextBox" runat="server" Text='<%# Bind("accountPassword") %>'
                                                    CssClass="form-control" ValidationGroup="updateAccount" />
                                                <asp:RequiredFieldValidator ID="ReqValPassU" runat="server"
                                                    ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                    ControlToValidate="accountPasswordTextBox" ValidationGroup="updateAccount"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnEditAcc" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnEditAcc_ServerClick" validationgroup="editAcc">
                                    Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <!-- Delete User Account modal -->
        <div class="modal fade" id="DeleteAccountModal" tabindex="-1" role="dialog" aria-labelledby="DeleteAccountLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteAccountLabel"><strong>Delete Account Information</strong></h5>
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
                                    Are you sure you want to delete this Account's information from the database? Doing so will
                                    also delete all associated information. This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnDeleteAccount" runat="server"
                                    onserverclick="BtnDeleteAccount_ServerClick" data-toggle="modal"
                                    data-target="#UpdateNotifModal">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Delete User UserDet modal -->
        <div class="modal fade" id="DeleteUserDetModal" tabindex="-1" role="dialog" aria-labelledby="DeleteUserDetLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteUserDetLabel"><strong>Delete User Information</strong></h5>
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
                                    Are you sure you want to delete this user's information from the database? 
                                    This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnDeleteUser" runat="server"
                                    onserverclick="BtnDeleteUser_ServerClick" data-toggle="modal"
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
    </div>

    <asp:SqlDataSource ID="SourceAccounts" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [BorrowerAccounts]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceAccountsEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM BorrowerAccounts WHERE borrowerID = @id" UpdateCommand="EXEC UpdateUserAccount @userName, @accountPassword, @borrowerID" DeleteCommand="EXEC DeleteUserDetails @id">
        <DeleteParameters>
            <asp:SessionParameter Name="id" SessionField="borrowerID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="borrowerID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceUsers" runat="server" SelectCommand="SELECT borrowerID, firstName, middleName, lastName, mail, phoneNumber, countryName, cityName, street, zipCode FROM completeBorrowerData" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceContactDet" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT (firstName + ' ' + middleName + ' ' + lastName) AS [Name], mail, phoneNumber, (street + ', ' + cityName  + ' ' + CONVERT(NVARCHAR,zipCode) + ',' + ' ' + countryName) AS [Address] FROM completeBorrowerData WHERE borrowerID = @id">
        <SelectParameters>
            <asp:ControlParameter ControlID="hideenID" Name="id" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceUsersEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM completeBorrowerDataB WHERE borrowerID = @id" UpdateCommand="EXEC UpdateUserDetails @firstName, @middleName, @lastName, @mail, @phoneNumber, @countryID, @cityID, @street, @zipCode, @addressID, @borrowerID, @numberID" DeleteCommand="DeleteUserDetails @bID
">
        <DeleteParameters>
            <asp:SessionParameter Name="bID" SessionField="borrowerID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="hideenID" Name="id" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceCountries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Cities" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Cities]"></asp:SqlDataSource>
</asp:Content>
