using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using MonoTouch.MapKit;
using System.Collections.Generic;
using MonoTouch.CoreLocation;
using System.IO;

namespace Mappir
{
	public static class HelperUtilities
	{ 
		public static UIImage GetImage(string imageName, float height, float width)
			{
				var documents =
					Environment.GetFolderPath (Environment.SpecialFolder.Resources);

				var filename = Path.Combine (documents, imageName);

			var image = UIImage.FromFile (filename).Scale(new SizeF() {Height=height, Width=width});

				return image;
			}

		public static tiposPuntos getTypePoint(string name){

			tiposPuntos tipo = new tiposPuntos ();

			switch (name) {

			case "Accidente":
				tipo = tiposPuntos.Accidente;
		      break;
			case "Bache":
				tipo = tiposPuntos.Bache;
				break;
			case "Bloqueo":
				tipo = tiposPuntos.Bloqueo;
				break;	
			case "CondicionInseg":
				tipo = tiposPuntos.CondicionInsegura;
				break;		
			case "RadarVelocidad":
				tipo = tiposPuntos.RadarVelocidad;
				break;				
			case "Congestionamiento":
				tipo = tiposPuntos.Congestionamiento;
				break;
			case "Manifestacion":
				tipo = tiposPuntos.Manifestacion;
				break;
			case "Reten":
				tipo = tiposPuntos.Reten;
				break;
			case "Policía":
				tipo = tiposPuntos.Policia;
				break;
			case "Obras":
				tipo = tiposPuntos.Obras;
				break;
				 
			}
			return tipo; 
 		}
		 
	}
}

