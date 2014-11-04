using System;
using System.Collections.Generic;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;
using MonoTouch.MapKit;

using MonoTouch.CoreLocation;
using System.IO;
using System.Linq; 

namespace Mappir
{
	public abstract class AlertasMap
	{
		protected const double withBackground   = 200;
		protected const double heightBackground = 300;



		protected const string imageLayout = "MenuRadial/TransparentBackground.png";
		protected const string imageBackgroundMenu    = "MenuAlertas/FondoAlertas.png";
		protected const string imageFondoIconos       = "MenuAlertas/FondoIconos.png";


		protected const string imageBache             = "MenuAlertas/Bache.png";
		protected const string imageAccidente         = "MenuAlertas/Accidente.png";

		protected const string imageBloqueo           = "MenuAlertas/Bloqueo.png";
		protected const string imageCondicionInsegura = "MenuAlertas/CondicionInseg.png";

		protected const string imageRadarVel          = "MenuAlertas/RadarVelocidad.png";
		protected const string imageCongestionamiento = "MenuAlertas/Congestionamiento.png";

		protected const string imageManifestacion     = "MenuAlertas/Manifestacion.png";
		protected const string imageReten             = "MenuAlertas/Reten.png";

		protected const string imagePolicia           = "MenuAlertas/Policía.png";
		protected const string imageObras             = "MenuAlertas/Obras.png";

		protected List<ToolItem> alertasCollection {
			get;
			set;
		}
		protected UIView container {
			get;
			set;
		}

		protected MappirViewController parent{
			get;
			set; 
		}
		public MKMapView map {
			get;
			set;
		}

		public AlertasMap ()
		{



		}

		protected void ocultaAlertasIconos (){

			for(int i = 0; i < alertasCollection.Count; i++){
				alertasCollection[i].NormalImage.RemoveFromSuperview();

			} 

		}

		protected virtual UIButton crearAlerta(string imagePath){

			var toolButton = UIButton.FromType(UIButtonType.Custom);
			toolButton.SetImage(UIImage.FromFile (imagePath), UIControlState.Normal);


			toolButton.TouchUpInside += delegate
			{ 

				//selectorAlerta(imagePath);

			};


			return toolButton;
		}


		protected void crearAlertas(){

			alertasCollection = new List<ToolItem> ();

			//baches
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageBache) 
			});

			//Accidente
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageAccidente) 
			});

			//bloqueo
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageBloqueo) 
			});

			//condicion insgura
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageCondicionInsegura) 
			});

			//Radar
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageRadarVel) 
			});

			//Congestionamiento
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageCongestionamiento) 
			});

			//Manifestacion
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageManifestacion) 
			});

			//Obras
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageReten) 
			});

			//Policia
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imagePolicia) 
			});

			//Obras
			alertasCollection.Add(new ToolItem () {
				NormalImage = crearAlerta (imageObras) 
			});

		} 

		protected	void  mostrarAlertasIconos(){
			//Ubicar en su posicion

			alertasCollection[0].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 40),(float) (container.Bounds.Height -heightBackground + 15 -50 ), 35,35);
			container.Add(alertasCollection[0].NormalImage);

			alertasCollection[1].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 125),(float)( container.Bounds.Height -heightBackground + 15 -50), 35,35);
			container.Add(alertasCollection[1].NormalImage);


			alertasCollection[2].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 40), (float)(container.Bounds.Height -heightBackground + 75-50), 35,35);
			container.Add(alertasCollection[2].NormalImage);


			alertasCollection[3].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 125), (float)(container.Bounds.Height -heightBackground + 75-50), 35,35);
			container.Add(alertasCollection[3].NormalImage);



			alertasCollection[4].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 40), (float)(container.Bounds.Height -heightBackground + 135-50), 35,35);
			container.Add(alertasCollection[4].NormalImage);



			alertasCollection[5].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 125), (float)(container.Bounds.Height -heightBackground + 135-50), 35,35);
			container.Add(alertasCollection[5].NormalImage);


			alertasCollection[6].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 40),(float) (container.Bounds.Height -heightBackground + 195-50), 35,35);
			container.Add(alertasCollection[6].NormalImage);


			alertasCollection[7].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 125), (float)(container.Bounds.Height -heightBackground + 185-50), 35,35);
			container.Add(alertasCollection[7].NormalImage);


			alertasCollection[8].NormalImage.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 40), (float)(container.Bounds.Height -heightBackground + 255-50), 35,35);
			container.Add(alertasCollection[8].NormalImage);


			alertasCollection[9].NormalImage.Frame = new RectangleF(((float)(container.Bounds.Width -withBackground)/2 + 125), (float)(container.Bounds.Height -heightBackground + 255-50), 35,35);
			container.Add(alertasCollection[9].NormalImage);


		}
		public void traerAlertasGuardadas(){

			this.parent.lstAlertas = AlertaManager.GetAlertas().ToList();
			 
		}
		public void mostrarTodasAlertasGuardadas(){
			traerAlertasGuardadas ();
			ActualizarAlertasMapa ();
		}
		public void ActualizarAlertasMapa(){

			this.map.Delegate = new CustomMapDelegate (this.parent.lstAlertas);

			//Crear anotacion
			this.parent.lstAlertas.ForEach (x => map.AddAnnotation (new MKPointAnnotation () {
				Title = x.Title,
				Coordinate = new CLLocationCoordinate2D () {
					Latitude = x.Latitude,
					Longitude = x.Longitude
				}
			}));

		}
		public void ocultarTodasAlertasGuardadas(){
			this.parent.lstAlertas = new List<Alerta> ();
			this.map.Delegate = new CustomMapDelegate (this.parent.lstAlertas);

			map.RemoveAnnotations (map.Annotations);

			//ActualizarAlertasMapa ();
		}

	}
}

