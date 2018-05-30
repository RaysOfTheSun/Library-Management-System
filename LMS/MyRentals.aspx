﻿<%@ Page Title="My Rentals - Dynamic Link Division of Libraries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyRentals.aspx.cs" Inherits="LMS.MyRentals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container" style="font-size: 1.3vw;">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="rentals-tab" data-toggle="tab" href="#rentals" role="tab" aria-controls="rentals" aria-selected="true">
                        <i class="fas fa-book"></i>&nbsp;Rentals</a>
                </li>
            </ul>
        </div>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade show active" id="rentals" role="tabpanel" aria-labelledby="rentals-tab">
                <div class="container">
                    <asp:UpdatePanel ID="UPLDRentals" runat="server" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="GvwRentals" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:GridView ID="GvwRentals" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table"
                                DataKeyNames="rentalID" DataSourceID="SourceRentals" GridLines="Horizontal" AllowPaging="True" PageSize="4">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">There are currently no rental details to show.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <%--<asp:BoundField DataField="rentalID" HeaderText="Rental ID" ReadOnly="True" SortExpression="rentalID" />--%>
                                    <%--<asp:BoundField DataField="borrowerID" HeaderText="borrowerID" SortExpression="borrowerID" />--%>
                                    <%--<asp:BoundField DataField="accountOwner" HeaderText="accountOwner" SortExpression="accountOwner" ReadOnly="True" />--%>
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" SortExpression="fullName" ReadOnly="True" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="returnDate" HeaderText="Return Date" SortExpression="returnDate" DataFormatString="{0:d}" />
                                </Columns>
                                <HeaderStyle BorderStyle="Solid" VerticalAlign="Middle" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="SourceRentals" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" DeleteCommand="EXEC DeleteRentalDetails @rentalID"
        ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM RentalDetails WHERE borrowerID = @id" UpdateCommand="EXEC ExtendRetal @rentalID, @date">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="bID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>