function changetheme(index) {
    if (parseInt(index) == 1) {
        $("#innerheader").css({ background: "#3485c4" });
        $(".login").css("background", "#2371af");
        $(".setting_login").css("background", "#2371af");
    }
    else if (parseInt(index) == 4) {
        $("#innerheader").css({ background: "#745474" });
        $(".preloader").css({ background: "#fff url(images/preloader_holtrenfrew.gif) no-repeat scroll center center" });

        $(".graphite").each(function () {
            $(this).find(".accordion").each(function () {
                $(this).find("li").each(function () {
                    $(this).find("ul").each(function () {
                        $(this).find("li").each(function () {
                            $(this).find("a").hover(function () {
                                //$(this).css("background", "#a5579d url(images/menu-arrow.png) no-repeat 102% center")
                                //$("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                                $(this).css("background", "#a5579d")
                                $("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                            });
                            $(this).find("a").mouseout(function () {
                                //$(this).css("background", "#2a2d33 url(images/menu-arrow.png) no-repeat 102% center")
                                //$("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                                $(this).css("background", "#2a2d33")
                                $("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                            });
                            //$(this).find("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                            $(this).find("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                        });
                    });
                });
            });
        });

        $("#accordionmenu_master").each(function () {
            $(this).find(".accordion").each(function () {
                $(this).find("ul").each(function () {
                    $(this).find("li").each(function () {
                        $(this).find("a").hover(function () {
                            //$(this).css("background", "#a5579d url(images/menu-arrow.png) no-repeat 102% center")
                            //$("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                            $(this).css("background", "#a5579d")
                            $("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                        });
                        $(this).find("a").mouseout(function () {
                            //$(this).css("background", "#2a2d33 url(images/menu-arrow.png) no-repeat 102% center")
                            //$("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                            $(this).css("background", "#2a2d33")
                            $("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                        });
                        //$(this).find("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                        $(this).find("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
                    });
                });
            });
        });
        // url(images/menu-arrow.png) no-repeat 102% center
        $(".dcjq-parent").css("background", "#7b2d73");

        $(".login").css("background", "#7b2d73");
        $(".setting_login").css("background", "#7b2d73");
        $(".usermenu").css("background", "#a5579d");

        $(".bluebutton").css("background", "#7b2d73");
        $(".Activebutton").css("background", "#a5579d");
        $(".InActivebutton").css("background", "#7b2d73");
        $(".panel-inner-mainheading").css("background", "#f8e3f8");

        $(".pagetitle").css("background", "#f8e3f8");
        $(".btn-primary").css("background", "#7b2d73");
        $(".btn-primary").css("border-color", "#7b2d73");

        $(".right_panel_in").css("background", "none");
        $(".buttonClear").css("color", "#7b2d73");
        $(".activeTimelineView").css("background-color", "#a5579d");
        $(".innerTimelinemenu").css("background-color", "#fff");

        $(".InActiveTabbutton").css("background", "#7b2d73");
        $(".ActiveTabbutton").css("background", "#a5579d");

        $(".innerTimelinemenu").hover(function () {
            if ($(this).css("background-color") != "rgb(165, 87, 157)") {
                $(this).css("background-color", "#7b2d73")
                $(this).css("color", "#fff")
            }
            else {
                $(this).css("background-color", "#a5579d");
                $(this).css("color", "#fff");
            }
        });
        $(".innerTimelinemenu").mouseout(function () {
            if ($(this).css("background-color") != "rgb(165, 87, 157)") {
                $(this).css("background-color", "#fff")
                $(this).css("color", "#000")
            }
            else {
                $(this).css("background-color", "#a5579d");
                $(this).css("color", "#fff");
            }
        });

        Set_Table_theme(index);

        $("tbody").each(function () {
            $(this).find("tr").each(function () {
                $(this).find("td").each(function () {
                    $(this).find("a").each(function () {
                        $(this).hover(function () {
                            $(this).css("color", "#7b2d73");
                        });
                        $(this).mouseout(function () {
                            $(this).css("color", "#000");
                        });
                    });
                });
            });
        });

        $(".tablecolor").each(function () {
            $(this).find("thead").each(function () {
                $(this).find("tr").each(function () {
                    $(this).find("th").each(function () {
                        $(this).css("background-color", "#7b2d73");
                    });
                });
            });
        });

        $(".tableheader").each(function () {
            $(this).find("tr").each(function () {
                $(this).find("th").each(function () {
                    $(this).css("background", "#7b2d73");
                });
            });
        });
    }
}

function Set_Table_theme(index) {
    if (parseInt(index) == 4) {
        $(".sorting").css("background-color", "#7b2d73");
        $(".sorting_asc").css("background-color", "#7b2d73");
        $(".sorting_desc").css("background-color", "#7b2d73");
        $(".sorting_asc_disabled").css("background-color", "#7b2d73");
        $(".sorting_desc_disabled").css("background-color", "#7b2d73");
        $(".sorting_disabled").css("background-color", "#7b2d73");
    }
}

function change_Active_InActive_Button_theme(index) {
    if (parseInt(index) == 4) {
        $(".bluebutton").css("background", "#7b2d73");
        $(".Activebutton").css("background", "#a5579d");
        $(".InActivebutton").css("background", "#7b2d73");
    }
}

function change_Timelinemenu_Button_theme(index) {
    if (parseInt(index) == 4) {
        $(".activeTimelineView").css("background-color", "#a5579d");
        $(".activeTimelineView").css("color", "#fff");
    }
}
function clear_Timelinemenu_Selected_BackColor_theme(index) {
    if (parseInt(index) == 4) {
        $(".innerTimelinemenu").css("background-color", "#fff");
        $(".innerTimelinemenu").css("color", "#000");
    }
}

function Set_Active_ReportPage_Selected_BackColor_theme(index) {
    if (parseInt(index) == 4) {
        $("a.active").css("background", "#8f4187 url(images/menu-arrow.png) no-repeat 102% center")
    }
}

