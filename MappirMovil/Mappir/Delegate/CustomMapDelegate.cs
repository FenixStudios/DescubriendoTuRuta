﻿using System;
using System.Drawing;

using MonoTouch.Foundation;
using MonoTouch.UIKit;
using MonoTouch.MapKit;
using System.Collections.Generic;
using MonoTouch.CoreLocation;
using System.IO;

namespace Mappir
{
	public class CustomMapDelegate:MKMapViewDelegate
	{
	  
		private List<Alerta> _infoList;

		public CustomMapDelegate(List<Alerta> infoList) {
	   	       _infoList = infoList;
   	    }

	   string pId = "PinAnnotation";



	  public override MKAnnotationView GetViewForAnnotation (MKMapView mapView, NSObject annotation)
	  {
		MKAnnotationView anView;

		if (annotation is MKUserLocation)
			return null; 

		// create pin annotation view
		anView = (MKPinAnnotationView)mapView.DequeueReusableAnnotation (pId);

		if (anView == null)
			anView = new MKPinAnnotationView (annotation, pId);

		var pointAnnotation = (MKPointAnnotation) annotation;
		var info = _infoList.Find (x => x.Title == pointAnnotation.Title);					

		anView.Image = GetImage (info.Image);
		anView.CanShowCallout = true;

		return anView;
	}

	public UIImage GetImage(string imageName)
	{
		var documents =
			Environment.GetFolderPath (Environment.SpecialFolder.Resources);

		var filename = Path.Combine (documents, imageName);

		var image = UIImage.FromFile (filename).Scale(new SizeF() {Height=30, Width=30});

		return image;
	}
	}
}