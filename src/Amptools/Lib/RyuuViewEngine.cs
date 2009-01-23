using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Amptools.Lib
{
    public class RyuuViewEngine : WebFormViewEngine 
    {

        public RyuuViewEngine()
        {

            

            this.ViewLocationFormats = new[] { 
                "~/Public/{0}.aspx",
                "~/Public/{0}.ascx",
                "~/App/Views/{1}/{0}.aspx",
                "~/App/Views/{1}/{0}.ascx",
                "~/App/Views/Layouts/{0}.aspx",
                "~/App/Views/Layouts/{0}.ascx",
            };

            this.MasterLocationFormats = new[] {
                "~/Public/{0}.master",
                "~/Shared/{0}.master",
                "~/App/Views/{1}/{0}.master",
                "~/App/Views/Layouts/{0}.master",
            };

            this.PartialViewLocationFormats = new[] { 
                "~/Public/{0}.aspx",
                "~/Public/{0}.ascx",
                "~/Public/_{0}.aspx",
                "~/Public/_{0}.ascx",
                "~/App/Views/{1}/_{0}.aspx",
                "~/App/Views/{1}/_{0}.ascx",
                "~/App/Views/Layouts/_{0}.aspx",
                "~/App/Views/Layouts/_{0}.ascx",
                "~/App/Views/{1}/{0}.aspx",
                "~/App/Views/{1}/{0}.ascx",
                "~/App/Views/Layouts/{0}.aspx",
                "~/App/Views/Layouts/{0}.ascx",
            };
        }

		public override ViewEngineResult FindPartialView(ControllerContext controllerContext, string partialViewName)
		{
			if (partialViewName.Contains("/"))
			{
				var parts = partialViewName.Split("/".ToCharArray());
				if (parts.Length == 2)
				{
					string path = "";
					string format = "~/App/Views/{0}/{1}.ascx";

					path = string.Format(format, parts);
					if (this.VirtualPathProvider.FileExists(path))
						return new ViewEngineResult(this.CreatePartialView(controllerContext, path), this);
					else
					{
						path = string.Format(format, parts[0], "_" + parts[1]);
						if(this.VirtualPathProvider.FileExists(path))
							return new ViewEngineResult(this.CreatePartialView(controllerContext, path), this);
					}
				}
			}
			return base.FindPartialView(controllerContext, partialViewName);
		}

    }
}
