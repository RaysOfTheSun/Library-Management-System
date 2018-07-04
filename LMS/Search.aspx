<%@ Page Title="Search - Dynamic Link Division of Libaries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="LMS.Search" %>

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
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:HiddenField ID="HfdBookID" runat="server" />
                            <asp:ListView ID="ListViewSearchResults" runat="server" DataKeyNames="bookID" DataSourceID="SourceBooks"
                                OnItemCommand="ListViewSearchResults_ItemCommand">
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
                                                            <asp:Button ID="BtnViewDetails" runat="server" Text="View Details" CssClass="btn btn-library btn-block"
                                                                CommandArgument='<%# Eval("bookID") %>' CausesValidation="false" data-toggle="modal"
                                                                data-target="#ViewBookDetailsModal" />
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>


        <!-- View Book Details modal -->
        <div class="modal fade" id="ViewBookDetailsModal" tabindex="-1" role="dialog" aria-labelledby="ViewBookDetailsModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewContactDetModalLongTitle"><strong>Book Details</strong></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                        <ContentTemplate>
                            <div class="modal-body">
                                <asp:FormView ID="FvwBookDetails" runat="server" DataSourceID="SourceBookDetails" CssClass="w-100">
                                    <ItemTemplate>
                                        <div class="form-group mb-1">
                                            <p class="h6">Title</p>
                                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("title") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Author</p>
                                            <asp:Label ID="AuthorLabel" runat="server" Text='<%# Bind("author") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Publisher</p>
                                            <asp:Label ID="PublisherNameLabel" runat="server" Text='<%# Bind("publisherName") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Genre</p>
                                            <asp:Label ID="GenreLabel" runat="server" Text='<%# Bind("genre") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Year of Publication</p>
                                            <asp:Label ID="PublicationLabel" runat="server" Text='<%# Bind("publishYear") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">ISBN</p>
                                            <asp:Label ID="IsbnLabel" runat="server" Text='<%# Bind("ISBN") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Edition</p>
                                            <asp:Label ID="EditionLabel" runat="server" Text='<%# Bind("edition") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                        <div class="form-group mb-1">
                                            <p class="h6">Synopsis</p>
                                            <asp:Label ID="SynopsisLabel" runat="server" Text='<%# Bind("bookSynopsis") %>' CssClass="text-justify form-control border-0" Enabled="false" />
                                        </div>
                                    </ItemTemplate>
                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="BtnRequestRentV" runat="server" Text='<%# SetAction(HfdBookID.Value, Session["bID"]) %>' CssClass="btn btn-library-10"
                                    CausesValidation="false" data-toggle="modal"
                                    data-target="#ConfirmRequestModal" Enabled='<%# IsRentable(HfdBookID.Value) %>' />
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
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
                                    data-target="#rentalNotifModal">
                                    Yes</button>
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
    <asp:SqlDataSource ID="SourceRentals" runat="server" InsertCommand="EXEC AddRequest @bookID, @borrowerID" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="borrowerID" SessionField="bID" Type="Int32" />
            <asp:ControlParameter ControlID="HfdBookID" Name="bookID" PropertyName="Value" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceBooks" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SourceBookDetails" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [BookDisplay] WHERE bookID = @id">
        <SelectParameters>
            <asp:ControlParameter ControlID="HfdBookID" Name="id" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
