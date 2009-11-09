package
{
	import com.flashartofwar.fcss.styles.Style;
	import com.flashartofwar.fcss.stylesheets.StyleSheet;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class ParseExternalCSSExample extends Sprite
	{
		
		private var outputDisplay : TextField;
		private var styleSheet : StyleSheet;
		private var cssText:String;
		private var urlLoader:URLLoader;
		
		public function ParseExternalCSSExample()
		{
			configureStage();
			createOutputDisplay();
			loadCSS();
		}
		
		private function loadCSS():void
		{
			urlLoader = new URLLoader( );
			urlLoader.addEventListener( Event.COMPLETE, onCSSLoad);
			urlLoader.load(new URLRequest("css/demo.styles.css"));
		}
		
		private function onCSSLoad(event:Event):void
		{
			cssText = URLLoader(event.target ).data;
			
			runDemo();
		}
		
		private function configureStage() : void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		protected function createOutputDisplay():void
		{
			outputDisplay = new TextField();
			outputDisplay.border = true;
			outputDisplay.x = outputDisplay.y = 10;
			outputDisplay.autoSize = "left";
			outputDisplay.multiline = true;
			outputDisplay.wordWrap = true;
			outputDisplay.width = 500;
			addChild(outputDisplay);
		}
		
		protected function runDemo():void
		{
			parseCSS( );
			outputStyles( );
		}
		
		protected function parseCSS() : void
		{
			styleSheet = new StyleSheet( );
			styleSheet.parseCSS(cssText);
		}
		
		protected function outputStyles() : void
		{
			// -- Output a few styles --//
			
			// This is a simple style request and probably the most common use.
			var baseStyle:Style = styleSheet.getStyle("baseStyle");
			// Output
			outputDisplay.appendText(baseStyle.toString() + "\n"+ "\n");
			
			// This is requsting a style that extends another style
			var buttonStyle:Style = styleSheet.getStyle(".Button");
			// Output
			outputDisplay.appendText(buttonStyle.toString() + "\n"+ "\n");
			
			// Let's combine a few styles on the fly
			var customPlayButtonStyle:Style = styleSheet.getStyle("baseStyle", "interactive", "#playButton");
			// Output
			outputDisplay.appendText(customPlayButtonStyle.toString() + "\n"+ "\n");
			
			
			// Let's combine a few styles on the fly from an array
			var styleNames:Array = ["baseStyle", "interactive", "#playButton"];
			var customPlayButtonStyle2:Style = styleSheet.getStyle.apply(null, styleNames);
			// Output
			outputDisplay.appendText("From an Array-"+customPlayButtonStyle2.toString() + "\n"+ "\n");
			
			// If you want to see what the entire StyleSheet looks like do this
			outputDisplay.appendText("StyleSheet:" + "\n" + styleSheet.toString() + "\n"+ "\n");
		}
		
	}
}

