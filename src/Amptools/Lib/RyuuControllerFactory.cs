
namespace Amptools.Lib
{
	using System.Web;
	using System.Web.Mvc;
	using Microsoft.Practices.Unity;

	public class RyuuControllerFactory : DefaultControllerFactory
	{


		#region IControllerFactory Members

		public override IController CreateController(System.Web.Routing.RequestContext requestContext, string controllerName)
		{
			var container = (IUnityContainer)requestContext.HttpContext.Application["UnityContainer"];
			var controllerType = this.GetControllerType(controllerName);

			
			return container.Resolve(controllerType)
				as IController;
		}

		

		#endregion
	}
}
