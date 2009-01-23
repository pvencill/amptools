

namespace Amptools.App.Helpers
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using System.Web.Mvc;

    using Html = System.Web.Mvc.HtmlHelper;

    public static class HtmlHelper
    {
        public static string Test(this Html obj)
        {
            return "Test";
        }


    }
}
