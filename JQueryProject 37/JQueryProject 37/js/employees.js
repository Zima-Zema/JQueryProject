$(function () {
    //visaual effects 
    $("#lihome").addClass("active");
    $("#imgBannertext").html("Home");
    //jquery code
    var time;
    var date1 = "";
    var reponse;
    getDate();
    $("#sendmessage").hide();
    intervalid = setInterval(function () {
        var now = new Date();
        $("#date").val(now.toLocaleTimeString('en-GB'));
    }, 1000);
    function getDate() {
        $.ajax({
            type: "POST",
            url: "Save.aspx/GetCurrentDate",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                date1 = msg.d;
            },
            error: function (r) {
                alert("error");
            }
        });
    }

    var data = new Array();
    $.ajax({
        url: "empData.txt",
        success: function (res) {
            reponse = res;
            data = JSON.parse(reponse);
            for (var i = 0; i < data.length; i++) {
                $("#empName").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
            }
        }
    });

    $("#empName").change(function () {
        $("#empId").val($("#empName option:selected").val());
    });
    var obj = {};
    var m;
    $.ajax({
        url: "attendanceBook.xml",
        success: function (res) {
            m = res;
            //console.log($(m).find("attendanceBook").find("employee").html());
        },
        error: function () {
            alert("error");
        }
    });

    $("#btn_Save").on("click", function () {
        var dayDate = $.trim(date1);
        var empId = $.trim($("#empId").val());
        var empName = $("#empName option:selected").text();
        var aTime = $.trim($("#date").val());
        var lTime = 0;
        var status = $("#attendaceType option:selected").text();
        var txt = $(m).find("attendanceBook").html();
        var employee;
        if (status == "Attendance") {
            var found = 1;
            if ($(m).find("employee").length == 0) {
                employee = " <employee><currentDate>" + dayDate + "</currentDate><employeeNo>" + empId + "</employeeNo><employeName>" + empName + "</employeName><arrivalTime>" + aTime + "</arrivalTime><leaveTime>" + lTime + "</leaveTime><totalHours>" + 0 + "</totalHours></employee>";
                found = 0;
                $("#sendmessage").show();
                $("#errormessage").hide();
            }
            else {
                $(m).find("employee").each(function (index) {
                    {
                        var date = $.trim($(this).children("currentDate").text());
                        var id = $.trim($(this).children("employeeNo").text());
                        if (dayDate == date && empId == id) {
                            $("#errormessage").text("Employee " + empName + " Can't Attend twice Aday").addClass("navbar-brand").show();
                            $("#sendmessage").hide();
                            found = 0;
                            return;
                        }
                    }
                });
                if (found !== 0) {
                    employee = " <employee><currentDate>" + dayDate + "</currentDate><employeeNo>" + empId + "</employeeNo><employeName>" + empName + "</employeName><arrivalTime>" + aTime + "</arrivalTime><leaveTime>" + lTime + "</leaveTime><totalHours>" + 0 + "</totalHours></employee>";
                    $("#sendmessage").show();
                    $("#errormessage").hide();
                }
            };
        }
        else {
            $(m).find("employee").each(function (index) {
                var date = $(this).children("currentDate").text();
                var id = $(this).children("employeeNo").text();
                var leaveTime = $(this).children("leaveTime").text();

                if (dayDate == date && empId == id && leaveTime == 0) {
                    var lTme = aTime;
                    var leave = $(this).find("leaveTime").text(lTme);
                    $("#sendmessage").text("Your leaving data is set. Thank you").show();
                    $("#errormessage").hide();
                }
                else if (dayDate == date && empId == id && leave != 0) {
                    $("#errormessage").text("Employee named " + empName + " Can't Leave More than Once !!").show();
                    $("#sendmessage").hide();
                    return;
                }
                else {
                    $("#errormessage").text("Employee named " + $("#empname").val() + " Has not attended So You Can't Save Leave Time for Him !!").show();
                    $("#sendmessage").hide();
                    return;
                }
            });
        }
        $(m).find("attendanceBook").append(employee);
        var obj = {};
        obj.xmlStr = "<attendanceBook>" + $(m).find("attendanceBook").html() + "</attendanceBook>";
        obj.path = "attendanceBook.xml";
        $.ajax({
            //url--class+method
            url: "Save.aspx/WriteXML",
            //shape of data that will send
            contentType: "application/json; charset=utf-8",
            //if not write --will send data in querystring
            type: "POST",
            //obj that send from text
            data: JSON.stringify(obj),
            //shape of data that will recevied
            dataType: "json",
            //success
            success: function (respond) {
                //alert(respond);
                //alert(respond.d);
            },
            //error
            error: function () {
                alert("something went wrong");
            }
        });//ajax
    });
});