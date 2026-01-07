package;

import sys.logger.Logs;

class Main {

    static var script = ScriptHandler; // What script to run (MUST CONTAIN `run()`!)

    public static function main()
    {
        Logs.init();

        var result:Dynamic = script.run();

        #if sys
            File.saveContent("return.txt", Std.string(result));
        #end
        trace(result);
    }
}