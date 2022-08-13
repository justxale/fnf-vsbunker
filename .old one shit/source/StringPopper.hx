package;

class StringPopper
{
    public static function stringPop(stringToPop:String):String
        {
            var arrayToReturn:Array<String> = stringToPop.split('');
            var stringToReturn:String = '';
    
            arrayToReturn.pop();
    
            for(i in 0...arrayToReturn.length)
            {
                stringToReturn = stringToReturn + arrayToReturn[i];
            }
            return stringToReturn;
        }
}
