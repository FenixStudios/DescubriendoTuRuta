using System;
using System.Collections.Generic;
using System.IO;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace Mappir {
	public class RutaEnconTableSource : UITableViewSource {
		List<TableItem> tableItems;
		 NSString cellIdentifier = new NSString("TableCell");
	
		public RutaEnconTableSource (List<TableItem> items)
		{
			tableItems = items;
		}
	
		/// <summary>
		/// Called by the TableView to determine how many cells to create for that particular section.
		/// </summary>
		public override int RowsInSection (UITableView tableview, int section)
		{
			return tableItems.Count;
		}
		
		/// <summary>
		/// Called when a row is touched
		/// </summary>
		public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
		{
		//	new UIAlertView("Row Selected"
		//		, tableItems[indexPath.Row].Heading, null, "OK", null).Show();
		//	tableView.DeselectRow (indexPath, true);
		}
		
		/// <summary>
		/// Called by the TableView to get the actual UITableViewCell to render for the particular row
		/// </summary>
		public override UITableViewCell GetCell (UITableView tableView, MonoTouch.Foundation.NSIndexPath indexPath)
		{
			// request a recycled cell to save memory
			CustomIndicaCell cell = tableView.DequeueReusableCell (cellIdentifier) as CustomIndicaCell;

			// if there are no cells to reuse, create a new one
			if (cell == null) {
				cell = new CustomIndicaCell (cellIdentifier);
			}

			cell.UpdateCell (tableItems[indexPath.Row].Indicacion
				, tableItems[indexPath.Row].Nombre
				,tableItems[indexPath.Row].Estado
				,tableItems[indexPath.Row].Municipio
				,tableItems[indexPath.Row].Tiempo
				,tableItems[indexPath.Row].Distancia
							, UIImage.FromFile ("Rutas/" +tableItems[indexPath.Row].ImageName) );
			
			return cell;
		}
	}
}