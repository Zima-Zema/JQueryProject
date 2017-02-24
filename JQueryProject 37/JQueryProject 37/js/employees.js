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
        },
        error: function () {
            alert("error");
        }
    });
    function timeToSeconds(time) {
        timeArray = time.split(':')
        var minutes = (timeArray[0] * 60) + (timeArray[1] * 1);
        var seconds = (minutes * 60) + (timeArray[2] * 1);
        return seconds;
    }
    function secondsToTime(secs) {
        var hours = Math.floor(secs / (60 * 60));
        hours = hours < 10 ? '0' + hours : hours;
        var divisor_for_minutes = secs % (60 * 60);
        var minutes = Math.floor(divisor_for_minutes / 60);
        minutes = minutes < 10 ? '0' + minutes : minutes;
        var divisor_for_seconds = divisor_for_minutes % 60;
        var seconds = Math.ceil(divisor_for_seconds);
        seconds = seconds < 10 ? '0' + seconds : seconds;
        return hours + ':' + minutes + ':' + seconds;
    }
    $("#btn_Save").on("click", function () {
        var dayDate = $.trim(date1);
        var empId = $.trim($("#empId").val());
        var empName = $("#empName option:selected").text();
        var aTime = $.trim($("#date").val());
        var lTime = 0;
        var status = $("#attendaceType option:selected").text();
        var txt = $(m).find("attendanceBook").html();
        var employee;
        var found = 1;
        if (status == "Attendance") {
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
                            alert(id);
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
                var arriveTime = $(this).children("arrivalTime").text();
                if (dayDate == date && empId == id && leaveTime == 0) {
                   // alert(id);
                    //alert(leaveTime);
                    //alert(date);
                    var lTme = aTime;
                    var leave = $(this).find("leaveTime").text(lTme);
                    var presenceTime = timeToSeconds(arriveTime);
                    var leavTime = timeToSeconds(lTme);
                    var workPeriod = leavTime - presenceTime;
                    var totalhours = secondsToTime(workPeriod);
                    $(this).find("totalHours").text(totalhours);
                    $("#sendmessage").text("Your leaving data is set. Thank you").show();
                    $("#errormessage").hide();
                }
                else if (dayDate == date && empId == id && leaveTime != 0) {
                    //alert(id);
                    //alert(leaveTime);
                    //alert(date);
                    $("#errormessage").text("Employee named " + empName + " Can't Leave More than Once !!").show();
                    $("#sendmessage").hide();
                    return;

                }
                else {
                    if (empId == id) {
                        $("#errormessage").text("Employee named " + empName + " Has not attended So You Can't Save Leave Time for Him !!").show();
                        $("#sendmessage").hide();
                        return;
                    }
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