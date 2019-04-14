<%@ Page Title="Add Program" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="program.aspx.cs"
    Inherits="program" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../calendar/js/moment.latest.min.js"></script>
    <script src="../CalendarViewer/bootstrap-datetimepicker.min.js"></script>
    <link href="../CalendarViewer/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    
    <link href="stylesheets/jquery.tables.css" rel="stylesheet" />
    <script src="js/jquery.dataTables.min.js"></script>
    <style>
        .dataTables_scrollBody, .dataTables_scrollHeadInner, .dataTables_scrollBody table {
            width: 100% !important;
        }
        .tableGIDResult table.dataTable>tbody{font-size:1em;}
        .tableGIDResult table {border: 1px solid #ddd;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <cc1:ToolkitScriptManager CombineScripts="True" runat="server" EnablePartialRendering="true"></cc1:ToolkitScriptManager>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <div id="divMessage" runat="server">
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="col-md-12">
                <div class="text-right">
                    <a class="btn btn-default btnback" href="ManageProgram.aspx">BACK</a>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="col-md-6 nopadding">
                <fieldset>
                    <legend>Program:</legend>
                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Program Name <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtSuperProgramName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtSuperProgramName" Text="Program Name is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Business Type <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlBusinessType" runat="server" CssClass="form-control" onchange="ChangeLiquorByBusinessType();"></asp:DropDownList>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true" CssClass="errorMessage"
                                ControlToValidate="ddlBusinessType" InitialValue="0" Text="Business Type is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Province <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlProvince" runat="server" CssClass="form-control" onchange="return ValidateDependentFields();"></asp:DropDownList> <%--GetLiquorBoardPeriod(1);--%>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true" CssClass="errorMessage"
                                ControlToValidate="ddlProvince" InitialValue="0" Text="Province is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>SGWS Year <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlSGWSCalendarYear" runat="server" CssClass="form-control" onchange="return GetLiquorBoardPeriod(0,1);"></asp:DropDownList>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true" CssClass="errorMessage"
                                ControlToValidate="ddlSGWSCalendarYear" InitialValue="0" Text="SGWS Calendar Year is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>SGWS Period <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlSGWSCalendarPeriod" runat="server" CssClass="form-control" onchange="return GetLiquorBoardPeriod(0,1);"></asp:DropDownList>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true" 
                                CssClass="errorMessage" ControlToValidate="ddlSGWSCalendarPeriod" InitialValue="0" 
                                Text="SGWS Calendar Period is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label id="lblBoardPeriod">Liquor Board Period <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <%--<asp:DropDownList ID="ddlLiquorBoardPeriod" runat="server" CssClass="form-control" onchange="GetStart_EndDate_ByLiquorBoardPeriod();"></asp:DropDownList>--%>
                            <asp:TextBox ID="txtLiquorBoardPeriod" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:HiddenField ID="hdn_ddlLiquorBoardPeriod" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvBoardPeriod" Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true" CssClass="errorMessage"
                                ControlToValidate="txtLiquorBoardPeriod" Text="Liquor Board Period is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Start Date <span class="errorMessage">*</span> </label>
                            <%--<input type="checkbox" id="chkOverRideDate" class="OverRideDate" />--%>
                            <asp:CheckBox ID="chkOverRideDate" runat="server" CssClass="OverRideDate" title="Change start and end date"/>
                        </div>
                        <div class="col-md-8">
                            <div class='input-group date datepicker' id='datepickerEffective'>
                                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true"
                                    CssClass="errorMessage" ControlToValidate="txtStartDate" Text="Start Date is required"></asp:RequiredFieldValidator>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>End Date <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <div class='input-group date datepicker'>
                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true"
                                    CssClass="errorMessage" ControlToValidate="txtEndDate" Text="End Date is required"></asp:RequiredFieldValidator>
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>SKU/Brand <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:DropDownList ID="ddlSKUSpecificOrBrandFamily" runat="server" CssClass="form-control"></asp:DropDownList>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true" CssClass="errorMessage"
                                ControlToValidate="ddlSKUSpecificOrBrandFamily" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                </fieldset>
            </div>

            <div class="col-md-6 nopadding">
                <fieldset>
                    <legend>Product Details:</legend>
                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Product Id (SGID) <span class="errorMessage">*</span></label>
                        </div>
                        <div class="col-md-8">
                            <asp:TextBox ID="txtGID" runat="server" CssClass="form-control"></asp:TextBox>
                            <i class='fa fa-search searchgid btn btn-primary' data-toggle="modal" data-target="#dvGIDPopup"></i>
                            <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgram" SetFocusOnError="true"
                                CssClass="errorMessage" ControlToValidate="txtGID" Text="SGID is required"></asp:RequiredFieldValidator>

                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Category</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblCategory" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Supplier</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblSupplier" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Brand</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblBrand" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>CSPC</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblCSPC" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Product Description</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblProductDescription" runat="server" Text="-" CssClass="overflow-y-auto lblproductdetails form-control"
                                readonly="true"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Size</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblSize" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Units per pack</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblUnitsPerPk" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <div class="col-md-4">
                            <label>Units</label>
                        </div>
                        <div class="col-md-8">
                            <asp:Label ID="lblUnits" runat="server" Text="-" readonly="true" CssClass="lblproductdetails form-control"></asp:Label>
                        </div>
                    </div>
                </fieldset>
            </div>

        </div>

        <div class="col-md-12">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <fieldset>
                        <legend>Types of Program</legend>
                        <div class="text-right">
                            <div class="col-md-12">
                                <%--<input type="button" id="btnAdd" value="Add" data-toggle="modal" data-target="#dvAddEditProgramPopup" 
                                class="btn btn-primary" onclick="ClearProgramDetails();"  />--%>
                                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-primary" data-toggle="modal"
                                    ValidationGroup="valProgram" OnClientClick="return ShowAddProgramPopup();" />
                                <%--   OnClick="btnAdd_Click" />--%>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="spacer10px"></div>
                        <div class="col-md-12">
                            <table id="tblPrograms" cellspacing="0" border="0" rules="all" class="table table-bordered table-striped dataTable no-footer display select" role="grid">
                                <thead>
                                    <%--<tr>
                                    <th class="grid-heading" rowspan="1" colspan="6">Types of Program</th>
                                </tr>--%>
                                    <tr>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Action</th>
                                        <th class="grid-heading" rowspan="1" colspan="1">Program Type Name</th>
                                        <th class="grid-heading" rowspan="1" colspan="1">Type</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">ATL/BTL</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Status</th>
                                        <th class="grid-heading" rowspan="1" colspan="1">Comments</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Depth per Unit</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Forecast Case Sales (base)</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Forecast Case Sales (lift)</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Forecast Total Sales (Phys)</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Forecast Total Sales (9L)</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Variable Cost</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">UpFront Fees</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">% Redemption</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Quantity of spend</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Spend per quantity</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Other Fixed Cost/Fee</th>
                                        <th class="grid-heading text-center" rowspan="1" colspan="1">Total Program Spend</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyPrograms" runat="server">
                                    <asp:Repeater ID="rptPrograms" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="text-center width3">
                                                    <a href="javascript:void(0);" onclick='return GetProgramDetailsByProgramId("<%# Eval("ProgramId") %>")'>
                                                        <i class="fa fa-pencil"></i></a>
                                                    <%-- <asp:LinkButton ID="lnkEditProgram" runat="server" Text="<i class='fa fa-pencil'></i>" CommandName="Edit"
                                                    CommandArgument='<%# Eval("ProgramId") %>' OnClick="lnkEditProgram_Click"></asp:LinkButton>--%>
                                                </td>
                                                <td class=" width15"><%# Eval("ProgramTypeName") %></td>
                                                <td class=" width15"><%# Eval("ProgramType") %></td>
                                                <td class="text-center width5"><%# Eval("ATL_BTL") %></td>
                                                <td class="text-center width10"><%# Eval("ProgramStatus") %></td>
                                                <td><%# Eval("Comment") %></td>
                                                <td class="text-center width5"><%# Eval("Depth") %></td>
                                                <td class="text-center width5"><%# Eval("ForecastCaseSalesBase") %></td>
                                                <td class="text-center width5"><%# Eval("ForecastCaseSalesLift") %></td>
                                                <td class="text-center width5"><%# Eval("ForecastTotalCaseSalesPhysCs") %></td>
                                                <td class="text-center width5"><%# Eval("ForecastTotalCaseSales9LCsConverted") %></td>
                                                <td class="text-center width5"><%# Eval("VariableCostPerCase") %></td>
                                                <td class="text-center width5"><%# Eval("UpforntFees_LTO_BAM") %></td>
                                                <td class="text-center width5"><%# Eval("RedemptionBAM") %></td>
                                                <td class="text-center width5"><%# Eval("SpendQuantity") %></td>
                                                <td class="text-center width5"><%# Eval("SpendPerQuantity") %></td>
                                                <td class="text-center width5"><%# Eval("OtherFixedCost") %></td>
                                                <td class="text-center width5"><%# Eval("TotalProgramSpend") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    
                                </tbody>
                            </table>
                        </div>
                        <div class="clearfix"></div>
                        <div class="spacer20px"></div>
                    </fieldset>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="clearfix"></div>
        <div class="col-md-12 text-right margintop-20">
            <asp:Button ID="btnSaveAll" runat="server" Text="Save" CssClass="btn btn-primary"
                ValidationGroup="valProgram" OnClientClick="return Validate();" />
            <a class="btn btn-default btnback" href="ManageProgram.aspx">BACK</a>
        </div>
    </div>

    <div id="dvAddEditProgramPopup" style="display: none; top: 30px;" class="modal modal-fade in">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background: #71777d; color: #fff;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" style="font-size: 13px;">Add Program</h4>
                </div>
                <div class="modal-body modalbody_extra">
                    <div class="table-responsive" style="overflow: hidden">
                        <div class="col-md-6 nopadding">
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Program Type Name <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtProgramName" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramDetails" SetFocusOnError="true"
                                        CssClass="errorMessage" ControlToValidate="txtProgramName" Text="Field is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Program Type <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlProgramType" runat="server" CssClass="form-control" onchange="return GetProgramCostFieldsByType(2);"></asp:DropDownList>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramDetails" SetFocusOnError="true" CssClass="errorMessage"
                                        ControlToValidate="ddlProgramType" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>ATL/BTL <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlAboveTheLineOrBelowTheLine" runat="server" CssClass="form-control"></asp:DropDownList>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramDetails" SetFocusOnError="true" CssClass="errorMessage"
                                        ControlToValidate="ddlAboveTheLineOrBelowTheLine" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Status <span class="errorMessage">*</span></label>
                                </div>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlProgramStatus" runat="server" CssClass="form-control"></asp:DropDownList>
                                    <asp:RequiredFieldValidator Display="Dynamic" runat="server" ValidationGroup="valProgramDetails" SetFocusOnError="true" CssClass="errorMessage"
                                        ControlToValidate="ddlProgramStatus" InitialValue="0" Text="Field is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Depth per Unit</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtDepthLTOorBAM" runat="server" data-float="true" autocomplete="false"
                                        CssClass="form-control text-right calculateTotalProgramSpend" onchange="CalculateVariableCost();"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Forecast Case Sales (base)</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtForecastCaseSalesBase" runat="server" data-float="true" CssClass="form-control text-right calculateTotalProgramSpend" 
                                        autocomplete="false" onchange="CalculateForecastTotalCaseSalesPhyCs();"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Forecast Case Sales (lift)</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtForecastCaseSalesLift" runat="server" data-float="true" CssClass="form-control text-right calculateTotalProgramSpend" 
                                        autocomplete="false" onchange="CalculateForecastTotalCaseSalesPhyCs();"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Forecast Total Sales (Phys)</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtForecastTotalCaseSalesPhysCs" runat="server" data-float="true" 
                                        CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 nopadding">

                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Forecast Total Sales (9L)</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtForecastTotalCaseSales9LCsConverted" runat="server" data-float="true" 
                                        CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Variable Cost</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtVariableCostPerCase" runat="server" data-float="true" 
                                        CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>UpFront Fees</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtUpFrontFeesforLTOorBAM" runat="server" data-float="true" 
                                        CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>% Redemption</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtPercentRedemptionRateforBAMonly" runat="server" data-float="true" autocomplete="false" 
                                        CssClass="form-control text-right calculateTotalProgramSpend" onchange="CalculateVariableCost();"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Quantity of spend</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtQuantityofSpend" runat="server" data-float="true" 
                                        CssClass="form-control text-right calculateTotalProgramSpend" autocomplete="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Spend per quantity</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtSpendperQuantity" runat="server" data-float="true" autocomplete="false"
                                        CssClass="form-control text-right calculateTotalProgramSpend"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Other Fixed Cost/Fee</label>
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="txtOtherFixedCostorFee" runat="server" data-float="true" autocomplete="false"
                                        CssClass="form-control text-right calculateTotalProgramSpend"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group clearfix">
                                <div class="col-md-6">
                                    <label>Total Program Spend </label>
                                </div>
                                <div class="col-md-6 text-right">
                                    <asp:Label ID="lblTotalProgramSpend" runat="server" Text="-"></asp:Label>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-12 nopadding">
                            <div class="form-group clearfix">
                                <div class="col-md-3">
                                    <label>Comments</label>
                                </div>
                                <div class="col-md-9">
                                    <asp:TextBox ID="txtComment" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 text-right">
                            <asp:Button ID="btnSaveProgram" runat="server" Text="Save" CssClass="btn btn-primary"
                                ValidationGroup="valProgramDetails" OnClientClick="return SaveProgram();" />
                            <a class="btn btn-default btnback" data-dismiss="modal" aria-label="Close">Cancel</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="dvGIDPopup" style="display: none; top: 30px;" class="modal modal-fade in">
        <div class="modal-dialog" role="document" style="width: 70%">
            <div class="modal-content">
                <div class="modal-header" style="background: #71777d; color: #fff;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" style="font-size: 13px;">Search SGID</h4>
                </div>
                <div class="modal-body modalbody_extra">
                    <div class="table-responsive" style="overflow: hidden">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Supplier Name </label>
                                <asp:DropDownList ID="ddlSupplierName" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Brand </label>
                                <asp:DropDownList ID="ddlBrand" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>SGID </label>
                                <asp:DropDownList ID="ddlSGID" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Product name </label>
                                <asp:TextBox ID="txtProductName" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-group">
                                <%--<input type="button" id="btnSearchGID" value="" class="btn btn-primary" onclick="return GetGID();" />--%>
                                <a onclick="return GetGID();" style="margin-top: 23px;" class="btn btn-primary"><i class='fa fa-search'></i></a>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <%--<input type="button" id="btnSearchGID" value="" class="btn btn-primary" onclick="return GetGID();" />--%>
                                <a onclick="return GetGID_Details();" class="btn btn-primary">Select</a>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-md-12 tableGIDResult table-responsive nopadding">
                            <table id="tblGIDResult" style="display: none;" class="table table-bordered table-striped dataTable no-footer display select">
                                <thead>
                                    <tr>
                                        <th class="grid-heading width10 text-center">Select</th>
                                        <th class="grid-heading text-left-imp">SGID</th>
                                        <th class="grid-heading text-left-imp">Supplier</th>
                                        <th class="grid-heading text-left-imp">Brand</th>
                                        <th class="grid-heading text-left-imp">Product Name</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyGIDResult"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <div id="dvMessagePopup" style="display: none; top: 30px;" class="modal modal-fade in">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background: #71777d; color: #fff;">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" style="font-size: 13px;">Message</h4>
                </div>
                <div class="modal-body modalbody_extra">
                    <div id="dvMsg" class="errorMessage"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var isDateOverride=false;
        $('.datepicker').datetimepicker({
            widgetPositioning: {
                horizontal: 'right',
                vertical: 'bottom'
            },
            useCurrent: false,
            allowInputToggle: true,
            format: 'MM/DD/YYYY'
        }).on('dp.change', function (e) {
            isDateOverride=true;
            CheckRequiredField();
        });

        
        function CheckRequiredField(){
            var ProvinceId = parseInt($("#<%= ddlProvince.ClientID %>").val());
            $("#dvMsg").html("");
            if(ProvinceId ==0){
                $("#<%= txtStartDate.ClientID %>").val('');
                $("#<%= txtEndDate.ClientID %>").val('');
                ShowMessagePopup("Please select province first.");
            }
            if($("#<%= txtLiquorBoardPeriod.ClientID %>").val() == ''){
                $("#<%= txtStartDate.ClientID %>").val('');
                $("#<%= txtEndDate.ClientID %>").val('');
                $("#dvMessagePopup").modal('show');
                if($("#dvMsg").html()){
                    $("#dvMsg").append("<br/>Liquor Board Period should not be empty.");
                }else{
                    $("#dvMsg").html("Liquor Board Period should not be empty.");
                }
            }
        }

        function ShowMessagePopup(message){
            $("#dvMessagePopup").modal('show');
            $("#dvMsg").html(message);
        }

        function ValidateDependentFields(){
            var ProvinceId = parseInt($("#<%= ddlProvince.ClientID %>").val());
            if(ProvinceId ==0){
                $("#<%= txtStartDate.ClientID %>").val('');
                $("#<%= txtEndDate.ClientID %>").val('');
                $("#<%= txtLiquorBoardPeriod.ClientID %>").val('');
                 $("#<%= hdn_ddlLiquorBoardPeriod.ClientID %>").val('');
                $("#<%= ddlSGWSCalendarYear.ClientID %>").val('0');
                $("#<%= ddlSGWSCalendarPeriod.ClientID %>").val('0');
            }else{
                GetLiquorBoardPeriod(0,1);
            }
        }

        function ShowAddProgramPopup() {
            if (Page_ClientValidate("valProgram")) {
                ClearProgramDetails();
                $("#dvAddEditProgramPopup").modal('show');
                return false;
            }
            else {
                return false;
            }
        }
        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = window.location.search.substring(1),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
                }
            }
        };

        function ClearProgramDetails() {
            _programId = 0;
            $("#<%= ddlProgramType.ClientID %>").val("0");
            $("#<%= ddlAboveTheLineOrBelowTheLine.ClientID %>").val("0");
            $("#<%= ddlProgramStatus.ClientID %>").val("3");
            $("#<%= ddlProgramStatus.ClientID %>").prop("disabled",true);
            $("#<%= txtProgramName.ClientID %>").val("");
            $("#<%= txtComment.ClientID %>").val("");
            $("#<%= txtDepthLTOorBAM.ClientID %>").val("");
            $("#<%= txtForecastCaseSalesBase.ClientID %>").val("");
            $("#<%= txtForecastCaseSalesLift.ClientID %>").val("");
            $("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val("");
            $("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val("");
            $("#<%= txtVariableCostPerCase.ClientID %>").val("");
            $("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val("");
            $("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val("");
            $("#<%= txtQuantityofSpend.ClientID %>").val("");
            $("#<%= txtSpendperQuantity.ClientID %>").val("");
            $("#<%= txtOtherFixedCostorFee.ClientID %>").val("");
            $("#<%= lblTotalProgramSpend.ClientID %>").text("-");
        }

        function Validate() {
            if (Page_ClientValidate("valProgram")) {
                SaveSuperProgram();
                return false;
            }
            else {
                return false;
            }
        }

        function GetLiquorBoardPeriod(flag,action) {
            var sgwsYear = $("#<%= ddlSGWSCalendarYear.ClientID %>").val();
            var sgwsPeriod = $("#<%= ddlSGWSCalendarPeriod.ClientID %>").val();
            var ProvinceId = parseInt($("#<%= ddlProvince.ClientID %>").val());
            if(action ==1){
                $("#<%= chkOverRideDate.ClientID %>").prop("checked",false);
            }
            if(ProvinceId > 0){
                if (sgwsYear > 0 && sgwsPeriod != '0') {
                    $.ajax({
                        method: "GET",
                        url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/GetLiquorBoardPeriod?sgwsYear=" + sgwsYear + "&sgwsPeriod="+sgwsPeriod+"&ProvinceId=" + ProvinceId,
                        processData: false,
                        success: function (data) {
                            if (data != null && data[0] != null) {
                                $("#<%= txtLiquorBoardPeriod.ClientID %>").val(data[0].Period);
                                $("#<%= hdn_ddlLiquorBoardPeriod.ClientID %>").val(data[0].FiscalYearByLiquorBoardId);

                                if(!$("#<%= chkOverRideDate.ClientID %>").is(":checked") && action!=2){
                                    $("#<%= txtStartDate.ClientID %>").val(data[0].StartDate);
                                    $("#<%= txtEndDate.ClientID %>").val(data[0].EndDate);
                                }
                               
                            }else{
                                 $("#<%= txtStartDate.ClientID %>").val('');
                                 $("#<%= txtEndDate.ClientID %>").val('');
                                 $("#<%= txtLiquorBoardPeriod.ClientID %>").val('');
                                 $("#<%= hdn_ddlLiquorBoardPeriod.ClientID %>").val('');
                            }
                        }
                    });
                }
            }
            else{
                $("#<%= ddlSGWSCalendarYear.ClientID %>").val('0');
                $("#<%= ddlSGWSCalendarPeriod.ClientID %>").val('0');
                $("#<%= txtStartDate.ClientID %>").val('');
                $("#<%= txtEndDate.ClientID %>").val('');
                $("#<%= txtLiquorBoardPeriod.ClientID %>").val(''); 
                $("#<%= hdn_ddlLiquorBoardPeriod.ClientID %>").val('');
                ShowMessagePopup("Please select province first.");
            }
            GetBAMCostByProvince();
            if (flag == 1) {
                ClearProductDetails();
            }
            return false;
        }
       
        var gidDetails;
        function GetGID() {

            var Brand = $("#<%= ddlBrand.ClientID %>").val();
            var SGID = $('#<%= ddlSGID.ClientID %>').val();
            var SupplierCode = $("#<%= ddlSupplierName.ClientID %>").val();
            var ProvinceId = $("#<%= ddlProvince.ClientID %>").val();
            var ProductName = $("#<%= txtProductName.ClientID %>").val();
            if(ProvinceId >0){
                $("#tblGIDResult").show();
                $("#tbodyGIDResult").html("");
                $.ajax({
                    method: "GET",
                    url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/GetGID?Brand=" + Brand + "&SGID=" + SGID +
                                "&SupplierCode=" + SupplierCode + "&ProvinceId=" + ProvinceId +"&ProductName="+ProductName,
                    processData: false,
                    success: function (data) {
                        if (data != null) {
                            gidDetails = data;//$.parseJSON(data);
                            var rows = "";
                            if (data.length > 0) {
                                for (var i = 0; i < data.length; i++) {
                                    rows += "<tr><td class='text-center'><input type=\"radio\" name=\"radioselectGIDs\" value=\"" + data[i].GID + "\"></td>"+
                                            "<td>" + data[i].GID + "</td>"+
                                            "<td>" + data[i].SupplierName + "</td>"+
                                            "<td>" + data[i].BrandName + "</td>"+
                                            "<td>" + data[i].ProductDescription + "</td>"+
                                            "</tr>";
                                }// onclick=\"GetGID_Details(this);\"
                            } else {
                                rows = "<tr class='odd'><td colspan='2' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
                            }
                            $("#tbodyGIDResult").append(rows);

                        }
                    }
                });
            }else{
                ShowMessagePopup("Please select province first.");
            }
            return false;
        }
        function GetGID_Details() {
            var gid = $("input[name='radioselectGIDs']:checked").val();
            //var gid = $(element).val();
            var selectedGID = $.grep(gidDetails, function (e) {
                return e.GID == gid;
            });

            if (selectedGID && selectedGID.length == 1) {
                $("#<%= txtGID.ClientID %>").val(selectedGID[0].GID);
                $("#<%= lblCategory.ClientID %>").text(selectedGID[0].Category);
                $("#<%= lblSupplier.ClientID %>").text(selectedGID[0].SupplierName);
                $("#<%= lblBrand.ClientID %>").text(selectedGID[0].BrandName);
                $("#<%= lblCSPC.ClientID %>").text(selectedGID[0].CSPC_Code);
                $("#<%= lblProductDescription.ClientID %>").text(selectedGID[0].ProductDescription);
                $("#<%= lblSize.ClientID %>").text(selectedGID[0].Size);
                $("#<%= lblUnitsPerPk.ClientID %>").text(selectedGID[0].UnitsPerPk);
                $("#<%= lblUnits.ClientID %>").text(selectedGID[0].Units);

            }
            $("#dvGIDPopup").modal('hide');
            return false;
        }

        function ClearProductDetails() {
            $("#<%= txtGID.ClientID %>").val("");
            $("#<%= lblCategory.ClientID %>").text("");
            $("#<%= lblSupplier.ClientID %>").text("");
            $("#<%= lblBrand.ClientID %>").text("");
            $("#<%= lblCSPC.ClientID %>").text("");
            $("#<%= lblProductDescription.ClientID %>").text("");
            $("#<%= lblSize.ClientID %>").text("");
            $("#<%= lblUnitsPerPk.ClientID %>").text("");
            $("#<%= lblUnits.ClientID %>").text("");

            $("#<%= ddlBrand.ClientID %>").val("0");
            $('#<%= ddlSGID.ClientID %>').val("0");
            $("#<%= ddlSupplierName.ClientID %>").val("0");

            $("#tblGIDResult").hide();
            $("#tbodyGIDResult").html("");

            CalculateForecastTotalCaseSales9L();
            CalculateVariableCost();
        }

        function ChangeUrl(superprogramid) {
            var urlparts = $(location).attr("href").split('?');
            history.pushState({}, null, urlparts[0] + '?SuperProgramId=' + superprogramid);
        }
        
        function Validate_Float_Value() {

            var el = $('input[data-float="true"]');
            el.prop("autocomplete", false); // remove autocomplete (optional)
            el.on('keydown', function (e) {
                if (e.shiftKey) {
                    return false;
                }
                else {
                    var allowedKeyCodesArr = [9, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 8, 37, 39, 109, 189, 46, 110, 190];  // allowed keys
                    if ($.inArray(e.keyCode, allowedKeyCodesArr) === -1 && (e.keyCode != 17 && e.keyCode != 86)) {  // if event key is not in array and its not Ctrl+V (paste) return false;
                        e.preventDefault();
                    } else if ($.trim($(this).val()).indexOf('.') > -1 && $.inArray(e.keyCode, [110, 190]) != -1) {  // if float decimal exists and key is not backspace return fasle;
                        e.preventDefault();
                    } else {
                        return true;
                    };
                }
            }).on('paste', function (e) {  // on paste
                var pastedTxt = e.originalEvent.clipboardData.getData('Text').replace(/[^0-9.]/g, '');  // get event text and filter out letter characters
                if ($.isNumeric(pastedTxt)) {  // if filtered value is numeric
                    e.originalEvent.target.value = pastedTxt;
                    e.preventDefault();
                } else {  // else 
                    e.originalEvent.target.value = ""; // replace input with blank (optional)
                    e.preventDefault();  // return false
                };
            });
        }

        var jsonPrograms = [];
        var selectedIndex = 0;
        var _superProgramId = 0;
        var _programId = 0;
        function SaveProgram() {
            if (Page_ClientValidate("valProgramDetails")) {
                var ProvinceId = $("#<%= ddlProvince.ClientID %>").val();
                    var BusinessTypeId = $("#<%= ddlBusinessType.ClientID %>").val();
                    var SuperProgramName=$("#<%= txtSuperProgramName.ClientID %>").val();
                    var ProgramStatus = $("#<%= ddlProgramStatus.ClientID %>").val();
                    var SGWSFiscalYear = $("#<%= ddlSGWSCalendarYear.ClientID %>").val();
                    var SGWSFiscalPeriod = $("#<%= ddlSGWSCalendarPeriod.ClientID %>").val();
                    var StartDate = $("#<%= txtStartDate.ClientID %>").val();//getFormattedDate(new Date($("#<%= txtStartDate.ClientID %>").val()));
                    var EndDate = $("#<%= txtEndDate.ClientID %>").val();//getFormattedDate(new Date($("#<%= txtEndDate.ClientID %>").val()));
                    var FiscalYearByLiquorBoardId = $("#<%= hdn_ddlLiquorBoardPeriod.ClientID %>").val();
                    var GID = $("#<%= txtGID.ClientID %>").val();
                    var IsSkuBased = false;
                    var IsBrandBased = false;
                    if( $("#<%= ddlSKUSpecificOrBrandFamily.ClientID %>").val()=="1")
                        IsSkuBased = true;
                    else
                        IsBrandBased = true;
                    var IsOverrideDate=$("#<%= chkOverRideDate.ClientID %>").is(":checked");

                    var ProgramTypeId = $("#<%= ddlProgramType.ClientID %>").val();
                    var ProgramName = $("#<%= txtProgramName.ClientID %>").val();
                    var Comment=$("#<%= txtComment.ClientID %>").val();
                    var ProgramStatus = $("#<%= ddlProgramStatus.ClientID %>").val();
                    var ATL_BTL = $("#<%= ddlAboveTheLineOrBelowTheLine.ClientID %>").val();
                    var Depth = $("#<%= txtDepthLTOorBAM.ClientID %>").val() == "" ? "0" :$("#<%= txtDepthLTOorBAM.ClientID %>").val();
                    var ForecastCaseSalesBase= $("#<%= txtForecastCaseSalesBase.ClientID %>").val() == "" ? "0" :$("#<%= txtForecastCaseSalesBase.ClientID %>").val();
                    var ForecastCaseSalesLift = $("#<%= txtForecastCaseSalesLift.ClientID %>").val() == "" ? "0" :$("#<%= txtForecastCaseSalesLift.ClientID %>").val();
                    var ForecastTotalCaseSalesPhysCs=$("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val() == "" ? "0" :$("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val();
                    var ForecastTotalCaseSales9LCsConverted=$("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val() == "" ? "0" :$("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val(); 
                    var VariableCostPerCase=$("#<%= txtVariableCostPerCase.ClientID %>").val() == "" ? "0" :$("#<%= txtVariableCostPerCase.ClientID %>").val();
                    var UpFrontFeesforLTOorBAM=$("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val() == "" ? "0" :$("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val();
                    var Redemption =$("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val() == "" ? "0" :$("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val();
                    var QuantityofSpend=$("#<%= txtQuantityofSpend.ClientID %>").val() == "" ? "0" :$("#<%= txtQuantityofSpend.ClientID %>").val();
                    var SpendperQuantity=$("#<%= txtSpendperQuantity.ClientID %>").val() == "" ? "0" :$("#<%= txtSpendperQuantity.ClientID %>").val();
                    var OtherFixedCostorFee=$("#<%= txtOtherFixedCostorFee.ClientID %>").val() == "" ? "0" :$("#<%= txtOtherFixedCostorFee.ClientID %>").val();
                var TotalProgramSpend=($("#<%= lblTotalProgramSpend.ClientID %>").text() == "" || $("#<%= lblTotalProgramSpend.ClientID %>").text() == "-")
                                        ? "0" :$("#<%= lblTotalProgramSpend.ClientID %>").text();

                    if (_superProgramId > 0) { //Add program only
                        $.ajax({
                            method: "GET",
                            url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/AddEditProgram?ProgramId=" + _programId + "&SuperProgramId=" + _superProgramId +
                                        "&ProgramCostId=0&ProgramTypeId=" + ProgramTypeId +
                                        "&ProgramTypeName=" + ProgramName + "&Comment=" + Comment + "&ProgramStatusId=" + ProgramStatus +
                                        "&ATL_BTL=" + ATL_BTL + "&Depth=" + Depth + "&ForecastCaseSalesBase=" + ForecastCaseSalesBase +
                                        "&ForecastCaseSalesLift=" + ForecastCaseSalesLift + "&ForecastTotalCaseSalesPhysCs=" + ForecastTotalCaseSalesPhysCs +
                                        "&ForecastTotalCaseSales9LCsConverted=" + ForecastTotalCaseSales9LCsConverted + "&VariableCostPerCase=" + VariableCostPerCase +
                                        "&UpforntFees_LTO_BAM=" + UpFrontFeesforLTOorBAM + "&RedemptionBAM=" + Redemption + "&SpendQuantity=" + QuantityofSpend +
                                        "&SpendPerQuantity=" + SpendperQuantity + "&OtherFixedCost=" + OtherFixedCostorFee +"&TotalProgramSpend="+TotalProgramSpend
                                        ,
                            processData: false,
                            success: function (data) {
                                if (data != null) {
                                    var Programs = JSON.parse(data.Programs);
                                    BindProgramsToGrid(Programs);
                                    $("#dvAddEditProgramPopup").modal('hide');
                                }
                            }
                        });
                    }
                    else {
                        $.ajax({
                            method: "GET",
                            url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/AddEditSuperProgramAndProgram?ProvinceId=" + ProvinceId + "&BusinessTypeId=" + BusinessTypeId +
                                "&SuperProgramName=" + SuperProgramName + "&SGWSFiscalYear=" + SGWSFiscalYear +
                                "&SGWSFiscalPeriod=" + SGWSFiscalPeriod + "&StartDate=" + StartDate + "&EndDate=" + EndDate +
                                "&FiscalYearByLiquorBoardId=" + FiscalYearByLiquorBoardId + "&GID=" + GID + "&IsSkuBased=" + IsSkuBased +
                                "&IsBrandBased=" + IsBrandBased + "&ProgramTypeId=" + ProgramTypeId +
                                "&ProgramTypeName=" + ProgramName + "&Comment=" + Comment + "&ProgramStatusId=" + ProgramStatus +
                                "&ATL_BTL=" + ATL_BTL + "&Depth=" + Depth + "&ForecastCaseSalesBase=" + ForecastCaseSalesBase +
                                "&ForecastCaseSalesLift=" + ForecastCaseSalesLift + "&ForecastTotalCaseSalesPhysCs=" + ForecastTotalCaseSalesPhysCs +
                                "&ForecastTotalCaseSales9LCsConverted=" + ForecastTotalCaseSales9LCsConverted + "&VariableCostPerCase=" + VariableCostPerCase +
                                "&UpforntFees_LTO_BAM=" + UpFrontFeesforLTOorBAM + "&RedemptionBAM=" + Redemption + "&SpendQuantity=" + QuantityofSpend +
                                "&SpendPerQuantity=" + SpendperQuantity + "&OtherFixedCost=" + OtherFixedCostorFee+"&TotalProgramSpend="+TotalProgramSpend+
                                "&IsOverrideDate="+IsOverrideDate,
                            processData: false,
                            success: function (data) {
                                if (data != null) {
                                    var SuperProgramId = JSON.parse(data.SuperProgramId);
                                    var Programs = JSON.parse(data.Programs);
                                    _superProgramId = SuperProgramId[0].SuperProgramId;
                                    BindProgramsToGrid(Programs);
                                    ChangeUrl(_superProgramId);
                                    
                                    $("#dvAddEditProgramPopup").modal('hide');
                                }
                            }
                        });
                    }
                }
                return false;
            }

            function BindProgramsToGrid(Programs) {
                var rows = "";
            
                $.each(Programs, function (i, v) {
                    rows += "<tr><td class='text-center'><a href=\"javascript:void(0);\" onclick=\"return GetProgramDetailsByProgramId(" + v.ProgramId + ")\"><i class=\"fa fa-pencil\"></i></a></td>" +
                            "<td>" + v.ProgramTypeName + "</td>" +
                            "<td>" + v.ProgramType + "</td>" +
                            "<td class='text-center'>" + v.ATL_BTL + "</td>" +
                            "<td class='text-center'>" + v.ProgramStatus + "</td>" +
                            "<td>" + v.Comment + "</td>" +
                            "<td class='text-center'>" + v.Depth + "</td>" +
                            "<td class='text-center'>" + v.ForecastCaseSalesBase + "</td>" +
                            "<td class='text-center'>" + v.ForecastCaseSalesLift + "</td>" +
                            "<td class='text-center'>" + v.ForecastTotalCaseSalesPhysCs + "</td>" +
                            "<td class='text-center'>" + v.ForecastTotalCaseSales9LCsConverted + "</td>" +
                            "<td class='text-center'>" + v.VariableCostPerCase + "</td>" +
                            "<td class='text-center'>" + v.UpforntFees_LTO_BAM + "</td>" +
                            "<td class='text-center'>" + v.RedemptionBAM + "</td>" +
                            "<td class='text-center'>" + v.SpendQuantity + "</td>" +
                            "<td class='text-center'>" + v.SpendPerQuantity + "</td>" +
                            "<td class='text-center'>" + v.OtherFixedCost + "</td>" +
                            "<td class='text-center'>" + v.TotalProgramSpend + "</td>" +
                            "</tr>";
                });
                $("#<%= tbodyPrograms.ClientID %>").html("");
                if (rows == "") {
                    rows = "<tr class='odd'><td colspan='2' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
                }
                $("#<%= tbodyPrograms.ClientID %>").append(rows);
        }

        function GetProgramDetailsByProgramId(programid) {
            _programId = programid;
            $.ajax({
                method: "GET",
                url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/GetProgramDetailsByProgramId?ProgramId=" + programid,
                processData: false,
                success: function (data) {
                    if (data != null) {
                        var ProgramDetails = JSON.parse(data.ProgramDetails);
                        showEditProgramPopup(ProgramDetails[0]);
                        $("#dvAddEditProgramPopup").modal('show');
                    }
                }
            });
        }

        function SaveSuperProgram(){
            var superProgramId = getUrlParameter('SuperProgramId');
            if (superProgramId > 0) {
                var ProvinceId = $("#<%= ddlProvince.ClientID %>").val();
                var BusinessTypeId = $("#<%= ddlBusinessType.ClientID %>").val();
                var SuperProgramName = $("#<%= txtSuperProgramName.ClientID %>").val();
                var ProgramStatus = $("#<%= ddlProgramStatus.ClientID %>").val();
                var SGWSFiscalYear = $("#<%= ddlSGWSCalendarYear.ClientID %>").val();
                var SGWSFiscalPeriod = $("#<%= ddlSGWSCalendarPeriod.ClientID %>").val();
                var StartDate = $("#<%= txtStartDate.ClientID %>").val();//getFormattedDate(new Date($("#<%= txtStartDate.ClientID %>").val()));
                var EndDate = $("#<%= txtEndDate.ClientID %>").val();//getFormattedDate(new Date($("#<%= txtEndDate.ClientID %>").val()));
                var FiscalYearByLiquorBoardId = $("#<%= hdn_ddlLiquorBoardPeriod.ClientID %>").val();
                var GID = $("#<%= txtGID.ClientID %>").val();
                var IsSkuBased = false;
                var IsBrandBased = false;
                var IsOverrideDate=$("#<%= chkOverRideDate.ClientID %>").is(":checked");
                if ($("#<%= ddlSKUSpecificOrBrandFamily.ClientID %>").val() == "1")
                    IsSkuBased = true;
                else
                    IsBrandBased = true;

                $.ajax({
                    method: "GET",
                    url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/AddEditSuperProgram?SuperProgramId=" + superProgramId + "&ProvinceId=" + ProvinceId + "&BusinessTypeId=" + BusinessTypeId +
                        "&SuperProgramName=" + SuperProgramName + "&SGWSFiscalYear=" + SGWSFiscalYear +
                        "&SGWSFiscalPeriod=" + SGWSFiscalPeriod + "&StartDate=" + StartDate + "&EndDate=" + EndDate +
                        "&FiscalYearByLiquorBoardId=" + FiscalYearByLiquorBoardId + "&GID=" + GID + "&IsSkuBased=" + IsSkuBased +
                        "&IsBrandBased=" + IsBrandBased + "&IsOverrideDate="+IsOverrideDate,
                    processData: false,
                    success: function (data) {
                        if (data != null) {
                            window.location.href = 'ManageProgram.aspx';
                        }
                    }
                });
            }
        }

        function showEditProgramPopup(ProgramDetails) {
            $("#<%= ddlProgramType.ClientID %>").val(ProgramDetails.ProgramTypeId);
            $("#<%= ddlAboveTheLineOrBelowTheLine.ClientID %>").val(ProgramDetails.AboveTheLineBelowTheLine);
            $("#<%= ddlProgramStatus.ClientID %>").val(ProgramDetails.ProgramStatusId);
            $("#<%= txtProgramName.ClientID %>").val(ProgramDetails.ProgramTypeName);
            $("#<%= txtComment.ClientID %>").val(ProgramDetails.Comment);
            $("#<%= txtDepthLTOorBAM.ClientID %>").val(ProgramDetails.Depth);
            $("#<%= txtForecastCaseSalesBase.ClientID %>").val(ProgramDetails.ForecastCaseSalesBase);
            $("#<%= txtForecastCaseSalesLift.ClientID %>").val(ProgramDetails.ForecastCaseSalesLift);
            $("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val(ProgramDetails.ForecastTotalCaseSalesPhysCs);
            $("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val(ProgramDetails.ForecastTotalCaseSales9LCsConverted);
            $("#<%= txtVariableCostPerCase.ClientID %>").val(ProgramDetails.VariableCostPerCase);
            $("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val(ProgramDetails.UpforntFees_LTO_BAM);
            $("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val(ProgramDetails.RedemptionBAM);
            $("#<%= txtQuantityofSpend.ClientID %>").val(ProgramDetails.SpendQuantity);
            $("#<%= txtSpendperQuantity.ClientID %>").val(ProgramDetails.SpendPerQuantity);
            $("#<%= txtOtherFixedCostorFee.ClientID %>").val(ProgramDetails.OtherFixedCost);
            $("#<%= lblTotalProgramSpend.ClientID %>").text(ProgramDetails.TotalProgramSpend);
            
            GetProgramCostFieldsByType(1);
            CalculateForecastTotalCaseSalesPhyCs();
            CalculateVariableCost();
        }

        
        function ChangeLiquorByBusinessType(){
            if($("#<%= ddlBusinessType.ClientID %>").val()==1){
                $("#lblBoardPeriod").text("Cannabis Board Period");
                $("#<%= rfvBoardPeriod.ClientID %>").text("Cannabis Board Period is required");
            }else{
                $("#lblBoardPeriod").text("Liquor Board Period");
                $("#<%= rfvBoardPeriod.ClientID %>").text("Liquor Board Period is required");
            }
        }

        function CalculateForecastTotalCaseSalesPhyCs() {
            var ForecastCaseSalesBase = 0;
            var ForecastCaseSalesLift = 0;
            if ($("#<%= txtForecastCaseSalesBase.ClientID %>").val() != "") {
                ForecastCaseSalesBase = parseFloat($("#<%= txtForecastCaseSalesBase.ClientID %>").val());
            }
            if ($("#<%= txtForecastCaseSalesLift.ClientID %>").val() != "") {
                ForecastCaseSalesLift = parseFloat($("#<%= txtForecastCaseSalesLift.ClientID %>").val());
            }
            $("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val(ForecastCaseSalesBase + ForecastCaseSalesLift);

            CalculateForecastTotalCaseSales9L();
        }

        function CalculateForecastTotalCaseSales9L() {
            var ForecastTotalCaseSalesPhysCs = 0;
            var Size = 0;
            var UnitsPerPk = 0;
            var Units = 0;
            if ($("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val() != "") {
                ForecastTotalCaseSalesPhysCs = parseFloat($("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val());
            }
            if ($("#<%= lblSize.ClientID %>").text() != "") {
                Size = parseFloat($("#<%= lblSize.ClientID %>").text());
            }
            if ($("#<%= lblUnitsPerPk.ClientID %>").text() != "") {
                UnitsPerPk = parseFloat($("#<%= lblUnitsPerPk.ClientID %>").text());
            }
            if ($("#<%= lblUnits.ClientID %>").text() != "") {
                Units = parseFloat($("#<%= lblUnits.ClientID %>").text());
            }
            $("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val(ForecastTotalCaseSalesPhysCs * Size * UnitsPerPk * Units / 9000);
            CalculateTotalProgramSpend();
        }

        function CalculateTotalProgramSpend(){
            var programtype = parseInt($("#<%= ddlProgramType.ClientID %>").val());
            var total=0;
            var depth = $("#<%= txtDepthLTOorBAM.ClientID %>").val() != '' ? parseFloat($("#<%= txtDepthLTOorBAM.ClientID %>").val()):0;
            var ForecastCaseSalesBase= $("#<%= txtForecastCaseSalesBase.ClientID %>").val()!= '' ? parseFloat($("#<%= txtForecastCaseSalesBase.ClientID %>").val()):0;
            var ForecastCaseSalesLift=$("#<%= txtForecastCaseSalesLift.ClientID %>").val()!= '' ? parseFloat($("#<%= txtForecastCaseSalesLift.ClientID %>").val()):0;
            var ForecastTotalCaseSalesPhysCs=$("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val()!= '' ? parseFloat($("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val()):0;
            var ForecastTotalCaseSales9LCsConverted=$("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val()!= '' ? parseFloat($("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").val()):0;
            var VariableCostPerCase=$("#<%= txtVariableCostPerCase.ClientID %>").val()!= '' ? parseFloat($("#<%= txtVariableCostPerCase.ClientID %>").val()):0;
            var UpFrontFeesforLTOorBAM= $("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val()!= '' ? parseFloat($("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val()):0;
            var Redemption= $("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val()!= '' ? parseFloat($("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val()):0;
            var QuantityofSpend=$("#<%= txtQuantityofSpend.ClientID %>").val()!= '' ? parseFloat($("#<%= txtQuantityofSpend.ClientID %>").val()):0;
            var SpendperQuantity= $("#<%= txtSpendperQuantity.ClientID %>").val()!= '' ? parseFloat($("#<%= txtSpendperQuantity.ClientID %>").val()):0;
            var OtherFixedCostorFee=$("#<%= txtOtherFixedCostorFee.ClientID %>").val()!= '' ? parseFloat($("#<%= txtOtherFixedCostorFee.ClientID %>").val()):0;

            if (<%= (int)Common.ProgramType.RetailSAQDepot%> == programtype || <%= (int)Common.ProgramType.RetailLTO%> == programtype
                || <%= (int)Common.ProgramType.RetailBonusAirMiles%> == programtype) {

                total = (ForecastTotalCaseSalesPhysCs * VariableCostPerCase)+UpFrontFeesforLTOorBAM;
            }
            else if (<%= (int)Common.ProgramType.RetailCorporatePrograms%> == programtype) {

                total=((ForecastTotalCaseSalesPhysCs * VariableCostPerCase)+UpFrontFeesforLTOorBAM) + (QuantityofSpend * SpendperQuantity) + OtherFixedCostorFee;
            }else{
                total=(QuantityofSpend * SpendperQuantity) + OtherFixedCostorFee;

                //total=depth+ForecastCaseSalesBase+ForecastCaseSalesLift+ForecastTotalCaseSalesPhysCs+ForecastTotalCaseSales9LCsConverted+
                //      VariableCostPerCase+UpFrontFeesforLTOorBAM+Redemption+QuantityofSpend+SpendperQuantity+OtherFixedCostorFee;
            }
            $("#<%= lblTotalProgramSpend.ClientID %>").text(total);
        }
        function CalculateVariableCost() {
            var programtype = parseInt($("#<%= ddlProgramType.ClientID %>").val());
            var province = parseInt($("#<%= ddlProvince.ClientID %>").val());
            var depth = 0;
            var units = 0;
            var redemption = 0;
            var result = 0;
             if ($("#<%= txtDepthLTOorBAM.ClientID %>").val() != "") {
                 depth = parseFloat($("#<%= txtDepthLTOorBAM.ClientID %>").val());
            }
            if ($("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val() != "") {
                redemption = parseFloat($("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val());
            }
            if ($("#<%= lblUnits.ClientID %>").text() != "") {
                units = parseFloat($("#<%= lblUnits.ClientID %>").text());
            }
            var a=1;
            if (<%= (int)Common.ProgramType.RetailBonusAirMiles%> == programtype) {//Retail - Bonus Air Miles
                result = redemption * depth * units * BAMcost;
            }
            else {
                if (province == 2) {// AB
                    a = 1.05;
                }
                result = depth * units * a;
            }
            $("#<%= txtVariableCostPerCase.ClientID %>").val(result);

            CalculateTotalProgramSpend();
        }
        var BAMcost = 0;
        function GetBAMCostByProvince() {
            var province = parseInt($("#<%= ddlProvince.ClientID %>").val());

            $.ajax({
                method: "GET",
                url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/GetBAMCostByProvince?ProvinceId=" + province,
                processData: false,
                success: function (data) {
                    if (data != null) {
                        BAMcost = data;
                    }
                }
            });
            return false;
        }

        function GetProgramCostFieldsByType(action){
            var programTypeId = parseInt($("#<%= ddlProgramType.ClientID %>").val());

            $.ajax({
                method: "GET",
                url: "<%= this.ResolveUrl("~/SGWS.asmx")%>/GetProgramCostFieldsByType?ProgramTypeId=" + programTypeId,
                processData: false,
                success: function (data) {
                    if (data != null) {
                        var relation_ProgramType_Cost = JSON.parse(data.ProgramTypeCost);
                        if(relation_ProgramType_Cost != null){
                            
                                $("#<%= txtDepthLTOorBAM.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].Depth == true? false:true);
                                $("#<%= txtForecastCaseSalesBase.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].ForecastCaseSalesBase == true? false:true);              
                                $("#<%= txtForecastCaseSalesLift.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].ForecastCaseSalesLift == true? false:true);              
                                $("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].ForecastTotalCaseSalesPhysCs == true? false:true);      
                                $("#<%= txtForecastTotalCaseSales9LCsConverted.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].ForecastTotalCaseSales9LCsConverted == true? false:true);
                                $("#<%= txtVariableCostPerCase.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].VariableCostPerCase == true? false:true);                
                                $("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].UpforntFees_LTO_BAM == true? false:true);             
                                $("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].RedemptionBAM == true? false:true);    
                                $("#<%= txtQuantityofSpend.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].SpendQuantity == true? false:true);                    
                                $("#<%= txtSpendperQuantity.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].SpendPerQuantity == true? false:true);                   
                                $("#<%= txtOtherFixedCostorFee.ClientID %>").prop("disabled",relation_ProgramType_Cost[0].OtherFixedCost == true? false:true);                
                            if(action ==2){
                                if(relation_ProgramType_Cost[0].Depth == false){
                                    $("#<%= txtDepthLTOorBAM.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].ForecastCaseSalesBase == false){
                                    $("#<%= txtForecastCaseSalesBase.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].ForecastCaseSalesLift == false){
                                    $("#<%= txtForecastCaseSalesLift.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].ForecastTotalCaseSalesPhysCs == false){
                                    $("#<%= txtForecastTotalCaseSalesPhysCs.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].ForecastTotalCaseSales9LCsConverted == false){
                                    $("#<%= txtVariableCostPerCase.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].VariableCostPerCase == false){
                                    $("#<%= txtVariableCostPerCase.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].UpforntFees_LTO_BAM == false){
                                    $("#<%= txtUpFrontFeesforLTOorBAM.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].RedemptionBAM == false){
                                    $("#<%= txtPercentRedemptionRateforBAMonly.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].SpendQuantity == false){
                                    $("#<%= txtQuantityofSpend.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].SpendPerQuantity == false){
                                    $("#<%= txtSpendperQuantity.ClientID %>").val('0');
                                }
                                if(relation_ProgramType_Cost[0].OtherFixedCost == false){
                                    $("#<%= txtOtherFixedCostorFee.ClientID %>").val('0');
                                }
                                CalculateTotalProgramSpend();
                            }
                           
                        }
                    }
                }
            });
            return false;
        }

        $(function () {
            Validate_Float_Value();

            jqueryDatatable();
            _superProgramId=<%=SuperProgramId%>;

            $('.calculateTotalProgramSpend').donetyping(function(){
                CalculateTotalProgramSpend();
            });
        });
        function jqueryDatatable() {
            $('#tblPrograms').dataTable({
                // iDisplayLength: 100,
                //destroy: true,
                bFilter: false,
                "scrollX": true,
                "order": [[1, 0]],
                bSort: true,
                bLengthChange: false,
                paging: false,
                bInfo: false,
                aoColumnDefs: [
                          {
                              bSortable: false,
                              aTargets: [0]
                          }
                ]
            });
        }

    </script>
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        prm.add_beginRequest(beginRequest);

        function beginRequest() {
            prm._scrollPosition = null;
        }

        ;(function($){
            $.fn.extend({
                donetyping: function(callback,timeout){
                    timeout = timeout || 1e3; // 1 second default timeout
                    var timeoutReference,
                    doneTyping = function(el){
                        if (!timeoutReference) return;
                        timeoutReference = null;
                        callback.call(el);
                    };
                    return this.each(function(i,el){
                        var $el = $(el);
                        // Chrome Fix (Use keyup over keypress to detect backspace)
                        // thank you @palerdot
                        $el.is(':input') && $el.on('keyup keypress paste',function(e){
                            // This catches the backspace button in chrome, but also prevents
                            // the event from triggering too preemptively. Without this line,
                            // using tab/shift+tab will make the focused element fire the callback.
                            if (e.type=='keyup' && e.keyCode!=8) return;

                            // Check if timeout has been set. If it has, "reset" the clock and
                            // start over again.
                            if (timeoutReference) clearTimeout(timeoutReference);
                            timeoutReference = setTimeout(function(){
                                // if we made it here, our timeout has elapsed. Fire the
                                // callback
                                doneTyping(el);
                            }, timeout);
                        }).on('blur',function(){
                            // If we can, fire the event since we're leaving the field
                            doneTyping(el);
                        });
                    });
                }
            });
        })(jQuery);
    </script>
</asp:Content>

