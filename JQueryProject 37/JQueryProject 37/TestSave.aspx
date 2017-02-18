<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestSave.aspx.cs" Inherits="TestSave" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="JQuery/jquery-3.1.1.js"></script>
    <script>
        var obj = {};
        $(function () {
            $("#b1").click(function () {
                obj.xmlStr = "<test>III</test>";
                obj.path = "test.xml";
                $.ajax({
                    type: "POST",
                    url: "Save.aspx/WriteXML",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(obj),
                    dataType: "json",
                    success: function (r) {
                        alert(r.d)
                    },
                    error: function () {
                        alert("Error")
                    }
                });
            });
            $("#b2").click(function () {

                var arr = new Array();
                arr[0] = { name: "Mohamed Badr", age: 29 };
                arr[1] = { name: "Ali Ahmed", age: 25 };
                arr[2] = { name: "Sara Mohamed", age: 26 };
                obj.jsonStr = JSON.stringify(arr);

                //obj.jsonStr = "test",
                    //JSON.stringify(arr)//'[{"name":"Sara","Age":20},{"name":"Ali","Age":25},{"name":"Mahmoud","Age":17},{"name":"Salma","Age":18}]',
                //obj.path = "D://JQueryProject35/cdcatalog.xml"
                obj.path = "test.txt";
                $.ajax({
                    type: "POST",
                    //url: "WriteWebService.asmx/WriteXML",
                    url: "Save.aspx/WriteJSON",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(obj),
                    dataType: "json",
                    success: function (r) {
                        alert(r.d)
                    },
                    error: function () {
                        alert("Error")
                    }
                });
            })
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input id="b1" type="button" value="Save XML" />
        <input id="b2" type="button" value="Save JSON" />
    
    </div>
    </form>
</body>
</html>
