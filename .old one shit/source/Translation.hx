package;

import DialogueBoxPsych;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

using StringTools;

/**
 * made by Acolyte
 */

class Translation
{
    public static var curLanguage:Int = 0;
    public static var languages:Array<Dynamic> = [
        {name: 'English', prefix: '', translation: {}}
    ];
    public static var curPrefix:String = '';

    public static function init() {
        for (file in FileSystem.readDirectory('assets/translation')) {
            languages.push(cast Json.parse(File.getContent('assets/translation/' + file)));
        }
    }

    public static function dialogue(dio:DialogueFile, file:String):DialogueFile {
        var trio:Dynamic = cast Json.parse(File.getContent('assets/translation/dialogues/$file.json'));
        for (l in 0...dio.dialogue.length) {
            dio.dialogue[l].text = trio.dialogue[l].text;
        }
        return dio;
    }
    
    public static function string(string:String, ?state:String = 'Translation'):String {
		if (string == '') return string;

        var data:Dynamic = languages[curLanguage];
        var link:String = (state + '.' + string).replace(' ', '_');

        var translated:String = Reflect.field(data.translation, link);
        if (translated == null) translated = Reflect.field(data.translation, 'Global.' + string);
		#if debug if (translated == null && data.name != 'English') trace(link); #end
		
        if (translated == null) return string;
        return translated;
	}

    public static function changeLanguage(change:Int = 0) {
		curLanguage += change;
		if (curLanguage >= languages.length)
			curLanguage = 0;
		if (curLanguage < 0)
			curLanguage = languages.length - 1;
        curPrefix = languages[curLanguage].prefix;
		//ClientPrefs.saveSettings();
	}

    public static function checkLanguage() {
		for (l in 0...languages.length) {
            if (languages[l].name == ClientPrefs.curLanguage) {
                curPrefix = languages[l].prefix;
                curLanguage = l;
				return;
			}
		}
	}
}