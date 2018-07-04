<%@ Page Title="My Rentals - Dynamic Link Division of Libraries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyRentals.aspx.cs" Inherits="LMS.MyRentals" %>

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
                            <asp:Panel ID="Panel1" runat="server" CssClass="jumbotron pb-2 pt-2 pr-2 pl-2 mb-2 mt-2" DefaultButton="BtnSearchRentalGrid">
                                <div class="input-group mx-auto mb-1 mt-1">
                                    <asp:TextBox ID="TbxSearchRentalGrid" runat="server" CssClass="form-control form-control-lg"
                                        Font-Size="14px" placeholder="search rented books"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="BtnSearchRentalGrid" runat="server" CssClass="btn btn-git btn-lg"
                                            OnClick="BtnSearchRentalGrid_Click"><i class="fa fa-search"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:GridView ID="GvwRentals" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table"
                                DataKeyNames="rentalID" DataSourceID="SourceRentals" GridLines="Horizontal" AllowPaging="True" PageSize="4">
                                <EmptyDataTemplate>
                                    <div class="container text-center">
                                        <p class="lead">You have not rented any books as of this time.</p>
                                    </div>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                                    <asp:BoundField DataField="fullName" HeaderText="Author" SortExpression="fullName" ReadOnly="True" />
                                    <asp:BoundField DataField="edition" HeaderText="Edition" SortExpression="edition" />
                                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                    <asp:BoundField DataField="rentalDate" HeaderText="Rental Date" SortExpression="rentalDate" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="returnDate" HeaderText="Return Date" SortExpression="returnDate" DataFormatString="{0:d}" />
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# SetText(Eval("returnDate")) %>' 
                                                CssClass='<%# SetCSSClass(Eval("returnDate")) %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
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
