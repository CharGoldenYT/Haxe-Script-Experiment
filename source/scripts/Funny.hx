package scripts;

import sys.ExitCodes;

class Funny extends Script
{
    public override function update(elapsed:Float):Null<Error>
    {
        if (elapsed * 1000 == 10)
        {
            return ExitCodes.normalExit;
        }
        else
        {
            return super.update(elapsed);
        }
    }
}