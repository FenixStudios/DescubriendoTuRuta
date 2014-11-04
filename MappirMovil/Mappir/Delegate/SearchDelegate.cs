using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

using MonoTouch.MapKit;
using System.Collections.Generic;
using MonoTouch.CoreLocation;
using System.IO;
using System.Linq;

namespace Mappir
{
	 

class SearchDelegate : UISearchDisplayDelegate
{
	MKMapView map;

	public SearchDelegate (MKMapView map)
	{
		this.map = map;
	}

	public override bool ShouldReloadForSearchString (UISearchDisplayController controller, string forSearchString)
	{
		// create search request
		var searchRequest = new MKLocalSearchRequest ();
		searchRequest.NaturalLanguageQuery = forSearchString;
		searchRequest.Region = new MKCoordinateRegion (map.UserLocation.Coordinate, new MKCoordinateSpan (0.25, 0.25));

		// perform search
		var localSearch = new MKLocalSearch (searchRequest);
		localSearch.Start (delegate (MKLocalSearchResponse response, NSError error) {
			if (response != null && error == null) {
				((SearchSource)controller.SearchResultsSource).MapItems = response.MapItems.ToList();
				controller.SearchResultsTableView.ReloadData();
			} else {
				Console.WriteLine ("local search error: {0}", error);
			}
		});

		return true;
	}
}
}