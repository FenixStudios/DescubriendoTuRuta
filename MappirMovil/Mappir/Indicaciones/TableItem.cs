using System;
using MonoTouch.UIKit;

namespace Mappir {
	public class TableItem {
		public string Indicacion { get; set; }
		
		public string Nombre { get; set; }

		public string Estado { get; set; }

		public string Municipio { get; set; }

		public string ImageName { get; set; }
		 
		public float Tiempo { get; set; }

		public float Distancia { get; set; }
		
		public UITableViewCellStyle CellStyle
		{
			get { return cellStyle; }
			set { cellStyle = value; }
		}
		protected UITableViewCellStyle cellStyle = UITableViewCellStyle.Default;
		
		public UITableViewCellAccessory CellAccessory
		{
			get { return cellAccessory; }
			set { cellAccessory = value; }
		}
		protected UITableViewCellAccessory cellAccessory = UITableViewCellAccessory.None;

		public TableItem () { }
		
		public TableItem (string nombre)
		{ Nombre = nombre; }
	}
}