using System;
using System.Drawing;

using MonoTouch.UIKit;


using MonoTouch.Foundation;


using MonoTouch.MapKit;
using System.Collections.Generic;
using MonoTouch.CoreLocation;
using System.IO;




using System.Net;
using System.Linq;
using System.Json;
using MonoTouch.CoreFoundation;

namespace Mappir
{
	public class AnotacionRuta
	{
		public double Latitude { get; set; }

		public double Longitude { get; set; }

		public string Image { get; set; }

		public string Titulo { get; set; }

		public string Nombre { get; set; }

		public string Indicacion { get; set; }

		public string Estado { get; set; }

		public string Edo { get; set; }

		public string Municipio { get; set; }

		public float TiempoEstimado { get; set; }

		public float Distancia { get; set; } 

		public float casetaParcial { get; set; }

		public float gasConsumida { get; set; }

		public float gasParcial { get; set; }

		public int tipoIndicacion   { get; set; }

		public List<CLLocationCoordinate2D> coordenadas   { get; set; }

		public AnotacionRuta ()
		{
			this.gasParcial = 0;
			this.gasConsumida = 0;
			this.casetaParcial = 0;
			this.Distancia = 0;
			this.TiempoEstimado = 0;
		}

	//	"titulo","nombre","indicacion","estado","edo","munipio","tiempoEstimado","distancia”,
	//	"casetaParcial","gasConsumida","gasParcial","punto []","caseta []","alerta []”,
	//	"tipoIndicacion",”puntoIntermedio”

	}
}

