
var jsonProgramCost = [];
function SetAllProgramTotalSpendDetails(Programs) {
    jsonProgramCost = Programs;
}

function TotalProgramSpend_CommonToolTip(ProgramId, element, _container) {

    var ProgramDetails = JSON.parse(jsonProgramCost).filter(function (entry) {
        return entry.ProgramId === ProgramId;
    });
    if (ProgramDetails != null && ProgramDetails.length > 0) {
        var totalspend_html = "<div style='z-index:99999!important;'><table class='TotalProgramSpend_Table'>";

        ////if (!$("#dvDepth").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Depth per Unit</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].Depth) + "</td></tr>";
        //if (!$("#dvForecastCaseSalesBase").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Forecast Case Sales (base)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastCaseSalesBase) + "</td></tr>";
        //if (!$("#dvForecastCaseSalesLift").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Forecast Case Sales (lift)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastCaseSalesLift) + "</td></tr>";
        //if (!$("#dvForecastTotalCaseSalesPhysCs").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Forecast Total Sales (Phys)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastTotalCaseSalesPhysCs) + "</td></tr>";
        //if (!$("#dvForecastTotalCaseSales9L").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Forecast Total Sales (9L)</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].ForecastTotalCaseSales9LCsConverted) + "</td></tr>";
        //if (!$("#dvVariableCost").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Variable Cost</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].VariableCostPerCase) + "</td></tr>";
        //if (!$("#dvUpFrontFees").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>UpFront Fees</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].UpforntFees_LTO_BAM) + "</td></tr>";
        //if (!$("#dvPercentRedemption").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>% Redemption</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].RedemptionBAM) + "</td></tr>";
        //if (!$("#dvQuantityofSpend").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Quantity of spend</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].SpendQuantity) + "</td></tr>";
        //if (!$("#dvSpendperQuantity").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Spend per quantity</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].SpendPerQuantity) + "</td></tr>";
        //if (!$("#dvOtherFixedCostorFee").is(":hidden"))
        totalspend_html += "<tr><td class='text-left'>Other Fixed Cost/Fee</td><td class='text-right'>" + numberWithCommas(ProgramDetails[0].OtherFixedCost) + "</td></tr>";

        totalspend_html += "</table></div>";
        $('#' + element).tooltip({
            html: true,
            placement: "left",
            title: totalspend_html,
            container: _container,
        });
        $('#' + element).attr('data-original-title', totalspend_html).tooltip('show');
    }
}


function numberWithCommas(x) {
    //return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");  //replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"); //
    if (x > 0) {
        var parts = x.toString().split(".");
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    } else {
        return 0;
    }
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