<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="user.aspx.cs" Inherits="adminsection_user" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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
    <style>
        .modalBackground {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .modalPopup {
            background-color: #ffffff;
            border-color: black;
            border-radius: 10px;
            border-style: solid;
            border-width: 3px;
            width: 350px;
            margin: 0 auto;
            padding: 10px 20px 20px;
        }

        .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus {
            color: #fff;
            background-color: #428bca !important;
            outline: 0;
        }

        .multiselect-container > li > a {
            text-decoration: none !important;
        }

        ul .active {
            border-bottom: none !important;
        }

        .dropdown-menu > a {
            text-decoration: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <cc1:ToolkitScriptManager CombineScripts="True" ID="scrmgr" runat="server" EnablePartialRendering="true"></cc1:ToolkitScriptManager>
    <asp:UpdatePanel ID="upUser" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="form-group">
                    <div id="divMessage" runat="server">
                    </div>
                </div>
                <div class="col-md-6">

                    <div class="col-md-8">
                        <div class="form-group">
                            <asp:HiddenField ID="hdUserID" runat="server" />
                            <label>First Name <span class="errorMessage">*</span></label>
                            <asp:TextBox ID="txtFirstName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVtxtFirstName" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtFirstName" Text="Required field"></asp:RequiredFieldValidator>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtFirstName" runat="server" TargetControlID="txtFirstName" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label>Last Name <span class="errorMessage">*</span></label>
                            <asp:TextBox ID="txtLastName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvtxtLastName" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtLastName" Text="Required field"></asp:RequiredFieldValidator>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtLastName" runat="server" TargetControlID="txtLastName" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label>Email Address <span class="errorMessage">*</span></label>
                            <asp:TextBox ID="txtEmailID" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvtxtEmailID" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtEmailID" Text="Required field"></asp:RequiredFieldValidator>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtEmailID" runat="server" TargetControlID="txtEmailID" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                            <asp:RegularExpressionValidator ID="REVtxtEmailID" runat="server"
                                ControlToValidate="txtEmailID" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true" ErrorMessage="Please Enter Valid Email ID."
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\s*$" ValidationGroup="u1"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label>Phone No.</label>
                            <asp:TextBox ID="txtPhoneNo" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtPhoneNo" runat="server" TargetControlID="txtPhoneNo" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div id="divEditPassword" runat="server">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label>Password <span class="errorMessage">*</span></label>
                                <asp:LinkButton ID="lbtnChangePassword" runat="server" CssClass="form-control" Text="Change Password"></asp:LinkButton>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div id="divAddPassword" runat="server">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label>Password <span class="errorMessage">*</span></label>
                                <asp:TextBox ID="txtPassword" runat="server" MaxLength="50" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <%--<asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtPassword" ID="revtxtPassword" ValidationExpression="^[\s\S]{0,5}$" ValidationGroup="u1" runat="server" ErrorMessage="Maximum 5 characters allowed."></asp:RegularExpressionValidator>--%>
                                <asp:RequiredFieldValidator ID="rfvtxtPassword" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                    CssClass="errorMessage" ControlToValidate="txtPassword" Text="Required field"></asp:RequiredFieldValidator>
                                <cc1:FilteredTextBoxExtender ID="ftbetxtPassword" runat="server" TargetControlID="txtPassword" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label>Role <span class="errorMessage">*</span></label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvddlRole" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="ddlRole" InitialValue="0" Text="Required field"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <label>Supplier</label>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlSuppliers" ClientIDMode="Static" runat="server" multiple="multiple" CssClass="multiselect"></asp:DropDownList>
                            <asp:HiddenField ID="hdnSuppliers" ClientIDMode="Static" runat="server" />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <label>Province</label>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlProvince" ClientIDMode="Static" runat="server" multiple="multiple" CssClass="multiselect"></asp:DropDownList>
                            <asp:HiddenField ID="hdnProvince" ClientIDMode="Static" runat="server" />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-8">
                        <label>Business Type</label>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlBusinessType" ClientIDMode="Static" runat="server" multiple="multiple" CssClass="multiselect"></asp:DropDownList>
                            <asp:HiddenField ID="hdnBusinessType" ClientIDMode="Static" runat="server" />
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <%--<div class="col-md-8">
                        <label>Brands</label>
                        <div class="form-group">
                            <asp:DropDownList ID="ddlBrand" ClientIDMode="Static" runat="server" multiple="multiple" CssClass="multiselect"></asp:DropDownList>
                            <asp:HiddenField ID="hdnBrand" ClientIDMode="Static" runat="server" />
                        </div>
                    </div>
                    <div class="clearfix"></div>--%>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Is Active? </label>
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-control" />
                        </div>
                    </div>

                    <div class="clearfix"></div>

                </div>
                <div class="clearfix"></div>
                <div class="col-md-4 col-sm-6  col-sm-offset-2 col-md-offset-8">
                    <div>
                        <div>
                            <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAdd_Click" ValidationGroup="u1" OnClientClick="return Validate();" />
                            <a id="aCancel" class="btn btn-primary" href="manage-user.aspx">Cancel</a>
                        </div>
                    </div>
                </div>
                <div>
                    <cc1:ModalPopupExtender ID="mpEditPassword" runat="server" PopupControlID="pnlEditPassword" TargetControlID="lbtnChangePassword"
                        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="pnlEditPassword" runat="server" CssClass="modalPopup" Style="display: none">
                        <div>
                            <h2>Change Password</h2>
                            <div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>New Password <span class="requiredStar">*</span></label>
                                            <asp:TextBox ID="txtPopupPassword" runat="server" CssClass="form-control" TextMode="Password">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFVtxtPopupPassword" Display="Dynamic" runat="server" ValidationGroup="pu1" SetFocusOnError="true" CssClass="errorMessage" ControlToValidate="txtPopupPassword" Text="Password is required"></asp:RequiredFieldValidator>
                                            <%-- <asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtPopupPassword" ID="revtxtPopupPassword" ValidationExpression="^[\s\S]{0,5}$" ValidationGroup="pu1" runat="server" ErrorMessage="Maximum 5 characters allowed."></asp:RegularExpressionValidator>--%>
                                        </div>
                                        <div class="form-group">
                                            <label>Confirm Password <span class="requiredStar">*</span></label>
                                            <asp:TextBox ID="txtPopupConfirmPassword" CssClass="form-control" runat="server" TextMode="Password">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFVtxtPopupConfirmPassword" Display="Dynamic" runat="server" ValidationGroup="pu1" SetFocusOnError="true" CssClass="errorMessage" ControlToValidate="txtPopupConfirmPassword" Text="Confirm Password is required"></asp:RequiredFieldValidator>
                                            <%--<asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="txtPopupConfirmPassword" ID="revtxtPopupConfirmPassword" ValidationGroup="pu1" ValidationExpression="^[\s\S]{0,5}$" runat="server" ErrorMessage="Maximum 5 characters allowed."></asp:RegularExpressionValidator>--%>
                                            <asp:CompareValidator ID="CVtxtPopupConfirmPassword" runat="server" ControlToCompare="txtPopupPassword"
                                                ControlToValidate="txtPopupConfirmPassword" CssClass="errorMessage" Display="Dynamic" ErrorMessage="The Confirm Password must match the Password."
                                                ValidationGroup="pu1"></asp:CompareValidator>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <asp:Button ID="btnChangePassword" CssClass="btn btn-primary" Text="Change Password" runat="server" ValidationGroup="pu1" CausesValidation="true" OnClick="btnChangePassword_Click" />
                                    <asp:Button ID="btnClose" CssClass="btn btn-primary" runat="server" Text="Close" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>

            <link href="dist/css/bootstrap-multiselect.css" rel="stylesheet" />
            <script src="dist/bootstrap-multiselect.js"></script>

        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        function pageLoad(sender, args) {
            $("#ddlSuppliers").multiselect(
                {
                    maxHeight: 200,
                    buttonWidth: 320,
                    includeSelectAllOption: true,
                    enableFiltering: true,
                    enableCaseInsensitiveFiltering: true,
                    onChange: function (option, checked) {
                        SelectSupplier();
                    },
                    onSelectAll: function () {
                        SelectSupplier();
                    },
                    onDeselectAll: function () {
                        SelectSupplier();
                    }
                }
            );

            function SelectSupplier() {
                var selected = [];
                $('#ddlSuppliers option:selected').each(function () {
                    selected.push([$(this).val(), $(this).data('order')]);
                });

                var text = '';
                for (var i = 0; i < selected.length; i++) {
                    text += selected[i][0] + ',';
                }
                text = text.substring(0, text.length - 1);

                $("#hdnSuppliers").val(text);

            }

            $("#ddlProvince").multiselect(
                {
                    maxHeight: 200,
                    buttonWidth: 320,
                    includeSelectAllOption: true,
                    enableFiltering: true,
                    enableCaseInsensitiveFiltering: true,
                    onChange: function (option, checked) {
                        SelectProvince();
                    },
                    onSelectAll: function () {
                        SelectProvince();
                    },
                    onDeselectAll: function () {
                        SelectProvince();
                    }
                }
            );

            function SelectProvince() {
                var selected = [];
                $('#ddlProvince option:selected').each(function () {
                    selected.push([$(this).val(), $(this).data('order')]);
                });

                var text = '';
                for (var i = 0; i < selected.length; i++) {
                    text += selected[i][0] + ',';
                }
                text = text.substring(0, text.length - 1);

                $("#hdnProvince").val(text);
            }

            $("#ddlBusinessType").multiselect(
                {
                    maxHeight: 200,
                    buttonWidth: 320,
                    onChange: function (option, checked) {
                        var selected = [];
                        $('#ddlBusinessType option:selected').each(function () {
                            selected.push([$(this).val(), $(this).data('order')]);
                        });

                        var text = '';
                        for (var i = 0; i < selected.length; i++) {
                            text += selected[i][0] + ',';
                        }
                        text = text.substring(0, text.length - 1);

                        $("#hdnBusinessType").val(text);
                    }
                }
            );



            //$("#ddlBrand").multiselect(
            //    {
            //        maxHeight: 200,
            //        buttonWidth: 320,
            //        onChange: function (option, checked) {
            //            var selected = [];
            //            $('#ddlBrand option:selected').each(function () {
            //                selected.push([$(this).val(), $(this).data('order')]);
            //            });

            //            var text = '';
            //            for (var i = 0; i < selected.length; i++) {
            //                text += selected[i][0] + ',';
            //            }
            //            text = text.substring(0, text.length - 1);

            //            $("#hdnBrand").val(text);
            //        }
            //    }
            //);

            var dataarray = $("#hdnProvince").val().split(",");
            $("#ddlProvince").val(dataarray);
            $("#ddlProvince").multiselect("refresh");

            dataarray = '';
            dataarray = $("#hdnSuppliers").val().split(",");
            //alert(dataarray);
            $("#ddlSuppliers").val(dataarray);
            $("#ddlSuppliers").multiselect("refresh");

            dataarray = '';
            dataarray = $("#hdnBusinessType").val().split(",");
            //alert(dataarray);
            $("#ddlBusinessType").val(dataarray);
            $("#ddlBusinessType").multiselect("refresh");

            //dataarray = '';
            //dataarray = $("#hdnBrand").val().split(",");
            ////alert(dataarray);
            //$("#ddlBrand").val(dataarray);
            //$("#ddlBrand").multiselect("refresh");
        }
    </script>
</asp:Content>

