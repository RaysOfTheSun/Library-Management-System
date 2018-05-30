<%@ Page Title="Login - Dynamic Link Division of Libaries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LMS.Login" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="lib-backdrop">
        <div class="tinted d-flex align-items-center h-100 w-100">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="lib-box">
                        
                        <h4 style="font-size:22px;"><i class="fa fa-cogs"></i> Dynamic Link | LIBRARIES</h4>
                    </div>
                </div>
                <div class="row justify-content-center align-items-center">
                    <div class="card" style="border-color: rebeccapurple;">
                        <div class="card-body" style="width: 360px;">
                            <h5 class="card-title lead text-center display-4"><strong>Sign In</strong></h5>
                            <div class="form-group">
                                <asp:TextBox ID="tbx_username" runat="server" CssClass="form-control"
                                    placeholder="username"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:TextBox ID="tbx_password" runat="server" CssClass="form-control"
                                    placeholder="password" TextMode="Password"></asp:TextBox>
                            </div>

                            <asp:Button ID="BtnLogin" runat="server" Text="Login" CssClass="btn btn-library-10 form-control form-control-lg" OnClick="btn_login_Click" />
                            <div class="divider">
                                <hr class="left">
                                <small>New to the library?</small>
                                <hr class="right">
                            </div>
                            <div class="form-group">
                                <asp:Button ID="BtnContact" runat="server" Text="Contact Administrator" CssClass="btn btn-info form-control form-control-lg"
                                    Font-Size="14px" />
                            </div>
                            <div class="form-group text-center">
                                <p>
                                    By signing in to Dynamic Link Libaries, you are agreeing to our 
                                    <a href="#">Terms of Use</a> and to our <a href="#">Privacy Policy</a>.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
