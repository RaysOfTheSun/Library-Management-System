<%@ Page Title="Accounts" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="LMS.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-accounts-tab" data-toggle="tab" href="#nav-accounts" role="tab" aria-controls="nav-accounts" aria-selected="false">
                        <i class="fas fa-user"></i>&nbsp;Accounts</a>
                    <a class="nav-item nav-link" id="nav-users-tab" data-toggle="tab" href="#nav-users" role="tab" aria-controls="nav-users" aria-selected="true">
                        <i class="fa fa-address-card"></i>&nbsp;User Details</a>
                    <asp:HiddenField ID="hiddenID" runat="server" />
                </div>
            </nav>
        </div>

        <div class="tab-content" id="myTabContent">
            <div class="container">
                <div class="jumbotron">
                    <p class="display-4">Stats</p>
                </div>
            </div>
            <div class="tab-pane fade" id="nav-accounts" role="tabpanel" aria-labelledby="home-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwAccounts" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GvwAccounts" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="borrowerID" DataSourceID="SourceAccounts" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="borrowerID" HeaderText="Borrower ID" ReadOnly="True" SortExpression="borrowerID" />
                                    <asp:BoundField DataField="accountOwner" HeaderText="Owner" ReadOnly="True" SortExpression="accountOwner" />
                                    <asp:BoundField DataField="userName" HeaderText="Username" SortExpression="userName" />
                                    <asp:BoundField DataField="accountPassword" HeaderText="Password" SortExpression="accountPassword" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnEditaccountDet" runat="server" Text="Edit" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#EditBookModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnDeleteaccountDet" runat="server" Text="Delete" CssClass="btn btn-danger btn-block" CommandName="deleteItem"
                                                        CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeleteBookModal" />
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
            <div class="tab-pane fade show active" id="nav-users" role="tabpanel" aria-labelledby="profile-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPDLdet" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwDetails" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GvwDetails" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="borrowerID" DataSourceID="SourceUsers" GridLines="Horizontal">
                                <Columns>
                                    <asp:BoundField DataField="borrowerID" HeaderText="Borrower ID" ReadOnly="True" SortExpression="borrowerID" />
                                    <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName" />
                                    <asp:BoundField DataField="middleName" HeaderText="Middle Name" SortExpression="middleName" />
                                    <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName" />
                                    <asp:BoundField DataField="countryName" HeaderText="Home Country" SortExpression="countryName" />
                                    <asp:BoundField DataField="cityName" HeaderText="Home City" SortExpression="cityName" />
                                    <asp:BoundField DataField="street" HeaderText="Street Address" SortExpression="street" />
                                    <asp:BoundField DataField="zipCode" HeaderText="Zip" SortExpression="zipCode" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Button ID="GrdBtnEditUserDet" runat="server" Text="Edit" CssClass="btn btn-primary" CommandName="editItem"
                                                CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#EditBookModal" />
                                            <asp:Button ID="GrdBtnDeleteUserDet" runat="server" Text="Delete" CssClass="btn btn-danger" CommandName="deleteItem"
                                                CommandArgument='<%# Eval("borrowerID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#DeleteBookModal" />
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
    </div>
    <asp:SqlDataSource ID="SourceAccounts" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [BorrowerAccounts]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceAccountsEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM BorrowerAccounts WHERE borrowerID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="newparameter" SessionField="borrowerID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceUsers" runat="server" SelectCommand="SELECT borrowerID, firstName, middleName, lastName, countryName, cityName, street, zipCode FROM completeBorrowerData" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceUsersEdit" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM completeBorrowerData WHERE borrowerID = @id">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="borrowerID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
