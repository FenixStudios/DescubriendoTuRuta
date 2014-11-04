using System;
using MonoTouch.UIKit;

namespace Mappir {
	public class TableItemRutaEncon {
		 

		public int tipo { get; set; }
		
		public int  casetasNo { get; set; }

		public float casetasTotal { get; set; }

		public float tiempoTotal { get; set; }

		public float distanciaTotal   { get; set; }
		 
		public float gasTotal { get; set; }

		public float total { get; set; }

		public string origen { get; set; }

		public string destino { get; set; }

		public string especiAuto   { get; set; }

		public string especiEjes   { get; set; }

		public string especiRendi   { get; set; }

	    public string especInciden   { get; set; }

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

		public TableItemRutaEncon () { }
		
		public TableItemRutaEncon (int tip)
		{ tipo = tip; }
	}
}