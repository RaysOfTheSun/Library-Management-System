<%@ Page Title="Rentals - Dynamic Link Administration" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="ManageRentals.aspx.cs" Inherits="LMS.ManageRentals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="requests-tab" data-toggle="tab" href="#requests" role="tab" aria-controls="requests" aria-selected="true">
                        <i class="fas fa-envelope"></i>&nbsp;Requests</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="rentals-tab" data-toggle="tab" href="#rentals" role="tab" aria-controls="rentals" aria-selected="false">
                        <i class="fas fa-book"></i>&nbsp;Rentals</a>
                </li>
            </ul>
        </div>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="requests" role="tabpanel" aria-labelledby="requests-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPDLRequests" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwRequests" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchRequestGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchRequestGrid" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search requestors"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchRequestGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchRequestGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:HiddenField ID="HfdRentalID" runat="server" />
                            <asp:GridView ID="GvwRequests" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="rentalID"
                                DataSourceID="SourceRequests" GridLines="Horizontal" OnRowCommand="GvwRequests_RowCommand" HeaderStyle-Wrap="false">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There are currently no book rental requests to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="rentalID" HeaderText="Rental ID" ReadOnly="True" SortExpression="rentalID" />
                                    <asp:BoundField DataField="accountOwner" HeaderText="Requestor" SortExpression="accountOwner" ReadOnly="True" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" ReadOnly="True" SortExpression="fullName" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="rentalDate" HeaderText="Rental Date" SortExpression="rentalDate" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="returnDate" HeaderText="Return Date" SortExpression="returnDate" DataFormatString="{0:d}" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row no-gutters">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnAcceptRequest" runat="server" Text="&#10004;" CssClass="btn btn-success btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#ConfirmAcceptRequestModal" />
                                                </div>
                                                <div class="col-sm-6 pl-1">
                                                    <asp:Button ID="GrdBtnRejectRequest" runat="server" Text="&#x2716;" CssClass="btn btn-danger btn-block" CommandName="deleteItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeleteRequestModal" />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="tab-pane fade" id="rentals" role="tabpanel" aria-labelledby="rentals-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPLDRentals" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwRentals" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="Panel2" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchRentalGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchRenters" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search renters"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchRentalGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchRentalGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GvwRentals" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table"
                                DataKeyNames="rentalID" DataSourceID="SourceRentals" GridLines="Horizontal" OnRowCommand="GvwRentals_RowCommand"
                                HeaderStyle-Wrap="false">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There are currently no rental details to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="rentalID" HeaderText="Rental ID" ReadOnly="True" SortExpression="rentalID" />
                                    <%--<asp:BoundField DataField="borrowerID" HeaderText="Borrower ID" SortExpression="borrowerID" />--%>
                                    <asp:BoundField DataField="accountOwner" HeaderText="Renter" SortExpression="accountOwner" ReadOnly="True" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" SortExpression="fullName" ReadOnly="True" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="rentalDate" HeaderText="Rental Date" SortExpression="rentalDate" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="returnDate" HeaderText="Return Date" SortExpression="returnDate" DataFormatString="{0:d}" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row no-gutters">
                                                <div class="col-sm-6 pr-1">
                                                    <asp:Button ID="GrdBtnExtendRental" runat="server" Text="Extend" CssClass="btn btn-success btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#ExtendRentalModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnReturnRental" runat="server" Text="Return" CssClass="btn btn-danger btn-block" CommandName="deleteItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#ReturnRentalModal" />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>

        <!-- Delete Request modal -->
        <div class="modal fade" id="DeleteRequestModal" tabindex="-1" role="dialog" aria-labelledby="DeleteRequestLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DeleteRequestLabel"><strong>Delete Request Information</strong></h5>
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
                                    Are you sure you want to reject this request and delete any associated 
                                    information to it from the database? This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnDeleteRequest" runat="server"
                                    onserverclick="BtnDeleteRequest_ServerClick">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Accept Request modal -->
        <div class="modal fade" id="ConfirmAcceptRequestModal" tabindex="-1" role="dialog" aria-labelledby="ConfirmAcceptRequestLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ConfirmAcceptRequestLabel"><strong>Accept Rental Request</strong></h5>
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
                                    Are you sure you want to accept this user's rental request? 
                                    This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnConfirmAcceptRequest_" runat="server"
                                    onserverclick="BtnConfirmAcceptRequest__ServerClick">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Return modal -->
        <div class="modal fade" id="ReturnRentalModal" tabindex="-1" role="dialog" aria-labelledby="ReturnRentalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ReturnRentalLabel"><strong>Return Book</strong></h5>
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
                                    Are you sure this user has properly and successfully returned the book he/she borrowed?
                                    This process will remove all rental details from the database. This action cannot be undone.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" id="BtnReturnRental" runat="server"
                                    onserverclick="BtnReturnRental_ServerClick" data-toggle="modal"
                                    data-target="#UpdateNotifModal">
                                    Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <%-- Extend Rental modal --%>
        <div class="modal fade" id="ExtendRentalModal" tabindex="-1" role="dialog" aria-labelledby="ExtendRentalModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ExtendRentalModalLabel"><strong>Extend Rental</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">

                                <asp:FormView ID="FvwRentalDetails" runat="server" DataSourceID="SourceRentalDatesEdit" DefaultMode="Edit" CssClass="w-100">
                                    <EditItemTemplate>
                                        <div class="form-group mb-1">
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("rentalID") %>'
                                                CssClass="form-control" Enabled="false" Visible="false" />
                                            <p class="h6">Title</p>
                                            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Eval("title") %>'
                                                CssClass="form-control" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Renter</p>
                                            <asp:TextBox ID="fullNameTextBox" runat="server" Text='<%# Eval("fullName") %>'
                                                CssClass="form-control" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Rental Date</p>
                                            <asp:TextBox ID="rentalDateTextBox" runat="server" Text='<%# Eval("rentalDate","{0:yyyy/MM/dd}") %>'
                                                CssClass="form-control" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Current Return Date</p>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("returnDate","{0:d}") %>'
                                                CssClass="form-control" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">New Return Date</p>
                                            <asp:TextBox ID="returnDateTextBox" runat="server" Text='<%# Bind("returnDate") %>' TextMode="Date"
                                                CssClass="form-control" />
                                            <asp:RequiredFieldValidator ID="ReqValDate" runat="server"
                                                ErrorMessage="This field is rquired" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="returnDateTextBox" ValidationGroup="extend"></asp:RequiredFieldValidator>
                                            <asp:CustomValidator ID="ReqNotPastValDate" runat="server" ForeColor="Red" ValidationGroup="extend"
                                                ErrorMessage="This value cannot be set to a date in the past"
                                                ControlToValidate="returnDateTextBox" OnServerValidate="ReqNotPastValDate_ServerValidate"></asp:CustomValidator>
                                        </div>
                                    </EditItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <button id="BtnExtendRental" type="button" class="btn btn-library-10"
                                    runat="server" onserverclick="BtnExtendRental_ServerClick" validationgroup="extend">
                                    Extend Rental</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
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
    <asp:SqlDataSource ID="SourceRequests" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM RentalRequestDetails" DeleteCommand="DeleteRequest @rentalID" InsertCommand="EXEC AddRental @id">
        <DeleteParameters>
            <asp:ControlParameter Name="rentalID" Type="Int32" ControlID="HfdRentalID" PropertyName="Value" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HfdRentalID" Name="id" PropertyName="Value" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SourceRentals" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" DeleteCommand="EXEC DeleteRentalDetails @rentalID"
        ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM RentalDetails">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HfdRentalID" Name="rentalID" PropertyName="Value" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SourceRentalDatesEdit" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" DeleteCommand="EXEC DeleteRentalDetails @rentalID"
        ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM RentalDetails WHERE rentalID = @id" UpdateCommand="EXEC ExtendRetal @rentalID, @returnDate">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HfdRentalID" Name="rentalID" PropertyName="Value" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="HfdRentalID" Name="id" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
