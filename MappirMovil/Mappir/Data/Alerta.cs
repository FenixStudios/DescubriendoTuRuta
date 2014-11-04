using System;

namespace Mappir
{
	public class Alerta
	{
		public Alerta(){}

		public Alerta (string title, double latitude, double longitude, string image, int tipo)
		{
			Title = title;
			Latitude = latitude;
			Longitude = longitude;
			Image = image;
			Type = tipo;
		}
		public int ID { get; set; }

		public int Type { get; set; }

		public string Title { get; set; }

		public double Latitude { get; set; }

		public double Longitude { get; set; }

		public string Image { get; set; }
	}
}

