<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LMS.Rgister" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="lib-backdrop">
        <div class="tinted d-flex align-items-center h-100 w-100">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="lib-box" style="width: 600px !important;">
                        <h4 style="font-size: 32px;"><i class="fa fa-cogs"></i>Dynamic Link | LIBRARIES</h4>
                    </div>
                </div>
                <div class="row justify-content-center align-items-center">
                    <div class="card" style="border-color: rebeccapurple;">
                        <div class="card-body" style="width: 600px;">
                            <h5 class="card-title lead text-center display-4"><strong>Sign Up</strong></h5>
                            <p class="h6"><strong>Personal Information</strong></p>
                            <div class="form-row">
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:TextBox ID="TbxFirstname" runat="server" CssClass="form-control"
                                        placeholder="first name"></asp:TextBox>
                                </div>
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:TextBox ID="TbxMiddleName" runat="server" CssClass="form-control"
                                        placeholder="middle name"></asp:TextBox>
                                </div>
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:TextBox ID="TbxLastName" runat="server" CssClass="form-control "
                                        placeholder="last name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:DropDownList ID="DrpCountry" runat="server" DataSourceID="Countries" DataTextField="countryName" DataValueField="countryID" CssClass="custom-select" AppendDataBoundItems="true">
                                        <asp:ListItem Selected="True" Value="-99">Country of Residence</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:DropDownList ID="DrpCity" runat="server" DataSourceID="Cities" DataTextField="cityName" DataValueField="cityID" CssClass="custom-select" AppendDataBoundItems="True">
                                        <asp:ListItem Selected="True" Value="-99">City of Residence</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:TextBox ID="TbxZipCode" runat="server" CssClass="form-control"
                                        placeholder="zip code"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-2">
                                <asp:TextBox ID="TbxStreet" runat="server" CssClass="form-control" TextMode="MultiLine"
                                    placeholder="street"></asp:TextBox>
                            </div>
                            <p class="h6"><strong>Account Information</strong></p>
                            <div>
                                <asp:TextBox ID="TbxEmail" runat="server" CssClass="form-control mb-1"
                                    placeholder="E-mail" TextMode="Email"></asp:TextBox>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-sm-6">
                                    <asp:TextBox ID="TbxPassword" runat="server" CssClass="form-control mb-1"
                                        placeholder="password" TextMode="Password"></asp:TextBox>
                                </div>
                                <div class="form-group col-sm-6">
                                    <asp:TextBox ID="TbxConfirmPassword" runat="server" CssClass="form-control"
                                        placeholder="confirm password" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group text-center">
                                <asp:Button ID="btn_login" runat="server" Text="Create My Account" CssClass="btn btn-library-10 form-control form-control-lg" OnClick="btn_login_Click" />
                                <p>
                                    By signing up for a Dynamic Link Libaries account, you are agreeing to our 
                                    <a href="#">Terms of Use</a> and to our <a href="#">Privacy Policy</a>.
                                </p>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="Countries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Cities" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Cities"></asp:SqlDataSource>
    <asp:SqlDataSource ID="LibraryDB" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" InsertCommand="EXEC CreateUser @first,@middle,@last,@mail,@pass,@countryID, @cityID,@street,@zip">
        <InsertParameters>
            <asp:ControlParameter ControlID="TbxFirstname" Name="first" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxMiddleName" Name="middle" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxLastName" Name="last" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxEmail" Name="mail" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxPassword" Name="pass" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DrpCountry" Name="countryID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DrpCity" Name="cityID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TbxStreet" Name="street" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxZipCode" Name="zip" PropertyName="Text" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
