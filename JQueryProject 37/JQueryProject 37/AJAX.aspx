<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AJAX.aspx.cs" Inherits="AJAX" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server">Ajax</title>
    <style>
        div {
            margin:20px auto;
        }
        table{
            border : 1px solid black;
        }
        .HP {
            background-color:Highlight;
        }
        .LP {
            background-color:hotpink;
        }
    </style>
    <script src="JQuery/jquery-3.1.1.js"></script>
    <script>
        //error: function (xhr, ajaxOptions, thrownError) {
        //    alert(xhr.status);
        //    alert(thrownError);
        //}
        var m;
        $(function () { 
            $("#b1").click(function () {
                $.ajax({
                    url: "cdcatalog.xml",
                    cache:false,
                    success: function (r) {
                        m = r;
                        var CDs = $(r).find("CD");
                        $("#l1").text("CDs Count = " + CDs.length);
                        //alert("success" + CDs.length);
                        $("#content").append("<table id='dataTable' border='1'><tr><th>No.</th><th>Title</th><th>Author</th><th>Price</th></tr></table>");
                        $(CDs).each(function (i) {
                            var price = Number($(this).find("PRICE").text());
                            $("#dataTable").append("<tr><td>" + (i + 1) + "</td><td>" + $(this).find("TITLE").text() + "</td><td>" + $(this).find("ARTIST").text() + "</td><td>" + $(this).find("PRICE").text() + "</td></tr>");
                            (price < 10) ? $("#dataTable tr:last").addClass("LP") : $("#dataTable tr:last").addClass("HP");
                        });
                    },
                    error: function (e) {
                        alert("error");
                    }
                });
            });
            $("#b2").click(function () {
                var CDs = $(m).find("CD");
                CDs.sort(function (a, b) {
                    var ap = Number($(a).find("PRICE").text());
                    var bp = Number($(b).find("PRICE").text());
                    return ((ap < bp) ? -1 : ((ap > bp) ? 1 : 0));
                });
                //Draw the Table Again
                $("#dataTable tr:gt(0)").remove();
                $(CDs).each(function (i) {
                    var price = Number($(this).find("PRICE").text());
                    $("#dataTable").append("<tr><td>" + (i + 1) + "</td><td>" + $(this).find("TITLE").text() + "</td><td>" + $(this).find("ARTIST").text() + "</td><td>" + $(this).find("PRICE").text() + "</td></tr>");
                    (price < 10) ? $("#dataTable tr:last").addClass("LP") : $("#dataTable tr:last").addClass("HP");
                });
                //alert("Haaaaaaaa");
                //mm = CDs;
            });
            $("#sel").change(function () {
                if ($(this).val() == 1) {
                    $(".LP").hide();
                    $(".HP").show();
                }
                else if ($(this).val() == 2) {
                    $(".HP").hide();
                    $(".LP").show();
                } else
                    $("#dataTable tr").show();
            });
            $("#titletxt").keyup(function () {
                var str = $(this).val().toLowerCase();
                $("#dataTable tr:gt(0)").each(function () {
                    var title = $(this).children(":eq(1)").text().toLowerCase();
                    if (title.indexOf(str) == -1) {
                        $(this).hide();
                    } else
                        $(this).show();
                });
                var count = $("#dataTable tr:gt(0):visible").length;
                $("#l1").text("CDs Count = " + count);
            });
            $("#authortxt").keyup(function () {
                var str = $(this).val().toLowerCase();
                $("#dataTable tr:gt(0)").each(function () {
                    var title = $(this).children(":eq(2)").text().toLowerCase();
                    if (title.indexOf(str) == -1) {
                        $(this).hide();
                    } else
                        $(this).show();
                });
                var count = $("#dataTable tr:gt(0):visible").length;
                $("#l1").text("CDs Count = " + count);
            });
        });
    </script>
</head>
<body>
    <script>
        
        $(function () {
            $("#newCD").click(function () {
                debugger;
                var CDtitle = $("#CDtitle").val();
                var CDartist = $("#CDartist").val();
                var CDcountry = $("#CDcountry").val();
                var CDprice = $("#CDprice").val();
                var CDcompany = $("#CDcompany").val();
                var CDyear = $("#CDyear").val();
                //var nnn = $.parseXML(m);

                var str = "<CD><TITLE>"+CDtitle+"</TITLE><ARTIST>"+CDartist+"</ARTIST><COUNTRY>"+CDcountry+"</COUNTRY><COMPANY>"+CDcompany+"</COMPANY><PRICE>"+CDprice+"</PRICE><YEAR>"+CDprice+"</YEAR></CD>";
                $(m).find("CATALOG").append(str);
                var CDs = $(m).find("CD");
                $("#dataTable tr:gt(0)").remove();
                $(CDs).each(function (i) {
                    var price = Number($(this).find("PRICE").text());
                    $("#dataTable").append("<tr><td>" + (i + 1) + "</td><td>" + $(this).find("TITLE").text() + "</td><td>" + $(this).find("ARTIST").text() + "</td><td>" + $(this).find("PRICE").text() + "</td></tr>");
                    (price < 10) ? $("#dataTable tr:last").addClass("LP") : $("#dataTable tr:last").addClass("HP");
                });
                $("new :text").each(function () {
                    $(this).val("");
                });
                //Save The New XML Document
                var d = {};
                d.xmlStr = "<CATALOG>" + $(m).find("CATALOG").html() +"</CATALOG>";
                d.path = "cdcatalog.xml"
                //D://JQueryProject35/cdcatalog.xml
                $.ajax({
                    type: "POST",
                    //url: "WriteWebService.asmx/WriteXML",
                    url: "Save.aspx/WriteXML",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(d),
                    dataType: "json",
                    success: function (r) {
                        alert(r.d)
                    },
                    error: function () {
                        alert("Error")
                    }
                });

            });
        });
    </script>
    <form id="form1" runat="server">
    <div>
        <div>
            <input type="button" value="Load XML" id="b1" />
            <input type="button" value="Sort With Price" id="b2" />
            <select id="sel">
                <option value="0">All</option>
                <option value="1">&gt 10</option>
                <option value="2">&lt 10</option>
            </select>
        </div>
        <div>
            <label>Search By Title : </label><input type="text" id="titletxt" />
            <label>Search By Author : </label><input type="text" id="authortxt" />
            <br />
            <label id="l1">CDs Count =  </label>
        </div>
        <div id="content">

        </div>
        <div id="new">
            <table>
                <tr>
                    <th>Title</th>
                    <td><input type="text" id="CDtitle" /></td>
                </tr>
                <tr>
                    <th>Artist</th>
                    <td><input type="text" id="CDartist" /></td>
                </tr>
                <tr>
                    <th>Country</th>
                    <td><input type="text" id="CDcountry" /></td>
                </tr>
                <tr>
                    <th>Price</th>
                    <td><input type="text" id="CDprice" /></td>
                </tr>
                <tr>
                    <th>Company</th>
                    <td><input type="text" id="CDcompany" /></td>
                </tr>
                <tr>
                    <th>Year</th>
                    <td><input type="text" id="CDyear" /></td>
                </tr>
                <tr>
                    <td colspan="2" >
                        <input id="newCD" type="button" value="Save" style="margin:5px 90px" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
