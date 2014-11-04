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


namespace Mappir {

	public class BuscarRuta : UIViewController {
		 
		private List<AnotacionRuta> lstRutas = new List<AnotacionRuta> ();
		private IndicaTableView vistaTableIndica{
			get;
			set;

		}
		protected MKMapView map;

		MKPolyline polylineOverlay;
		MKPolylineRenderer polylineRenderer;
		MKCircle circleOverlay;
		MKCircleRenderer circleRenderer;


		public BuscarRuta ( MKMapView mapa )
		{	
			this.map = mapa;

			this.map.OverlayRenderer = (m, o) => {
				if (o is MKPolyline){
				if(polylineRenderer == null) {
					polylineRenderer = new MKPolylineRenderer(o as MKPolyline);
					polylineRenderer.FillColor = UIColor.Green;

					polylineRenderer.LineWidth = 3;
					//polylineRenderer.LineCap = MonoTouch.CoreGraphics.CGLineCap.Square;
					polylineRenderer.StrokeColor = UIColor.Green; //= 100000;

					//polylineRenderer.FillColor = UIColor.Purple;
					//polylineRenderer.Alpha = 0.5f;
				}
				return polylineRenderer;
				}
				else if(o is MKCircle){
				if(circleRenderer == null) {
					circleRenderer = new MKCircleRenderer(o as MKCircle);
					circleRenderer.FillColor = UIColor.Purple;
					circleRenderer.Alpha = 0.5f;
				}
				return circleRenderer;
				}
				else return null;
			};

		}
		private void cargarVistaIndicacionesRuta(){

			vistaTableIndica = new IndicaTableView (lstRutas);

			//Crear los items de las indicaciones
			vistaTableIndica.View.Frame   = new RectangleF (0, 0, View.Bounds.Width, View.Bounds.Height);
			 
			Add(vistaTableIndica.View);
		}

		private void buscarRuta(){
			string url = "http://ttr.sct.gob.mx/TTR/rest/GeoRouteSvt?json={\"usr\":\"sct\",\"key\":\"sct\",\"origen\":{\"idCategoria\":\"A-2\",\"desc\":\"Tulancingo+de+Bravo,+Hidalgo\",\"idTramo\":239380,\"source\":2192695,\"target\":2192696,\"x\":-98.36848884,\"y\":20.09149176},\"destinos\":[{\"idCategoria\":\"A-3\",\"desc\":\"Villahermosa,+Centro,+Tabasco\",\"idTramo\":285382,\"source\":2227979,\"target\":2233871,\"x\":-92.9531,\"y\":17.9925}],\"opciones\":{\"casetas\":true,\"alertas\":true},\"vehiculo\":{\"tipo\":1,\"subtipo\":1,\"rendimiento\":16,\"combustible\":3,\"costoltgas\":\"12.80\",\"excedente\":\"0\"},\"ruta\":1}";

			HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create (url);
			//	cargarVistaIndicacionesRuta();
			request.BeginGetResponse ((r) =>
				{

					var httpRequest = (HttpWebRequest)r.AsyncState;
					var response = (HttpWebResponse)request.EndGetResponse(r);

					string res = null;
					using (StreamReader srd = new StreamReader(response.GetResponseStream())) {
						res = srd.ReadToEnd ();
					}


					var json = JsonValue.Parse(res);
					var status = json["status"];

					JsonArray results = (JsonArray)json["results"];

					var a = results[0];

					JsonArray tramos = (JsonArray)a["grafo"];


					lstRutas = new List<AnotacionRuta> ();

					foreach(var tramo in tramos){
						AnotacionRuta ar = new AnotacionRuta ();

						ar.Nombre =  tramo[1];

						ar.Indicacion = tramo[2];

						ar.Estado =  tramo[3];

						ar.Municipio =  tramo[5];

						ar.TiempoEstimado = tramo[6];
						ar.Distancia = tramo[7];

						ar.tipoIndicacion =  tramo[14];

						JsonArray paresCoords = (JsonArray)tramo[11];

						 
						ar.coordenadas = new List<CLLocationCoordinate2D>();

						//var coords = new List<CLLocationCoordinate2D>();

						for(int i = 0; i < paresCoords.Count(); i++){

							JsonArray parXY  = (JsonArray)paresCoords[i];
							CLLocationCoordinate2D item = new CLLocationCoordinate2D((double)parXY[1],(double)parXY[0]);
							ar.coordenadas.Add(item);
							//item.x = (double)parXY[0];
							//item.y = (double)parXY[1];

							//ar.coordenadas.Add(item); 
						}
						 

						ar.Image = getImageName(ar.tipoIndicacion);
						//string []valores = tramo.ToString().Split(",".ToCharArray());
						lstRutas.Add(ar);
					}

					//DispatchQueue.MainQueue.DispatchAsync(() => {cargarVistaBuscarRuta(); } );
					DispatchQueue.MainQueue.DispatchAsync(() => {mostrarRutaMapa(); } );

					 DispatchQueue.MainQueue.DispatchAsync(() => {cargarVistaIndicacionesRuta(); } );

				}, null);


		}
		private void mostrarRutaMapa(){

			var coords = new CLLocationCoordinate2D(24.976111, -99.132778);
			circleOverlay = MKCircle.Circle (coords, 100000);
			this.map.AddOverlay (circleOverlay);

		     for (int i = 0; i < lstRutas.Count; i++) {
				polylineOverlay = MKPolyline.FromCoordinates (lstRutas[i].coordenadas.ToArray ());
				this.map.AddOverlay (MKPolyline.FromCoordinates (lstRutas[i].coordenadas.ToArray ()));
			 }

		}
		private string getImageName(int index){

			string nameImage = "";
			switch (index) {

			case 0:
				nameImage = "Pin.png";
				break;

			case 1:
				nameImage = "Pin.png";
				break;

			case 2:
				nameImage = "rec.png";
				break;

			case 3:
				nameImage = "izqLig.png";
				break;

			case 4:
				nameImage = "derLig.png";
				break;

			case 5:
				nameImage = "izq.png";
				break;
			case 6:
				nameImage = "der.png";
				break;

			}

			return nameImage;

		}
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			///Configurar barra de navegacion 
		  

			var fondo = new UIImageView (UIImage.FromBundle ("MenuRadial/Fondo.png"));
			Add (fondo);

			UINavigationBar navBar = new UINavigationBar ();
			navBar.Frame = new RectangleF (0, 0, (float)View.Bounds.Width, (float)40);
			navBar.BarTintColor = UIColor.FromRGBA (0, 133, 61, 255);
			navBar.TintColor = UIColor.White;


			UINavigationItem itemNavBar = new UINavigationItem ();
			itemNavBar.Title = "Buscar ruta";

			/////Buton izquierdo
			var btnAtras = new UIBarButtonItem ();

			UITextAttributes buttonAttribute = new UITextAttributes ();
			buttonAttribute.TextColor = UIColor.White;

			btnAtras.SetTitleTextAttributes (buttonAttribute, UIControlState.Application);
			btnAtras.Title = "Atras";
			btnAtras.Style = UIBarButtonItemStyle.Done;

			btnAtras.Clicked += (sender, args) => {
				// butto<n was clicked
				View.RemoveFromSuperview ();
			};

			itemNavBar.SetLeftBarButtonItem(btnAtras, true);

			/////Buton Derecho
			var btnBuscar = new UIBarButtonItem ();

			UITextAttributes buttonDerAttribute = new UITextAttributes ();
			buttonDerAttribute.TextColor = UIColor.White;

			btnBuscar.SetTitleTextAttributes (buttonDerAttribute, UIControlState.Application);
			btnBuscar.Title = "Buscar";
			btnBuscar.Style = UIBarButtonItemStyle.Done;

			btnBuscar.Clicked += (sender, args) => {
				// butto<n was clicked
				//View.RemoveFromSuperview ();
				buscarRuta();
			};

			itemNavBar.SetRightBarButtonItem (btnBuscar, true);


			navBar.PushNavigationItem (itemNavBar, false);

			Add (navBar);
			 
			UILabel lbOrigen = new UILabel ();
			lbOrigen.Text = "Origen";
			lbOrigen.Frame = new RectangleF (20,60,View.Bounds.Width - 250, 25);
		
			UILabel lbDestino = new UILabel ();
			lbDestino.Text = "Destino";
			lbDestino.Frame = new RectangleF (20,100,View.Bounds.Width - 250, 25);

			UITextView inputOrigen = new UITextView ();
			inputOrigen.Frame =  new RectangleF (View.Bounds.Width - 220  ,60,200, 25);
			inputOrigen.Text = "Ubicación Actual";


			UITextView inputDestino = new UITextView ();
			inputDestino.Frame =  new RectangleF (View.Bounds.Width - 220  ,100,200, 25);

			Add (inputOrigen);
			Add (inputDestino);

			Add (lbDestino);
			Add (lbOrigen);
		}
	}
}