<%@ Page Title="Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="LMS.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="content-wrapper">
            <div class="container">
                <div class="form-group">
                    <asp:Label ID="LblSearchBox" runat="server" Text="Search for" CssClass="lead col-form-label text-uppercase"></asp:Label>
                    <asp:TextBox ID="TbxSearchTerms" runat="server" CssClass="form-control form-control-lg"
                        placeholder="Percy Jackson, Fiction, Biography...">
                    </asp:TextBox>
                </div>
                <div class="form-inline">
                    <asp:Label ID="Label3" runat="server" Text="Limit search to:" CssClass="mr-1 text-uppercase lead"></asp:Label>
                    <asp:DropDownList ID="DrpItem" runat="server" CssClass="custom-select mr-1">
                        <asp:ListItem>Books</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="DrpWords" runat="server" CssClass="custom-select mr-1">
                        <asp:ListItem>that contain exact words from my query</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="DrpField" runat="server" CssClass="custom-select mr-1">
                        <asp:ListItem Value="all">in all fields</asp:ListItem>
                        <asp:ListItem Value="title">in title</asp:ListItem>
                        <asp:ListItem Value="auth">in author</asp:ListItem>
                        <asp:ListItem Value="pub">in publisher</asp:ListItem>
                        <asp:ListItem Value="isbn">in ISBN</asp:ListItem>
                        <asp:ListItem Value="callnum">in call number</asp:ListItem>
                    </asp:DropDownList>
                    <div class="text-right ml-auto">
                        <asp:Button ID="BtnSearchLib" runat="server" Text="SEARCH" CssClass="btn btn-library-10" Font-Size="18px"
                            OnClick="BtnSearchLib_Click" />
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="wrap">
                    <asp:HiddenField ID="HfdBookID" runat="server" />
                    <asp:ListView ID="ListViewSearchResults" runat="server" DataKeyNames="bookID" DataSourceID="SourceBooks" OnItemCommand="ListViewSearchResults_ItemCommand">
                        <EmptyDataTemplate>
                            <span>No titles were found based on your criteria.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <br />
                            <div class="container">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="container">
                                            <div class="row align-items-center">
                                                <div class="col col-md-2">
                                                    <img src="Images/Books/sea_of_monsters/01.jpg" class="img-thumbnail" />
                                                </div>
                                                <div class="col col-sm-8">
                                                    <div class="container">
                                                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("title") %>'
                                                            CssClass="display-4" />
                                                        <br />
                                                        <p class="h5">
                                                            <strong>By
                                                    <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("author") %>' />
                                                            </strong>
                                                        </p>
                                                        <p class="h6">
                                                            Published by 
                                                        <asp:Label ID="publisherNameLabel" runat="server" Text='<%# Eval("publisherName") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            Published on 
                                                        <asp:Label ID="publishYearLabel" runat="server" Text='<%# Eval("publishYear") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            ISBN: 
                                                        <asp:Label ID="ISBNLabel" runat="server" Text='<%# Eval("ISBN") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            Edition: 
                                                        <asp:Label ID="editionLabel" runat="server" Text='<%# Eval("edition") %>' />
                                                        </p>
                                                        <p class="h6">
                                                            Genre: 
                                                        <asp:Label ID="genreLabel" runat="server" Text='<%# Eval("genre") %>' />
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col-sm-0 align-self-center">
                                                    <asp:Button ID="BtnRequestRent" runat="server" Text="Request to Rent" CssClass="btn btn-library btn-block"
                                                        CommandArgument='<%# Eval("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                        data-target="#rentalNotifModal" Enabled='<%# IsLoggedIn() %>' />
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <span style=""></span>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server" style="">
                                <span runat="server" id="itemPlaceholder" />
                            </div>
                            <div class="wrap">
                                <div style="">
                                    <asp:DataPager ID="DataPager1" runat="server">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>

                        </LayoutTemplate>
                    </asp:ListView>
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
    <asp:SqlDataSource ID="SourceRentals" runat="server" InsertCommand="EXEC AddRequest @bookID, @borrowerID" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="borrowerID" SessionField="bID" Type="Int32" />
            <asp:ControlParameter ControlID="HfdBookID" Name="bookID" PropertyName="Value" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"></asp:SqlDataSource>
</asp:Content>
