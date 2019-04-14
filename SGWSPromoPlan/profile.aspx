<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="adminsection_profile" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <cc1:ToolkitScriptManager  CombineScripts="True" ID="scrmgr" runat="server" EnablePartialRendering="true"></cc1:ToolkitScriptManager>
    <asp:UpdatePanel ID="upUser" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <div id="divMessage" runat="server">
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Email Address </label>
                            <asp:Label ID="lblEmailID" runat="server" MaxLength="100" disabled="disabled" CssClass="form-control"></asp:Label>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>First Name <span class="errorMessage">*</span></label>
                            <asp:TextBox ID="txtFirstName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVtxtFirstName" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtFirstName" Text="Required field"></asp:RequiredFieldValidator>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtFirstName" runat="server" TargetControlID="txtFirstName" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Last Name <span class="errorMessage">*</span></label>
                            <asp:TextBox ID="txtLastName" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvtxtLastName" Display="Dynamic" runat="server" ValidationGroup="u1" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtLastName" Text="Required field"></asp:RequiredFieldValidator>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtLastName" runat="server" TargetControlID="txtLastName" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Phone No.</label>
                            <asp:TextBox ID="txtPhoneNo" runat="server" MaxLength="50" CssClass="form-control"></asp:TextBox>
                            <cc1:FilteredTextBoxExtender ID="ftbetxtPhoneNo" runat="server" TargetControlID="txtPhoneNo" FilterMode="InvalidChars" InvalidChars="</>"></cc1:FilteredTextBoxExtender>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-12">
                        <div>
                            <div>
                                <asp:Button ID="btnAdd" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnAdd_Click" ValidationGroup="u1" OnClientClick="return Validate();" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

