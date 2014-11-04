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
  public enum tiposPuntos{
		Bache,
		Accidente,
		Bloqueo,
		CondicionInsegura,
		RadarVelocidad,
		Congestionamiento,
		Manifestacion,
		Reten,
		Policia,
		Obras
	}

	public class MenuAlertas: AlertasMap
	{ 


		public double currentLongitud {
			get;
			set;
		}
		public double currentLatitud {
			get;
			set;
		}

		private UIButton backgroundLayout {
			get;
			set;
		} 

	

		private UIImageView backgroundMenuAlertas {
			get;
			set;
		} 
		private UIImageView backgroundIconos {
			get;
			set;
		} 
		 
		public CLLocationManager locManager {
			get;
			set;
		}
	

	 
		public MenuAlertas (UIView container, MKMapView mapa, MappirViewController parent )
		{
			this.container = container;
			this.map = mapa;
			this.parent = parent;

			locManager = new CLLocationManager(); 

			if (locManager.Location == null) {
		    	//Activando gps
				locManager.StartUpdatingLocation ();
			}

			if (locManager.Location != null) {
				this.currentLatitud = locManager.Location.Coordinate.Latitude;
				this.currentLongitud = locManager.Location.Coordinate.Longitude;
		 

			 
				//Evento para actualizar la coordenada
				locManager.LocationsUpdated += delegate(object sender, CLLocationsUpdatedEventArgs e) {

					foreach (CLLocation l in e.Locations) {
						Console.WriteLine (l.Coordinate.Latitude.ToString () + ", " + l.Coordinate.Longitude.ToString ());
						this.currentLatitud = l.Coordinate.Latitude;
						this.currentLongitud = l.Coordinate.Longitude;
					} 
				}; 


		 
				crearFondoMenuAlerta ();
				crearAlertas ();

				//cargar imagen transparente
				crearImagenTransparente ();

				mostrarBackGroundMenu ();
				mostrarAlertasIconos ();
			} else {

				UIAlertView _error = new UIAlertView ("gps desactivado", "Para crear alertas, es necesario activar el gps en ajustes", null, "Aceptar", null);

				_error.Show ();

			//gps esta apagado activarlo
				//map.ShowsUserLocation = true;
				locManager.StartUpdatingLocation ();
			}

			//Alertas en el mapa
			parent.lstAlertas = new List<Alerta> ();
			  
			//mostrarTodasAlertasGuardadas ();
		}

		private void crearImagenTransparente(){
		 
			backgroundLayout = UIButton.FromType(UIButtonType.Custom);
			backgroundLayout.Frame = new RectangleF(0, 0, container.Bounds.Width, container.Bounds.Height);
			backgroundLayout.SetImage(UIImage.FromFile(imageLayout), UIControlState.Normal);

		    //Configuraciones de eventos________________________________________________________
            backgroundLayout.TouchUpInside += (object sender, EventArgs e) => {
				   backgroundLayout.RemoveFromSuperview();
			 
					ocultaBackGroundMenu();
					ocultaAlertasIconos ();
			};
			  
			//Colocar el boton en el contenedor _______________________________________________
				container.Add(backgroundLayout);

		}
		private void crearFondoMenuAlerta(){
		 
			 
			backgroundMenuAlertas =  new UIImageView (UIImage.FromBundle(imageBackgroundMenu));
            
			backgroundMenuAlertas.Hidden = true;
	 
	 

			backgroundIconos =  new UIImageView (UIImage.FromBundle(imageFondoIconos));
		 
			backgroundIconos.Hidden = true;
	 

		}



		protected override UIButton crearAlerta(string imagePath){

			var toolButton = UIButton.FromType(UIButtonType.Custom);
			toolButton.SetImage(UIImage.FromFile (imagePath), UIControlState.Normal);


			toolButton.TouchUpInside += delegate
			{ 

				selectorAlerta(imagePath);

			};


			return toolButton;
		}

		private	void mostrarBackGroundMenu(){
		 
			backgroundMenuAlertas.RemoveFromSuperview ();

		 
			backgroundIconos.RemoveFromSuperview ();
		 
			 
			backgroundMenuAlertas.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2  ), (float)(container.Bounds.Height -heightBackground - 50 ),(float) withBackground,(float)heightBackground);
			container.Add (backgroundMenuAlertas);
			 
			backgroundMenuAlertas.Hidden = false;
		 
		
			 
			backgroundIconos.Frame = new RectangleF((float)((container.Bounds.Width -withBackground)/2 + 15 ), (float)(container.Bounds.Height -heightBackground -50 ),(float) (withBackground -30),(float)heightBackground);
			container.Add (backgroundIconos);
			 
			backgroundIconos.Hidden = false;
		 
		
		}
		private void ocultaBackGroundMenu(){

			backgroundMenuAlertas.RemoveFromSuperview ();
			backgroundIconos.RemoveFromSuperview ();
		 
		}
	

	
		private void selectorAlerta (string image){
		 
			//Esconder
			backgroundLayout.RemoveFromSuperview(); 
			ocultaBackGroundMenu();
			ocultaAlertasIconos ();

			//Crear anotacion 

			//Agregar anotacion en el mapa
			Alerta actualAlerta = crearAlertaPunto(image);

			if (actualAlerta != null) {
				 
				//guardar la alerta en la base de datos
				AlertaManager.SaveAlerta(actualAlerta); 

				///Agregar la alerta a la lista de alertas visibles en el mapa
				parent.lstAlertas.Add (actualAlerta);

				ActualizarAlertasMapa ();
			}
		
		}
		public Alerta crearAlertaPunto(string image){
			//Obtener las alertas de archivo guardado

			Alerta alerta = null;
			 
			//Los valores de georeferencia son validos?
			if (this.currentLatitud > 0) {

				string title = image.Replace (".png","" ).Replace ("MenuAlertas/", "");
				 
				alerta = new Alerta (title, this.currentLatitud, this.currentLongitud, image, Convert.ToInt32 (HelperUtilities.getTypePoint (image)));
				 			
			} else {
				//buscar la coordenada actual

			}

			return alerta;	
		}
		  

	
	}
}

