
$(document).ready(function () {
    $('#MainContent_repCustomers_chkCheckAll').click(function () {
        if ($(this).is(':checked')) {
            $("div#customer table tbody tr td input:[type='checkbox']:not(:checked)").each(function () {
                $(this).attr('checked', true);
            });
        }
        else {

            $("div#customer table tbody tr td input:[type='checkbox']:checked").each(function () {
                $(this).attr('checked', false);
            });
        }
    });
});