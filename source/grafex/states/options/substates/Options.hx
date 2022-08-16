package grafex.states.options.substates;

import grafex.systems.song.Song;
import grafex.states.substates.LoadingState;
import grafex.systems.Paths;
import utils.FPSMem;

import lime.app.Application;
import lime.system.DisplayMode;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import flixel.graphics.FlxGraphic;
import openfl.Lib;

class Option
{
	public function new()
	{
		display = updateDisplay();
	}

	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;

	public var acceptType:Bool = false;

	public var waitingType:Bool = false;

	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String
	{
		return updateDisplay();
	};

	public function onType(text:String)
	{
	}

	// Returns whether the label is to be updated.
	public function press():Bool
	{
		return true;
	}

	private function updateDisplay():String
	{
		return "";
	}

	public function left():Bool
	{
		return false;
	}

	public function right():Bool
	{
		return false;
	}
}

class DFJKOption extends Option
{
	public function new()
	{
		super();
    if (OptionsMenu.isInPause)
		description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
	    description = Translation.string('Edit your keybindings','Options');
	}

	public override function press():Bool
	{
		//OptionsMenu.instance.selectedCatIndex = 4;
		//OptionsMenu.instance.switchCat(OptionsMenu.instance.options[4], false);

                if (OptionsMenu.isInPause)
			return false;
		OptionsMenu.openControllsState();
             		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Edit Keybindings','Options');
	}
}

class NotesOption extends Option
{
	public function new()
	{
		super();
                if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
		description = Translation.string('Edit notes colors','Options');

	}

	public override function press():Bool
	{
		//OptionsMenu.instance.selectedCatIndex = 4;
		//OptionsMenu.instance.switchCat(OptionsMenu.instance.options[4], false);

                if (OptionsMenu.isInPause)
			return false;
		OptionsMenu.openNotesState();
             		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Edit notes colors','Options');

	}
}

class Customizeption extends Option
{
	public function new()
	{
		super();
                 if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
		description = Translation.string('Edit elements positions / beat offset','Options');
	}

	public override function press():Bool
	{
		//OptionsMenu.instance.selectedCatIndex = 4;
		//OptionsMenu.instance.switchCat(OptionsMenu.instance.options[4], false);


         if (OptionsMenu.isInPause)
			return false;
		OptionsMenu.openAjustState();
	    return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Edit elements positions / beat offset','Options');
	}
}

class SickMSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " " + Translation.string('(Press R to reset)','Options');

		acceptType = true;
	}

	public override function left():Bool
	{
		ClientPrefs.sickWindow--;
		if (ClientPrefs.sickWindow < 0)
			ClientPrefs.sickWindow = 0;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		ClientPrefs.sickWindow++;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			ClientPrefs.sickWindow = 45;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Sicks','NotePressInfo') + ": < " + ClientPrefs.sickWindow + " " + Translation.string('ms','NotePressInfo') + " >";
	}
}

class GoodMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " " + Translation.string('(Press R to reset)','Options');
		acceptType = true;
	}

	public override function left():Bool
	{
		ClientPrefs.goodWindow--;
		if (ClientPrefs.goodWindow < 0)
			ClientPrefs.goodWindow = 0;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		ClientPrefs.goodWindow++;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			ClientPrefs.goodWindow = 90;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Goods','NotePressInfo') + ": < " + ClientPrefs.goodWindow + " " + Translation.string('ms','NotePressInfo') + " >";
	}
}

class BadMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " " + Translation.string('(Press R to reset)','Options');
		acceptType = true;
	}

	public override function left():Bool
	{
		ClientPrefs.badWindow--;
		if (ClientPrefs.badWindow < 0)
			ClientPrefs.badWindow = 0;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		ClientPrefs.badWindow++;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			ClientPrefs.badWindow = 135;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Bads','NotePressInfo') + ": < " + ClientPrefs.badWindow + " " + Translation.string('ms','NotePressInfo') + " >";
	}
}

/*class ShitMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptType = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.shitMs--;
		if (FlxG.save.data.shitMs < 0)
			FlxG.save.data.shitMs = 0;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.shitMs = 160;
	}

	public override function right():Bool
	{
		FlxG.save.data.shitMs++;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "SHIT: < " + FlxG.save.data.shitMs + " ms >";
	}
} 

class CpuStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.cpuStrums = !FlxG.save.data.cpuStrums;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "CPU Strums: < " + (FlxG.save.data.cpuStrums ? "Light up" : "Stay static") + " >";
	}
}

class GraphicLoading extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cacheImages = !FlxG.save.data.cacheImages;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "";
	}
}

class EditorRes extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.editorBG = !FlxG.save.data.editorBG;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Editor Grid: < " + (FlxG.save.data.editorBG ? "Shown" : "Hidden") + " >";
	}
} */

class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.downScroll = !ClientPrefs.downScroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('DownScroll', 'Options') + ": < " + (ClientPrefs.downScroll ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class GhostTapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.ghostTapping = !ClientPrefs.ghostTapping;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Ghost Tapping', 'Options') + ": < " + (ClientPrefs.ghostTapping ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class SkipTitleOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.skipTitleState = !ClientPrefs.skipTitleState;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('TitleState Skipping', 'Options') + ": < " + (ClientPrefs.skipTitleState ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class KESustainsOption extends Option
{
	public function new(desc:String)
	{
		super();
         if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
		description = desc;
	}

	public override function left():Bool
	{
                if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.keSustains = !ClientPrefs.keSustains;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Kade Engine Sustains System: < " + (ClientPrefs.keSustains ? "Enabled" : "Disabled") + " >";
	}
}



class ScoreZoom extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.scoreZoom = !ClientPrefs.scoreZoom;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Score zomming in beats', 'Options') + ": < " + (ClientPrefs.scoreZoom ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class HideHud extends Option
{
	public function new(desc:String)
	{
		super();
              if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;

	}

	public override function left():Bool
	{
              	if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.hideHud = !ClientPrefs.hideHud;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('HUD', 'Options') + ": < " + (!ClientPrefs.hideHud ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class MicedUpSusOption extends Option
{
	public function new(desc:String)
	{
		super();
              if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;

	}

	public override function left():Bool
	{
              	if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.micedUpSus = !ClientPrefs.micedUpSus;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('MicedUp Sustains Filter', 'Options') + ": < " + (ClientPrefs.micedUpSus ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class ShowCombo extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.showCombo = !ClientPrefs.showCombo;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Combo Sprite', 'Options') + ": < " + (ClientPrefs.showCombo ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class BlurNotes extends Option
{
	public function new(desc:String)
	{
		super();
              if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
           	if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.blurNotes = !ClientPrefs.blurNotes;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Blurred Notes', 'Options') + ": < " + (ClientPrefs.blurNotes ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class AutoSave extends Option
{
	public function new(desc:String)
	{
		super();

			description = desc;
	}

	public override function left():Bool
	{

		ClientPrefs.chartautosave = !ClientPrefs.chartautosave;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Chart AutoSave', 'Options') + ": < " + (ClientPrefs.chartautosave ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class AutoSaveInt extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.chartautosaveInterval--;
		if (ClientPrefs.chartautosaveInterval < 1)
		ClientPrefs.chartautosaveInterval = 1;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		ClientPrefs.chartautosaveInterval++;
		if (ClientPrefs.chartautosaveInterval > 15)
			ClientPrefs.chartautosaveInterval = 15;
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return Translation.string('Chart AutoSave Interval', 'Options') + ": < " + ClientPrefs.chartautosaveInterval + " " + Translation.string('Minutes', 'Options') + " >";
	}
}


class NoReset extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.noReset = !ClientPrefs.noReset;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Reset Button: < " + (!ClientPrefs.noReset ? "Enabled" : "Disabled") + " >";
	}
}

class ResetButtonOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		ClientPrefs.noReset = !ClientPrefs.noReset;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Reset Button', 'Options') + ": < " + (ClientPrefs.noReset ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class Shouldcameramove extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		ClientPrefs.shouldcameramove= !ClientPrefs.shouldcameramove;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Dynamic Camera', 'Options') + ": < " + (ClientPrefs.shouldcameramove ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class InstantRespawn extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		ClientPrefs.instantRespawn = !ClientPrefs.instantRespawn;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Instant Respawn', 'Options') + ": < " + (ClientPrefs.instantRespawn ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class FlashingLightsOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.flashing = !ClientPrefs.flashing;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Flashing Lights', 'Options') + ": < " + (ClientPrefs.flashing ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class AntialiasingOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.globalAntialiasing = !ClientPrefs.globalAntialiasing;
               // onChangeAntiAliasing();
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Antialiasing', 'Options') + ": < " + (ClientPrefs.globalAntialiasing ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class MissSoundsOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.playmisssounds = !ClientPrefs.playmisssounds;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Miss Sounds', 'Options') + ": < " + (ClientPrefs.playmisssounds ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class MissAnimsOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.playmissanims = !ClientPrefs.playmissanims;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Miss Animations', 'Options') + ": < " + (ClientPrefs.playmissanims ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";	}
}

class PauseCountDownOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.countdownpause = !ClientPrefs.countdownpause;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('AfterPause CountDown', 'Options') + ": < " + (ClientPrefs.countdownpause ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class GreenScreenMode extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.greenscreenmode = !ClientPrefs.greenscreenmode;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Green screen', 'Options') + ": < " + (ClientPrefs.greenscreenmode ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class Judgement extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		OptionsMenu.instance.selectedCatIndex = 5;
		OptionsMenu.instance.switchCat(OptionsMenu.instance.options[5], false);
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Edit Judgements', 'Options');

	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		
ClientPrefs.showFPS = !ClientPrefs.showFPS;
FPSMem.showFPS = ClientPrefs.showFPS;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('FPS Counter', 'Options') + ": < " + (FPSMem.showFPS ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	} 
}

class MEMOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{

                ClientPrefs.showMEM = !ClientPrefs.showMEM;
                FPSMem.showMem =  ClientPrefs.showMEM;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Memory Counter', 'Options') + ": < " + (FPSMem.showMem ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	} 
}

class AutoPause extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.autoPause = !ClientPrefs.autoPause;
                FlxG.autoPause = ClientPrefs.autoPause;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('AutoPause', 'Options') + ": < " + (ClientPrefs.autoPause ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	} 
}

class ShowSplashes extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
        ClientPrefs.noteSplashes = !ClientPrefs.noteSplashes;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('NoteSplashes', 'Options') + ": < " + (ClientPrefs.noteSplashes ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	} 
}
class QualityLow extends Option
{
	public function new(desc:String)
	{
		super();
              if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
             		if (OptionsMenu.isInPause)
			return false;
        ClientPrefs.lowQuality = !ClientPrefs.lowQuality;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Low Quality', 'Options') + ": < " + (ClientPrefs.lowQuality ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	} 
}

class FPSCapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return Translation.string('FPS Cap', 'Options') + ": < " + ClientPrefs.framerate + " >";
	}

	override function right():Bool
	{
		if (ClientPrefs.framerate >= 290)
		{
			ClientPrefs.framerate = 290;
                        onChangeFramerate();
		}
		else
			ClientPrefs.framerate = ClientPrefs.framerate + 5;
		    onChangeFramerate();

		return true;
	}

	override function left():Bool
	{
		if (ClientPrefs.framerate > 290)
			ClientPrefs.framerate = 290;
		else if (ClientPrefs.framerate <= 60)
			ClientPrefs.framerate = Application.current.window.displayMode.refreshRate;
		else
			ClientPrefs.framerate = ClientPrefs.framerate - 5;
			onChangeFramerate();
		return true;
	}

    function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}

	override function getValue():String
	{
		return updateDisplay();
	}
}

class HideOppStrumsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.hideOpponenStrums = !ClientPrefs.hideOpponenStrums;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('Opponent Strums', 'Options') + ": < " + (!ClientPrefs.hideOpponenStrums ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class OffsetMenu extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");

		PlayState.SONG = Song.loadFromJson('tutorial', '');
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 0;
		//PlayState.offsetTesting = true;
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Time your offset";
		
	}
}
class OffsetThing extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.noteOffset--;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.noteOffset++;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('Note offset', 'Options') + ": < " + Utils.truncateFloat(ClientPrefs.noteOffset, 0) + " >";
	}

	public override function getValue():String
	{
		return 	Translation.string('Note offset', 'Options') + ": < " + Utils.truncateFloat(ClientPrefs.noteOffset, 0) + " >";
	}
} 

class CamZoomOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.camZooms = !ClientPrefs.camZooms;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('Camera Zoom', 'Options') + ": < " + (ClientPrefs.camZooms ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class JudgementCounter extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.showjud = !ClientPrefs.showjud;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('Judgement Counter', 'Options') + ": < " + (ClientPrefs.showjud ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class Imagepersist extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.imagesPersist = !ClientPrefs.imagesPersist;
                FlxGraphic.defaultPersist = ClientPrefs.imagesPersist;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('Persistent Cached Data', 'Options') + ": < " + (ClientPrefs.imagesPersist ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class ControllerMode extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.controllerMode = !ClientPrefs.controllerMode;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return 	Translation.string('Controller Mode', 'Options') + ": < " + (ClientPrefs.controllerMode ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class MiddleScrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.middleScroll = !ClientPrefs.middleScroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Middle Scroll', 'Options') + ": < " + (ClientPrefs.middleScroll ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
        //Translation.string('Enabled', 'Options');
		//Translation.string('Disabled', 'Options');
	}
}


class NoteskinOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.noteSkinNum--;
		if (ClientPrefs.noteSkinNum < 0)
		ClientPrefs.noteSkinNum = OptionsHelpers.noteskinArray.length - 4;
     OptionsHelpers.ChangeNoteSkin(ClientPrefs.noteSkinNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.noteSkinNum++;
		if (ClientPrefs.noteSkinNum > OptionsHelpers.noteskinArray.length - 1)
			ClientPrefs.noteSkinNum = OptionsHelpers.noteskinArray.length - 1;
                  OptionsHelpers.ChangeNoteSkin(ClientPrefs.noteSkinNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return Translation.string('Current Noteskin', 'Options') + ": < " + OptionsHelpers.getNoteskinByID(ClientPrefs.noteSkinNum) + " >";
	}
}

class AccTypeOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.ratingSystemNum--;
		if (ClientPrefs.ratingSystemNum < 0)
		ClientPrefs.ratingSystemNum = OptionsHelpers.AccuracyTypeArray.length - 6;
     OptionsHelpers.ChangeAccType(ClientPrefs.ratingSystemNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		ClientPrefs.ratingSystemNum++;
		if (ClientPrefs.ratingSystemNum > OptionsHelpers.AccuracyTypeArray.length - 1)
			ClientPrefs.ratingSystemNum = OptionsHelpers.AccuracyTypeArray.length - 1;
                  OptionsHelpers.ChangeAccType(ClientPrefs.ratingSystemNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return 	Translation.string('Current Accuracy Type', 'Options') + ": < " + OptionsHelpers.getAccTypeID(ClientPrefs.ratingSystemNum) + " >";
	}
}

class LangOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool {
		Translation.changeLanguage(1);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool {
		Translation.changeLanguage(-1);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String {
		return Translation.string('Language', 'OptionsMenu') + ': < ' + Translation.languages[Translation.curLanguage].name + ' >';
	}
}

class ColorBlindOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.ColorBlindTypeNum--;
		if (ClientPrefs.ColorBlindTypeNum < 0)
		ClientPrefs.ColorBlindTypeNum = OptionsHelpers.ColorBlindArray.length - 1;
        OptionsHelpers.ChangeColorBlind(ClientPrefs.ColorBlindTypeNum);
		ColorblindFilters.applyFiltersOnGame();
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		ClientPrefs.ColorBlindTypeNum++;
		if (ClientPrefs.ColorBlindTypeNum > OptionsHelpers.ColorBlindArray.length - 1)
			ClientPrefs.ColorBlindTypeNum = OptionsHelpers.ColorBlindArray.length - 4;
                  OptionsHelpers.ChangeColorBlind(ClientPrefs.ColorBlindTypeNum);
				  ColorblindFilters.applyFiltersOnGame();
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return Translation.string('Color Blindness Type', 'Options') + ": < " + OptionsHelpers.getColorBlindByID(ClientPrefs.ColorBlindTypeNum) + " >";
	}
}
class IconBop extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
		description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
		description = Translation.string('Icon bopping type','Options');
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.hliconbopNum--;
		if (ClientPrefs.hliconbopNum < 0)
		ClientPrefs.hliconbopNum = OptionsHelpers.IconsBopArray.length - 3;
     OptionsHelpers.ChangeIconBop(ClientPrefs.hliconbopNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.hliconbopNum++;
		if (ClientPrefs.hliconbopNum > OptionsHelpers.IconsBopArray.length - 1)
			ClientPrefs.hliconbopNum = OptionsHelpers.IconsBopArray.length - 1;
                  OptionsHelpers.ChangeIconBop(ClientPrefs.hliconbopNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return Translation.string('Icon bopping type', 'Options') + ": < " + OptionsHelpers.getIconBopByID(ClientPrefs.hliconbopNum) + " >";
	}
}

class TimeBarType extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.timeBarTypeNum--;
		if (ClientPrefs.timeBarTypeNum < 0)
		ClientPrefs.timeBarTypeNum = OptionsHelpers.TimeBarArray.length - 3;
     OptionsHelpers.ChangeTimeBar(ClientPrefs.timeBarTypeNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.timeBarTypeNum++;
		if (ClientPrefs.timeBarTypeNum > OptionsHelpers.TimeBarArray.length - 1)
			ClientPrefs.timeBarTypeNum = OptionsHelpers.TimeBarArray.length - 1;
                  OptionsHelpers.ChangeTimeBar(ClientPrefs.timeBarTypeNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return Translation.string('Time bar type', 'Options') + ": < " + OptionsHelpers.getTimeBarByID(ClientPrefs.timeBarTypeNum) + " >";
	}
}


class HealthBarOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.visibleHealthbar = !ClientPrefs.visibleHealthbar;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Health Bar','Options') + ": < " + (ClientPrefs.visibleHealthbar ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
		//Translation.string('Enabled', 'Options');
		//Translation.string('Disabled', 'Options');
	}
}

class HealthBarAlpha extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
		acceptValues = true;
	}

	override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.healthBarAlpha += 0.1;

		if (ClientPrefs.healthBarAlpha > 1)
			ClientPrefs.healthBarAlpha = 1;
		return true;
	}

	override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.healthBarAlpha -= 0.1;

		if (ClientPrefs.healthBarAlpha < 0)
			ClientPrefs.healthBarAlpha = 0;

		return true;
	}

	private override function updateDisplay():String
		{
			return Translation.string('Healthbar Transparceny','Options') + ": < " + Utils.truncateFloat(ClientPrefs.healthBarAlpha, 1) + " >";
		}
	
}

class HitSoundOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('HitSound volume','Options') + ": < " + Utils.truncateFloat(ClientPrefs.hsvol, 1) + " >";
	}

	override function right():Bool
	{
		ClientPrefs.hsvol += 0.1;
		if (ClientPrefs.hsvol > 1)
			ClientPrefs.hsvol = 1;
                FlxG.sound.play(Paths.sound('note_click'), ClientPrefs.hsvol);
		return true;

	}

	override function left():Bool
	{
		ClientPrefs.hsvol -= 0.1;
		if (ClientPrefs.hsvol < 0)
			ClientPrefs.hsvol = 0;
                FlxG.sound.play(Paths.sound('note_click'), ClientPrefs.hsvol);
		return true;
	}
}

class LaneUnderlayOption extends Option
{
	public function new(desc:String)
	{
		super();
		if (OptionsMenu.isInPause)
			description = Translation.string('This option cannot be toggled in the pause menu.','Options');
		else
			description = desc;
		acceptValues = true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Lane Transparceny','Options') + ": < " + Utils.truncateFloat(ClientPrefs.underdelayalpha, 1) + " >";

	}

	override function right():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.underdelayalpha += 0.1;

		if (ClientPrefs.underdelayalpha > 1)
			ClientPrefs.underdelayalpha = 1;
		return true;
	}

	override function left():Bool
	{
		if (OptionsMenu.isInPause)
			return false;
		ClientPrefs.underdelayalpha -= 0.1;

		if (ClientPrefs.underdelayalpha < 0)
			ClientPrefs.underdelayalpha = 0;

		return true;
	}
}

class VintageOption extends Option
{	
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.vintageOnGame = !ClientPrefs.vintageOnGame;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('Vintage', 'Options') + ": < " + (ClientPrefs.vintageOnGame ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
	}
}

class SongNameOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		ClientPrefs.songNameDisplay = !ClientPrefs.songNameDisplay;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return Translation.string('SongName Displayed','Options') + ": < " + (ClientPrefs.songNameDisplay ? Translation.string('Enabled', 'Options') : Translation.string('Disabled', 'Options')) + " >";
        }
}