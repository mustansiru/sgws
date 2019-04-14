<%@ Application Language="C#" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
    }

    void Application_Error(object sender, EventArgs e)
    {
        //// Code that runs when an unhandled error occurs
        //Exception exc = Server.GetLastError();

        //// Handle HTTP errors
        //Server.Transfer("404.aspx");

        //// Clear the error from the server
        //Server.ClearError();
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
    }
    protected void Application_AcquireRequestState(Object sender, EventArgs e)
    {

        if (HttpContext.Current.Request.Headers["X-Requested-With"] == "XMLHttpRequest")
        {
            try
            {
                if (!HttpContext.Current.Request.Url.OriginalString.Contains(".ashx") && (HttpContext.Current.Session == null || HttpContext.Current.Session["LoggedInUser"] == null))
                {
                    Context.Response.ContentType = "application/json";
                    Context.Response.StatusCode = 403;
                    Context.Response.Write(
                new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { error = "ajaxcallerror" })
                );
                }
                if (HttpContext.Current.Request.Url.OriginalString.Contains(".ashx") && HttpContext.Current.Session.Contents.Count == 0)
                {
                    Context.Response.ContentType = "application/json";
                    Context.Response.StatusCode = 403;
                    Context.Response.Write(
                new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { error = "ajaxcallerror" })
                );
                }
            }
            catch (Exception ex)
            {
                Context.Response.ContentType = "application/json";
                Context.Response.StatusCode = 403;
                Context.Response.Write(
            new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { error = "ajaxcallerror" })
            );
            }
        }
    }

</script>
