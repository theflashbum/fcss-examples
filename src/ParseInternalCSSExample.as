package
{
	import com.flashartofwar.fcss.styles.Style;
	import com.flashartofwar.fcss.stylesheets.StyleSheet;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;

	public class ParseInternalCSSExample extends Sprite
	{

		private var outputDisplay : TextField;
		private var styleSheet : StyleSheet;

		public function ParseInternalCSSExample()
		{
			configureStage();
			createOutputDisplay();
			runDemo( );
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

		public function get cssText():String
		{
			var xml:XML = <css><![CDATA[/* This is a comment in the CSS file */
								baseStyle {
										x: 10px;
										y: 10px;
										width: 100px;
										height: 100px;
										padding: 5px;
										margin: 10px;
								}
								
								baseStyle .Button{
										x: 0px;
										y: 0px;
										background-color: #000000;
								}
								
								#playButton {
										background-color: #FFFFFF;
										background-image: url('/images/full_screen_background.jpg');
								}
								
								#fullScreenButton{
										background-color: #FF0000;
										background-image: url('/images/full_screen_background.jpg');
								}
								
								#playButton:over {
										background-color: #333333;
								}
								
								interactive {
										cursor: hand;
								}
								
								baseStyle interactive .SimpleButton
								{
									width: 100;
									height: 100;
								}
							]]>
				</css>;

			return xml.toString();

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
			var customPlayButtonStyle:Style = styleSheet.getStyle.apply(null, styleNames);
			// Output
			outputDisplay.appendText("From an Array-"+customPlayButtonStyle.toString() + "\n"+ "\n");

			// If you want to see what the entire StyleSheet looks like do this
			outputDisplay.appendText("StyleSheet:" + "\n" + styleSheet.toString() + "\n"+ "\n");
		}

	}
}

