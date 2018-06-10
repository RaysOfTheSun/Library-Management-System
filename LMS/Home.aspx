<%@ Page Title="Home - Dynamic Link Division of Libaries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="LMS._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid" id="searchbox">
    <div class="wrap">
        <div class="col-sm-12">
            <div class="container" id="searchbox-inner">
                <div class="wrap">
                    <div class="container">
                        <div class="form-group">
                            <asp:Label ID="lbl_searchbox" runat="server" Text="Search for" CssClass="lead col-form-label text-uppercase"></asp:Label>
                            <asp:TextBox ID="TbxSearchTerms" runat="server" CssClass="form-control form-control-lg"
                                         placeholder="Alaska, Fiction...">
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
                                    OnClick="BtnSearchLib_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="wrap">
    <div class="container-fluid">
        <div class="container">
            <div class="row">
                <div class="col col-sm-6 ">
                    <div class="row">
                        <div class="col col-sm-6">
                            <ul class="bullet-less">
                                <li style="border: 0; padding: 0;">
                                    <h4 style="color: black;">
                                        <strong>Quick Links</strong>
                                    </h4>
                                </li>
                                <li>
                                    <a href="#">Hours</a>
                                </li>
                                <li>
                                    <a href="#">Visiting</a>
                                </li>
                                <li style="border-bottom: 0;">
                                    <a href="#">Computing</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col col-sm-6">
                            <ul class="bullet-less">
                                <li style="border: 0; padding: 0;">
                                    <h4 style="color: black;">
                                        <strong>Explore</strong>
                                    </h4>
                                </li>
                                <li>
                                    <a href="#">Research Guides</a>
                                </li>
                                <li>
                                    <a href="#">Research Services</a>
                                </li>
                                <li style="border-bottom: 0;">
                                    <a href="#">Special Collections, Archives, & Avery Fisher Center</a>
                                </li>
                            </ul>
                        </div>
                        <div class="w-100"></div>
                        <div class="col col-sm-12">
                            <ul class="bullet-less">
                                <li style="border: 0; padding: 0;">
                                    <h4 style="color: black;">
                                        <strong>Rooms & Spaces</strong>
                                    </h4>
                                </li>
                                <li>
                                    <div class="card bg-light" style="border: 0;">
                                        <div class="row">
                                            <div class="col-3" style="padding-right: 0;">
                                                <img src="Images/bobst-LL1-09B-4.jpg" class="img-thumbnail"/>
                                            </div>
                                            <div class="col-9">
                                                <a href="#">Praesent elementum diam non consequat condimentum.</a>
                                                <p>Nunc placerat enim imperdiet, egestas felis id, volutpat elit.</p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="card bg-light" style="border: 0;">
                                        <div class="row">
                                            <div class="col-3" style="padding-right: 0;">
                                                <img src="Images/bobst-6-graduate-study.jpg" class="img-thumbnail"/>
                                            </div>
                                            <div class="col-9">
                                                <a href="#">In et justo vehicula, ultricies risus volutpat, mollis dui.</a>
                                                <p>Aenean at magna iaculis, imperdiet tortor vel, venenatis diam.</p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="card bg-light" style="border: 0;">
                                        <div class="row">
                                            <div class="col-3" style="padding-right: 0;">
                                                <img src="Images/avery-fisher-center-media-collaborative-room-copyright-sarah-mechling.jpg" class="img-thumbnail"/>
                                            </div>
                                            <div class="col-9">
                                                <a href="#">Nullam pulvinar nisl a ex pulvinar vestibulum ut eu est.</a>
                                                <p>Vivamus nec mi faucibus, commodo turpis in, gravida lacus.</p>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li style="border-bottom: 0;">
                                    <a href="#" class="more">See more &#10148;</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-sm-6 align-self-start w-100">
                    <h4 style="color: black;">
                        <strong>Explore Our Resources</strong>
                    </h4>
                    <div class="row">
                        <div class="col col-md-6 mr-2 mb-2">
                            <div class="card text-center" style="width: 18rem;">
                                <img class="card-img-top" src="Images/Symposium-Flyer.jpg" alt="Card image cap"/>
                                <div class="card-body">
                                    <a href="#" class="card-text">Quisque eu blandit ex, vitae.</a>
                                </div>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="card text-center" style="width: 18rem;">
                                <img class="card-img-top" src="Images/tamiment-library-world-youth-festival-prague.jpg" alt="Card image cap"/>
                                <div class="card-body">
                                    <a href="#" class="card-text">Donec condimentum eros erat, eu.</a>
                                </div>
                            </div>
                        </div>
                        <div class="w-100"></div>
                        <div class="col col-md-6 mr-2">
                            <div class="card text-center" style="width: 18rem;">
                                <img class="card-img-top" src="Images/find-your-subject-specialist.jpg" alt="Card image cap"/>
                                <div class="card-body">
                                    <a href="#" class="card-text">Maecenas eu convallis enim. In.</a>
                                </div>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="card text-center" style="width: 18rem;">
                                <img class="card-img-top" src="Images/pexels-photo-265087.jpeg" alt="Card image cap"/>
                                <div class="card-body">
                                    <a href="#" class="card-text">Morbi efficitur nibh diam, nec.</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="padding-top: 20px;">
                <div class="col col-sm-6">
                    <ul class="bullet-less-content">
                        <li style="border: 0; padding: 0;">
                            <h4 style="color: black;">
                                <strong>Library News & Updates</strong>
                            </h4>
                        </li>
                        <li>
                            <a href="#">Praesent hendrerit odio nec nisi maximus, non blandit enim aliquet</a>
                            <p>Pellentesque pretium tellus sit amet malesuada laoreet</p>
                        </li>
                        <li>
                            <a href="#">Etiam ut est non justo dapibus mollis ac id sapien</a>
                            <p>Pellentesque placerat tellus sed fermentum ultrices</p>
                        </li>
                        <li>
                            <a href="#">Vivamus vestibulum urna ut dolor vestibulum rutrum.</a>
                            <p>Nulla sed nunc interdum, viverra mi vel, porttitor es</p>
                        </li>
                        <li style="border-bottom: 0;">
                            <a href="#" class="more">See more &#10148;</a>
                        </li>
                    </ul>
                </div>
                <div class="col col-sm-6">
                    <ul class="bullet-less-content">
                        <li style="border: 0; padding: 0;">
                            <h4 style="color: black;">
                                <strong>Library Classes</strong>
                            </h4>
                        </li>
                        <li>
                            <a href="#">Proin laoreet ultricies odio</a>
                            <p>Nunc mattis sem tempus elementum lacinia.</p>
                        </li>
                        <li>
                            <a href="#">Morbi quis orci sed nisl molestie tristique ut id nisi.</a>
                            <p>Suspendisse et tortor sed mi iaculis lacinia a id turpis.</p>
                        </li>
                        <li>
                            <a href="#">Proin mattis leo ac leo tincidunt porttitor.</a>
                            <p>Suspendisse tempus arcu et accumsan gravida.</p>
                        </li>
                        <li style="border-bottom: 0;">
                            <a href="#" class="more">See more &#10148;</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>