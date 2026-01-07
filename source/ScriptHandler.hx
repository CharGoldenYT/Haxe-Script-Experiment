package;

import haxe.Exception;
import sys.ExitCodes;

// This contains the actual code that is ran.

class InfiniteIterator
{
    var index:Int = 0;
    public function new() {}

    public inline function hasNext():Bool return true;
    public inline function next():Int return index++;
}

class ScriptHandler
{
    public static var scripts:Array<Script> = [];
    static var updateFps:Int = 60;

    public static function calculateFrameDelay():Float
    {
        return updateFps * 1000;
    }

    public static function loadScripts()
    {
        new scripts.Funny();
    }

    static var lastFrame:Int = 0;
    public static function run():String
    {
        loadScripts();
        for (i in new InfiniteIterator())
        {
            try
            {
                var result = doUpdate(i / calculateFrameDelay());
                if (result != null)
                {
                    return ExitCodes.throwNew(result.code, result.message);
                }
            }
            catch(e:Exception)
            {
                return ExitCodes.throwNew(1, e.message);
            }

            var curFrame = i / calculateFrameDelay();
            if (Math.floor(curFrame) > lastFrame)
            {
                lastFrame = Math.floor(curFrame);
               // trace(lastFrame);
            }
        }
        
        return ExitCodes.throwNew(0); // ran successfully.
    }

    static function doUpdate(elapsed:Float):Null<Error>
    {
        var result:Null<Error> = null;

        for (script in scripts)
        {
            result = script.update(elapsed);
            if (result != null) return result;
        }

        return null;
    }
}