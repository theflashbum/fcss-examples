package com.flashartofwar.fcss.examples
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class AbstractExample extends EventDispatcher
	{
		protected static const BREAK:String = "----------------------------------------------------------------------------------------------------------";
		protected var _report:String = "";

		public function get report():String
		{
			return _report;
		}

		public function AbstractExample(target:IEventDispatcher=null)
		{
			super(target);
		}

		public function runExample(data:* = null):void
		{

		}

		public function addToReport(value:String):void
		{
			_report +=value;
		}

		protected function exampleComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE, true, true));
		}
	}
}

