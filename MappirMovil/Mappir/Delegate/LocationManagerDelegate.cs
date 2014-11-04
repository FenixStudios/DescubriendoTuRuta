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
	public class LocationManagerDelegate : CLLocationManagerDelegate
	{
		public override void AuthorizationChanged (CLLocationManager manager, CLAuthorizationStatus status)
		{
			// NOTE: Don't call the base implementation on a Model class
			// see http://docs.xamarin.com/guides/ios/application_fundamentals/delegates,_protocols,_and_events
			//throw new NotImplementedException ();
		 
				//	public locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
				if (status == CLAuthorizationStatus.AuthorizedWhenInUse  ) {
					//[self.locationManager startUpdatingLocation];
				} else if (status == CLAuthorizationStatus.AuthorizedAlways) {
					// iOS 7 will redundantly call this line.
					//[self.locationManager startUpdatingLocation];
					manager.StartUpdatingLocation();

				} else if (status > CLAuthorizationStatus.NotDetermined) {

				}
			 
			///////////////////////////////////////
	
		}
	
	}
}

