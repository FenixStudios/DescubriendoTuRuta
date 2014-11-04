using System;
using System.Drawing;
using System.Collections.Generic;
using MonoTouch.UIKit;

namespace Mappir {
	public class IndicaTableView : UIViewController {
		UITableView table;
		private List<AnotacionRuta> lstRutas = new List<AnotacionRuta> ();

		public IndicaTableView (  List<AnotacionRuta> lstRutas)
		{	
			this.lstRutas = lstRutas;
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
			itemNavBar.Title = "Indicaciones";


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

			navBar.PushNavigationItem (itemNavBar, false);

			Add (navBar);

		 

			table = new UITableView(View.Bounds); // defaults to Plain style
			table.BackgroundColor =  UIColor.FromRGBA (0,0,0,0);

			//table.AutoresizingMask = UIViewAutoresizing.All;
			table.Frame = new RectangleF (0, 40, (float)View.Bounds.Width, (float)View.Bounds.Height - 40);
 
			table.SeparatorColor = UIColor.White; // UIColor.FromRGB (127,106,0);
		

			List<TableItem> tableItems = new List<TableItem>();
			
			  
			foreach(var ar in lstRutas){
				TableItem item = new TableItem ();

				item.ImageName = ar.Image;// "Pin.png";
				 
				item.Indicacion = ar.Indicacion;
				item.Nombre = ar.Nombre;
				item.Estado = ar.Estado;
				item.Municipio = ar.Municipio;
				item.Distancia = ar.Distancia;
				item.Tiempo = ar.TiempoEstimado;

				tableItems.Add (item);
			}

			table.Source = new TableSource(tableItems);

			Add (table);
		}
	}
}