package sys;

typedef Error = {
    var code:Int;
    @:optional var message:String;
}

class ExitCodes
{
    public static final genericBadRun:Error = {
        code: 1, 
        message: "The script failed to run for one or more reasons:"
    };
    public static final normalExit:Error = {
        code: 0,
        message: "The script ran successfully"
    }
    public static final illegalAccess:Error = {
        code: 4,
        message: "The script tried to access a resource it didn't have access to, verify the permissions, and check if sys is enabled on that system."
    }

    static var validCodes:Array<Int> = [0, 1, 4];
    static var codesByIndex:Map<Int, Error> = [
        0 => normalExit,
        1 => genericBadRun,
        4 => illegalAccess
    ];

    public static function throwNew(code:Int = 0, ?message:String = "Generic Error", ?details:Array<Dynamic>):String
    {
        var finalMessage:String = message;
        var finalCode:Int = code;
        if (!validCodes.contains(code))
        {
            finalCode = 1;
        }
        
        var error:Error = codesByIndex[finalCode];
        if (code == 1)
        {
            for (i in 0...details.length)
            {
                var item = details[i];
                finalMessage = finalMessage.replace('{[$i]}', Std.string(item));
            }
        }
        else
        {
            finalMessage = error.message;
        }

        return 'Process exited with code $code: `$finalMessage`';
    }
}