
namespace Amptools
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Web;
	using Microsoft.Practices.Unity;
	using Amptools.App.Models;

	public partial class MvcApplication : Microsoft.Practices.Unity.i
	{
		public void RegisterDependencyInjection()
		{
			IUnityContainer container = new UnityContainer();
			this.Application["UnityContainer"] = container;

			container.RegisterType<IWikiService>(new ContainerControlledLifetimeManager());
		}
	}
}
