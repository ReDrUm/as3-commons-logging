package com.timkeir.logging
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.utils.Dictionary;
	import org.as3commons.logging.LogLevel;
	import org.as3commons.logging.level.DEBUG;
	import org.as3commons.logging.level.ERROR;
	import org.as3commons.logging.level.FATAL;
	import org.as3commons.logging.level.INFO;
	import org.as3commons.logging.level.WARN;
	import org.as3commons.logging.setup.target.IFormattingLogTarget;
	import org.as3commons.logging.util.LogMessageFormatter;
	import org.as3commons.logging.util.toLogName;

	/**
	 * <code>MonsterDebuggerV3Target</code> logs directly to the Monster Debugger 3 Traces console.
	 * 
	 * <p>The Monster Debugger is an alternative way to display your logging statements.</p>
	 * 
	 * @see http://demonsterdebugger.com@author tim.keir
	 * @see http://www.as3commons.org/as3-commons-logging
	 *  
	 * @author Tim Keir. Based on Martin Heidegger's org.as3commons.logging.setup.target.MonsterDebuggerTarget.
	 * @created 16/05/2011
	 * @since 2.0
	 */
	public final class MonsterDebuggerV3Target extends Object implements IFormattingLogTarget
	{
		/** Default output format used to stringify log statements via MonsterDebugger.trace(). */
		public static const DEFAULT_FORMAT:String = "{message}";
		
		/** Default output format used to stringify log statements via MonsterDebugger.log(). */
		public static const CLASSIC_FORMAT:String = "{shortName} - {message}";

		/** Default colors used to color the output statements. */
		public static const DEFAULT_COLORS:Dictionary = new Dictionary();
		{
			DEFAULT_COLORS[DEBUG] = 0x0030AA;
			DEFAULT_COLORS[FATAL] = 0xAA0000;
			DEFAULT_COLORS[ERROR] = 0xFF0000;
			DEFAULT_COLORS[INFO] = 0x666666;
			DEFAULT_COLORS[WARN] = 0xff7700;
		}

		/** Colors used to display the messages. */
		private var _colors:Dictionary;

		/** Formatter that renders the log statements via MonsterDebugger.trace(). */
		private var _formatter:LogMessageFormatter;
		/** Formatter that renders the log statements via MonsterDebugger.log(). */
		private const _classicFormatter:LogMessageFormatter = new LogMessageFormatter(CLASSIC_FORMAT);

		/** Optional default parameters for individual classes. Classes are mapped as the key to MonsterDebuggerV3Params objects. */
		private static const defaultParams:Dictionary = new Dictionary(true);

		/**
		 * Constructs a new <code>MonsterDebuggerTarget</code>
		 * 
		 * @param format Default format used to render log statements.
		 * @param colors Default colors used to color log statements.
		 */
		public function MonsterDebuggerV3Target(format:String = null, colors:Dictionary = null)
		{
			this.format = format||DEFAULT_FORMAT;
			this.colors = colors||DEFAULT_COLORS;
		}

		/**
		 * The colors used to to send the log statement.
		 * 
		 * <p>Monster Debugger supports custom colors for log statements. These
		 * can be changed dynamically if you pass here a Dictionary with Colors (numbers)
		 * used for all levels:</p>
		 * 
		 * @example <listing version="3.0">
		 *     import org.as3commons.logging.level.*;
		 *     
		 *     var colors: Dictionary = new Dictionary();
		 *     colors[DEBUG] = 0x00FF00;
		 *     colors[INFO] = 0x00FFFF;
		 *     colors[WARN] = 0xFF0000;
		 *     colors[ERROR] = 0x0000FF;
		 *     colors[FATAL] = 0xFFFF00;
		 *     MONSTER_DEBUGGER_V3_TARGET.colors = colors;
		 * </listing>
		 */
		public function get colors():Dictionary
		{
			return _colors;
		}
		public function set colors(colors:Dictionary):void
		{
			_colors = colors||DEFAULT_COLORS;
		}

		/**
		 * @see http://www.as3commons.org/as3-commons-logging/asdoc/org/as3commons/logging/setup/target/IFormattingLogTarget.html#format
		 */
		public function set format(format:String):void
		{
			_formatter = new LogMessageFormatter(format||DEFAULT_FORMAT);
		}

		/**
		 * Add default Params to a specific class.
		 * 
		 * <p>Params are stored via a String representation of the class. This avoids storing actual
		 * references to the class allowing for proper garbage collection.
		 * <code>target</code> is of type Class to force the use of qualified class names to avoid
		 * conflicts between common classes using the same name.</p>
		 * 
		 * @see com.timkeir.logging.MonsterDebuggerV3Params
		 * 
		 * @example <listing version="3.0">
		 *     import com.timkeir.logging.MONSTER_DEBUGGER_V3_TARGET;
		 *     import com.timkeir.logging.MonsterDebuggerV3Params;
		 *     
		 *     MONSTER_DEBUGGER_V3_TARGET.addClassDefaultParams(ExampleClass, new MonsterDebuggerV3Params("Developer Name", "Example Label"));
		 * </listing>
		 * 
		 * @param target The class you wish to apply the default params to.
		 * @param params The params you wish to apply.
		 */
		public function addClassDefaultParams(target:Class, params:MonsterDebuggerV3Params):void
		{
			var className:String = toLogName(target);
			defaultParams[className] = params;
		}

		/**
		 * Remove default Params from a specific class.
		 * 
		 * <code>target</code> is of type Class to force the use of qualified class names to avoid
		 * conflicts between common classes using the same name.</p>
		 * 
		 * @example <listing version="3.0">
		 *     import com.timkeir.logging.MONSTER_DEBUGGER_V3_TARGET;
		 *     
		 *     MONSTER_DEBUGGER_V3_TARGET.removeClassDefaultParams(ExampleClass);
		 * </listing>
		 * 
		 * @param target The class you wish to remove the default params from.
		 */
		public function removeClassDefaultParams(target:Class):void
		{
			var className:String = toLogName(target);
			if(defaultParams[className] != undefined)
			{
				defaultParams[className] = null;
				delete defaultParams[className];
			}
		}
		
		/**
		 * Renders a log statement.
		 * 
		 * <p>Passing in an optional MonsterDebuggerV3Params object allows you to utilise
		 * additional functionality within Monster Debugger.<p>
		 * 
		 * @example <listing version="3.0">
		 *     import com.timkeir.logging.MonsterDebuggerV3Params;
		 *     
		 *     var md3params: MonsterDebuggerV3Params = new MonsterDebuggerV3Params();
		 *     md3params.person = "Developer Name;
		 *     md3params.label = "myLabel;
		 *     md3params.color = 0xFF0000;
		 *     md3params.depth = 5;
		 *     md3params.log = false;
		 *     
		 *     logger.debug("Test Log", md3params);
		 * </listing>
		 * 
		 * @see com.timkeir.logging.MonsterDebuggerV3Params
		 * 
		 * @see http://demonsterdebugger.com/asdoc/com/demonsters/debugger/MonsterDebugger.html#trace()
		 * @see http://demonsterdebugger.com/asdoc/com/demonsters/debugger/MonsterDebugger.html#log()
		 * 
		 * @param name Name of the logger that triggered the log statement.
		 * @param shortName Shortened form of the name.
		 * @param level Level of the log statement that got triggered
		 * @param timeStamp Time stamp of when the log statement got triggered.
		 * @param message Message/Object of the log statement.
		 * @param parameters Parameters for the log statement.
		 */
		public function log(name:String, shortName:String, level:LogLevel, timeStamp:Number, message:*, parameters:Array):void
		{
		    var md3Params:MonsterDebuggerV3Params;
		    var person:String = "";
		    var label:String = "";
		    var color:int = _colors[level];
		    var depth:int = 5;
		    var log:Boolean = false;
		    
		    // Check for Monster Debugger specific parameters
		    paramsLoop : for each(var value:* in parameters)
		    {
		    	if(value is MonsterDebuggerV3Params)
		    	{
		    		md3Params = value;
		    		person = md3Params.person;
		    		label = md3Params.label;
		    		depth = md3Params.depth;
		    		log = md3Params.log;
		    		
		    		// Only set colour if specified, defaults to this.colors
		    		if(md3Params.color != -1)
		    		{
		    			color = md3Params.color;
		    		}
		    		
		    		// Remove once set to prevent it showing up in a classic trace if log is true.
		    		parameters.splice(parameters.indexOf(value), 1);
		
		    		break paramsLoop;
		    	}
		    	
		    }
		    
		    // Check for default params attached to class (unless overriden above)
		    if(!md3Params && defaultParams[name] != undefined)
		    {
				md3Params = defaultParams[name];
				person = md3Params.person;
				label = md3Params.label;
				if(md3Params.color != -1)
				{
					color = md3Params.color;
				}
				depth = md3Params.depth;
				log = md3Params.log;
		    }
		    
		    // Remove params object if set
		    md3Params = null;
		    
			// Enhanced trace via MonsterDebugger console
			if(!log)
			{
				if(message is String)
				{
					MonsterDebugger.trace(name, _formatter.format(name, shortName, level, timeStamp, message, parameters), person, label, color, depth);
					return;
				}
				MonsterDebugger.trace(name, message, person, label, color, depth);
			}
		    // Classic trace via MonsterDebugger console
		    else
		    {
		    	if(message is String)
		    	{
					if(parameters.length > 0)
					{
		    			MonsterDebugger.log(_classicFormatter.format(name, shortName, level, timeStamp, message, parameters), parameters);
		    			return;
		    		}
		    		// Dont pass in paramters if empty. This prevents an unneccessary comma at end of statement.
		    		MonsterDebugger.log(_classicFormatter.format(name, shortName, level, timeStamp, message, parameters));
		    		return;
				}
				parameters.length > 0 ? MonsterDebugger.log(message, parameters) : MonsterDebugger.log(message);
		    }
		}
	}
}

