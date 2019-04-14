<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="adminsection_login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="shortcut icon" type="image/x-icon" href="../favicon.ico" />
    <meta charset="utf-8" />
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <link rel="stylesheet" type="text/css" href="../lib/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="../lib/font-awesome/css/font-awesome.css" />
    <script src="../js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../stylesheets/theme.css" />   
</head>
<body class="theme-blue">
    <form id="form1" runat="server">
        <cc1:ToolkitScriptManager  CombineScripts="True" ID="tsm" runat="server"></cc1:ToolkitScriptManager>
        <!-- Demo page code -->
        <script type="text/javascript">
            $(function () {
                var match = document.cookie.match(new RegExp('color=([^;]+)'));
                if (match) var color = match[1];
                if (color) {
                    $('body').removeClass(function (index, css) {
                        return (css.match(/\btheme-\S+/g) || []).join(' ')
                    })
                    $('body').addClass('theme-' + color);
                }

                $('[data-popover="true"]').popover({ html: true });

            });
        </script>
        <script type="text/javascript">
            $(function () {
                var uls = $('.sidebar-nav > ul > *').clone();
                uls.addClass('visible-xs');
                $('#main-menu').append(uls.clone());
            });
        </script>
        <script>
            function Validate() {
                if (Page_ClientValidate("u1")) {
                    return true;
                }
                else {
                    return false;
                }
            }
        </script>

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le fav and touch icons -->
        <link rel="shortcut icon" href="../assets/ico/favicon.ico" />
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png" />
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png" />
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png" />
        <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png" />


        <!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
        <!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
        <!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
        <!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
        <!--[if (gt IE 9)|!(IE)]><!-->

        <!--<![endif]-->

        <div class="navbar navbar-default leftmenuheader" role="navigation" style="background: #fff!important;border-bottom: solid 2px #3A4651;margin-bottom: 0px;">
            <div class="navbar-header">
                <a href="login.aspx">
                    <div style="margin: 10px;">
                        <img src="../logo.png" width="100" height="100" alt="logo" /></div>
                </a>
            </div>
        </div>
        <div class="dialog">
            <div class="panel panel-default">
                <p class="panel-heading no-collapse leftmenuheader"><b>Admin Sign In</b></p>
                <div class="panel-body">
                    <div class="form-group">
                        <label>Email Address </label>
                        <asp:TextBox ID="txtUserName" CssClass="form-control" runat="server" MaxLength="100" TabIndex="1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtUserName" ControlToValidate="txtUserName" runat="server" ValidationGroup="u1"></asp:RequiredFieldValidator>
                        <cc1:FilteredTextBoxExtender ID="ftbetxtUserName" runat="server" TargetControlID="txtUserName" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        <asp:RegularExpressionValidator ID="REVtxtUserName" runat="server"
                                ControlToValidate="txtUserName" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true" ErrorMessage="Please Enter Valid Email Address"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\s*$" ValidationGroup="u1"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <label>Password </label>
                        <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" MaxLength="50" TextMode="Password" TabIndex="2"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvtxtPassword" ControlToValidate="txtPassword" runat="server" ValidationGroup="u1"></asp:RequiredFieldValidator>
                        <cc1:FilteredTextBoxExtender ID="ftbetxtPassword" runat="server" TargetControlID="txtPassword" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                    </div>
                 <%--   <p class="pull-right margin-zero padding-top">
                        <a id="aForgotPassword" runat="server"  tabindex="4">Forgot your password?</a>
                    </p>--%>
                    <asp:Button ID="btnLogin" runat="server" TabIndex="3" Text="Login" CssClass="btn btn-primary" OnClick="btnLogin_Click" OnClientClick="return Validate();" ValidationGroup="u1" />&nbsp;&nbsp;<span id="divMessage" class="errorMessage" runat="server"></span>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <script src="../lib/bootstrap/js/bootstrap.js"></script>
        <script type="text/javascript">
            $("[rel=tooltip]").tooltip();
            $(function () {
                $('.demo-cancel-click').click(function () { return false; });
            });
        </script>
    </form>
</body>
</html>
