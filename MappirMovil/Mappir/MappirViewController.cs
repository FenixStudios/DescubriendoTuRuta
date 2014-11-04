using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;
 
using MonoTouch.MapKit;
using System.Collections.Generic;
using MonoTouch.CoreLocation;
using System.IO;
 
//using Xamarin.Forms;
//using Xamarin.Forms.Maps;
 
 
  

namespace Mappir
{
	public partial class MappirViewController : UIViewController
	{
		protected MKMapView map;
	

		//protected LocationManagerDelegate  locationManagerDelegate {
		//	get;
		//	set;
		//}

	//	private List<Alerta> _infoList;

	 	public RadialMenu _radialMenu {
	 		get;
	 		set;
	 	}

	 	public MenuAlertas _alertas{
	 		get;
	 		set; 
	 	}
		public List<Alerta> lstAlertas{
			get;
			set;
		}

		public List<AnotacionRuta> lstAnotacionesRuta{
			get;
			set; 
		}

		public CLGeocoder geoCoder{
			get;
			set; 
		} 

		//Constructor 
		public MappirViewController (IntPtr handle) : base (handle)
		{
			//_infoList = GetInfoList ();
			//UIApplication.SharedApplication.SetStatusBarHidden (true, true);

		}
		 
		public override void LoadView ()
		{
			//locationManagerDelegate = new LocationManagerDelegate ();
			float heightView = UIScreen.MainScreen.Bounds.Height;
			float widthView = UIScreen.MainScreen.Bounds.Width;

			var stack = new  UIView (); 

			//Configurar mapa y agregarlo a la vista
			map = new MKMapView (UIScreen.MainScreen.Bounds);

			map.MapType = MKMapType.Standard;

		 
	
			stack.AddSubview( map);

		 

			UISearchBar searchBar = createSearchBar (widthView);
			stack.AddSubview(searchBar); 


			//__________________________________________________________________________________

			//Agregar  el menu radial
			_radialMenu = new RadialMenu(stack,map, this);



			//__________________________________________________________________
			//Agregar boton menu Alertas  

			var btnMenuAlertas = UIButton.FromType(UIButtonType.Custom);
			btnMenuAlertas.SetImage(UIImage.FromFile ("MenuAlertas/MenuAlertas.png"), UIControlState.Normal);

			btnMenuAlertas.Frame = new RectangleF(5,heightView - 55,50,50);
			btnMenuAlertas.TouchUpInside += delegate
			{ 
				_alertas = new MenuAlertas (stack, map, this);
				Console.WriteLine("Submit button pressed");
			};

			stack.AddSubview(btnMenuAlertas);
		   
			//Agregar Buton de redes sociales
			 
			var btnRedesSociales = UIButton.FromType(UIButtonType.Custom);
			btnRedesSociales.SetImage(UIImage.FromFile ("Iconos/RedesSociales.png"), UIControlState.Normal);


			btnRedesSociales.Frame = new RectangleF(widthView - 65,heightView - 55,60,50);
		    btnRedesSociales.TouchUpInside += delegate
			{ 
				Console.WriteLine("Submit button pressed");
			};

			stack.AddSubview(btnRedesSociales);
  
			View = stack;
		}	

	
	///	Geocoder geoCoder;
		public UISearchBar createSearchBar(float widthView){
			 
			UISearchBar searchBar = new UISearchBar (){ Placeholder = "Buscar" };
			searchBar.SearchBarStyle = UISearchBarStyle.Minimal;

			searchBar.BarTintColor = UIColor.FromRGBA(0, 133, 61, 100);
			 
			searchBar.Frame = new RectangleF(70,0,widthView - 70,40); 

			searchBar.SearchButtonClicked += OnSearchBarButtonPressed;
			 
			return searchBar;
		}
	 
		private void OnSearchBarButtonPressed(object sender, EventArgs args)
		{
			UISearchBar searchBar = (UISearchBar)sender;

			CLGeocoder clg = new CLGeocoder();
			string sw = searchBar.Text;  

			clg.GeocodeAddress(sw, HandleCLGeocodeCompletionHandler);


		}
		void HandleCLGeocodeCompletionHandler (CLPlacemark[] placemarks, NSError error)
		{
			try 
			{
				CLLocationCoordinate2D coordinate = placemarks [0].Location.Coordinate;

				lstAnotacionesRuta = new List<AnotacionRuta> ();

				if(coordinate.Latitude > 0){
					lstAnotacionesRuta.Add( new AnotacionRuta(){ Latitude = coordinate.Latitude,
						Longitude= coordinate.Longitude, Image="Rutas/Pin.png", Titulo="Ubicación" });
					};

				mostrarPuntosRutas();
				//map.SetCenterCoordinate (coordinate, true);
				MKCoordinateRegion mapRegion = MKCoordinateRegion.FromDistance (coordinate, 1000, 1000);
				map.Region = mapRegion;


			//	viewController = new MapViewController (coordinate, Globals.SelectedCustomer.Name, mapLocation);
				 
			 //	ActivityThread.Stop ();
			//	this.NavigationController.PushViewController (viewController, true);
			
			} 
			catch (Exception) 
			{
			//	ActivityThread.Stop ();
				var erroralert = new UIAlertView ("La ubicación no puso ser encontrada", "", null, "Aceptar", null);
			 	erroralert.Show ();
			}

		}

		void mostrarPuntosRutas(){

			//map.Delegate = new CustomMapDelegate (lstAnotacionesRuta);
		
			this.map.Delegate = new CustomMapDelegateRuta (this.lstAnotacionesRuta);

			//Crear anotacion
			this.lstAnotacionesRuta.ForEach (x => map.AddAnnotation (new MKPointAnnotation () {
				Title = x.Titulo,
				Coordinate = new CLLocationCoordinate2D () {
					Latitude = x.Latitude,
					Longitude = x.Longitude
				}
			}));


		}

		public List<Alerta> GetInfoList ()
		{
			//Obtener las alertas de archivo guardado

			var infoList = new List<Alerta> () {

		//		new Alerta("Accidente", 23.634501,-102.552784, "MenuAlertas/Accidente.png" ),
		//		new Alerta("Bache", 23.034501,-102.052784, "MenuAlertas/Bache.png" ),
			};				

			return infoList;																																																	
		}
		 

		#region View lifecycle

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();

			// Release any cached data, images, etc that aren't in use.
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			
			// Perform any additional setup after loading the view, typically from a nib.
		}

		public override void ViewWillAppear (bool animated)
		{
			base.ViewWillAppear (animated);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
		}

		public override void ViewWillDisappear (bool animated)
		{
			base.ViewWillDisappear (animated);
		}

		public override void ViewDidDisappear (bool animated)
		{
			base.ViewDidDisappear (animated);
		}

		#endregion
	}
}

