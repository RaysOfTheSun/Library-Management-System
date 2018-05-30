<%@ Page Title="Catalog - Dynamic Link Division of Libraries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalog.aspx.cs" Inherits="LMS.Catalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container">
            <p class="display-4">Books</p>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="LvwBooks" />
                </Triggers>
                <ContentTemplate>
                    <asp:HiddenField ID="HfdBookID" runat="server" />
                    <asp:ListView ID="LvwBooks" runat="server" DataKeyNames="bookID" DataSourceID="SourceBooks" GroupItemCount="4" OnItemCommand="LvwBooks_ItemCommand">
                        <EmptyDataTemplate>
                            <table runat="server" style="">
                                <tr>
                                    <td>No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <EmptyItemTemplate>
                            <td runat="server" />
                        </EmptyItemTemplate>
                        <GroupTemplate>
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </GroupTemplate>
                        <ItemTemplate>
                            <td runat="server" style="">
                                <div class="card text-center mb-3" style="width: 18rem;">
                                    <div class="card-header">
                                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>' CssClass="h5" />
                                    </div>
                                    <div class="card-body text-center mb-0">
                                        <img src="Images/Books/sea_of_monsters/01.jpg" class="card-img-top img-thumbnail" />
                                        <p class="h6 align-middle mt-3 mb-0">
                                            Written by
                                            <br />
                                            <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("author") %>' />
                                        </p>
                                    </div>
                                    <div class="card-footer text-muted">
                                        <div class="my-1">
                                            <asp:Button ID="BtnRequestRent" runat="server" Text='<%# SetAction(Eval("bookID"), Session["bID"]) %>' CssClass="btn btn-library-10 btn-block"
                                                CommandArgument='<%# Eval("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                data-target="#ConfirmRequestModal" Enabled='<%# IsRentable(Eval("bookID")) %>' />
                                        </div>
                                    </div>
                                </div>
                                <br />
                            </td>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="groupPlaceholderContainer" runat="server" border="0" style="">
                                            <tr id="groupPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style=""></td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                    </asp:ListView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <!-- Rental Confirmation modal -->
        <div class="modal fade" id="ConfirmRequestModal" tabindex="-1" role="dialog" aria-labelledby="ConfirmRequestModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="ConfirmRequestModalLabel"><strong>Request Confirmation</strong></h5>
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
                                    Are you sure you sure you wish to have this book rented?
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-success" id="BtnConfirmRequest" runat="server" 
                                    onserverclick="BtnConfirmRequest_ServerClick" data-toggle="modal"
                                    data-target="#rentalNotifModal">Yes</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>

        <!-- Rental Notification modal -->
        <div class="modal fade" id="rentalNotifModal" tabindex="-1" role="dialog" aria-labelledby="rentalNotifLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="rentalNotifLabel"><strong>Rental Request</strong></h5>
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
                                    The librarian has been notified regarding your request. Please head over to
                                    the counter to complete the rental process.
                                </p>
                            </div>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" id="BtnConfirmRental" runat="server"
                                    onserverclick="BtnConfirmRental_ServerClick">
                                    OK</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [BookDisplay]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceRentals" runat="server" InsertCommand="EXEC AddRequest @bookID, @borrowerID" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="borrowerID" SessionField="bID" Type="Int32" />
            <asp:ControlParameter ControlID="HfdBookID" Name="bookID" PropertyName="Value" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
