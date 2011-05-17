package
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import com.timkeir.logging.MonsterDebuggerV3Params;
	import com.timkeir.logging.MonsterDebuggerV3Target;
	import com.timkeir.logging.MONSTER_DEBUGGER_V3_TARGET;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LOGGER_FACTORY;
	import org.as3commons.logging.getLogger;
	import org.as3commons.logging.setup.SimpleTargetSetup;
	
	import flash.display.Sprite;
	
	public class ExampleClass extends Sprite
	{
		// Init Logger
		private static var logger:ILogger = getLogger(ExampleClass);
		
		public function ExampleClass()
		{
			// Init Monster Debugger 3
			MonsterDebugger.initialize(this);
			
			// Init Logger Target
			LOGGER_FACTORY.setup = new SimpleTargetSetup(MONSTER_DEBUGGER_V3_TARGET);
			
			// Define default params
			var md3Params:MonsterDebuggerV3Params = new MonsterDebuggerV3Params();
			md3Params.person = "User";		// The value for the Person field within Monster Debugger Traces Panel.
			md3Params.label = "Label";		// The value for the Label field within Monster Debugger Traces Panel.
			md3Params.color = 0x0030AA;		// The text colour of the trace statement.
			md3Params.depth = 5;			// The depth Monster Debugger should should display when tracing complex data types.
			md3Params.log = false;			// Whether to use a class trace via MonsterDebugger.log() rather then MonsterDebugger.trace().
			
			// Log something
			logger.debug("This will not utilise the Person or Label fields because none have been specified yet.");
			
			// Add default params to this class
			MONSTER_DEBUGGER_V3_TARGET.addClassDefaultParams(ExampleClass, md3Params);
			
			// Log some more
			logger.debug("This will utilise the default params we just assigned.");
			logger.debug("This will use the supplied params instead of the default ones.", new MonsterDebuggerV3Params("Bob", "altLabel", 0xCC0000));
			logger.debug("This will utilise the default params.");
			
			// Remove default params from this class
			MONSTER_DEBUGGER_V3_TARGET.removeClassDefaultParams(ExampleClass);
			
			// Another log
			logger.debug("This will not utilise the Person or Label fields because the default params have been removed.");
		}
	}
}