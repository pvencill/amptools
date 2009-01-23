using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

namespace Amptools.App.Controllers
{
	using Models;
	using Microsoft.Practices.Unity;

	public class WikiController : Controller
	{

		[Dependency()]
		public IWikiService Service { get; set; } 

		public ActionResult Index()
		{
			// Add action logic here
			throw new NotImplementedException();
		}
	}
}
