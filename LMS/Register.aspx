<%@ Page Title="Register - Dynamic Link Division of Libraries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LMS.Rgister" %>

<%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="lib-backdrop">
        <div class="tinted d-flex align-items-center h-100 w-100">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="lib-box" style="width: 600px !important;">
                        <h4 style="font-size: 32px;"><i class="fa fa-cogs"></i>&nbsp;Dynamic Link | LIBRARIES</h4>
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
                                    <asp:RequiredFieldValidator ID="ReqValFName" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxFirstname"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:TextBox ID="TbxMiddleName" runat="server" CssClass="form-control"
                                        placeholder="middle name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValMName" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxMiddleName"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-sm-4 mb-1">
                                    <asp:TextBox ID="TbxLastName" runat="server" CssClass="form-control"
                                        placeholder="last name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValLName" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxLastName"></asp:RequiredFieldValidator>
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
                                    <asp:RequiredFieldValidator ID="ReqValZip" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxZipCode"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="mb-2">
                                <asp:TextBox ID="TbxNumber" runat="server" CssClass="form-control mb-1"
                                    placeholder="phone number (optional)"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxLastName"></asp:RequiredFieldValidator>--%>
                                <asp:TextBox ID="TbxStreet" runat="server" CssClass="form-control" TextMode="MultiLine"
                                    placeholder="street"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValStreet" runat="server"
                                    ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                    ControlToValidate="TbxStreet"></asp:RequiredFieldValidator>
                            </div>
                            <p class="h6"><strong>Account Information</strong></p>
                            <div>
                                <asp:TextBox ID="TbxEmail" runat="server" CssClass="form-control mb-1"
                                    placeholder="E-mail" TextMode="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqValMail" runat="server"
                                    ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                    ControlToValidate="TbxEmail"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-sm-6">
                                    <asp:TextBox ID="TbxPassword" runat="server" CssClass="form-control mb-1"
                                        placeholder="password" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqValPass" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxPassword"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-sm-6">
                                    <asp:TextBox ID="TbxConfirmPassword" runat="server" CssClass="form-control"
                                        placeholder="confirm password" TextMode="Password"></asp:TextBox>
                                    <asp:CompareValidator ID="CompValPass" runat="server"
                                        ErrorMessage="Your passwords do not match" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxConfirmPassword"
                                        ControlToCompare="TbxPassword"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="ReqPassCon" runat="server"
                                        ErrorMessage="This field is required" ForeColor="Red" Display="Dynamic"
                                        ControlToValidate="TbxConfirmPassword"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <asp:Button ID="BtnCreate" runat="server" Text="Create My Account"
                                CssClass="btn btn-library-10 form-control form-control-lg" OnClick="BtnCreate_Click" />
                            <div class="divider">
                                <hr class="left">
                                <small>Need to start again?</small>
                                <hr class="right">
                            </div>
                            <div class="form-group">
                                <asp:Button ID="BtnReset" runat="server" Text="Reset All Fields" CssClass="btn btn-danger form-control form-control-lg"
                                    Font-Size="14px" OnClientClick="return false;" data-toggle="modal" data-target="#exampleModal" />
                            </div>
                            <div class="form-group text-center">
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

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Confirm Reset</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to reset all fields?
                </div>
                <div class="modal-footer">
                    <asp:Button ID="BtnConfirmReset" runat="server" Text="Yes"
                        OnClientClick="this.form.reset(); return false;" CssClass="btn btn-danger" data-dismiss="modal" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="Countries" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [Countries]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="Cities" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Cities"></asp:SqlDataSource>
    <asp:SqlDataSource ID="LibraryDB" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" InsertCommand="EXEC CreateUser @first,@middle,@last,@mail,@pass,@countryID,@cityID,@street,@zip,@number
"
        ProviderName="<%$ ConnectionStrings:LibraryDBConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="TbxFirstname" Name="first" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxMiddleName" Name="middle" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxLastName" Name="last" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxEmail" Name="mail" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxPassword" Name="pass" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DrpCountry" Name="countryID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DrpCity" Name="cityID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TbxStreet" Name="street" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TbxZipCode" Name="zip" PropertyName="Text" Type="Int16" />
            <asp:ControlParameter ControlID="TbxNumber" Name="number" PropertyName="Text" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
