package com.flashartofwar.fcss.examples
{
	import com.flashartofwar.fcss.styles.IStyle;
	import com.flashartofwar.fcss.stylesheets.FStyleSheet;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ParseExternalCSS extends AbstractExample
	{

		private var styleSheet : FStyleSheet;
		private var cssText:String;
		private var urlLoader:URLLoader;

		public function ParseExternalCSS()
		{

		}

		override public function runExample(data:* = null):void
		{
			loadCSS(data);
		}

		private function loadCSS(url:String):void
		{
			urlLoader = new URLLoader( );
			urlLoader.addEventListener( Event.COMPLETE, onCSSLoad);
			urlLoader.load(new URLRequest(url));
		}

		private function onCSSLoad(event:Event):void
		{
			cssText = URLLoader(event.target ).data;

			runDemo();
		}

		protected function runDemo():void
		{
			parseCSS( );
			outputStyles( );
		}

		protected function parseCSS() : void
		{
			styleSheet = new FStyleSheet( );
			styleSheet.parseCSS(cssText);
		}

		protected function outputStyles() : void
		{
			// -- Output a few styles --//

			// This is a simple style request and probably the most common use.
			var baseStyle:IStyle = styleSheet.getStyle("baseStyle");
			// Output
			addToReport(baseStyle.toString() + "\n"+ "\n");

			// This is requsting a style that extends another style
			var buttonStyle:IStyle = styleSheet.getStyle(".Button");
			// Output
			addToReport(buttonStyle.toString() + "\n"+ "\n");

			// Let's combine a few styles on the fly
			var customPlayButtonStyle:IStyle = styleSheet.getStyle("baseStyle", "interactive", "#playButton");
			// Output
			addToReport(customPlayButtonStyle.toString() + "\n"+ "\n");


			// Let's combine a few styles on the fly from an array
			var styleNames:Array = ["baseStyle", "interactive", "#playButton"];
			var customPlayButtonStyle2:IStyle = styleSheet.getStyle.apply(null, styleNames);
			// Output
			addToReport("From an Array-"+customPlayButtonStyle2.toString() + "\n"+ "\n");

			// If you want to see what the entire StyleSheet looks like do this
			addToReport("StyleSheet:" + "\n" + styleSheet.toString() + "\n"+ "\n");
		}

	}
}

