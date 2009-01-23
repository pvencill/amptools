

namespace Amptools
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Mvc;
    using System.Web.Routing;

    public partial class MvcApplication : HttpApplication
    {
       

        protected void Application_Start(object sender, EventArgs e)
        {
            ViewEngines.Engines.Clear();
            ViewEngines.Engines.Add(new Lib.RyuuViewEngine());

            RegisterRoutes(RouteTable.Routes);

            
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            var path = this.Context.Request.Url.AbsolutePath.ToLower();
            if (!path.Contains("/public/"))
            {
                var index = path.LastIndexOf(".");
                var uri = this.Context.Request.Url;
                var app = this.Context.Request.ApplicationPath;
                if (index > 0)
                {
                    var ext = path.Substring(index);
                    if (new[] { ".jpg", ".gif", ".aspx", ".html", ".htm", ".css", 
						".js", ".ico", ".png", ".swf", ".svg", ".htc", ".vcf" }.Contains(ext))
                    {
                        var baseUrl = uri.GetLeftPart(UriPartial.Authority);
                        var query = uri.PathAndQuery;

                        if (path.Contains("~/"))
                        {
                            query = query.Substring(query.IndexOf("~/") + 1);
                        }

                        if (app == "/")
                            app = "";
                        else
                            query = query.Replace(app, "");

                        Context.RewritePath(app + "/public" + query);
                    }
                }
            }
            
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}
