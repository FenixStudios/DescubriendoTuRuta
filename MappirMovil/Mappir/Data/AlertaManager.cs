using System;
using System.Collections.Generic;

namespace Mappir {
	/// <summary>
	/// Manager classes are an abstraction on the data access layers
	/// </summary>
	public static class AlertaManager {
		static AlertaManager ()
		{

		}
		
		public static Alerta GetAlerta(int id)
		{
			return AlertaRepositoryADO.GetAlerta(id);
		}
		
		public static IList<Alerta> GetAlertas ()
		{
			return new List<Alerta>(AlertaRepositoryADO.GetAlertas());
		}
		
		public static int SaveAlerta (Alerta item)
		{
			return AlertaRepositoryADO.SaveAlerta(item);
		}
		
		public static int DeleteAlerta(int id)
		{
			return AlertaRepositoryADO.DeleteAlerta(id);
		}
	}
}