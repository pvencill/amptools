

namespace Amptools
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Mvc;
    using System.Web.Routing;

    public partial class MvcApplication 
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default",                                              // Route name
                "{controller}/{action}/{id}",                           // URL with parameters
                new { controller = "Blog", action = "Index", id = "" }  // Parameter defaults
            );


			routes.MapRoute(
				"Blog",
				"{year}/{month}/{title}",
				new { controller = "Blog", action = "Blog", id = "" },
				new { year = @"\d{4}", month = @"\d{2}", }
				);
        }
    }
}
