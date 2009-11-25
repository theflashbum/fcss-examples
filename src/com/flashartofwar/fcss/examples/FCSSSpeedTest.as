package com.flashartofwar.fcss.examples
{
	import com.flashartofwar.fcss.styles.IStyle;
	import com.flashartofwar.fcss.stylesheets.FStyleSheet;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.utils.getTimer;

	public class FCSSSpeedTest extends AbstractExample
	{
		private var rawCSS : String;
		private var urlLoader : URLLoader;
		private var styleSheet:FStyleSheet;

		public function FCSSSpeedTest()
		{

		}

		override public function runExample(data:* = null):void
		{
			rawCSS = data;

			styleSheet = new FStyleSheet();
			addToReport(BREAK+"\n* Test FCSS Pre-parser *\n"+BREAK+"\n");
			// parse css
			var t:Number = getTimer();


			styleSheet.parseCSS(rawCSS, true);
			t = (getTimer()-t);
			var strDebug:String;
			addToReport("- Parsing time: " + t + " ms\n");
			addToReport("- Bytes: " + rawCSS.length + " (" + Math.round(rawCSS.length / t) + " bytes/ms)\n\n");
			addToReport(strDebug);
			var fcssSpeedTest:FCSSSpeedTest = new FCSSSpeedTest();

			//
			requestAllstyles();
			requestAllstyles();

			exampleComplete()
		}



		protected function requestAllstyles():void
		{
			addToReport(BREAK+"\n* Test Requesting Every style *\n"+BREAK+"\n");

			var t:Number = getTimer();
			var strDebug:String;

			var styles:Array = styleSheet.styleNames;
			var total:int = styles.length;
			var i:int;
			var style:IStyle;
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
			strDebug = "Total time to request "+(total-1)+" styles time: " + t + " ms"+"\n";
			addToReport(strDebug);

			addToReport(""+(styles.length - results.length)+"/"+styles.length+" styles took 0 ms"+"\n");

			var average:Number = results.length/styles.length;

			addToReport("Average Style Request Time "+ average+ " ms"+"\n");
			results.sortOn("time", Array.NUMERIC | Array.DESCENDING); 

			var average2:Number = ((requestTimes/total-1) < 0) ? 0 : (requestTimes/total-1);

			addToReport("- Shortest Request "+results[results.length - 1].time+" ms '"+ results[results.length - 1].name+"' (* 0 ms doesn't count.)"+"\n");
			addToReport("- Longest Request "+results[0].time+" "+ results[0].name+"\n");

			var oneSecondRequests:Number = 0; 
			var longerStyles:String ="";
			for(i = 0; i < results.length; i++)
			{
				if(results[i].time > 1)
					longerStyles += "    Style '"+results[i].name+"' - "+results[i].time+" ms\n"+"\n";
				else
					oneSecondRequests ++;
			}

			addToReport(""+oneSecondRequests+" styles took 1 ms"+"\n");

			addToReport("Style requests > 1 ms:"+"\n");
			addToReport(longerStyles);
		}
	}
}

