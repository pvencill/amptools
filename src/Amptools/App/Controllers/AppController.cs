
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

namespace Amptools.Controllers
{
    public class AppController : Controller
    {
    
        protected override void HandleUnknownAction(string actionName)
        {
            this.ViewData["Title"] = "Amptools: " + actionName;

            this.View(actionName).ExecuteResult(this.ControllerContext);
        }
    }
}
