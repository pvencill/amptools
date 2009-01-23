using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

namespace Amptools.App.Controllers
{
	public class BlogController : Controller
	{
		public ActionResult Index()
		{
			return this.View("~/Public/Index.aspx");
		}

		public ActionResult Blog()
		{
			var year = Convert.ToInt32(this.Request.Params["year"]);
			var month = Convert.ToInt32(this.Request.Params["month"]);
			var title = this.Request.Params["title"].Replace(".aspx", "");
			return this.View("~/Blog/" + year + "/" + month + "/" + title + ".aspx");
		}
	}
}
