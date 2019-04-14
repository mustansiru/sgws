var _programId = 0;
var _superProgramId = 0;
var BAMcost = 0;
var provinceId = 0;
var Units = 0;
var Size = 0;
var UnitsPerPk = 0;
var action = 0;
var isAddProgram = false;
var isInputChanged = false;

$(function () {
    $("#spProductRequireMessage").html("");
    //FillPopupDropdowns();
    Validate_Float_Value();
    $('.calculateTotalProgramSpend').donetyping(function(){
        CalculateTotalProgramSpend();
    });

    $("#modalAddEditProgram").on("hidden.bs.modal", function () {
        //$('#smartwizard').smartWizard("stepState", [2], "show");
        ClearSuperProgramDetails();
        ClearProgramDetails();
        ClearProductDetails();
    });

    $("#modalAddEditProgram").on("shown.bs.modal", function () {
        if (_superProgramId == 0) {
            $("#dvProgramListAccordion").hide();
            $('#dvPopupProgramList').collapse('hide');
            $('#dvPopupProgramElements').collapse('show');
        }
        else if (_superProgramId >0 && _programId > 0) {
            $("#dvProgramListAccordion").show();
            $('#dvPopupProgramList').collapse('show');
            $('#dvPopupProgramElements').collapse('show');
        } else {
            $("#dvProgramListAccordion").show();
            $('#dvPopupProgramList').collapse('show');
            $('#dvPopupProgramElements').collapse('hide');
        }
    });

    $("#dvPopupProgramElements").on("shown.bs.collapse", function () {
        isAddProgram = true;
    });
    $("#dvPopupProgramElements").on("hidden.bs.collapse", function () {
        isAddProgram = false;
    });
    
    $("input[type='text'], select").change(function () {
        isInputChanged = true;
    });
});

$(document).on('show.bs.modal', '.modal', function (event) {
    var zIndex = 1040 + (10 * $('.modal:visible').length);
    $(this).css('z-index', zIndex);
    setTimeout(function () {
        $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
    }, 0);
});

function ShowDetails(flag) {
    if (flag == 1) {
        $("#aCampaignName").text($("#txtSuperProgramName").val());
        $("#aProductName").text($("#ddlProducts_livesearch option:selected").text());
        if ($("#aCampaignName").text() != "" && $("#aProductName").text() != "") {
            $("#lblarrowseparator").text("  >  ");
        }
    } else {
        $("#aCampaignName").text("");
        $("#aProductName").text("");
        $("#lblarrowseparator").text("");
    }
}

function Validate(valgroup) {
    if (isAddProgram == true) {
        ValidatorEnable($("[id$=rfvtxtProgramName]")[0], true);
        ValidatorEnable($("[id$=rfvddlProgramType]")[0], true);
        ValidatorEnable($("[id$=rfvddlATL_BTL]")[0], true);
        ValidatorEnable($("[id$=rfvddlProgramStatus]")[0], true);
        if (Page_ClientValidate(valgroup)) {
            if ($("#ddlProducts_livesearch").val() == "0" || $("#ddlProducts_livesearch").val() == "") {
                $("#spProductRequireMessage").html("Product is required.");
            } else {
                $("#spProductRequireMessage").html("");
                SaveProgram();
            }            
            return false;
        }
        else {
            return false;
        }
    } else { //only update superprogram
        ValidatorEnable($("[id$=rfvtxtProgramName]")[0], false);
        ValidatorEnable($("[id$=rfvddlProgramType]")[0], false);
        ValidatorEnable($("[id$=rfvddlATL_BTL]")[0], false);
        ValidatorEnable($("[id$=rfvddlProgramStatus]")[0], false);
        if (Page_ClientValidate(valgroup)) {
            if ($("#ddlProducts_livesearch").val() == "0" || $("#ddlProducts_livesearch").val() == "") {
                $("#spProductRequireMessage").html("Product is required.");
            } else {
                $("#spProductRequireMessage").html("");
                SaveSuperProgram();
            }            
            return false;
        }
        else {
            return false;
        }
    }


    //if (action == 2 || action ==3)//edit superprogram or copy !$("#step-3").is(":visible")
    //{
    //    ValidatorEnable($("[id$=rfvtxtProgramName]")[0], false);
    //    ValidatorEnable($("[id$=rfvddlProgramType]")[0], false);
    //    ValidatorEnable($("[id$=rfvddlATL_BTL]")[0], false);
    //    ValidatorEnable($("[id$=rfvddlProgramStatus]")[0], false);
    //    if (Page_ClientValidate(valgroup)) {
    //        SaveSuperProgram();
    //        return false;
    //    }
    //    else {
    //        return false;
    //    }
    //}
    //else {
    //    ValidatorEnable($("[id$=rfvtxtProgramName]")[0], true);
    //    ValidatorEnable($("[id$=rfvddlProgramType]")[0], true);
    //    ValidatorEnable($("[id$=rfvddlATL_BTL]")[0], true);
    //    ValidatorEnable($("[id$=rfvddlProgramStatus]")[0], true);
    //    if (Page_ClientValidate(valgroup)) {
    //        SaveProgram();
    //        return false;
    //    }
    //    else {
    //        return false;
    //    }
    //}
}

function CheckRequiredField() {
    var ProvinceId = parseInt($("#ddlProvince").val());
    $("#dvMsg").html("");
    if (ProvinceId == 0) {
        $("#txtStartDate").val('');
        $("#txtEndDate").val('');
        ShowMessagePopup("Please select province first.");
    }
    if ($("#txtLiquorBoardPeriod").val() == '') {
        $("#txtStartDate").val('');
        $("#txtEndDate").val('');
        $("#dvMessagePopup").modal('show');
        if ($("#dvMsg").html()) {
            $("#dvMsg").append("<br/>Liquor Board Period should not be empty.");
        } else {
            $("#dvMsg").html("Liquor Board Period should not be empty.");
        }
    }
}

function ShowMessagePopup(message) {
    $("#dvMessagePopup").modal('show');
    $("#dvMsg").html(message);
    AutoHide_Message("dvMessagePopup");
}

function ShowConfirmationPopup(message, yesCall) {
    $("#dvConfirmationMsg").html(message);
    $("#btnYes").attr("onclick", yesCall);
    $("#dvConfirmationPopup").modal('show');
}

function AutoHide_Message(ctrlId) {
    setTimeout(function () {
        $("#" + ctrlId).fadeTo(2000, 500).slideUp(500, function () {
            $("#" + ctrlId).modal('hide'); //$("#" + ctrlId).hide();
        });
    }, 1000);
}

function ClearSuperProgramDetails() {
    action = 0;
    _superProgramId = 0;
    $("#txtSuperProgramName").val("");
    $("#ddlBusinessType").val("2");
    $("#ddlProvince").val("0");
    $("#ddlSGWSCalendarYear").val("0");
    $("#ddlSGWSCalendarPeriod").val("0");
    $("#ddlSKUSpecificOrBrandFamily").val("0");
    $("#txtLiquorBoardPeriod").val("");
    $("#txtStartDate").val("");
    $("#txtEndDate").val("");
    $("#chkOverRideDate").prop("checked", false);

}

function ClearProgramDetails() {
    action = 1;
    _programId = 0;
    $("#ddlProgramType").val("0");
    $("#ddlAboveTheLineOrBelowTheLine").val("0");
    $("#ddlPopUpProgramStatus").val("3");
    $("#ddlPopUpProgramStatus").prop("disabled", true);
    $("#txtProgramName").val("");
    $("#txtComment").val("");
    $("#txtDepthLTOorBAM").val("");
    $("#txtForecastCaseSalesBase").val("");
    $("#txtForecastCaseSalesLift").val("");
    $("#txtForecastTotalCaseSalesPhysCs").val("");
    $("#txtForecastTotalCaseSales9LCsConverted").val("");
    $("#txtVariableCostPerCase").val("");
    $("#txtUpFrontFeesforLTOorBAM").val("");
    $("#txtPercentRedemptionRateforBAMonly").val("");
    $("#txtQuantityofSpend").val("");
    $("#txtSpendperQuantity").val("");
    $("#txtOtherFixedCostorFee").val("");
    $("#lblTotalProgramSpend").text("-");
}

function ClearProductDetails() {
    //$("#txtGID").val("");
    //$("#lblCategory").text("");
    //$("#lblSupplier").text("");
    //$("#lblBrand").text("");
    //$("#lblCSPC").text("");
    //$("#lblProductDescription").text("");
    //$("#lblSize").text("");
    //$("#lblUnitsPerPk").text("");
    //$("#lblUnits").text("");

    $("#ddlBrand").val("0");
    //$('#ddlSGID').val("0");
    $("#ddlSupplierName").val("0");
    $("#ddlProducts").html('');
    $("#ddlProducts_livesearch").html('');
    $('#ddlProducts_livesearch').val('0').trigger('chosen:updated');
    $("#tblGIDResult").hide();
    $("#tbodyGIDResult").html("");
    Units = 0;
    Size = 0;
    UnitsPerPk = 0;
    CalculateForecastTotalCaseSales9L();
    CalculateVariableCost();
}

function GetLiquorBoardPeriod(flag, action) {
    //if (action == 1) {
    //    $("#chkOverRideDate").prop("checked", false);
    //}
    var ProvinceId = parseInt($("#ddlProvince").val());
    if (ProvinceId > 0) {
        var sgwsYear = $("#ddlSGWSCalendarYear").val();
        var sgwsPeriod = $("#ddlSGWSCalendarPeriod").val();
        if (sgwsYear > 0 && sgwsPeriod != '0') {
            $.ajax({
                method: "GET",
                url: "SGWS.asmx/GetLiquorBoardPeriod?sgwsYear=" + sgwsYear + "&sgwsPeriod=" + sgwsPeriod + "&ProvinceId=" + ProvinceId,
                processData: false,
                success: function (data) {
                    if (data != null && data[0] != null) {
                        $("#txtLiquorBoardPeriod").val(data[0].Period);
                        $("#hdn_ddlLiquorBoardPeriod").val(data[0].FiscalYearByLiquorBoardId);

                        if (!$("#chkOverRideDate").is(":checked") && action != 2) {
                            $("#txtStartDate").val(data[0].StartDate);
                            $("#txtEndDate").val(data[0].EndDate);
                        }

                    } else {
                        $("#txtStartDate").val('');
                        $("#txtEndDate").val('');
                        $("#txtLiquorBoardPeriod").val('');
                        $("#hdn_ddlLiquorBoardPeriod").val('');
                    }
                }
            });
        }
    }
    else {
        ShowMessagePopup("Please select province first.");
        $("#ddlSGWSCalendarYear").val('0');
        $("#ddlSGWSCalendarPeriod").val('0');
        $("#txtStartDate").val('');
        $("#txtEndDate").val('');
        $("#txtLiquorBoardPeriod").val('');
        $("#hdn_ddlLiquorBoardPeriod").val('');
    }

    GetBAMCostAndProductByProgram(_programId);//GetBAMCostByProvince();
    if (flag == 1) {
        ClearProductDetails();
    }
    return false;
}

function SaveProgram() {
    if (Page_ClientValidate("valProgramWizard")) {
        var mode = 1;
        var ProvinceId = $("#ddlProvince").val();
        var BusinessTypeId = $("#ddlBusinessType").val();
        var SuperProgramName = EncodeValue($("#txtSuperProgramName").val());
        var ProgramStatus = $("#ddlPopUpProgramStatus").val();
        var SGWSFiscalYear = $("#ddlSGWSCalendarYear").val();
        var SGWSFiscalPeriod = $("#ddlSGWSCalendarPeriod").val();
        var StartDate = $("#txtStartDate").val();//getFormattedDate(new Date($("#txtStartDate").val()));
        var EndDate = $("#txtEndDate").val();//getFormattedDate(new Date($("#txtEndDate").val()));
        var FiscalYearByLiquorBoardId = $("#hdn_ddlLiquorBoardPeriod").val();
        var GID = $("#ddlProducts_livesearch").val();
        var IsSkuBased = false;
        var IsBrandBased = false;
        if ($("#ddlSKUSpecificOrBrandFamily").val() == "1")
            IsSkuBased = true;
        else
            IsBrandBased = true;
        var IsOverrideDate = $("#chkOverRideDate").is(":checked");

        var ProgramTypeId = $("#ddlProgramType").val();
        var ProgramName = EncodeValue($("#txtProgramName").val());// encodeURI($("#txtProgramName").val());
        var Comment = EncodeValue($("#txtComment").val());//encodeURI($("#txtComment").val());
        var ProgramStatus = $("#ddlPopUpProgramStatus").val();
        var ATL_BTL = $("#ddlAboveTheLineOrBelowTheLine").val();
        var Depth = $("#txtDepthLTOorBAM").val() == "" ? "0" : $("#txtDepthLTOorBAM").val();
        var ForecastCaseSalesBase = $("#txtForecastCaseSalesBase").val() == "" ? "0" : $("#txtForecastCaseSalesBase").val();
        var ForecastCaseSalesLift = $("#txtForecastCaseSalesLift").val() == "" ? "0" : $("#txtForecastCaseSalesLift").val();
        var ForecastTotalCaseSalesPhysCs = $("#txtForecastTotalCaseSalesPhysCs").val() == "" ? "0" : $("#txtForecastTotalCaseSalesPhysCs").val();
        var ForecastTotalCaseSales9LCsConverted = $("#txtForecastTotalCaseSales9LCsConverted").val() == "" ? "0" : $("#txtForecastTotalCaseSales9LCsConverted").val();
        var VariableCostPerCase = $("#txtVariableCostPerCase").val() == "" ? "0" : $("#txtVariableCostPerCase").val();
        var UpFrontFeesforLTOorBAM = $("#txtUpFrontFeesforLTOorBAM").val() == "" ? "0" : $("#txtUpFrontFeesforLTOorBAM").val();
        var Redemption = $("#txtPercentRedemptionRateforBAMonly").val() == "" ? "0" : $("#txtPercentRedemptionRateforBAMonly").val();
        var QuantityofSpend = $("#txtQuantityofSpend").val() == "" ? "0" : $("#txtQuantityofSpend").val();
        var SpendperQuantity = $("#txtSpendperQuantity").val() == "" ? "0" : $("#txtSpendperQuantity").val();
        var OtherFixedCostorFee = $("#txtOtherFixedCostorFee").val() == "" ? "0" : $("#txtOtherFixedCostorFee").val();
        var TotalProgramSpend = ($("#lblTotalProgramSpend").text() == "" || $("#lblTotalProgramSpend").text() == "-")
                                ? "0" : $("#lblTotalProgramSpend").text();

        if (_superProgramId > 0) { //Add program only
            //if (!$("#txtSuperProgramName").is(":disabled"))
                SaveSuperProgram(); //update super program
            if (_programId > 0)
                mode = 2;
            $.ajax({
                method: "GET",
                url: "SGWS.asmx/AddEditProgram?ProgramId=" + _programId + "&SuperProgramId=" + _superProgramId +
                "&ProgramCostId=0&ProgramTypeId=" + ProgramTypeId +
                "&ProgramTypeName=" + ProgramName + "&Comment=" + Comment + "&ProgramStatusId=" + ProgramStatus +
                "&ATL_BTL=" + ATL_BTL + "&Depth=" + Depth + "&ForecastCaseSalesBase=" + ForecastCaseSalesBase +
                "&ForecastCaseSalesLift=" + ForecastCaseSalesLift + "&ForecastTotalCaseSalesPhysCs=" + ForecastTotalCaseSalesPhysCs +
                "&ForecastTotalCaseSales9LCsConverted=" + ForecastTotalCaseSales9LCsConverted + "&VariableCostPerCase=" + VariableCostPerCase +
                "&UpforntFees_LTO_BAM=" + UpFrontFeesforLTOorBAM + "&RedemptionBAM=" + Redemption + "&SpendQuantity=" + QuantityofSpend +
                "&SpendPerQuantity=" + SpendperQuantity + "&OtherFixedCost=" + OtherFixedCostorFee + "&TotalProgramSpend=" + TotalProgramSpend,
                processData: false,
                success: function (data) {
                    if (data != null) {
                        GotoStep(2);
                        var Programs = JSON.parse(data.Programs);
                        if (mode ==2)
                            ShowMessagePopup("<span class='successMessage'>Program updated successfully.</span>");
                        else
                            ShowMessagePopup("<span class='successMessage'>Program added successfully.</span>");

                        SetAllProgramTotalSpendDetails(data.Programs);
                        BindListOfProgram(Programs);
                        //BindProgramsToGrid(Programs);
                        //$("#modalAddEditProgram").modal('hide');
                        ClearProgramDetails();
                        //ClearProductDetails();
                        $('#dvPopupProgramElements').collapse('hide');
                        $("#dvProgramListAccordion").show();
                        $('#dvPopupProgramList').collapse('show');
                        JqueryDatatable();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    if (_programId > 0)
                        ShowMessagePopup("Failed to update program.");
                    else
                        ShowMessagePopup("Failed to add program."); 
                }
            });
        }
        else {
            $.ajax({
                method: "GET",
                url: "SGWS.asmx/AddEditSuperProgramAndProgram?ProvinceId=" + ProvinceId + "&BusinessTypeId=" + BusinessTypeId +
            "&SuperProgramName=" + SuperProgramName + "&SGWSFiscalYear=" + SGWSFiscalYear +
            "&SGWSFiscalPeriod=" + SGWSFiscalPeriod + "&StartDate=" + StartDate + "&EndDate=" + EndDate +
            "&FiscalYearByLiquorBoardId=" + FiscalYearByLiquorBoardId + "&GID=" + GID + "&IsSkuBased=" + IsSkuBased +
            "&IsBrandBased=" + IsBrandBased + "&ProgramTypeId=" + ProgramTypeId +
            "&ProgramTypeName=" + ProgramName + "&Comment=" + Comment + "&ProgramStatusId=" + ProgramStatus +
            "&ATL_BTL=" + ATL_BTL + "&Depth=" + Depth + "&ForecastCaseSalesBase=" + ForecastCaseSalesBase +
            "&ForecastCaseSalesLift=" + ForecastCaseSalesLift + "&ForecastTotalCaseSalesPhysCs=" + ForecastTotalCaseSalesPhysCs +
            "&ForecastTotalCaseSales9LCsConverted=" + ForecastTotalCaseSales9LCsConverted + "&VariableCostPerCase=" + VariableCostPerCase +
            "&UpforntFees_LTO_BAM=" + UpFrontFeesforLTOorBAM + "&RedemptionBAM=" + Redemption + "&SpendQuantity=" + QuantityofSpend +
            "&SpendPerQuantity=" + SpendperQuantity + "&OtherFixedCost=" + OtherFixedCostorFee + "&TotalProgramSpend=" + TotalProgramSpend +
            "&IsOverrideDate=" + IsOverrideDate,
                processData: false,
                success: function (data) {
                    if (data != null) {
                        GotoStep(2);
                        var SuperProgramId = JSON.parse(data.SuperProgramId);
                        var ProgramList = JSON.parse(data.Programs);
                        _superProgramId = SuperProgramId[0].SuperProgramId;
                       // BindProgramsToGrid(Programs);
                        //ChangeUrl(_superProgramId);
                        //JqueryDatatable();
                        ClearProgramDetails();
                        //ClearProductDetails();
                        if (ProgramList != "[]" && ProgramList.length > 0) {
                            SetAllProgramTotalSpendDetails(data.Programs);
                            BindListOfProgram(ProgramList);
                             $("#dvProgramListAccordion").show();
                             $('#dvPopupProgramList').collapse('show');
                             $('#dvPopupProgramElements').collapse('hide');
                        }
                        //$("#modalAddEditProgram").modal('hide');
                        ShowMessagePopup("<span class='successMessage'>Program added successfully.</span>");
                        JqueryDatatable();
                    }
                }
            });
        }
    }
    return false;
}

function SaveSuperProgram()
{
    if (_superProgramId > 0) {
        var ProvinceId = $("#ddlProvince").val();
        var BusinessTypeId = $("#ddlBusinessType").val();
        var SuperProgramName = EncodeValue($("#txtSuperProgramName").val());
        var ProgramStatus = $("#ddlPopUpProgramStatus").val();
        var SGWSFiscalYear = $("#ddlSGWSCalendarYear").val();
        var SGWSFiscalPeriod = $("#ddlSGWSCalendarPeriod").val();
        var StartDate = $("#txtStartDate").val();//getFormattedDate(new Date($("#txtStartDate").val()));
        var EndDate = $("#txtEndDate").val();//getFormattedDate(new Date($("#txtEndDate").val()));
        var FiscalYearByLiquorBoardId = $("#hdn_ddlLiquorBoardPeriod").val();
        var GID = $("#ddlProducts_livesearch").val();
        var IsSkuBased = false;
        var IsBrandBased = false;
        if ($("#ddlSKUSpecificOrBrandFamily").val() == "1")
            IsSkuBased = true;
        else
            IsBrandBased = true;
        var IsOverrideDate = $("#chkOverRideDate").is(":checked");

        //Edit Superprogram program only            
        $.ajax({
            method: "GET",
            url: "SGWS.asmx/AddEditSuperProgram?SuperProgramId=" + _superProgramId + "&ProvinceId=" + ProvinceId + "&BusinessTypeId=" + BusinessTypeId +
            "&SuperProgramName=" + SuperProgramName + "&SGWSFiscalYear=" + SGWSFiscalYear +
            "&SGWSFiscalPeriod=" + SGWSFiscalPeriod + "&StartDate=" + StartDate + "&EndDate=" + EndDate +
            "&FiscalYearByLiquorBoardId=" + FiscalYearByLiquorBoardId + "&GID=" + GID + "&IsSkuBased=" + IsSkuBased +
            "&IsBrandBased=" + IsBrandBased + "&IsOverrideDate=" + IsOverrideDate,
            processData: false,
            success: function (data) {
                if (data != null && data["Table"] != null && data["Table"][0].SuperProgramId >0) {
                    GotoStep(2);
                    //var SuperProgramId = JSON.parse(data.SuperProgramId);
                    //var Programs = JSON.parse(data.Programs);
                    //_superProgramId = SuperProgramId[0].SuperProgramId;
                    // BindProgramsToGrid(Programs);
                    //ChangeUrl(_superProgramId);
                    //JqueryDatatable();
                    //$("#modalAddEditProgram").modal('hide');
                    ShowMessagePopup("<span class='successMessage'>Campaign updated successfully.</span>");
                    ClearProgramDetails();
                    // ClearProductDetails();
                    JqueryDatatable();
                }
            }
        });
    }
    return false;
}

function EncodeValue(value) {
    return escape(value);
}
function AddFromProgramElements() {
    ClearProgramDetails();
    //GotoStep(0);
    //ResetProgramWizard();
    ShowDetails(0);
    if ($("#smartwizard").smartWizard("currentStep") == 0) {
        $("#prev-btn").addClass('disabled');
        $('.sw-btn-group-extra').hide();
    }
}

function GetProgramDetailsByProgramId(programid) {
    //GetBAMCostAndProductByProgram(programid);
    _programId = programid;
    $.ajax({
        method: "GET",
        url: "SGWS.asmx/GetProgramDetailsByProgramId?ProgramId=" + programid,
        processData: false,
        success: function (data) {
            if (data != null) {
                var ProgramDetails = JSON.parse(data.ProgramDetails);
                var ProgramList = JSON.parse(data.ProgramList);
                ShowProgramWizard(true);// $('#modalAddEditProgram').modal('show');
                if (ProgramDetails != null && ProgramDetails.length > 0) {
                    showEditProgramPopup(ProgramDetails[0],1);                    
                }
                SetAllProgramTotalSpendDetails(data.ProgramList);
                BindListOfProgram(ProgramList);
                ResetProgramWizard();
                GotoStep(2);

            }
        }
    });
}

function find_in_object(my_object, my_criteria) {
    return my_object.filter(function (obj) {
        return Object.keys(my_criteria).every(function (c) {
            return obj[c] == my_criteria[c];
        });
    });

}

function BindListOfProgram(Programs) {
    var rows = "";
    
    $.each(Programs, function (i, v) {        
        rows += "<tr><td class='text-center'><a href=\"javascript:void(0);\" onclick=\"return GetProgramDetailsFromPopup(" + v.ProgramId + ");\"><i class=\"fa fa-pencil\"></i></a>" +
                " | <a href=\"javascript:void(0);\" onclick=\"return DeleteProgramConfirmation(" + v.ProgramId + ");\"><i class=\"fa fa-trash-o\"></i></a>" +
                "</td>" +
                "<td>" + v.ProgramTypeName + "</td>" +
                "<td>" + v.ProgramType + "</td>" +
                "<td class='text-center'>" + v.ATL_BTL + "</td>" +
                "<td>" + v.Comment + "</td>"+
                "<td class='text-center'><a href='javascript:void(0);' data-toggle='tooltip' id='aTotalProgramSpend_" + v.ProgramId + "' class='TotalProgramSpend_ToolTip' " +
                "onmouseover='TotalProgramSpend_CommonToolTip(" + v.ProgramId + ",\"aTotalProgramSpend_" + v.ProgramId + "\",\"#modalAddEditProgram\");' " +
                " onfocus='TotalProgramSpend_CommonToolTip(" + v.ProgramId + ",\"aTotalProgramSpend_" + v.ProgramId + "\",\"#modalAddEditProgram\");'>" + v.TotalProgramSpend +
                "</a></td>" +
                "</tr>";       
    });
   
    $("#tbodyPopupProgramsList").html("");
    if (rows == "") {
        rows = "<tr class='odd'><td colspan='5' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
    }
    $("#tbodyPopupProgramsList").append(rows);
}



function DeleteProgramConfirmation(ProgramId) {
    ShowConfirmationPopup("Are you sure you want to delete program?", "DeleteProgram("+ProgramId+")");
}

function DeleteProgram(ProgramId) {
    $("#dvConfirmationPopup").modal('hide');
    $.ajax({
        method: "GET",
        url: "SGWS.asmx/DeleteProgram?ProgramId=" + ProgramId,
        processData: false,
        success: function (data) {
            if (data != null) {
                ShowMessagePopup("<span class='successMessage'>Program deleted successfully.</span>");
                var ProgramList = JSON.parse(data.ProgramList);
                //if (ProgramList != null && ProgramList.length > 0) {
                    BindListOfProgram(ProgramList);
                //}
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ShowMessagePopup("Failed to detete program.");
        }
    });
}

function GetProgramDetailsFromPopup(ProgramId) {
    action = 1;
    //GetBAMCostAndProductByProgram(programid);
    _programId = ProgramId;
    $.ajax({
        method: "GET",
        url: "SGWS.asmx/GetProgramDetailsByProgramId?ProgramId=" + ProgramId,
        processData: false,
        success: function (data) {
            if (data != null) {
                var ProgramDetails = JSON.parse(data.ProgramDetails);
                if (ProgramDetails != null && ProgramDetails.length > 0) {
                    showEditProgramPopup(ProgramDetails[0], 0);
                    //var ProgramList = JSON.parse(data.ProgramList);
                    //BindListOfProgram(ProgramList);
                }
            }
        }
    });
}

function ChangeLiquorByBusinessType() {
    if ($("#ddlBusinessType").val() == 1) {
        $("#lblBoardPeriod").text("GND Board Period");
        $("#rfvBoardPeriod").text("GND Board Period is required");
    } else {
        $("#lblBoardPeriod").text("SGWS Board Period");
        $("#rfvBoardPeriod").text("SGWS Board Period is required");
    }
}

function ValidateDependentFields() {
    var ProvinceId = parseInt($("#ddlProvince").val());
    if (ProvinceId == 0) {
        EnableDisableProvinceDependents(true);
        $("#txtStartDate").val('');
        $("#txtEndDate").val('');
        $("#txtLiquorBoardPeriod").val('');
        $("#hdn_ddlLiquorBoardPeriod").val('');
        $("#ddlSGWSCalendarYear").val('0');
        $("#ddlSGWSCalendarPeriod").val('0');
    } else {
        EnableDisableProvinceDependents(false);
        GetLiquorBoardPeriod(0, 1);
    }
}

function EnableDisableProvinceDependents(isDisabled) {
    if (isDisabled == true) {        
        $("#txtStartDate").attr('disabled', 'disabled');
        $("#txtEndDate").attr('disabled', 'disabled');
        $("#txtLiquorBoardPeriod").attr('disabled', 'disabled');
        $("#hdn_ddlLiquorBoardPeriod").attr('disabled', 'disabled');
        $("#ddlSGWSCalendarYear").attr('disabled', 'disabled');
        $("#ddlSGWSCalendarPeriod").attr('disabled', 'disabled');
    }
    else {
        $("#txtStartDate").removeAttr('disabled');
        $("#txtEndDate").removeAttr('disabled');
        $("#txtLiquorBoardPeriod").removeAttr('disabled');
        $("#hdn_ddlLiquorBoardPeriod").removeAttr('disabled');
        $("#ddlSGWSCalendarYear").removeAttr('disabled');
        $("#ddlSGWSCalendarPeriod").removeAttr('disabled');

        if ($("#chkOverRideDate").is(":checked")) {
            //$("#chkOverRideDate").prop("checked", true);
            $("#txtStartDate").prop("disabled", false);
            $("#txtEndDate").prop("disabled", false);
        }
        else {
            //$("#chkOverRideDate").prop("checked", false);
            $("#txtStartDate").prop("disabled", true);
            $("#txtEndDate").prop("disabled", true);
        }
    }
    IsClearDates();
}

function IsClearDates() {
    var ProvinceId = parseInt($("#ddlProvince").val());
    if (ProvinceId > 0) {
        if ($("#chkOverRideDate").is(":checked")) {
            $("#txtStartDate").removeAttr('disabled');
            $("#txtEndDate").removeAttr('disabled');
            $("#txtStartDate").val("");
            $("#txtEndDate").val("");
        } else {
            $("#txtStartDate").attr('disabled', 'disabled');
            $("#txtEndDate").attr('disabled', 'disabled');
            if ($("#txtLiquorBoardPeriod").val() != '0' && $("#txtLiquorBoardPeriod").val() != '') {
                GetLiquorBoardPeriod(0, 1);
            }
        }
    }
}

function GetSupplier_Products_ByBrand(element, brandId,productId) {
    var SupplierId = $(element).val();
    if (SupplierId == null || SupplierId == '')
        SupplierId = 0;
    //if (SupplierId != null && SupplierId != '')
    //{
        $.ajax({
            method: "GET",
            url: "SGWS.asmx/GetBrand_Products_BySupplier?SupplierId=" + SupplierId,
            processData: false,
            success: function (data) {
                if (data != null) {
                    var Brands = JSON.parse(data.Brands);
                    var Programs = JSON.parse(data.Programs);
                    $("#ddlBrand").html('');
                    $("#ddlProducts").html('');
                    $("#ddlProducts_livesearch").html('');
                    BindOptions("#ddlBrand", Brands);
                    BindOptions("#ddlProducts", Programs);
                    BindOptions("#ddlProducts_livesearch", Programs);
                    if (brandId != undefined && brandId > 0)
                        $("#ddlBrand").val(brandId);
                    else
                        $("#ddlBrand").val('0');

                    if (productId != undefined && productId != "" && productId != 0 && productId.length > 0)
                        $('#ddlProducts_livesearch').val(productId).trigger('chosen:updated');
                    else
                        $('#ddlProducts_livesearch').val('0').trigger('chosen:updated');
                }
            }
        });
    //}
}

function GetProducts_BySupplier_Brand(element,brandId,productId) {
    var SupplierId = $("#ddlSupplierName").val();
    var BrandId = $(element).val();
    if (SupplierId == null || SupplierId == '')
        SupplierId = 0;
    if (BrandId == null || BrandId == '')
        BrandId = 0;
    //if (SupplierId > 0 && BrandId>0) {
        $.ajax({
            method: "GET",
            url: "SGWS.asmx/GetProducts_BySupplier_Brand?SupplierId=" + SupplierId + "&BrandId=" + BrandId,
            processData: false,
            async: false,
            success: function (data) {
                if (data != null) {
                    var Programs = JSON.parse(data.Programs);
                    $("#ddlProducts").html('');
                    $("#ddlProducts_livesearch").html('');
                    BindOptions("#ddlProducts", Programs);
                    BindOptions("#ddlProducts_livesearch", Programs);
                    
                    if (productId != undefined && productId != "" && productId != 0 && productId.length > 0)
                        $('#ddlProducts_livesearch').val(productId).trigger('chosen:updated');
                    else
                        $('#ddlProducts_livesearch').val('0').trigger('chosen:updated');
                }
            }
        });
    //}
}

function GetGID() {
    var Brand = $("#ddlBrand").val();
    var SupplierId = $("#ddlSupplierName").val();
    var ProvinceId = $("#ddlProvince").val();
    //var Product = $('#ddlProducts_livesearch').val();
    var SGID = $("#ddlProducts_livesearch").val();
    if (ProvinceId > 0) {
        $("#tblGIDResult").show();
        $("#tbodyGIDResult").html("");
        $.ajax({
            method: "GET",
            url: "SGWS.asmx/GetGID?Brand=" + Brand + "&SGID=" + SGID + "&SupplierCode=" + SupplierId + "&ProvinceId=" + ProvinceId + "&ProductName=''",// + Product,
            processData: false,
            success: function (data) {
                if (data != null) {
                    //gidDetails = data;
                    var rows = "";
                    if (data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            rows += "<tr><td class='text-center'><a style='cursor:pointer;' onclick=\"SelectProduct('" + data[i].GID + "'," +
                                data[i].Size + "," + data[i].UnitsPerPk + "," + data[i].Units + ");\">Select</a></td>" +
                                    //"<td>" + data[i].GID + "</td>"+
                                    "<td>" + data[i].SupplierName + "</td>" +
                                    "<td>" + data[i].BrandName + "</td>" +
                                    "<td>" + data[i].ProductDescription + "</td>" +
                                    "</tr>";
                        }
                    } else {
                        rows = "<tr class='odd'><td colspan='4' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
                    }
                    $("#tbodyGIDResult").append(rows);

                }
            }
        });
    } else {
        ShowMessagePopup("Please select province first.");
    }
    return false;
}

function SelectProduct(value, _size, _unitsPerPk, _units) {
    $('#ddlProducts_livesearch').val(value).trigger('chosen:updated');
    $("#ddlProducts").val(value);

    Units = _units;
    Size = _size;
    UnitsPerPk = _unitsPerPk;

    CalculateForecastTotalCaseSales9L();
    CalculateVariableCost();

    $("#tblGIDResult").hide();
    $("#spProductRequireMessage").html("");
}

function FillPopupDropdowns(data) {
    if (data != '') {
        //var Products = JSON.parse(data);
        BindOptions("#ddlProducts", data);
        BindOptions("#ddlProducts_livesearch", data);
        $('#ddlProducts_livesearch').val('0').trigger('chosen:updated');
    }
    //if (ddlATL_BTL_ != '') {
    //    BindOptions("#ddlATL_BTL", ddlATL_BTL_);
    //}
    //if (ddlProgramStatus_ != '') {
    //    BindOptions("#ddlPopUpProgramStatus", ddlProgramStatus_);
    //}
}

function BindOptions(element, values) {
    var opts = [];
    $(element).append($("<option />", { value: 0, text: "--Select--" }));
    for (var i = 0; i < values.length; i++) {
        opts.push($("<option />", { value: values[i].Id, text: values[i].Value }));
    }
    $(element).append(opts);
}

function GetProductDetailsByGID(gid) {
    var SGID = gid;
    $("#tblGIDResult").hide();
    $("#tbodyGIDResult").html("");
    $.ajax({
        method: "GET",
        url: "SGWS.asmx/GetProductDetailsByGID?GID=" + gid,
        processData: false,
        success: function (data) {
            if (data != null) {
                var ProductDetails = JSON.parse(data.ProductDetails);
                if (ProductDetails != null && ProductDetails.length > 0) {
                    ShowDetails(1);
                    Size = ProductDetails[0].Size;
                    UnitsPerPk = ProductDetails[0].UnitsPerPk;
                    Units = ProductDetails[0].Units;

                    CalculateForecastTotalCaseSales9L();
                    CalculateVariableCost();
                    //$("#tblGIDResult").hide();
                }
            }
        }
    });
}

function GetProgramDetailsBySuperProgramId(spid) {
    ResetProgramWizard();
    GotoStep(0);
    action = 2;//edit
    _programId = 0;
   // $('#smartwizard').smartWizard("stepState", [2], "hide");
    if (spid > 0) {
        $.ajax({
            method: "GET",
            url: "SGWS.asmx/GetProgramDetailsBySuperProgramId?SuperProgramId=" + spid,
            processData: false,
            success: function (data) {
                if (data != null) {
                    var ProgramDetails = JSON.parse(data.ProgramDetails);
                    if (ProgramDetails != "[]" && ProgramDetails.length > 0) {
                        EnableDisableSuperprogramFields(false);
                        SuperProgramDetailsEditMode(ProgramDetails[0]);
                        ShowProgramWizard(true); //$("#modalAddEditProgram").modal('show');
                    }
                    var ProgramList = JSON.parse(data.ProgramsList);
                    if (ProgramList != "[]" && ProgramList.length > 0) {
                        SetAllProgramTotalSpendDetails(data.ProgramsList);
                        BindListOfProgram(ProgramList);
                    }
                }
            }
        });
    }
}
      
//function GetProgramDetailsByProgramId(programid) {
//    _programId = programid;
//    $.ajax({
//        method: "GET",
//        url: "SGWS.asmx/GetProgramDetailsByProgramId?ProgramId=" + programid,
//        processData: false,
//        success: function (data) {
//            if (data != null) {
//                var ProgramDetails = JSON.parse(data.ProgramDetails);
//                showEditProgramPopup(ProgramDetails[0]);
//                $("#modalAddEditProgram").modal('show');
//            }
//        }
//    });
//}

function SuperProgramDetailsEditMode(SuperProgramDetails) {
    _superProgramId = SuperProgramDetails.SuperProgramId;
    //Superprogram (campaign)
    $("#txtSuperProgramName").val(SuperProgramDetails.SuperProgramName);
    $("#ddlBusinessType").val(SuperProgramDetails.BusinessTypeId);
    $("#ddlProvince").val(SuperProgramDetails.ProvinceId);
    $("#ddlSGWSCalendarYear").val(SuperProgramDetails.SGWSYear);
    $("#ddlSGWSCalendarPeriod").val(SuperProgramDetails.SGWSPeriod);
    $("#hdn_ddlLiquorBoardPeriod").val(SuperProgramDetails.FiscalYearByLiquorBoardId);
    if (SuperProgramDetails.IsSkuBased == true) {
        $("#ddlSKUSpecificOrBrandFamily").val(1);
    } else if (SuperProgramDetails.IsBrandBased == true) {
        $("#ddlSKUSpecificOrBrandFamily").val(2);
    }
    $("#txtLiquorBoardPeriod").val(SuperProgramDetails.LiquorBoardPPeriod);
    $("#txtStartDate").val(SuperProgramDetails.StartDate);
    $("#txtEndDate").val(SuperProgramDetails.EndDate);

    if (SuperProgramDetails.IsOverrideDate == true) {
        $("#chkOverRideDate").prop("checked", true);
        $("#txtStartDate").prop("disabled", false);
        $("#txtEndDate").prop("disabled", false);
    }
    else {
        $("#chkOverRideDate").prop("checked", false);
        $("#txtStartDate").prop("disabled", true);
        $("#txtEndDate").prop("disabled", true);
    }
    //Product details
    $("#ddlSupplierName").val(SuperProgramDetails.SupplierId);
    GetSupplier_Products_ByBrand($("#ddlSupplierName"), SuperProgramDetails.BrandId, SuperProgramDetails.GID);

    $("#ddlBrand").val(SuperProgramDetails.BrandId);
    //GetSupplier_Products_ByBrand($("#ddlSupplierName"));
    GetProducts_BySupplier_Brand($("#ddlBrand"), SuperProgramDetails.BrandId, SuperProgramDetails.GID);

    $('#ddlProducts').val(SuperProgramDetails.GID);
    $('#ddlProducts_livesearch').val(SuperProgramDetails.GID).trigger('chosen:updated');

    ShowDetails(1);
    GetProductDetailsByGID(SuperProgramDetails.GID);
}

function EnableDisableSuperprogramFields(flag) {
    $("#txtSuperProgramName").prop("disabled", flag);
    $("#ddlBusinessType").prop("disabled", flag);
    $("#ddlProvince").prop("disabled", flag);
    $("#ddlSGWSCalendarYear").prop("disabled", flag);
    $("#ddlSGWSCalendarPeriod").prop("disabled", flag);
    $("#ddlSKUSpecificOrBrandFamily").prop("disabled", flag);
    $("#txtStartDate").prop("disabled", flag);
    $("#txtEndDate").prop("disabled", flag);
    $("#chkOverRideDate").prop("disabled", flag);

    $("#ddlSupplierName").prop("disabled", flag);
    $("#ddlBrand").prop("disabled", flag);
    $('#ddlProducts').prop("disabled", flag);
    $('#ddlProducts_livesearch').prop("disabled", flag).trigger('chosen:updated');
    //$('#ddlProducts_livesearch_chosen').prop("disabled", true);
}

function showEditProgramPopup(ProgramDetails, flag) {
    $('#dvPopupProgramList').collapse('hide');
    $('#dvPopupProgramElements').collapse('show');
    _superProgramId = ProgramDetails.SuperProgramId;
    //_programId = ProgramDetails.ProgramId;
    //if (flag == 1) {
    EnableDisableSuperprogramFields(false);
        SuperProgramDetailsEditMode(ProgramDetails);
        //true
    //}
    //Program
    $("#ddlProgramType").val(ProgramDetails.ProgramTypeId);
    $("#ddlAboveTheLineOrBelowTheLine").val(ProgramDetails.AboveTheLineBelowTheLine);
    $("#ddlPopUpProgramStatus").val(ProgramDetails.ProgramStatusId);
    $("#ddlPopUpProgramStatus").prop("disabled", false);
    $("#txtProgramName").val(ProgramDetails.ProgramTypeName);
    $("#txtComment").val(ProgramDetails.Comment);
    $("#txtDepthLTOorBAM").val(ProgramDetails.Depth);
    $("#txtForecastCaseSalesBase").val(ProgramDetails.ForecastCaseSalesBase);
    $("#txtForecastCaseSalesLift").val(ProgramDetails.ForecastCaseSalesLift);
    $("#txtForecastTotalCaseSalesPhysCs").val(ProgramDetails.ForecastTotalCaseSalesPhysCs);
    $("#txtForecastTotalCaseSales9LCsConverted").val(ProgramDetails.ForecastTotalCaseSales9LCsConverted);
    $("#txtVariableCostPerCase").val(ProgramDetails.VariableCostPerCase);
    $("#txtUpFrontFeesforLTOorBAM").val(ProgramDetails.UpforntFees_LTO_BAM);
    $("#txtPercentRedemptionRateforBAMonly").val(ProgramDetails.RedemptionBAM);
    $("#txtQuantityofSpend").val(ProgramDetails.SpendQuantity);
    $("#txtSpendperQuantity").val(ProgramDetails.SpendPerQuantity);
    $("#txtOtherFixedCostorFee").val(ProgramDetails.OtherFixedCost);
    $("#lblTotalProgramSpend").text(ProgramDetails.TotalProgramSpend);

    GetBAMCostAndProductByProgram(_programId);
    GetProgramCostFieldsByType(1);    
    CalculateForecastTotalCaseSalesPhyCs();
    CalculateVariableCost();
    //TotalProgramSpend_ToolTip(ProgramDetails,2);
}

function GetProgramCostFieldsByType(action){
    var programTypeId = parseInt($("#ddlProgramType").val());
    if (programTypeId == 5 || programTypeId == 4) { //4	=Retail - LTO's (limited time offer),5=	Retail - Bonus Air Miles
        $("#lblUpfrontFees").text("Total fixed Cost");
        $("#lblQuantity").text("Quantity Of Spend");
        $("#lblSpendPerQuantity").text("Spend Per Quantity");
        $("#lblOtherCost").text("Other Fixed Cost/Fee");
    }
    else {
        $("#lblUpfrontFees").text("UpFront Fees");
        $("#lblQuantity").text("Quantity");
        $("#lblSpendPerQuantity").text("Cost Per Quantity");
        $("#lblOtherCost").text("Total fixed Cost");
    }
    if (programTypeId == 1 || programTypeId == 2 || programTypeId == 4 || programTypeId == 5) {
        $("#dvOtherFields").addClass("col-md-6");
        $("#dvOtherFields .form-group").removeClass("col-md-6").addClass("col-md-12");
        $("#dvForecastFields").addClass("col-md-6");
        $("#dvForecastFields .form-group").removeClass("col-md-6").addClass("col-md-12");
    } else {
        $("#dvOtherFields").removeClass("col-md-6");
        $("#dvOtherFields .form-group").removeClass("col-md-12").addClass("col-md-6");
        $("#dvForecastFields").removeClass("col-md-6");
        $("#dvForecastFields .form-group").removeClass("col-md-12").addClass("col-md-6");
    }

    $.ajax({
        method: "GET",
        url: "SGWS.asmx/GetProgramCostFieldsByType?ProgramTypeId=" + programTypeId,
        processData: false,
        success: function (data) {
            if (data != null) {
                var relation_ProgramType_Cost = JSON.parse(data.ProgramTypeCost);
                if (relation_ProgramType_Cost != null && relation_ProgramType_Cost.length>0) {
                    $("#dvDepth").css("display", relation_ProgramType_Cost[0].Depth == true ? "block" : "none");
                    $("#dvForecastCaseSalesBase").css("display", relation_ProgramType_Cost[0].ForecastCaseSalesBase == true ? "block" : "none");
                    $("#dvForecastCaseSalesLift").css("display", relation_ProgramType_Cost[0].ForecastCaseSalesLift == true ? "block" : "none");
                    $("#dvForecastTotalCaseSalesPhysCs").css("display", relation_ProgramType_Cost[0].ForecastTotalCaseSalesPhysCs == true ? "block" : "none");
                    $("#dvForecastTotalCaseSales9L").css("display", relation_ProgramType_Cost[0].ForecastTotalCaseSales9LCsConverted == true ? "block" : "none");
                    $("#dvVariableCost").css("display", relation_ProgramType_Cost[0].VariableCostPerCase == true ? "block" : "none");
                    $("#dvUpFrontFees").css("display", relation_ProgramType_Cost[0].UpforntFees_LTO_BAM == true ? "block" : "none");
                    $("#dvPercentRedemption").css("display", relation_ProgramType_Cost[0].RedemptionBAM == true ? "block" : "none");
                    $("#dvQuantityofSpend").css("display", relation_ProgramType_Cost[0].SpendQuantity == true ? "block" : "none");
                    $("#dvSpendperQuantity").css("display", relation_ProgramType_Cost[0].SpendPerQuantity == true ? "block" : "none");
                    $("#dvOtherFixedCostorFee").css("display", relation_ProgramType_Cost[0].OtherFixedCost == true ? "block" : "none");
                    //$("#txtDepthLTOorBAM").prop("disabled",relation_ProgramType_Cost[0].Depth == true? false:true);
                    //$("#txtForecastCaseSalesBase").prop("disabled",relation_ProgramType_Cost[0].ForecastCaseSalesBase == true? false:true);              
                    //$("#txtForecastCaseSalesLift").prop("disabled",relation_ProgramType_Cost[0].ForecastCaseSalesLift == true? false:true);              
                    //$("#txtForecastTotalCaseSalesPhysCs").prop("disabled",relation_ProgramType_Cost[0].ForecastTotalCaseSalesPhysCs == true? false:true);      
                    //$("#txtForecastTotalCaseSales9LCsConverted").prop("disabled",relation_ProgramType_Cost[0].ForecastTotalCaseSales9LCsConverted == true? false:true);
                    //$("#txtVariableCostPerCase").prop("disabled",relation_ProgramType_Cost[0].VariableCostPerCase == true? false:true);                
                    //$("#txtUpFrontFeesforLTOorBAM").prop("disabled",relation_ProgramType_Cost[0].UpforntFees_LTO_BAM == true? false:true);             
                    //$("#txtPercentRedemptionRateforBAMonly").prop("disabled",relation_ProgramType_Cost[0].RedemptionBAM == true? false:true);    
                    //$("#txtQuantityofSpend").prop("disabled",relation_ProgramType_Cost[0].SpendQuantity == true? false:true);                    
                    //$("#txtSpendperQuantity").prop("disabled",relation_ProgramType_Cost[0].SpendPerQuantity == true? false:true);                   
                    //$("#txtOtherFixedCostorFee").prop("disabled",relation_ProgramType_Cost[0].OtherFixedCost == true? false:true);                
                    if(action ==2){
                        if(relation_ProgramType_Cost[0].Depth == false){
                            $("#txtDepthLTOorBAM").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].ForecastCaseSalesBase == false){
                            $("#txtForecastCaseSalesBase").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].ForecastCaseSalesLift == false){
                            $("#txtForecastCaseSalesLift").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].ForecastTotalCaseSalesPhysCs == false){
                            $("#txtForecastTotalCaseSalesPhysCs").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].ForecastTotalCaseSales9LCsConverted == false){
                            $("#txtVariableCostPerCase").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].VariableCostPerCase == false){
                            $("#txtVariableCostPerCase").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].UpforntFees_LTO_BAM == false){
                            $("#txtUpFrontFeesforLTOorBAM").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].RedemptionBAM == false){
                            $("#txtPercentRedemptionRateforBAMonly").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].SpendQuantity == false){
                            $("#txtQuantityofSpend").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].SpendPerQuantity == false){
                            $("#txtSpendperQuantity").val('0.00');
                        }
                        if(relation_ProgramType_Cost[0].OtherFixedCost == false){
                            $("#txtOtherFixedCostorFee").val('0.00');
                        }
                        CalculateTotalProgramSpend();
                    }                           
                }

                //TotalProgramSpend_ToolTip(null, 2);
            }
        }
    });
    return false;
}

function DisableProgramelements() {
    $("#ddlProgramType").prop("disabled", true);
    $("#ddlAboveTheLineOrBelowTheLine").prop("disabled", true);
    $("#ddlPopUpProgramStatus").prop("disabled", true);
    $("#txtProgramName").prop("disabled", true);
    $("#txtComment").prop("disabled", true);
    $("#txtDepthLTOorBAM").prop("disabled", true);
    $("#txtForecastCaseSalesBase").prop("disabled", true);
    $("#txtForecastCaseSalesLift").prop("disabled", true);
    $("#txtForecastTotalCaseSalesPhysCs").prop("disabled", true);
    $("#txtForecastTotalCaseSales9LCsConverted").prop("disabled", true);
    $("#txtVariableCostPerCase").prop("disabled", true);
    $('#txtUpFrontFeesforLTOorBAM').prop("disabled", true);
    $("#txtPercentRedemptionRateforBAMonly").prop("disabled", true);
    $("#txtQuantityofSpend").prop("disabled", true);
    $("#txtSpendperQuantity").prop("disabled", true);
    $("#txtOtherFixedCostorFee").prop("disabled", true);
    $("#lblTotalProgramSpend").prop("disabled", true);
}


function CopySuperProgram(superProgramId) {
    GotoStep(0);
    action = 3;
    $.ajax({
        method: "GET",
        url: "SGWS.asmx/CopySuperProgram?SuperProgramId=" + superProgramId,
        processData: false,
        success: function (data) {
            if (data != null) {
                var SuperProgram = JSON.parse(data.SuperProgram);
                if (SuperProgram.length >0) {
                    EnableDisableSuperprogramFields(false);
                    SuperProgramDetailsEditMode(SuperProgram[0]);
                    $("#chkOverRideDate").prop("checked", false);
                    ShowProgramWizard(true); //$("#modalAddEditProgram").modal('show');
                    //if (SuperProgram[0].SuperProgramId > 0) {
                    //    //window.location.href = 'program.aspx?SuperProgramId=' + SuperProgram[0].SuperProgramId;
                    //}
                }
                var ProgramList = JSON.parse(data.ProgramsList);
                if (ProgramList != "[]" && ProgramList.length > 0) {
                    SetAllProgramTotalSpendDetails(data.ProgramsList);
                    BindListOfProgram(ProgramList);
                }
                JqueryDatatable();
            }
        }
    });
}

function TotalProgramSpend_ToolTip(ProgramDetails,action) {
    var totalspend_html = "<div style='z-index:99999!important;'><table class='TotalProgramSpend_Table'>";
    //if (ProgramDetails != null && ProgramDetails != "[]") {
    //    if ($("#dvDepth").is(":hidden"))
    //        totalspend_html += "<tr><td>Depth per Unit</td><td>" + ProgramDetails.Depth + "</td></tr>";
    //    if ($("#dvForecastCaseSalesBase").is(":hidden"))
    //        totalspend_html += "<tr><td>Forecast Case Sales (base)</td><td>" + ProgramDetails.ForecastCaseSalesBase + "</td></tr>";
    //    if ($("#dvForecastCaseSalesLift").is(":hidden"))
    //        totalspend_html += "<tr><td>Forecast Case Sales (lift)</td><td>" + ProgramDetails.ForecastCaseSalesLift + "</td></tr>";
    //    if ($("#dvForecastTotalCaseSalesPhysCs").is(":hidden"))
    //        totalspend_html += "<tr><td>Forecast Total Sales (Phys)</td><td>" + ProgramDetails.ForecastTotalCaseSalesPhysCs + "</td></tr>";
    //    if ($("#dvForecastTotalCaseSales9L").is(":hidden"))
    //        totalspend_html += "<tr><td>Forecast Total Sales (9L)</td><td>" + ProgramDetails.ForecastTotalCaseSales9LCsConverted + "</td></tr>";
    //    if ($("#dvVariableCost").is(":hidden"))
    //        totalspend_html += "<tr><td>Variable Cost</td><td>" + ProgramDetails.VariableCostPerCase + "</td></tr>";
    //    if ($("#dvUpFrontFees").is(":hidden"))
    //        totalspend_html += "<tr><td>UpFront Fees</td><td>" + ProgramDetails.UpforntFees_LTO_BAM + "</td></tr>";
    //    if ($("#dvPercentRedemption").is(":hidden"))
    //        totalspend_html += "<tr><td>% Redemption</td><td>" + ProgramDetails.RedemptionBAM + "</td></tr>";
    //    if ($("#dvQuantityofSpend").is(":hidden"))
    //        totalspend_html += "<tr><td>Quantity of spend</td><td>" + ProgramDetails.SpendQuantity + "</td></tr>";
    //    if ($("#dvSpendperQuantity").is(":hidden"))
    //        totalspend_html += "<tr><td>Spend per quantity</td><td>" + ProgramDetails.SpendPerQuantity + "</td></tr>";
    //    if ($("#dvOtherFixedCostorFee").is(":hidden"))
    //        totalspend_html += "<tr><td>Other Fixed Cost/Fee</td><td>" + ProgramDetails.OtherFixedCost + "</td></tr>";
    //} else {
        if (!$("#dvDepth").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Depth per Unit</td><td class='text-right'>" + numberWithCommas($("#txtDepthLTOorBAM").val()) + "</td></tr>";
        if (!$("#dvForecastCaseSalesBase").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Forecast Case Sales (base)</td><td class='text-right'>" + numberWithCommas($("#txtForecastCaseSalesBase").val()) + "</td></tr>";
        if (!$("#dvForecastCaseSalesLift").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Forecast Case Sales (lift)</td><td class='text-right'>" + numberWithCommas($("#txtForecastCaseSalesLift").val()) + "</td></tr>";
        if (!$("#dvForecastTotalCaseSalesPhysCs").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Forecast Total Sales (Phys)</td><td class='text-right'>" + numberWithCommas($("#txtForecastTotalCaseSalesPhysCs").val()) + "</td></tr>";
        if (!$("#dvForecastTotalCaseSales9L").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Forecast Total Sales (9L)</td><td class='text-right'>" + numberWithCommas($("#txtForecastTotalCaseSales9LCsConverted").val()) + "</td></tr>";
        if (!$("#dvVariableCost").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Variable Cost</td><td class='text-right'>" + numberWithCommas($("#txtVariableCostPerCase").val()) + "</td></tr>";
        if (!$("#dvUpFrontFees").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>UpFront Fees</td><td class='text-right'>" + numberWithCommas($("#txtUpFrontFeesforLTOorBAM").val()) + "</td></tr>";
        if (!$("#dvPercentRedemption").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>% Redemption</td><td class='text-right'>" + numberWithCommas($("#txtPercentRedemptionRateforBAMonly").val()) + "</td></tr>";
        if (!$("#dvQuantityofSpend").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Quantity of spend</td><td class='text-right'>" + numberWithCommas($("#txtQuantityofSpend").val()) + "</td></tr>";
        if (!$("#dvSpendperQuantity").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Spend per quantity</td><td class='text-right'>" + numberWithCommas($("#txtSpendperQuantity").val()) + "</td></tr>";
        if (!$("#dvOtherFixedCostorFee").is(":hidden"))
            totalspend_html += "<tr><td class='text-left'>Other Fixed Cost/Fee</td><td class='text-right'>" + numberWithCommas($("#txtOtherFixedCostorFee").val()) + "</td></tr>";
        
    totalspend_html += "</table></div>";
    $('#aTotalProgramSpend').tooltip({
        html: true,
        placement: "left",
        title: totalspend_html,
        container: '#modalAddEditProgram',
        //template: '<div class="popover"><div class="arrow"></div><div class="popover-title">'+totalspend_html+'</div></div>'
    });
    $('#aTotalProgramSpend').attr('data-original-title', totalspend_html).tooltip('show');

}

function CancelWizard() {
    if (isInputChanged == true) {
        ShowConfirmationPopup('Are you sure want to continue, your changes will be lost?', 'ClosePopup("modalAddEditProgram");ClosePopup("dvConfirmationPopup");')
    } else {
        ClosePopup("modalAddEditProgram");
       // ClosePopup("dvConfirmationPopup");
    }
    return false;
}

function ClosePopup(id) {
    $("#" + id).modal('hide');
}

//function TotalProgramSpend_CommonToolTip(ProgramId, element, _container) {
//    var ProgramDetails = JSON.parse(jsonProgramCost).filter(function (entry) {
//        return entry.ProgramId === ProgramId;
//    });
//    if (ProgramDetails != null && ProgramDetails.length > 0) {
//        var totalspend_html = "<div style='z-index:99999!important;'><table class='TotalProgramSpend_Table'>";        
//        ////if (!$("#dvDepth").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Depth per Unit</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].Depth) + "</td></tr>";
//        //if (!$("#dvForecastCaseSalesBase").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Forecast Case Sales (base)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastCaseSalesBase) + "</td></tr>";
//        //if (!$("#dvForecastCaseSalesLift").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Forecast Case Sales (lift)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastCaseSalesLift) + "</td></tr>";
//        //if (!$("#dvForecastTotalCaseSalesPhysCs").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Forecast Total Sales (Phys)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastTotalCaseSalesPhysCs) + "</td></tr>";
//        //if (!$("#dvForecastTotalCaseSales9L").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Forecast Total Sales (9L)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastTotalCaseSales9LCsConverted) + "</td></tr>";
//        //if (!$("#dvVariableCost").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Variable Cost</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].VariableCostPerCase) + "</td></tr>";
//        //if (!$("#dvUpFrontFees").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>UpFront Fees</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].UpforntFees_LTO_BAM) + "</td></tr>";
//        //if (!$("#dvPercentRedemption").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>% Redemption</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].RedemptionBAM) + "</td></tr>";
//        //if (!$("#dvQuantityofSpend").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Quantity of spend</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].SpendQuantity) + "</td></tr>";
//        //if (!$("#dvSpendperQuantity").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Spend per quantity</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].SpendPerQuantity) + "</td></tr>";
//        //if (!$("#dvOtherFixedCostorFee").is(":hidden"))
//        totalspend_html += "<tr><td class='text-left'>Other Fixed Cost/Fee</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].OtherFixedCost) + "</td></tr>";

//        totalspend_html += "</table></div>";
//        $('#' + element).tooltip({
//            html: true,
//            placement: "left",
//            title: totalspend_html,
//            container: _container,//'#modalAddEditProgram',
//        });
//        $('#' + element).attr('data-original-title', totalspend_html).tooltip('show');
//    }
//}

///////////////////////////////////////////////////////

//function CopyProgram(programid) {
//    $.ajax({
//        method: "GET",
//        url: "SGWS.asmx/CopyProgram?ProgramId=" + programid,
//        processData: false,
//        success: function (data) {
//            if (data != null) {
//                var ProgramDetails = JSON.parse(data.ProgramDetails);
//                showEditProgramPopup(ProgramDetails[0]);
//                $("#modalAddEditProgram").modal('show');
//            }
//        }
//    });
//}


function SaveOnlyProgram(valgroup) {
    if (Page_ClientValidate(valgroup)) {
        var ProgramTypeId = $("#ddlProgramType").val();
        var ProgramName = EncodeValue($("#txtProgramName").val());
        var Comment = EncodeValue($("#txtComment").val());
        var ProgramStatus = $("#ddlPopUpProgramStatus").val();
        var ATL_BTL = $("#ddlAboveTheLineOrBelowTheLine").val();
        var Depth = $("#txtDepthLTOorBAM").val() == "" ? "0" : $("#txtDepthLTOorBAM").val();
        var ForecastCaseSalesBase = $("#txtForecastCaseSalesBase").val() == "" ? "0" : $("#txtForecastCaseSalesBase").val();
        var ForecastCaseSalesLift = $("#txtForecastCaseSalesLift").val() == "" ? "0" : $("#txtForecastCaseSalesLift").val();
        var ForecastTotalCaseSalesPhysCs = $("#txtForecastTotalCaseSalesPhysCs").val() == "" ? "0" : $("#txtForecastTotalCaseSalesPhysCs").val();
        var ForecastTotalCaseSales9LCsConverted = $("#txtForecastTotalCaseSales9LCsConverted").val() == "" ? "0" : $("#txtForecastTotalCaseSales9LCsConverted").val();
        var VariableCostPerCase = $("#txtVariableCostPerCase").val() == "" ? "0" : $("#txtVariableCostPerCase").val();
        var UpFrontFeesforLTOorBAM = $("#txtUpFrontFeesforLTOorBAM").val() == "" ? "0" : $("#txtUpFrontFeesforLTOorBAM").val();
        var Redemption = $("#txtPercentRedemptionRateforBAMonly").val() == "" ? "0" : $("#txtPercentRedemptionRateforBAMonly").val();
        var QuantityofSpend = $("#txtQuantityofSpend").val() == "" ? "0" : $("#txtQuantityofSpend").val();
        var SpendperQuantity = $("#txtSpendperQuantity").val() == "" ? "0" : $("#txtSpendperQuantity").val();
        var OtherFixedCostorFee = $("#txtOtherFixedCostorFee").val() == "" ? "0" : $("#txtOtherFixedCostorFee").val();
        var TotalProgramSpend = ($("#lblTotalProgramSpend").text() == "" || $("#lblTotalProgramSpend").text() == "-")
                                ? "0" :numberWithCommas( $("#lblTotalProgramSpend").text());

        if (_superProgramId > 0) { //Add program only
            $.ajax({
                method: "GET",
                url: "SGWS.asmx/AddEditProgram?ProgramId=" + _programId + "&SuperProgramId=" + _superProgramId +
                "&ProgramCostId=0&ProgramTypeId=" + ProgramTypeId +
                "&ProgramTypeName=" + ProgramName + "&Comment=" + Comment + "&ProgramStatusId=" + ProgramStatus +
                "&ATL_BTL=" + ATL_BTL + "&Depth=" + Depth + "&ForecastCaseSalesBase=" + ForecastCaseSalesBase +
                "&ForecastCaseSalesLift=" + ForecastCaseSalesLift + "&ForecastTotalCaseSalesPhysCs=" + ForecastTotalCaseSalesPhysCs +
                "&ForecastTotalCaseSales9LCsConverted=" + ForecastTotalCaseSales9LCsConverted + "&VariableCostPerCase=" + VariableCostPerCase +
                "&UpforntFees_LTO_BAM=" + UpFrontFeesforLTOorBAM + "&RedemptionBAM=" + Redemption + "&SpendQuantity=" + QuantityofSpend +
                "&SpendPerQuantity=" + SpendperQuantity + "&OtherFixedCost=" + OtherFixedCostorFee + "&TotalProgramSpend=" + TotalProgramSpend,
                processData: false,
                success: function (data) {
                    if (data != null) {
                        var Programs = JSON.parse(data.Programs);
                        BindProgramsToGrid(Programs);
                        ShowProgramWizard(false); //$("#modalAddEditProgram").modal('hide');
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
        rows += "<tr><td class='text-center'><a href=\"javascript:void(0);\" onclick=\"return GetProgramDetailsByProgramId(" + v.ProgramId + ")\"><i class=\"fa fa-pencil\"></i></a>" +
            "</td>" +
            "<td>" + v.ProgramTypeName + "</td>" +
            "<td>" + v.ProgramType + "</td>" +
            "<td>" + v.ATL_BTL + "</td>" +
            "<td>" + v.Comment + "</td>" +
            "<td>" + v.ProgramStatus + "</td>" +

            "</tr>";
        // | <a href=\"javascript:void(0);\" onclick=\"return CopyProgram(" + v.ProgramId + ")\">Copy</a>
    });
    var tableObjId = "#SP" + _superProgramId;
    //alert(tableObjId);
    $(tableObjId).html("");
    if (rows == "") {
        rows = "<tr class='odd'><td colspan='2' class='dataTables_empty' style='font-size: 13px;'>No data available in table</td></tr>";
    }
    $(tableObjId).append(rows);
}

function CalculateForecastTotalCaseSalesPhyCs() {
    var ForecastCaseSalesBase = 0;
    var ForecastCaseSalesLift = 0;
    if ($("#txtForecastCaseSalesBase").val() != "") {
        ForecastCaseSalesBase = parseFloat($("#txtForecastCaseSalesBase").val());
    }
    if ($("#txtForecastCaseSalesLift").val() != "") {
        ForecastCaseSalesLift = parseFloat($("#txtForecastCaseSalesLift").val());
    }
    $("#txtForecastTotalCaseSalesPhysCs").val((ForecastCaseSalesBase + ForecastCaseSalesLift).toFixed(2));

    CalculateForecastTotalCaseSales9L();
}

function CalculateForecastTotalCaseSales9L() {
    var ForecastTotalCaseSalesPhysCs = 0;
    if ($("#txtForecastTotalCaseSalesPhysCs").val() != "") {
        ForecastTotalCaseSalesPhysCs = parseFloat($("#txtForecastTotalCaseSalesPhysCs").val());
    }
    //if ($("#lblSize").text() != "") {
    //    Size = parseFloat($("#lblSize").text());
    //}
    //if ($("#lblUnitsPerPk").text() != "") {
    //    UnitsPerPk = parseFloat($("#lblUnitsPerPk").text());
    //}
    //if ($("#lblUnits").text() != "") {
    //    Units = parseFloat($("#lblUnits").text());
    //}
    $("#txtForecastTotalCaseSales9LCsConverted").val(parseFloat(ForecastTotalCaseSalesPhysCs * Size * UnitsPerPk * Units / 9000).toFixed(2));
    CalculateTotalProgramSpend();
}

function CalculateTotalProgramSpend(){
    var programtype = parseInt($("#ddlProgramType").val());
    var total = 0.00;
    var depth = $("#txtDepthLTOorBAM").val() != '' ? parseFloat($("#txtDepthLTOorBAM").val()):0.00;
    var ForecastCaseSalesBase = $("#txtForecastCaseSalesBase").val() != '' ? parseFloat($("#txtForecastCaseSalesBase").val()) : 0.00;
    var ForecastCaseSalesLift = $("#txtForecastCaseSalesLift").val() != '' ? parseFloat($("#txtForecastCaseSalesLift").val()) : 0.00;
    var ForecastTotalCaseSalesPhysCs = $("#txtForecastTotalCaseSalesPhysCs").val() != '' ? parseFloat($("#txtForecastTotalCaseSalesPhysCs").val()) : 0.00;
    var ForecastTotalCaseSales9LCsConverted = $("#txtForecastTotalCaseSales9LCsConverted").val() != '' ? parseFloat($("#txtForecastTotalCaseSales9LCsConverted").val()) : 0.00;
    var VariableCostPerCase = $("#txtVariableCostPerCase").val() != '' ? parseFloat($("#txtVariableCostPerCase").val()) : 0.00;
    var UpFrontFeesforLTOorBAM = $("#txtUpFrontFeesforLTOorBAM").val() != '' ? parseFloat($("#txtUpFrontFeesforLTOorBAM").val()) : 0.00;
    var Redemption = $("#txtPercentRedemptionRateforBAMonly").val() != '' ? parseFloat($("#txtPercentRedemptionRateforBAMonly").val()) : 0.00;
    var QuantityofSpend = $("#txtQuantityofSpend").val() != '' ? parseFloat($("#txtQuantityofSpend").val()) : 0.00;
    var SpendperQuantity = $("#txtSpendperQuantity").val() != '' ? parseFloat($("#txtSpendperQuantity").val()) : 0.00;
    var OtherFixedCostorFee = $("#txtOtherFixedCostorFee").val() != '' ? parseFloat($("#txtOtherFixedCostorFee").val()) : 0.00;

    if (programtype == 2 || programtype == 4 || programtype == 5) {

        total = (ForecastTotalCaseSalesPhysCs * VariableCostPerCase)+UpFrontFeesforLTOorBAM;
    }
    else if (programtype == 1) {

        total=parseFloat(((ForecastTotalCaseSalesPhysCs * VariableCostPerCase)+UpFrontFeesforLTOorBAM) + (QuantityofSpend * SpendperQuantity) + OtherFixedCostorFee);
    }else{
        total = parseFloat((QuantityofSpend * SpendperQuantity) + OtherFixedCostorFee);
    }
    if (total > 0) {
        total = total.toFixed(2);
    }
    $("#lblTotalProgramSpend").text(numberWithCommas(total));
    //TotalProgramSpend_ToolTip(null, 1);
}

function CalculateVariableCost() {
    
    var programtype = parseInt($("#ddlProgramType").val());
    //var province = parseInt($("#ddlProvince").val());
    var depth = 0;
    //var units = 0;
    var redemption = 0;
    var result = 0;
    if ($("#txtDepthLTOorBAM").val() != "") {
        depth = parseFloat($("#txtDepthLTOorBAM").val());
    }
    if ($("#txtPercentRedemptionRateforBAMonly").val() != "") {
        redemption = parseFloat($("#txtPercentRedemptionRateforBAMonly").val());
    }
    
    var a = 1;
    if (programtype == 5) {//Retail - Bonus Air Miles
        result = parseFloat(redemption * depth * Units * BAMcost);
    }
    else {
        if (provinceId == 2) {// AB
            a = 1.05;
        }
        result = parseFloat(depth * Units * a);
    }
    $("#txtVariableCostPerCase").val(result.toFixed(2));

    CalculateTotalProgramSpend();
}

function GetBAMCostAndProductByProgram(programId) {
    if (programId > 0) {
        $.ajax({
            method: "GET",
            url: "SGWS.asmx/GetBAMCostAndProductByProgram?ProgramId=" + programId,
            processData: false,
            async:false,
            success: function (data) {
                if (data != null) {
                    var _BAMCost = JSON.parse(data.BAMcost);
                    var _ProductDetails = JSON.parse(data.ProductInfo);
                    if (_BAMCost != null && _BAMCost.length > 0) {
                        BAMcost = _BAMCost[0].BAMCost;
                    }
                    if (_ProductDetails != null && _ProductDetails.length > 0) {
                        provinceId = _ProductDetails[0].ProvinceId;
                        Units = _ProductDetails[0].Units;
                        Size = _ProductDetails[0].Size;
                        UnitsPerPk = _ProductDetails[0].UnitsPerPk;
                    }
                }
            }
        });
    }
    return false;
}




//General Functions

; (function ($) {
    $.fn.extend({
        donetyping: function (callback, timeout) {
            timeout = timeout || 1e3; // 1 second default timeout
            var timeoutReference,
            doneTyping = function (el) {
                if (!timeoutReference) return;
                timeoutReference = null;
                callback.call(el);
            };
            return this.each(function (i, el) {
                var $el = $(el);
                // Chrome Fix (Use keyup over keypress to detect backspace)
                // thank you @palerdot
                $el.is(':input') && $el.on('keyup keypress paste', function (e) {
                    // This catches the backspace button in chrome, but also prevents
                    // the event from triggering too preemptively. Without this line,
                    // using tab/shift+tab will make the focused element fire the callback.
                    if (e.type == 'keyup' && e.keyCode != 8) return;

                    // Check if timeout has been set. If it has, "reset" the clock and
                    // start over again.
                    if (timeoutReference) clearTimeout(timeoutReference);
                    timeoutReference = setTimeout(function () {
                        // if we made it here, our timeout has elapsed. Fire the
                        // callback
                        doneTyping(el);
                    }, timeout);
                }).on('blur', function () {
                    // If we can, fire the event since we're leaving the field
                    doneTyping(el);
                });
            });
        }
    });
})(jQuery);
