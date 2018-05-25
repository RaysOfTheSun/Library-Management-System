<%@ Page Title="Rentals" Language="C#" MasterPageFile="~/Administrator.Master" AutoEventWireup="true" CodeBehind="ManageRentals.aspx.cs" Inherits="LMS.ManageRentals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="requests-tab" data-toggle="tab" href="#requests" role="tab" aria-controls="requests" aria-selected="true">
                        <i class="fas fa-envelope"></i>&nbsp;requests</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="rentals-tab" data-toggle="tab" href="#rentals" role="tab" aria-controls="rentals" aria-selected="false">
                        <i class="fas fa-book"></i>&nbsp;rentals</a>
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
                            <asp:GridView ID="GvwRequests" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="rentalID" DataSourceID="SourceRequests" GridLines="Horizontal">
                                <EmptyDataTemplate>
                                    <div class="content-wrapper">
                                        <div class="display-2">There are currently no book rental requests.</div>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="rentalID" HeaderText="rentalID" ReadOnly="True" SortExpression="rentalID" />
                                    <asp:BoundField DataField="accountOwner" HeaderText="Requestor" SortExpression="accountOwner" ReadOnly="True" />
                                    <asp:BoundField DataField="title" HeaderText="Book" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" ReadOnly="True" SortExpression="fullName" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnAcceptRequest" runat="server" Text="Accept" CssClass="btn btn-primary btn-block" CommandName="editItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#editAccountModal" />
                                                </div>
                                                <div class="col-sm-6">
                                                    <asp:Button ID="GrdBtnRejectRequest" runat="server" Text="Reject" CssClass="btn btn-danger btn-block" CommandName="deleteItem"
                                                        CommandArgument='<%# Eval("rentalID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#DeleteAccountModal" />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="tab-pane fade" id="rentals" role="tabpanel" aria-labelledby="rentals-tab">
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SourceRequests" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM RentalRequestDetails"></asp:SqlDataSource>
</asp:Content>
