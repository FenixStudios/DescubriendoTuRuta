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
		public class ToolItem
		{
			public Boolean isSelected {
				get;
				set;
			}

		public UIButton NormalImage{
				get;
				set;
			}

		public UIButton SelectedImage{
				get;
				set;
			}


			public PositionXY ToolPosition {
				get;
				set;
			}

			public double Height {
				get;
				set;
			}
			public double Width {
				get;
				set;
			}
		 
	}
}


