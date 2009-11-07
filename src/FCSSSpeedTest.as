package
{
	import com.flashartofwar.fcss.styles.Style;
	import com.flashartofwar.fcss.stylesheets.StyleSheet;
	import com.flashartofwar.fcss.utils.CSSTidyUtil;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getTimer;

	public class FCSSSpeedTest extends Sprite
	{
		private var rawCSS : String;
		private var urlLoader : URLLoader;
		private var styleSheet:StyleSheet;
		private static const BREAK:String = "--------------------------------------------";

		public function FCSSSpeedTest()
		{
			urlLoader = new URLLoader( );
			urlLoader.addEventListener( Event.COMPLETE, onCSSLoad);
			urlLoader.load(new URLRequest("css/large_demo.styles.css"));

		}

		protected function parseCamoCSS():void
		{
			//var tidyCSS:String = CSSTidyUtil.tidy(rawCSS);
			styleSheet = new StyleSheet();	
			trace(BREAK+"\n* Test FCSS Pre-parser *\n"+BREAK);
			// parse css	
			var t:Number = getTimer();


			styleSheet.parseCSS(rawCSS, true);
			t = (getTimer()-t);
			var strDebug:String;
			strDebug = "    Parsing time: " + t + " ms\n";
			strDebug += "    Bytes: " + rawCSS.length + " (" + Math.round(rawCSS.length / t) + " bytes/ms)";
			trace(strDebug);
		}

		private function onCSSLoad(event : Event) : void
		{
			rawCSS = URLLoader(event.target ).data;
			parseCamoCSS();
			requestAllstyles();
			requestAllstyles();

		}

		protected function requestAllstyles():void
		{
			trace(BREAK+"\n* Test Requesting Every style *\n"+BREAK);

			var t:Number = getTimer();
			var strDebug:String;

			var styles:Array = styleSheet.styleNames;
			var total:int = styles.length;
			var i:int;
			var style:Style;
			var styleRequestTime:Number;
			var styleName:String;
			var requestTimes:Number = 0;
			var longestRequest:Number = 0;
			var highestRequest:Number = 0;
			var results:Array = [];

			for(i = 0; i < total; i++)
			{
				styleName = styles[i];
				styleRequestTime = getTimer();
				style = styleSheet.getStyle(styleName);
				styleRequestTime = (getTimer()-styleRequestTime);
				if(styleRequestTime > 0)
					results.push({time:styleRequestTime, name:styleName});

				requestTimes += styleRequestTime;

			}
			t = (getTimer()-t);
			strDebug = "    Total time to request "+(total-1)+" styles time: " + t + " ms";
			trace(strDebug);

			trace("    "+(styles.length - results.length)+"/"+styles.length+" styles took 0 ms");

			var average:Number = results.length/styles.length;

			trace("    Average Style Request Time", average, "ms");
			results.sortOn("time", Array.NUMERIC | Array.DESCENDING); 

			var average2:Number = ((requestTimes/total-1) < 0) ? 0 : (requestTimes/total-1);

			trace("    Shortest Request",results[results.length - 1].time, results[results.length - 1].name," (Styles that take 0 ms do not count.)");
			trace("    Longest Request",results[0].time, results[0].name);

			var oneSecondRequests:Number = 0; 
			var longerStyles:String ="";
			for(i = 0; i < results.length; i++)
			{
				if(results[i].time > 1)
					longerStyles += "        Style '"+results[i].name+"' - "+results[i].time+" ms\n";
				else
					oneSecondRequests ++;
			}

			trace("    "+oneSecondRequests+" styles took 1 ms");

			trace("    Style requests > 1 ms:");
			trace(longerStyles);
		}
	}
}

