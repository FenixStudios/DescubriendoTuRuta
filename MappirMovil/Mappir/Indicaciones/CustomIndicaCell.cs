using System;
using MonoTouch.Foundation;
using MonoTouch.UIKit;
using System.Drawing;


namespace Mappir {
	public class CustomIndicaCell: UITableViewCell  {
		
		UILabel indicacionLabel, nombreLabel,estadoLabel,municipioLabel,tiempoLabel,distanciaLabel;
		UIImageView imageView;

		 

		public CustomIndicaCell (NSString cellId) : base (UITableViewCellStyle.Default, cellId)
		{
			SelectionStyle = UITableViewCellSelectionStyle.Gray;
			
			ContentView.BackgroundColor = UIColor.Black;// UIColor.FromRGB (218, 255, 127);
			//ContentView.Frame = new RectangleF(0 , 0, ContentView.Bounds.Width, 70);

			imageView = new UIImageView();

			indicacionLabel = new UILabel () {
				Font = UIFont.FromName("Arial", 9f),
				TextColor = UIColor.White,
				BackgroundColor = UIColor.Clear,
			
				
			};
			
			nombreLabel = new UILabel () {
				Font = UIFont.FromName("Arial", 9f),
				TextColor = UIColor.White,
				//TextAlignment = UITextAlignment.Center,
				BackgroundColor = UIColor.Clear
			};
			estadoLabel = new UILabel () {
				Font = UIFont.FromName("Arial", 9f),
				TextColor = UIColor.White,
				BackgroundColor = UIColor.Clear
			};
			municipioLabel = new UILabel () {
				Font = UIFont.FromName("Arial", 9f),
				TextColor = UIColor.White,
				BackgroundColor = UIColor.Clear
			};
			tiempoLabel = new UILabel () {
				Font = UIFont.FromName("Arial", 10f),
				TextColor = UIColor.Green,
				BackgroundColor = UIColor.Clear
			};
			distanciaLabel = new UILabel () {
				Font = UIFont.FromName("Arial", 10f),
				TextColor = UIColor.Red,
				BackgroundColor = UIColor.Clear
			};

			ContentView.Add (indicacionLabel);
			ContentView.Add (nombreLabel);
			ContentView.Add (estadoLabel);
			ContentView.Add (municipioLabel);
			ContentView.Add (tiempoLabel);
			ContentView.Add (distanciaLabel);

			 
			ContentView.Add (imageView);

		}
	 
	
		public void UpdateCell (string indicacion, string nombre,string estado, string municipio, float tiempo, float distancia, UIImage image)
		{
			imageView.Image = image;

			indicacionLabel.Text = indicacion;
			nombreLabel.Text = nombre;
			estadoLabel.Text = estado;
			municipioLabel.Text = municipio;


			tiempoLabel.Text = tiempo.ToString() + " min.";

			if (distancia > 1000) {

				distanciaLabel.Text = (Math.Round((distancia/1000), 2) ).ToString () + " km.";
		
			} else {
			
				distanciaLabel.Text = Math.Round(distancia,2).ToString () + " m.";
			}

		}

		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();
			
			imageView.Frame = new RectangleF(20 , 5, 33, 33);

			indicacionLabel.Frame = new RectangleF(70, -5, ContentView.Bounds.Width - 140, 25);
			nombreLabel.Frame = new RectangleF(70, 5 , ContentView.Bounds.Width - 140, 25);
			estadoLabel.Frame = new RectangleF(70, 15 , ContentView.Bounds.Width - 140, 25);
			municipioLabel.Frame = new RectangleF(70, 25 , ContentView.Bounds.Width - 140, 25);
			tiempoLabel.Frame = new RectangleF(ContentView.Bounds.Width - 65, -5, 50, 25);
			distanciaLabel.Frame = new RectangleF(ContentView.Bounds.Width - 65, 15, 50, 25);
			//distanciaLabel.Frame = new RectangleF(100, 18, 100, 20);
		
		
		}
	}
}

