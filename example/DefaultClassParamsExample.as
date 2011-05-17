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
	
	public class DefaultClassParamsExample extends Sprite
	{
		// Init Logger
		private static var logger:ILogger = getLogger(ExampleClass);
		
		public function DefaultClassParamsExample()
		{
			// Init Monster Debugger 3
			MonsterDebugger.initialize(this);
			
			// Init Logger Target
			LOGGER_FACTORY.setup = new SimpleTargetSetup(MONSTER_DEBUGGER_V3_TARGET);
			
			// Define default params
			var md3Params:MonsterDebuggerV3Params = new MonsterDebuggerV3Params();
			// The value for the Person field within Monster Debugger Traces Panel
			md3Params.person = "User";
			// The value for the Label field within Monster Debugger Traces Panel.
			md3Params.label = "Custom";
			
			// Add default params to this class. From this point on all log statements will use these params unless overridden.
			MONSTER_DEBUGGER_V3_TARGET.addClassDefaultParams(DefaultClassParamsExample, md3Params);
			
			// Log something
			logger.debug("This will utilise the default params we just assigned.");
			// OUTPUT: (String) = This will utilise the default params we just assigned.
			
			// Default params can be overridden for single log statements
			logger.debug("This will use the supplied params instead of the default ones.", new MonsterDebuggerV3Params("Developer", "Label", 0xCC0000));
			// OUTPUT: (String) = This will use the supplied params instead of the default ones.
			
			// This will use the default md3Params 
			logger.debug("This will utilise the default params.");
			// OUTPUT: (String) = This will utilise the default params.
			
			// You can remove default params from a class at any time like this
			MONSTER_DEBUGGER_V3_TARGET.removeClassDefaultParams(DefaultClassParamsExample);
		}
	}
}