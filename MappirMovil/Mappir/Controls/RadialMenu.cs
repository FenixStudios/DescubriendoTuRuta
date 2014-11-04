 
using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

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
	public class RadialMenu: AlertasMap
	{
	
		/// <summary>
		/// Constantes
		/// </summary>
		private const string imageNameMainButton = "MenuRadial/Menu.png";
		private const string imageMainRadialMenu = "MenuRadial/MainMenuRadialFondo.png";
		private const string imageSecondRadialMenu = "MenuRadial/SecondMenuRadialFondo.png";
		//private const string imageLayout = "MenuRadial/TransparentBackground.png";

		//Imagenes herramientas
		private const string imageMisRutas = "MenuRadial/MisRutas.png";
		private const string imageMisRutasSel = "MenuRadial/MisRutasSel.png";

		private const string imageConfiguraciones = "MenuRadial/Configuraciones.png";
		private const string imageConfiguracionesSel = "MenuRadial/ConfiguracionesSel.png";

		private const string imageBuscarRuta = "MenuRadial/BuscarRuta.png";
		private const string imageBuscarRutaSel = "MenuRadial/BuscarRutaSel.png";

		private const string imagePlay = "MenuRadial/Play.png";
		private const string imagePlaySel = "MenuRadial/PlaySel.png";

		private const string imageCorreo = "MenuRadial/Correo.png";
		private const string imageCorreoSel = "MenuRadial/CorreoSel.png";

		private const string imageCapas = "MenuRadial/Capas.png";
		private const string imageCapasSel = "MenuRadial/CapasSel.png";

		private const string imageAcercaDe = "MenuRadial/AcercaDe.png";
		private const string imageAcercaDeSel = "MenuRadial/AcercaDeSel.png";

		private const string imageTelefonosEmergencia = "MenuRadial/TelefonosEmergencia.png";
		private const string imageTelefonosEmergenciaSel = "MenuRadial/TelefonosEmergenciaSel.png";


	    //Herramientas radial secundario
		private const string imageBuscarRutaConf = "MenuRadial/BuscarRutaConf.png";
		private const string imageBuscarRutaConfSel = "MenuRadial/BuscarRutaConfSel.png";

		private const string imageMisUbicaciones = "MenuRadial/MisUbicaciones.png";
		private const string imageMisUbicacionesSel = "MenuRadial/MisUbicacionesSel.png";

		private const string imageConfigUsers = "MenuRadial/ConfigUsers.png";
		private const string imageConfigUsersSel = "MenuRadial/ConfigUsersSel.png";


		private const double WidthMainButton = 50;
		private const double HeightMainButton = 50;

		private const double WidthRadialMenu  = 200;
		private const double HeightRadialMenu = 200;

		private const double WidthSecondRadialMenu = 108;
		private const double HeightSecondaRadialMenu = 108;

	//	private UIView container {
	//		get;
	//		set;
	//	}

		private UIView vistaCapas{
			get;
			set;

		}
		private UIView vistaIndica{
			get;
			set;

		}

		private BuscarRuta vistaBuscarRuta{
			get;
			set; 
		}

	

		private List<ToolItem> toolsCollectionMainRadial {
			get;
			set;
		}
		private List<ToolItem> toolsCollectionMainRadialSecond {
			get;
			set;
		}
		private PositionXY positionMainButton {
			get;
			set;
		}

		public PositionXY positionRadialMenu {
			get;
			set;
		}
		  

		private UIImageView secondRadialMenuBackground{
			get;
			set;
		}

		public ToolItem toolSelected {
			get;
			set;
		}

		private UIButton btnMainMenu {
			get;
			set;
		}
		private UIImageView MainMenuBackground {
			get;
			set;
		} 

		private UIButton backgroundLayout {
			get;
			set;
		} 
	
		public RadialMenu (UIView container,MKMapView mapa, MappirViewController parent )
		{
			this.container = container;
			this.parent = parent;
			this.map = mapa;



			///Valores predeterminados
			valoresPredeterminados ();

			//Crear MenuRadial principal
			 crearMenuRadial ();

			//Mostrar MenuRadial

			//Crear MenuRadial Secundario

			//Crea el boton principal  
			crearBotonPrincipal ();

			//Muestra el boton principal
			mostrarBotonPrincipal ();

		 
		} 

		private void valoresPredeterminados(){
			positionMainButton = new PositionXY ();
			positionMainButton.x = 5;
			positionMainButton.y = 5;
			  
		}
  
		private void crearBotonPrincipal(){

			//Crear boton Principal
		    btnMainMenu = UIButton.FromType(UIButtonType.Custom);
			btnMainMenu.SetImage(UIImage.FromFile (imageNameMainButton), UIControlState.Normal);

			btnMainMenu.Frame = new RectangleF((float)positionMainButton.x,(float)positionMainButton.y,(float)WidthMainButton,(float)HeightMainButton);
			btnMainMenu.TouchUpInside += delegate
			{ 
				ocultarBotonPrincipal();
				mostrarMenuRadial(); 
				Console.WriteLine("mostrarMenuRadial(); ");
			};

			container.Add(btnMainMenu);
			 
 		}
		 
		 
		private void mostrarBotonPrincipal(){
			//Colocar y mostrar en posicion

			if	(btnMainMenu != null)
				btnMainMenu.Hidden = false;

		} 
		private void ocultarBotonPrincipal(){
			//Colocar y mostrar en posicion

			if	(btnMainMenu != null)
				btnMainMenu.Hidden = true;

		} 
		private void ocultarMenuRadial(){
		
			//ocultar background Menu radial
			if(MainMenuBackground != null){

				MainMenuBackground.RemoveFromSuperview ();
				 
				//ocultar herramientas
				ocultarHerramientasRadialMenu ();


			} 
		} 

		private void crearMenuRadial(){
		 
			MainMenuBackground =  new UIImageView (UIImage.FromBundle(imageMainRadialMenu));
			//backgroundMenuAlertas.InputTransparent = true;
			MainMenuBackground.Hidden = true;

 
		 
			crearMenuRadialSecundario ();

			createImageIconsMainRadial ();

			createImageIconosRadialSecondary ();

		}
		private void crearMenuRadialSecundario(){
		 
			 
			secondRadialMenuBackground =  new UIImageView (UIImage.FromBundle(imageSecondRadialMenu));
			secondRadialMenuBackground.Hidden = true;
		
		}
		private void mostrarMenuRadial(){
		
			//cargar imagen transparente
			crearImagenTransparente ();

			//Calcula posicion
			positionRadialMenu = new PositionXY ();
			positionRadialMenu.x = (container.Bounds.Width - WidthRadialMenu)/2;
			positionRadialMenu.y = (container.Bounds.Height - HeightRadialMenu)/2;

			//Remover del contenedor si esta agregado
			MainMenuBackground.RemoveFromSuperview ();
		 
			 
			//Cambiar su posicion
			MainMenuBackground.Frame = new RectangleF((float)positionRadialMenu.x,(float)positionRadialMenu.y,(float)WidthRadialMenu,(float)HeightRadialMenu);


			 
			//Muestra el menu radial 
			MainMenuBackground.Hidden = false;
			container.Add (MainMenuBackground);
			//MainMenuBackground.IsVisible = true;
			//MainMenuBackground.Opacity = 0.6;
			//MainMenuBackground.FadeTo (1);

			mostrarHerramientaRadial ();
		 
		}
		private void crearImagenTransparente(){
			backgroundLayout = UIButton.FromType(UIButtonType.Custom);
			backgroundLayout.Frame = new RectangleF(0, 0, container.Bounds.Width, container.Bounds.Height);
			backgroundLayout.SetImage(UIImage.FromFile(imageLayout), UIControlState.Normal);

			//Configuraciones de eventos________________________________________________________
			backgroundLayout.TouchUpInside += (object sender, EventArgs e) => {

				closeRadial();
			

			};

			//Colocar el boton en el contenedor _______________________________________________
			container.Add(backgroundLayout);
			 
		}
		private void closeRadial(){

			backgroundLayout.RemoveFromSuperview();

			mostrarBotonPrincipal();
			ocultarMenuRadial();
			ocultarRadialSecundario ();
		}

		private void createImageIconsMainRadial(){
		
			toolsCollectionMainRadial = new List<ToolItem> ();
			//Crear arreglo de iconos
			ToolItem misRutas = new ToolItem () {
				NormalImage = crearImagenTool (imageMisRutas,imageMisRutasSel ),
				//SelectedImage = crearImagenTool (imageMisRutasSel)
			
			};
			toolsCollectionMainRadial.Add (misRutas);

			ToolItem configuraciones = new ToolItem () {
				NormalImage = crearImagenTool (imageConfiguraciones,imageConfiguracionesSel),
				//SelectedImage = crearImagenTool (imageConfiguracionesSel)
			};
			toolsCollectionMainRadial.Add (configuraciones);

			ToolItem buscarRutas = new ToolItem () {
				NormalImage = crearImagenTool (imageBuscarRuta,imageBuscarRutaSel),
			//	SelectedImage = crearImagenTool (imageBuscarRutaSel)
			}; 
			toolsCollectionMainRadial.Add (buscarRutas);

			ToolItem play = new ToolItem () {
				NormalImage = crearImagenTool (imagePlay,imagePlaySel),
				//SelectedImage = crearImagenTool (imagePlaySel)
			}; 
			toolsCollectionMainRadial.Add (play);

			ToolItem correo = new ToolItem () {
				NormalImage = crearImagenTool (imageCorreo,imageCorreoSel),
			//	SelectedImage = crearImagenTool (imageCorreoSel)
			}; 
			toolsCollectionMainRadial.Add (correo);

			ToolItem capas = new ToolItem () {
				NormalImage = crearImagenTool (imageCapas,imageCapasSel),
				//SelectedImage = crearImagenTool (imageCapasSel)
			}; 
			toolsCollectionMainRadial.Add (capas);

			ToolItem acerca = new ToolItem () {
				NormalImage = crearImagenTool (imageAcercaDe,imageAcercaDeSel),
				//SelectedImage = crearImagenTool (imageAcercaDeSel)
			}; 
			toolsCollectionMainRadial.Add (acerca);

			ToolItem telefonoEmer = new ToolItem () {
				NormalImage = crearImagenTool (imageTelefonosEmergencia,imageTelefonosEmergenciaSel),
				//SelectedImage = crearImagenTool (imageTelefonosEmergenciaSel)
			}; 
			toolsCollectionMainRadial.Add (telefonoEmer);



		}

		  private void	createImageIconosRadialSecondary (){
			  
			toolsCollectionMainRadialSecond = new List<ToolItem> ();
			//Crear arreglo de iconos
			ToolItem confUsers = new ToolItem () {
				NormalImage = crearImagenTool (imageConfigUsers,imageConfigUsersSel),
				//SelectedImage = crearImagenTool (imageConfigUsersSel)

			};
			toolsCollectionMainRadialSecond.Add (confUsers);

			ToolItem buscarRuta = new ToolItem () {
				NormalImage = crearImagenTool (imageBuscarRutaConf,imageBuscarRutaConfSel),
				//SelectedImage = crearImagenTool (imageBuscarRutaConfSel)

			};
			toolsCollectionMainRadialSecond.Add (buscarRuta);

			ToolItem misUbicaciones = new ToolItem () {
				NormalImage = crearImagenTool (imageMisUbicaciones,imageMisUbicacionesSel),
			//	SelectedImage = crearImagenTool (imageMisUbicacionesSel)

			};
			toolsCollectionMainRadialSecond.Add (misUbicaciones);
			 

		}
		private void ocultarHerramientasRadialMenu (){
	 

		 
		    
			for (int i = 0; i < toolsCollectionMainRadial.Count; i++) {
			    
				if (toolsCollectionMainRadial [i].NormalImage.Superview != null) {
				
					toolsCollectionMainRadial [i].NormalImage.RemoveFromSuperview ();
				}
			}
		}
		private void ocultarHerramientasRadialMenuSecondary (){
			 
		 

			for (int i = 0; i < toolsCollectionMainRadialSecond.Count; i++) {
			
				if (toolsCollectionMainRadialSecond [i].NormalImage.Superview != null) {
					toolsCollectionMainRadialSecond [i].NormalImage.RemoveFromSuperview ();
				}
			
			}
			 
		}
		//Colocar Herramientas en radial

		private void mostrarHerramientaRadial(){

			//Ubicar en su posicion
			toolsCollectionMainRadial[0].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + 5),(float) (positionRadialMenu.y + HeightRadialMenu/2 - 20  ), 35,35);
			container.Add(toolsCollectionMainRadial[0].NormalImage);


		 

			//Ubicar en su posicion
			toolsCollectionMainRadial[1].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + 25),(float) (positionRadialMenu.y + HeightRadialMenu/2 - 20 -50 ), 35,35);
			container.Add(toolsCollectionMainRadial[1].NormalImage);

		 

			//Ubicar en su posicion
			toolsCollectionMainRadial[2].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 - 15),(float) (positionRadialMenu.y + 5 ), 35,35);
			container.Add(toolsCollectionMainRadial[2].NormalImage);

		 

			//Ubicar en su posicion
			toolsCollectionMainRadial[3].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 + 45 ),(float) (positionRadialMenu.y + HeightRadialMenu/2 - 20 -50 ), 35,35);
			container.Add(toolsCollectionMainRadial[3].NormalImage);

			 

			//Ubicar en su posicion
			toolsCollectionMainRadial[4].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu -40),(float) (positionRadialMenu.y + HeightRadialMenu/2 - 20 ), 35,35);
			container.Add(toolsCollectionMainRadial[4].NormalImage);
   

			//Ubicar en su posicion
			toolsCollectionMainRadial[5].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 + 45 ),(float) (positionRadialMenu.y + HeightRadialMenu/2 + 30   ), 35,35);
			container.Add(toolsCollectionMainRadial[5].NormalImage);

		 

			//Ubicar en su posicion
			toolsCollectionMainRadial[6].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 - 15),(float) (positionRadialMenu.y + HeightRadialMenu/2 + 60 ), 35,35);
			container.Add(toolsCollectionMainRadial[6].NormalImage);

		 

			//Ubicar en su posicion
			toolsCollectionMainRadial[7].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + 25),(float) (positionRadialMenu.y + HeightRadialMenu/2 + 30   ), 35,35);
			container.Add(toolsCollectionMainRadial[7].NormalImage);

		 

		}
 
		private UIButton crearImagenTool(string normal, string Highlighted ){
		 
			UIButton  toolImage = UIButton.FromType(UIButtonType.Custom);
			toolImage.SetImage(UIImage.FromFile(normal), UIControlState.Normal);
			toolImage.SetImage(UIImage.FromFile(Highlighted), UIControlState.Highlighted);
			//Configuraciones de eventos________________________________________________________
			toolImage.TouchUpInside += (object sender, EventArgs e) => {
				SelectorEventos(normal);
			};
			 

			return toolImage;
		}

		private void SelectorEventos(string value){

			switch (value) {

			case imageMisRutas:

				break;
			case imageConfiguraciones:
				//Mostrar menu radial secundario
				ocultarMenuRadial ();
				 

				//if (container.Contains (secondRadialMenuBackground))
						 
				if (secondRadialMenuBackground.Superview != null)
						ocultarRadialSecundario ();
					else
					    mostrarRadialSecundario ();
				break;
			case imageCapas:
				//Mostrar vista de capas

				cargarVistaCapas ();
				 
				break;

			case imageBuscarRuta:
				closeRadial ();
				cargarVistaBuscarRuta();
				//buscarRuta ();
				break;

			default:
				break;
			}

		}
		 
		private void cargarVistaBuscarRuta(){
		
			vistaBuscarRuta = new BuscarRuta (this.map);

			//Crear los items de las indicaciones
			vistaBuscarRuta.View.Frame   = new RectangleF (0, 0, container.Bounds.Width, container.Bounds.Height);
			 
			container.Add (vistaBuscarRuta.View);

		}



	 

		private void cargarVistaCapas(){

			if (vistaCapas == null) {
			
				vistaCapas = new UIView ();
				vistaCapas.Bounds = container.Bounds;
				vistaCapas.Frame = new RectangleF (0, 0, container.Bounds.Width, container.Bounds.Height);
			 
				var fondo = new UIImageView (UIImage.FromBundle ("MenuRadial/Fondo.png"));
				vistaCapas.Add (fondo);


				UINavigationBar navBar = new UINavigationBar ();
				navBar.Frame = new RectangleF (0, 0, (float)container.Bounds.Width, (float)40);
		
				navBar.BarTintColor = UIColor.FromRGBA (0, 133, 61, 255);
				navBar.TintColor = UIColor.White;

			 
				UINavigationItem itemNavBar = new UINavigationItem ();
				itemNavBar.Title = "Capas";
	 

				var btnDone = new UIBarButtonItem ();

				UITextAttributes buttonAttribute = new UITextAttributes ();
				buttonAttribute.TextColor = UIColor.White;

				btnDone.SetTitleTextAttributes (buttonAttribute, UIControlState.Application);
				btnDone.Title = "Hecho";
				btnDone.Style = UIBarButtonItemStyle.Done;

				btnDone.Clicked += (sender, args) => {
					// butto<n was clicked
					vistaCapas.RemoveFromSuperview ();
				};
			 
				itemNavBar.SetRightBarButtonItem (btnDone, true);

				navBar.PushNavigationItem (itemNavBar, false);
		 
				vistaCapas.Add (navBar);
			 
				vistaCapas.Add (itemBackground ());
				vistaCapas.Add (createSwitch ());
				vistaCapas.Add (createLabelSwitch ());




			}
			container.Add (vistaCapas);
		}
		private UIImageView itemBackground (){

			var item =  new UIImageView (UIImage.FromBundle("MenuRadial/ItemBG.png"));
			item.Frame =  new RectangleF(10,60,(float)container.Bounds.Width- 20, (float)40);

			return item;
		}
		private UIView createLabelSwitch(){


			UILabel lb = new UILabel ();
			lb.Text = "Alertas ";
			lb.TextColor = UIColor.DarkGray;
 

 			//lb.AttributedTex = labelAttribute;
			lb.Frame = new RectangleF(20,70,100,20);

			return lb;
		}
		private UIView createSwitch(){


			UISwitch alertasSwitch = new UISwitch ();

			alertasSwitch.Frame = new RectangleF(container.Bounds.Width - 70,65,20,10);

			alertasSwitch.ValueChanged+= (object sender, EventArgs e) => {

				closeRadial();
				if(alertasSwitch.On == true){

					mostrarTodasAlertasGuardadas();
				}else{
					ocultarTodasAlertasGuardadas();
				}
			};

			return alertasSwitch;
		}
		private UIView customButton(string text){

			RectangleF frame =  new RectangleF(0,0,(float)container.Bounds.Width, (float)20);

			var myCustomView = new UIView(frame);
		
			myCustomView.AddSubview(new UIImageView (UIImage.FromBundle("MenuRadial/BG.png")));
			 
			myCustomView.AddSubview(new UILabel(frame) { Text = text });

			return myCustomView;
		}
		private void  ocultarRadialSecundario(){
		 
			 
			if(secondRadialMenuBackground != null){

				//if (container.Children.Contains (secondRadialMenuBackground)) {
				if ( secondRadialMenuBackground.Superview != null) {
					 	//ocultar background
					//container.Children.Remove (secondRadialMenuBackground);
					secondRadialMenuBackground.RemoveFromSuperview ();
				}
				//ocultar herramientas
				ocultarHerramientasRadialMenuSecondary ();
 
			} 

		
		}

		private void mostrarRadialSecundario (){
			//Colocar la imagen
		  

			//Calcula posicion
			 
			 
			//Remover del contenedor si esta agregado
			//if (container.Children.Contains (secondRadialMenuBackground)) {
			if (secondRadialMenuBackground.Superview != null){
			//	container.Children.Remove (secondRadialMenuBackground);
				secondRadialMenuBackground.RemoveFromSuperview ();
			}

			//Cambiar su posicion
		secondRadialMenuBackground.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 - 54), (float)(positionRadialMenu.y + HeightRadialMenu/2 - 54 ),(float) WidthSecondRadialMenu,(float)HeightSecondaRadialMenu);
		container.Add (secondRadialMenuBackground);
		  
		   
 
	     	secondRadialMenuBackground.Hidden = false;
			 
			mostrarIconoMenuRadialSecundario ();
		}

		private void mostrarIconoMenuRadialSecundario(){
			//Ubicar en su posicion
			toolsCollectionMainRadialSecond[0].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 - 45 ), (float)(positionRadialMenu.y + HeightRadialMenu/2   ),(float) 35,(float)35);
			container.Add (toolsCollectionMainRadialSecond[0].NormalImage);

		 

			//Ubicar en su posicion
			toolsCollectionMainRadialSecond[1].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 -14 ), (float)(positionRadialMenu.y + HeightRadialMenu/2 - 50  ),(float) 35,(float)35);
			container.Add (toolsCollectionMainRadialSecond[1].NormalImage);

		 

			//Ubicar en su posicion
			toolsCollectionMainRadialSecond[2].NormalImage.Frame = new RectangleF((float)(positionRadialMenu.x + WidthRadialMenu/2 +20 ), (float)(positionRadialMenu.y + HeightRadialMenu/2   ),(float) 32,(float)32);
			container.Add (toolsCollectionMainRadialSecond[2].NormalImage);


		 
		}
		 
	}
	 
}

