using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
[System.Web.Script.Services.ScriptService]
public partial class Save : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //[System.Web.Services.WebMethod]
    //public static string GetCurrentTime(string name)
    //{
    //    return "Hello " + name + Environment.NewLine + "The Current Time is: "
    //        + DateTime.Now.ToString();
    //}


    [System.Web.Services.WebMethod]
    public static string GetCurrentTime()
    {
        return DateTime.Now.ToString("HH:mm:ss");
    }

    [System.Web.Services.WebMethod]
    public static string GetCurrentDate()
    {
        return DateTime.Now.ToString("yyyy-MM-dd");
    }




    [System.Web.Services.WebMethod]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Xml)]
    public static string WriteXML(string xmlStr, string path)
    {
        string filepath = System.Web.HttpContext.Current.Server.MapPath("./" + path);
        XmlDocument doc = new XmlDocument();
        doc.LoadXml(xmlStr);
        //var dates = doc.FirstChild.ChildNodes;
        //foreach (XmlNode date in dates) {
        //    if (date.Attributes[0].ToString() == DateTime.Now.ToString("yyyy-MM-dd"))
        //    {
        //        return "found";
        //    }
        //    else {
        //        return "notfound";
        //    }
        //}
        doc.Save(filepath);
        return "ok";
    }
    [System.Web.Services.WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string WriteJSON(string jsonStr, string path)
    {
        string filepath = System.Web.HttpContext.Current.Server.MapPath("./" + path);
        FileStream file = new FileStream(filepath, FileMode.OpenOrCreate, FileAccess.Write);
        file.SetLength(0);
        // Create a new stream to read from a file
        StreamWriter sr = new StreamWriter(file);
        //write the jsonstr to the file
        sr.Write(jsonStr);
        // Close StreamReader
        sr.Close();
        // Close file
        file.Close();
        return "ok";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //string s = Save.WriteXML("<Badr><Data>Mohamed Badr</Data></Badr>", "D://t.xml");
    }
}