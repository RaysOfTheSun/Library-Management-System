﻿<%@ Page Title="Rentals" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="ManageRentals.aspx.cs" Inherits="LMS.ManageRentals" %>

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
                            <asp:HiddenField ID="HfdRentalID" runat="server" />
                            <asp:GridView ID="GvwRequests" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="rentalID"
                                DataSourceID="SourceRequests" GridLines="Horizontal" OnRowCommand="GvwRequests_RowCommand">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There are currently no book rental requests to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="rentalID" HeaderText="rentalID" ReadOnly="True" SortExpression="rentalID" />
                                    <asp:BoundField DataField="accountOwner" HeaderText="Requestor" SortExpression="accountOwner" ReadOnly="True" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" ReadOnly="True" SortExpression="fullName" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="returnDate" HeaderText="Return Date" SortExpression="returnDate" DataFormatString="{0:d}" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnAcceptRequest" runat="server" Text="Accept" CssClass="btn btn-success btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#ConfirmAcceptRequestModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnRejectRequest" runat="server" Text="Reject" CssClass="btn btn-danger btn-block" CommandName="deleteItem"
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
                            <asp:GridView ID="GvwRentals" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table"
                                DataKeyNames="rentalID" DataSourceID="SourceRentals" GridLines="Horizontal" OnRowCommand="GvwRentals_RowCommand">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There are currently no rental details to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="rentalID" HeaderText="rentalID" ReadOnly="True" SortExpression="rentalID" />
                                    <asp:BoundField DataField="accountOwner" HeaderText="Renter" ReadOnly="True" SortExpression="accountOwner" />
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="FullName" ReadOnly="True" SortExpression="fullName" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
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
        <div class="modal" id="DeleteRequestModal" tabindex="-1" role="dialog" aria-labelledby="DeleteRequestLabel" aria-hidden="true">
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
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="BtnDeleteRequest" runat="server"
                            onserverclick="BtnDeleteRequest_ServerClick">
                            Yes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Accept Request modal -->
        <div class="modal" id="ConfirmAcceptRequestModal" tabindex="-1" role="dialog" aria-labelledby="ConfirmAcceptRequestLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ConfirmAcceptRequestLabel"><strong>Delete Request Information</strong></h5>
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
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="BtnConfirmAcceptRequest_" runat="server"
                            onserverclick="BtnConfirmAcceptRequest__ServerClick">
                            Yes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Return modal -->
        <div class="modal" id="ReturnRentalModal" tabindex="-1" role="dialog" aria-labelledby="ReturnRentalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ReturnRentalLabel"><strong>Delete Request Information</strong></h5>
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
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="BtnReturnRental" runat="server"
                            onserverclick="BtnReturnRental_ServerClick">
                            Yes</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- Extend Rental modal --%>
        <div class="modal" id="ExtendRentalModal" tabindex="-1" role="dialog" aria-labelledby="ExtendRentalModalLabel" aria-hidden="true">
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
                                <div class="justify-content-center align-items-center">
                                    <div class="form-group mb-1">
                                        <p class="h6">New Return Date</p>
                                        <asp:TextBox ID="TbxExtensionDate" runat="server" CssClass="form-control"
                                            placeholder="Date" ValidationGroup="extend" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="modal-footer">
                        <button id="BtnExtendRental" type="button" class="btn btn-library-10"
                            runat="server" onserverclick="BtnExtendRental_ServerClick" validationgroup="extend">
                            Extend Rental</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
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
        ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM RentalDetails" UpdateCommand="EXEC ExtendRetal @rentalID, @date">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HfdRentalID" Name="rentalID" PropertyName="Value" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HfdRentalID" Name="rentalID" PropertyName="Value" />
            <asp:ControlParameter ControlID="TbxExtensionDate" Name="date" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>