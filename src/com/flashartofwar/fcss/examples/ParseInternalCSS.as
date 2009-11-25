package com.flashartofwar.fcss.examples
{
	import com.flashartofwar.fcss.styles.IStyle;
	import com.flashartofwar.fcss.styles.Style;
	import com.flashartofwar.fcss.stylesheets.FStyleSheet;

	public class ParseInternalCSS extends AbstractExample
	{

		private var styleSheet : FStyleSheet;

		public function ParseInternalCSS()
		{

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

		override public function runExample(data:* = null):void
		{
			parseCSS( );
			outputStyles( );
			exampleComplete();
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

			// This is requsting a style that extends another style
			var buttonStyle:IStyle = styleSheet.getStyle(".Button");

			// Let's combine a few styles on the fly
			var customPlayButtonStyle:IStyle = styleSheet.getStyle("baseStyle", "interactive", "#playButton");

			// Let's combine a few styles on the fly from an array
			var styleNames:Array = ["baseStyle", "interactive", "#playButton"];
			var customPlayButtonStyle2:IStyle = styleSheet.getStyle.apply(null, styleNames);


			// Output
			addToReport('var baseStyle:IStyle = styleSheet.getStyle("baseStyle");\n'+baseStyle.toString() + "\n"+ "\n");

			// Output
			addToReport('var buttonStyle:IStyle = styleSheet.getStyle(".Button");\n'+buttonStyle.toString() + "\n"+ "\n");
			// Output
			addToReport('var customPlayButtonStyle:IStyle = styleSheet.getStyle("baseStyle", "interactive", "#playButton");\n'+customPlayButtonStyle.toString() + "\n"+ "\n");
			// Output
			addToReport('var styleNames:Array = ["baseStyle", "interactive", "#playButton"];\nvar customPlayButtonStyle2:IStyle = styleSheet.getStyle.apply(null, styleNames);\n'+"From an Array-"+customPlayButtonStyle2.toString() + "\n"+ "\n");

			// If you want to see what the entire StyleSheet looks like do this
			addToReport('styleSheet.toString();\n'+"StyleSheet:" + "\n" + styleSheet.toString() + "\n"+ "\n");
		}

	}
}

