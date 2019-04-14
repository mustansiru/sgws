<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="change-password.aspx.cs" Inherits="adminsection_change_password" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <div id="divMessage" runat="server">
                    </div>
                </div>
                <div class="form-group">
                    <label>Old Password<span class="requiredStar">*</span></label>
                    <asp:TextBox ID="txtOldPassword" CssClass="form-control" runat="server" MaxLength="50" TextMode="Password">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVtxtOldPassword" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true" CssClass="errorMessage" ControlToValidate="txtOldPassword" Text="Old Password is required"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label>New Password<span class="requiredStar">*</span></label>
                    <asp:TextBox ID="txtNewPassword" CssClass="form-control" runat="server" MaxLength="50" TextMode="Password">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVtxtNewPassword" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true" CssClass="errorMessage" ControlToValidate="txtNewPassword" Text="New Password is required"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <label>Confirm New Password<span class="requiredStar">*</span></label>
                    <asp:TextBox ID="txtConfirmPassword" CssClass="form-control" runat="server" MaxLength="50" TextMode="Password">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVtxtConfirmPassword" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true" CssClass="errorMessage" ControlToValidate="txtConfirmPassword" Text="New Password is required"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CVtxtPopupConfirmPassword" runat="server" ControlToCompare="txtNewPassword"
                        ControlToValidate="txtConfirmPassword" CssClass="errorMessage" Display="Dynamic" ErrorMessage="The Confirm Password must match the Password."
                        ValidationGroup="u1"></asp:CompareValidator>
                </div>
                <div>
                    <asp:Button ID="btnChangePassword" CssClass="btn btn-primary" runat="server" Text="Change Password" OnClientClick="return Validate();" OnClick="btnChangePassword_Click" ValidationGroup="u1" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

