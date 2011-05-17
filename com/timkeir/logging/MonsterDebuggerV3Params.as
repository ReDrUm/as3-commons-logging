package com.timkeir.logging
{
	/**
	 *	Optional Parameters from MonsterDebugger 3.x. trace() statement
	 *	for use with MonsterDebuggerV3Target in relation to AS3 Commons Logging framework.
	 *	
	 *	@see http://demonsterdebugger.com/asdoc/com/demonsters/debugger/MonsterDebugger.html#trace()
	 *	@see http://www.as3commons.org/as3-commons-logging
	 *	
	 *	@see com.timkeir.logging.MonsterDebuggerV3Target
	 *
	 *	@author Tim Keir
	 *	@created 16/05/2011
	 *	@since 2.0
	 */
	public final class MonsterDebuggerV3Params
	{
		public var person:String;
		public var label:String;
		public var color:int;
		public var depth:int;
		public var log:Boolean;
		
		/**
		 *	A Value Object to be mapped to the optional parameters within a MonsterDebugger trace statement.
		 *	
		 *	NOTE: If setting log to true all other MonsterDebuggerV3Params will be ignored. See the official
		 *	Monster Debugger docs for more details.
		 *	@see http://demonsterdebugger.com/asdoc/com/demonsters/debugger/MonsterDebugger.html#log()
		 *	
		 *	@param person The name of the developer triggering the trace statement. Used for filtering.
		 *	@param label A custom label used for filtering. e.g. The name of the feature you're debugging.
		 *	@param color The colour the trace statement is to appear within MonsterDebugger.
		 *	@param depth How many levels deep to traverse if tracing a complex object.
		 *	@param log Whether to enable a classic trace via MonsterDebugger.log() instead of trace().
		 */
		public function MonsterDebuggerV3Params(person:String = "", label:String = "", color:int = -1, depth:int = 5, log:Boolean = false)
		{
			this.person = person;
			this.label = label;
			this.color = color;
			this.depth = depth;
			this.log = log;
		}
	}
}