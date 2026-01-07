package;

import sys.ExitCodes.Error;

class Script
{
    public function new()
    {
        ScriptHandler.scripts.push(this);
    }

    public function update(elapsed:Float):Null<Error> {
        return null;
    }
}