using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using MonoTouch.MapKit;
using System.Collections.Generic;
using MonoTouch.CoreLocation;
using System.IO;

namespace Mappir
{
  

class SearchSource : UITableViewSource
{
	static readonly string mapItemCellId = "mapItemCellId";
	UISearchDisplayController searchController;
	MKMapView map;

	public List<MKMapItem> MapItems { get; set; }

	public SearchSource (UISearchDisplayController searchController, MKMapView map)
	{
		this.searchController = searchController;
		this.map = map;

		MapItems = new List<MKMapItem> ();
	}

	public override int RowsInSection (UITableView tableview, int section)
	{
		return MapItems.Count;
	}

	public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
	{
		var cell = tableView.DequeueReusableCell (mapItemCellId);

		if (cell == null)
			cell = new UITableViewCell ();

		cell.TextLabel.Text = MapItems [indexPath.Row].Name;
		return cell;
	}

	public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
	{
		searchController.SetActive (false, true);

		// add item to map
		CLLocationCoordinate2D coord = MapItems [indexPath.Row].Placemark.Location.Coordinate;
		map.AddAnnotation (new MKPointAnnotation () {
			Title = MapItems [indexPath.Row].Name, 
			Coordinate = coord
		});

		map.SetCenterCoordinate (coord, true);
	}
}
}

