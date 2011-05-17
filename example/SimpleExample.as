package
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import com.timkeir.logging.MonsterDebuggerV3Params;
	import com.timkeir.logging.MONSTER_DEBUGGER_V3_TARGET;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LOGGER_FACTORY;
	import org.as3commons.logging.getLogger;
	import org.as3commons.logging.setup.SimpleTargetSetup;
	
	import flash.display.Sprite;
	
	public class SimpleExample extends Sprite
	{
		// Init Logger
		private static var logger:ILogger = getLogger(ExampleClass);
		
		public function SimpleExample()
		{
			// Init Monster Debugger 3
			MonsterDebugger.initialize(this);
			
			// Init Logger Target
			LOGGER_FACTORY.setup = new SimpleTargetSetup(MONSTER_DEBUGGER_V3_TARGET);
			
			// Log some more
			logger.debug("This is a standard trace which won't make use of the Person or Label filters available in Monster Debugger 3.");
			
			// Default params can be overridden for single log statements
			logger.debug("This is an enhanced trace utilising the Person and Label filters and a custom color", new MonsterDebuggerV3Params("User", "Label", 0xCC0000));
		}
	}
}