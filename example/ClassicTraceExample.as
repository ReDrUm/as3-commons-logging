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
	
	public class ClassicTraceExample extends Sprite
	{
		// Init Logger
		private static var logger:ILogger = getLogger(ExampleClass);
		
		public function ClassicTraceExample()
		{
			// Init Monster Debugger 3
			MonsterDebugger.initialize(this);
			
			// Init Logger Target
			LOGGER_FACTORY.setup = new SimpleTargetSetup(MONSTER_DEBUGGER_V3_TARGET);
			
			// Define default params
			var md3Params:MonsterDebuggerV3Params = new MonsterDebuggerV3Params();
			// Activate classic tracing via MonsterDebugger.log() where you can supply a comma separated list of objects to trace.
			md3Params.log = true;
			
			// Log something
			logger.debug("many", "things", this.x, md3Params, "The param order doesn't matter");
			// OUTPUT: (String) = ClassicTraceExample - many,things,0,the param order doesn't matter
		}
	}
}