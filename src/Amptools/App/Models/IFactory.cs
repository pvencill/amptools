﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Amptools.App.Models
{
	public interface IFactory<T> 
	{
		T FindById(object id);
	}
}
