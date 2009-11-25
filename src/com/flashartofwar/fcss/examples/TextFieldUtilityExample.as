package com.flashartofwar.fcss.examples
{
	import com.flashartofwar.fcss.factories.TextFieldFactory;
	import com.flashartofwar.fcss.managers.StyleSheetManager;
	import com.flashartofwar.fcss.styles.Style;
	import com.flashartofwar.fcss.stylesheets.StyleSheet;
	import com.flashartofwar.fcss.utils.TextFieldUtil;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;

	public class TextFieldUtilityExample extends Sprite
	{
		private var styleSheet:StyleSheet;

		public function TextFieldUtilityExample()
		{
			configureStage();
			runDemo( );
		}

		public function get cssText():String
		{
			var xml:XML = <css>
					<![CDATA[
							/* This is a comment in the CSS file */
							baseStyle {
								x: 10px;
								y: 10px;
								width: 100px;
								height: 100px;
								padding: 5px;
								margin: 10px;
							}
							
							baseStyle #demoTextField1
							{
								autoSize: left;
								background: true;
								backgroundColor: black;
								border: true;
								borderColor: red;
								multiline: true;
								restrict: A-Z 0-9;
								textColor: white;
								selectable: false;
								wordWrap: true;
								x: 100;
								y: 50;
								
							}
							
							#demoTextField1 #demoTextField2
							{
								backgroundColor: white;
								border: false;				
								styleSheet: a, a:hover, .redText;
								y: 200;
							}
							
							a{color:#000000;}
				
							a:hover{color:#00ff00;}
				
							.redText{color:#FF0000;}
						]]>
				</css>;
			return xml.toString();
		}

		private function configureStage() : void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		protected function runDemo():void
		{
			parseCSS( );
			creatTextField( );
		}

		protected function parseCSS() : void
		{
			/*
			 * This is very important. Inorder to have the TextFieldFactory work
			 * you need to put all of your CSS in the StyleSheetManager
			 */
			StyleSheetManager.instance.parseCSS(cssText);
		}

		protected function creatTextField():void
		{
			var tfFactory:TextFieldFactory = new TextFieldFactory();
			/*
			 * This creates a simple TextField and uses the demoTextField1
			 * style as it's ID. The factory will automatically use the TextField's
			 * class name and add "#" to the id when looking up it's css.
			 */
			var tf:TextField = new TextField();
			var style1:Style = StyleSheetManager.instance.getStyle("#demoTextField1");
			TextFieldUtil.applyStyle(tf, style1);
			tf.text = "F*CSS Hello World";
			addChild(tf);

			/*
			 * This example shows you how to take advantage of F*CSS's built in
			 * support for inline StyleSheets.
			 */
			var tf2:TextField = new TextField();
			var style2:Style = StyleSheetManager.instance.getStyle("#demoTextField2");
			TextFieldUtil.applyStyle(tf2, style2);
			tf2.text = "<span class='redText'>F*CSS</span> <a href='http://code.google.com/p/fcss-lib/source/browse/#svn/branches/fcss_api_change_for_1.6.0_alpha' target='blank'>Docs</a>";
			addChild(tf2);

		}
	}
}

