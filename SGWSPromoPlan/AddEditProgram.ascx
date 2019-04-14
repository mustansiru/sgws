<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddEditProgram.ascx.cs" Inherits="AddEditProgram" %>

<!-- Include SmartWizard CSS -->
<link href="../dist/css/smart_wizard.css" rel="stylesheet" type="text/css" />
<%--<link rel="stylesheet" type="text/css" href="../lib/bootstrap/css/bootstrap4.min.css" />--%>
<!-- Optional SmartWizard theme -->
<link href="../dist/css/smart_wizard_theme_circles.css" rel="stylesheet" type="text/css" />
<link href="../dist/css/smart_wizard_theme_arrows.css" rel="stylesheet" type="text/css" />
<link href="../dist/css/smart_wizard_theme_dots.css" rel="stylesheet" type="text/css" />
<link href="../CalendarViewer/bootstrap-datetimepicker.min.css" rel="stylesheet" />
<link href="../css/chosen.min.css" rel="stylesheet" />

<!-- Include SmartWizard JavaScript source -->
<script type="text/javascript" src="../dist/js/jquery.smartWizard.min.js"></script>
<script src="../calendar/js/moment.latest.min.js"></script>
<script src="../CalendarViewer/bootstrap-datetimepicker.min.js"></script>
<script src="../js/chosen.jquery.min.js"></script>
<script type="text/javascript" src="js/CommonFunctions.js"></script>
<script type="text/javascript" src="js/program.js"></script>

<style>
    .modalAddEditProgram .modal-header .close {
        margin-top: -22px;
    }

    .modalAddEditProgram .modal-title {
        color: #fff;
    }

    .tooltip.top > .tooltip-arrow {
        background-color: #fff;
    }

    .modalAddEditProgram .tooltip {
        background-color: #fff !important;
    }

    /*.tooltip-qm {
  float: left;
  margin: -2px 0px 3px 4px;
  font-size: 12px;
}*/

    .modalAddEditProgram .btn.disabled {
        cursor: not-allowed !important;
        background-color: #eee;
        opacity: 1;
        pointer-events: auto;
    }

    #smartwizard {
        margin-top: 5px;
    }
</style>
<!-- Modal -->
<div class="modal fade modalAddEditProgram" id="modalAddEditProgram" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Add Program</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">X</span>
                </button>
            </div>
            <div class="modal-body">

                <!-- Smart Wizard HTML -->
                <a href="#step-1" id="aCampaignName"></a>
                <label id="lblarrowseparator"></label>
                <a href="#step-2" id="aProductName"></a>
                <div id="smartwizard">
                    <ul>
                        <li><a href="#step-1">Add Campaign<%--<br /><small>Step description</small>--%></a></li>
                        <li><a href="#step-2">Add Product<%--<br /><small>Step description</small>--%></a></li>
                        <li><a href="#step-3">Add Program Elements<%--<br /><small>Step description</small>--%></a></li>
                        <%--<li><a href="#step-4">Step Title<br />
                                <small>Step description</small></a></li>--%>
                    </ul>

                    <div>
                        <div id="step-1" class="">
                            <div class="col-md-6 nopadding">
                                <div class="form-group nopadding col-md-12">
                                    <div class="col-md-4">
                                        <label>Business Type <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="ddlBusinessType" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="ChangeLiquorByBusinessType();"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfv_ddlBusinessType" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                            ControlToValidate="ddlBusinessType" InitialValue="0" Text="Business Type is required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group nopadding col-md-12">
                                    <div class="col-md-4 nopadding-right">
                                        <label>Program Name <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtSuperProgramName" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="ShowDetails();"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfv_SuperProgramName" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                            CssClass="errorMessage" ControlToValidate="txtSuperProgramName" Text="Program Name is required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <%--<div class="clearfix"></div>--%>
                                <div class="form-group nopadding col-md-12">
                                    <div class="col-md-4">
                                        <label>Province <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="ddlProvince" runat="server" CssClass="form-control" ClientIDMode="Static"
                                            onchange="return ValidateDependentFields();">
                                        </asp:DropDownList>
                                        <%--GetLiquorBoardPeriod(1);--%>
                                        <asp:RequiredFieldValidator ID="rfv_ddlProvince" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                            ControlToValidate="ddlProvince" InitialValue="0" Text="Province is required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6 nopadding">
                                <div class="form-group nopadding col-md-12">
                                    <div class="col-md-4">
                                        <label>SGWS Year <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="ddlSGWSCalendarYear" runat="server" CssClass="form-control" ClientIDMode="Static"
                                            onchange="return GetLiquorBoardPeriod(0,1);">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfv_ddlSGWSCalendarYear" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                            ControlToValidate="ddlSGWSCalendarYear" InitialValue="0" Text="SGWS Calendar Year is required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <%--<div class="clearfix"></div>--%>
                                <div class="form-group nopadding col-md-12">
                                    <div class="col-md-4">
                                        <label>SGWS Period <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:DropDownList ID="ddlSGWSCalendarPeriod" runat="server" CssClass="form-control" ClientIDMode="Static"
                                            onchange="return GetLiquorBoardPeriod(0,1);">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                            CssClass="errorMessage" ControlToValidate="ddlSGWSCalendarPeriod" InitialValue="0"
                                            Text="SGWS Calendar Period is required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="form-group nopadding col-md-12">
                                    <div class="col-md-4">
                                        <label id="lblBoardPeriod">SGWS Board Period <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-8">
                                        <%--<asp:DropDownList ID="ddlLiquorBoardPeriod" runat="server" CssClass="form-control" onchange="GetStart_EndDate_ByLiquorBoardPeriod();"></asp:DropDownList>--%>
                                        <asp:TextBox ID="txtLiquorBoardPeriod" runat="server" CssClass="form-control" ClientIDMode="Static" ReadOnly="true"></asp:TextBox>
                                        <asp:HiddenField ID="hdn_ddlLiquorBoardPeriod" runat="server" ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="rfvBoardPeriod" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                            ControlToValidate="txtLiquorBoardPeriod" Text="SGWS Board Period is required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="form-group col-md-12 programdatesbox">
                                <fieldset>
                                    <legend>
                                        <asp:CheckBox ID="chkOverRideDate" runat="server" CssClass="OverRideDate" title="Change start and end date"
                                            ClientIDMode="Static" onchange="IsClearDates();" ToolTip="Change start and end date" />
                                    </legend>
                                    <div class="col-md-2">
                                        <label class="col-form-label">Start Date <span class="errorMessage">*</span> </label>
                                        <%--<input type="checkbox" id="chkOverRideDate" class="OverRideDate" />--%>
                                    </div>
                                    <div class="col-md-4">
                                        <div class='input-group date datepicker' id='datepickerEffective'>
                                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                                CssClass="errorMessage" ControlToValidate="txtStartDate" Text="Start Date is required"></asp:RequiredFieldValidator>
                                            </div>
                                    <%--</div>

                                <div class="form-group col-md-6 nopadding">--%>
                                    <div class="col-md-2">
                                        <label class="col-form-label">End Date <span class="errorMessage">*</span></label>
                                    </div>
                                    <div class="col-md-4">
                                        <div class='input-group date datepicker'>
                                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                        <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                                CssClass="errorMessage" ControlToValidate="txtEndDate" Text="End Date is required"></asp:RequiredFieldValidator>
                                            
                                    </div>
                                </fieldset>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div id="step-2" class="">
                            <div class="form-group col-md-6 nopadding">
                                <div class="col-md-4">
                                    <label>Supplier</label>
                                </div>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlSupplierName" CssClass="form-control" runat="server" ClientIDMode="Static"
                                        onchange="GetSupplier_Products_ByBrand(this);">
                                    </asp:DropDownList>
                                    <%--<asp:Label ID="lblSupplier" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>--%>
                                    <%-- <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" InitialValue="0"
                                        CssClass="errorMessage" ControlToValidate="ddlSupplierName" Text="Supplier is required"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="form-group col-md-6 nopadding">
                                <div class="col-md-4">
                                    <label>SKU/Brand <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlSKUSpecificOrBrandFamily" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                        ControlToValidate="ddlSKUSpecificOrBrandFamily" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group col-md-6 nopadding">
                                <div class="col-md-4 nopadding-right">
                                    <label>Brand</label>
                                </div>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlBrand" CssClass="form-control" runat="server" ClientIDMode="Static"
                                        onchange="GetProducts_BySupplier_Brand(this);">
                                    </asp:DropDownList>
                                    <%--<asp:Label ID="lblBrand" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>--%>
                                    <%--<asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                        CssClass="errorMessage" ControlToValidate="ddlBrand" Text="Brand is required" InitialValue="0"></asp:RequiredFieldValidator>--%>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="form-group col-md-6 nopadding">
                                <div class="col-md-4">
                                    <label>Product Name <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-8">
                                    <select id="ddlProducts_livesearch" class="livesearch form-control"></select>
                                    <select id="ddlProducts" class="form-control" style="display: none;"></select>
                                    <span class="errorMessage" id="spProductRequireMessage"></span>
                                    <%-- <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                    CssClass="errorMessage" ControlToValidate="ddlProducts_livesearch" Text="SGID is required"></asp:RequiredFieldValidator>
                                    <asp:DropDownList ID="ddlProductName" CssClass="form-control" runat="server" ClientIDMode="Static"
                                         style="display: none;"></asp:DropDownList>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                        CssClass="errorMessage" ControlToValidate="ddlProductName" Text="Product Name is required"
                                        InitialValue="0"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblProductName" runat="server" Text="-" CssClass="overflow-y-auto lblproductdetails form-control"
                                            readonly="true"></asp:Label>--%>
                                </div>
                            </div>
                            <div class="form-group col-md-6 nopadding">
                                <a onclick="return GetGID();" class="btn btn-primary"><i class='fa fa-search'></i></a>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-12 tableGIDResult table-responsive">
                                <table id="tblGIDResult" style="display: none;" class="table table-bordered table-striped dataTable no-footer display select">
                                    <thead>
                                        <tr>
                                            <th class="grid-heading width10 text-center">Select</th>
                                            <%--<th class="grid-heading text-left-imp">SGID</th>--%>
                                            <th class="grid-heading text-left-imp">Supplier</th>
                                            <th class="grid-heading text-left-imp">Brand</th>
                                            <th class="grid-heading text-left-imp">Product Name</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyGIDResult"></tbody>
                                </table>
                            </div>
                            <div class="clearfix"></div>
                            <%--   <div class="form-group">
                                <div class="col-md-2">
                                    <label>Category <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-4">
                                   <asp:Label ID="lblCategory" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2">
                                    <label>CSPC</label>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="lblCSPC" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                    <div class="col-md-2">
                                        <label>Product Description</label>
                                    </div>
                                    <div class="col-md-4">
                                        <asp:Label ID="lblProductDescription" runat="server" Text="-" CssClass="overflow-y-auto lblproductdetails form-control"
                                            readonly="true"></asp:Label>
                                    </div>
                                </div>--%>
                        </div>
                        <div id="step-3" class="">
                            <div class="panel-group" id="dvProgramListAccordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a href="#dvPopupProgramList" data-toggle="collapse">Programs</a>
                                        </h4>
                                    </div>
                                    <div id="dvPopupProgramList" class="col-md-12 form-group table-responsive nopadding panel-collapse collapse">
                                        <div class="panel-body">
                                            <table cellspacing="0" border="0" rules="all" class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                                                <thead>
                                                    <tr>
                                                        <th class="grid-heading text-center">Action</th>
                                                        <th class="grid-heading text-center">Program Type</th>
                                                        <th class="grid-heading text-center">Program</th>
                                                        <th class="grid-heading text-center">ATL/BTL</th>
                                                        <th class="grid-heading text-center">Comments</th>
                                                        <th class="grid-heading text-center">Planned Spend</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbodyPopupProgramsList"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="panel-group">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a href="#dvPopupProgramElements" data-toggle="collapse" onclick="AddFromProgramElements();">Add New Program</a>
                                        </h4>
                                    </div>
                                    <div id="dvPopupProgramElements" class="panel-collapse collapse ">
                                        <div class="panel-body">
                                            <div class="form-group col-md-6 nopadding">
                                                <div class="col-md-6 nopadding-right">
                                                    <label>Program Type Name <span class="errorMessage">*</span></label>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:TextBox ID="txtProgramName" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvtxtProgramName" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true"
                                                        CssClass="errorMessage" ControlToValidate="txtProgramName" Text="Field is required"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-6 nopadding">
                                                <div class="col-md-6">
                                                    <label>Program Element <span class="errorMessage">*</span></label>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlProgramType" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="return GetProgramCostFieldsByType(2);"></asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvddlProgramType" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                                        ControlToValidate="ddlProgramType" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-6 nopadding">
                                                <div class="col-md-6">
                                                    <label>ATL/BTL <span class="errorMessage">*</span></label>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlAboveTheLineOrBelowTheLine" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvddlATL_BTL" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                                        ControlToValidate="ddlAboveTheLineOrBelowTheLine" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-6 nopadding">
                                                <div class="col-md-6">
                                                    <label>Status <span class="errorMessage">*</span></label>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:DropDownList ID="ddlPopUpProgramStatus" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvddlProgramStatus" Display="Dynamic" runat="server" ValidationGroup="valProgramWizard" SetFocusOnError="true" CssClass="errorMessage"
                                                        ControlToValidate="ddlPopUpProgramStatus" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="form-group col-md-12 nopadding">
                                                <div class="col-md-6 commentlabel">
                                                    <label>Comments</label>
                                                </div>
                                                <div class="col-md-6 commentinput">
                                                    <asp:TextBox ID="txtComment" runat="server" CssClass="form-control" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div id="dvOtherFields" class="nopadding">
                                                <div class="form-group col-md-6 nopadding" id="dvDepth">
                                                    <div class="col-md-6">
                                                        <label>Depth per Unit</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtDepthLTOorBAM" runat="server" data-float="true" autocomplete="false" ClientIDMode="Static"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" onchange="CalculateVariableCost();"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvPercentRedemption">
                                                    <div class="col-md-6">
                                                        <label>% Redemption</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtPercentRedemptionRateforBAMonly" runat="server" data-float="true" autocomplete="false"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" onchange="CalculateVariableCost();"
                                                            ClientIDMode="Static"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvVariableCost">
                                                    <div class="col-md-6">
                                                        <label>Variable Cost</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtVariableCostPerCase" runat="server" data-float="true" ClientIDMode="Static" ReadOnly="true"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvOtherFixedCostorFee">
                                                    <div class="col-md-6">
                                                        <label id="lblOtherCost">Other Fixed Cost/Fee</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtOtherFixedCostorFee" runat="server" data-float="true" autocomplete="false"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" ClientIDMode="Static"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvQuantityofSpend">
                                                    <div class="col-md-6">
                                                        <label id="lblQuantity">Quantity Of Spend</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtQuantityofSpend" runat="server" data-float="true" ClientIDMode="Static"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvUpFrontFees">
                                                    <div class="col-md-6">
                                                        <label id="lblUpfrontFees">UpFront Fees</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtUpFrontFeesforLTOorBAM" runat="server" data-float="true" ClientIDMode="Static"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                                    </div>
                                                </div>
                                                
                                            </div>

                                            <div id="dvForecastFields" class="nopadding">
                                                <div class="form-group col-md-6 nopadding" id="dvForecastCaseSalesBase">
                                                    <div class="col-md-6">
                                                        <label>Forecast Case Sales (base)</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtForecastCaseSalesBase" runat="server" data-float="true"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" ClientIDMode="Static"
                                                            autocomplete="false" onchange="CalculateForecastTotalCaseSalesPhyCs();"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvForecastCaseSalesLift">
                                                    <div class="col-md-6">
                                                        <label>Forecast Case Sales (lift)</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtForecastCaseSalesLift" runat="server" data-float="true"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" ClientIDMode="Static"
                                                            autocomplete="false" onchange="CalculateForecastTotalCaseSalesPhyCs();"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-6 nopadding" id="dvForecastTotalCaseSalesPhysCs">
                                                    <div class="col-md-6">
                                                        <label>Forecast Total Sales (Phys)</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtForecastTotalCaseSalesPhysCs" runat="server" data-float="true" ClientIDMode="Static"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6 nopadding" id="dvForecastTotalCaseSales9L">
                                                    <div class="col-md-6 nopadding-right">
                                                        <label>Forecast Total Sales (9L)</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtForecastTotalCaseSales9LCsConverted" runat="server" data-float="true" ClientIDMode="Static"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group col-md-6 nopadding" id="dvSpendperQuantity">
                                                    <div class="col-md-6">
                                                        <label id="lblSpendPerQuantity">Spend per quantity</label>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <asp:TextBox ID="txtSpendperQuantity" runat="server" data-float="true" autocomplete="false"
                                                            CssClass="form-control text-right calculateTotalProgramSpend" ClientIDMode="Static"></asp:TextBox>
                                                    </div>
                                                </div>


                                            <div class="clearfix"></div>
                                            <hr />
                                            <div class="form-group col-md-12 nopadding" id="dvTotalProgramSpend">
                                                <div class="col-md-6"></div>
                                                <div class="col-md-4 col-sm-6">
                                                    <label>Total Program Spend </label>
                                                </div>
                                                <div class="col-md-2 text-right col-sm-6">
                                                    <a href="javascript:void(0);" data-toggle="tooltip" id="aTotalProgramSpend" class="TotalProgramSpend_ToolTip"
                                                        onmouseover="TotalProgramSpend_ToolTip();" onfocus="TotalProgramSpend_ToolTip();">
                                                        <asp:Label ID="lblTotalProgramSpend" runat="server" Text="-" ClientIDMode="Static"></asp:Label>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <%-- <div class="modal-footer">
                    <div class="col-md-12 text-right margintop-20">
                        <asp:Button ID="btnSaveAll" runat="server" Text="Save" CssClass="btn btn-primary"
                            ValidationGroup="valProgramWizard" OnClientClick="return Validate('valProgramWizard');" />
                        <%--<a class="btn btn-default btnback" href="ManageProgram.aspx">BACK</a>- -%>
                    </div>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>--%>
    </div>
</div>


<div id="dvMessagePopup" style="display: none; top: 30px;" class="modal modal-fade in">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background: #71777d; color: #fff;">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="font-size: 13px;">Message</h4>
            </div>
            <div class="modal-body">
                <div id="dvMsg" class="errorMessage"></div>
            </div>
        </div>
    </div>
</div>

<div id="dvConfirmationPopup" style="display: none; top: 30px;" class="modal modal-fade in">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background: #71777d; color: #fff;">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="font-size: 13px;">Confirmation</h4>
            </div>
            <div class="modal-body">
                <div id="dvConfirmationMsg"></div>
                <div class="text-right">
                    <button id="btnYes" type="button" class="btn btn-primary">Yes</button>
                    <button id="btnNo" type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">No</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function () {
        $("#<%=PopupOpener%>").click(function () {
            ShowProgramWizard(true);
            //$("#modalAddEditProgram").modal('show');
            EnableDisableProvinceDependents(true);
            ClearProgramDetails();
            ClearProductDetails();
            GotoStep(0);
            return false;
        });
        $('.datepicker').datetimepicker({
            widgetPositioning: {
                horizontal: 'right',
                vertical: 'bottom'
            },
            useCurrent: false,
            allowInputToggle: true,
            format: 'MM/DD/YYYY'
        }).on('dp.change', function (e) {
            CheckRequiredField();
        });
        $(".livesearch").chosen({
            disable_search_threshold: 0,
            search_contains: true
        }).change(function () {
            var gid = $(this).val();
            GetProductDetailsByGID(gid);
        });

        //TotalProgramSpend_ToolTip();
    });
    function ShowProgramWizard(flag) {
        $("#modalAddEditProgram").modal({
            backdrop: "static",
            keyboard: "false",
            show: flag
        });
    }
</script>
<script type="text/javascript">
    $(document).ready(function () {

        // Toolbar extra buttons
        var btnFinish = $('<button></button>').text('Finish')
                                         .addClass('btn btn-info')
                                         .on('click', function () { return Validate('valProgramWizard'); });
        var btnCancel = $('<button></button>').text('Cancel')
                                         .addClass('btn btn-danger')
                                         .on('click', function () { return CancelWizard(); });//$('#smartwizard').smartWizard("reset");
        var btnClose = $('<button></button>').text('Close')
                                         .addClass('btn btn-danger').attr('data-dismiss="modal"');

        // Smart Wizard 1
        $('#smartwizard').smartWizard({
            //selected: 0,
            theme: 'arrows',
            transitionEffect: 'fade',
            showStepURLhash: false,

            toolbarSettings: {
                toolbarPosition: 'both',
                toolbarButtonPosition: 'right',
                toolbarExtraButtons: [btnFinish, btnCancel]
            }
        });

        $('.sw-btn-group-extra').hide();
        // Step show event
        $("#smartwizard").on("showStep", function (e, anchorObject, stepNumber, stepDirection, stepPosition) {
            //alert("You are on step "+stepNumber+" now");
            if (stepPosition === 'first') {
                $("#prev-btn").addClass('disabled');
                $('.sw-btn-group-extra').hide();
            } else if (stepPosition === 'final') {
                $("#next-btn").addClass('disabled');
                $('.sw-btn-group-extra').show();
            } else {
                $("#prev-btn").removeClass('disabled');
                $("#next-btn").removeClass('disabled');
                $('.sw-btn-group-extra').hide();
            }
        });
        $('#modalAddEditProgram').on('hidden.bs.modal', function () {
            $("#modalAddEditProgram .errorMessage").hide();
        });
    });

    function GotoStep(stepno) {
        // $('#smartwizard').smartWizard('selected', no);//
        $('#smartwizard').smartWizard('goToStep', stepno);
        if (stepno == 1) {
            $("a[href='#step-1']").parent("li.nav-item").addClass("done");
        }
        else if (stepno == 2) {
            $("a[href='#step-2']").parent("li.nav-item").addClass("done");
        }
        else {
            $("a[href='#step-1']").parent("li.nav-item").removeClass("done");
            $("a[href='#step-2']").parent("li.nav-item").removeClass("done");
        }
    }
    function ResetProgramWizard() {
        $('#smartwizard').smartWizard("reset");
    }
</script>
