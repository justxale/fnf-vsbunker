package options;

import flixel.FlxCamera;
import flixel.FlxSubState;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Lib;
import options.Options;
import options.ControlsSubState;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionCata extends FlxSprite
{
	public var title:String;
	public var options:Array<Option>;

	public var optionObjects:FlxTypedGroup<FlxText>;

	public var titleObject:FlxText;

	public var middle:Bool = false;

	public function new(x:Float, y:Float, _title:String, _options:Array<Option>, middleType:Bool = false)
	{
		super(x, y);
		title = _title;
		middle = middleType;
		if (!middleType)
			makeGraphic(236, 64, FlxColor.BLACK);
		alpha = 0.4;

		options = _options;

		optionObjects = new FlxTypedGroup();

		titleObject = new FlxText((middleType ? 1180 / 2 : x), y + (middleType ? 0 : 16), 0, title);
		titleObject.setFormat(Paths.font("VCR OSD Mono Cyr.ttf"), 35, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleObject.borderSize = 3;

		if (middleType)
		{
			titleObject.x = 50 + ((1180 / 2) - (titleObject.fieldWidth / 2));
		}
		else
			titleObject.x += (width / 2) - (titleObject.fieldWidth / 2);

		titleObject.scrollFactor.set();

		scrollFactor.set();

		for (i in 0...options.length)
		{
			var opt = options[i];
			var text:FlxText = new FlxText((middleType ? 1180 / 2 : 72), titleObject.y + 54 + (46 * i), 0, opt.getValue());
			if (middleType)
			{
				text.screenCenter(X);
			}
			text.setFormat(Paths.font("VCR OSD Mono Cyr.ttf"), 35, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			text.borderSize = 3;
			text.borderQuality = 1;
			text.scrollFactor.set();
			optionObjects.add(text);
		}
	}

	public function changeColor(color:FlxColor)
	{
		makeGraphic(236, 64, color);
	}
}

class OptionsMenu extends FlxSubState
{
	public static var instance:OptionsMenu;

	public var background:FlxSprite;

	public var selectedCat:OptionCata;

	public var selectedOption:Option;

	public var selectedCatIndex = 0;
	public var selectedOptionIndex = 0;

	public var isInCat:Bool = false;

	public var options:Array<OptionCata>;

	public static var isInPause = false;

	public var shownStuff:FlxTypedGroup<FlxText>;

	public static var visibleRange = [114, 640];

	var startSong = true;

	public function new(pauseMenu:Bool = false)
	{
		super();

		isInPause = pauseMenu;
	}

	public var menu:FlxTypedGroup<FlxSprite>;

	public var descText:FlxText;
	public var descBack:FlxSprite;

	override function create()
	{

		if (!isInPause)
		  if(!ControlsSubState.fromcontrols)
			if(startSong)
				FlxG.sound.playMusic(Paths.music('optionsSong'));
			else
				startSong = true;


		options = [
			new OptionCata(50, 40, Translation.string('Gameplay','OptionsMenu'), [	
				//new OffsetThing(Translation.string('Change the note visual offset (how many milliseconds a note looks like it is offset in a chart)','OptionsMenu')),
				new HitSoundOption(Translation.string("Adds 'sound' on note hits.",'OptionsMenu')),
				new GhostTapOption(Translation.string('Toggle counting pressing a directional input when no arrow is there as a miss.','OptionsMenu')),
				new DownscrollOption(Translation.string('Toggle making the notes scroll down rather than up.','OptionsMenu')),
				new ResetButtonOption(Translation.string('Toggle pressing R to gameover.','OptionsMenu')),
				new InstantRespawn(Translation.string('Toggle if you instantly respawn after dying.','OptionsMenu')),
				new CamZoomOption(Translation.string('Toggle the camera zoom in-game.','OptionsMenu')),
                new DFJKOption(),
                new NotesOption(),
                new Customizeption(),
				new Judgement(Translation.string('Create a custom judgement preset','OptionsMenu')),
				new Shouldcameramove(Translation.string('Moves camera on opponent/player note hits.','OptionsMenu')),
			]),
			new OptionCata(286, 40, Translation.string('Appearance','OptionsMenu'), [
				new NoteskinOption(Translation.string('Change your current noteskin','OptionsMenu')),
				new AccTypeOption(Translation.string('Change your current accuracy type you want!','OptionsMenu')),
                new IconBop(Translation.string('Change icon bopping type','OptionsMenu')),
				new MiddleScrollOption(Translation.string('Put your lane in the center or on the right.','OptionsMenu')), 
				new HideOppStrumsOption(Translation.string('Shows/Hides opponent strums on screen.(RESTART SONG)','OptionsMenu')),
				new MissSoundsOption(Translation.string("Toggle miss sounds playing when you don't hit a note.",'OptionsMenu')),
				new MissAnimsOption(Translation.string("Toggle miss animations playing when you don't hit a note.",'OptionsMenu')),
                new ShowSplashes(Translation.string('Show particles on SICK hit.','OptionsMenu')),
                new MicedUpSusOption(Translation.string('Enables filter like in MicedUp Engine.','OptionsMenu')),
               // new SustainsAlpha("Change Sustain Notes Alpha."),
				new HealthBarOption(Translation.string('Toggles health bar visibility','OptionsMenu')),
				new JudgementCounter(Translation.string("Show your judgements that you've gotten in the song",'OptionsMenu')),
				new LaneUnderlayOption(Translation.string('How transparent your lane is, higher = more visible.','OptionsMenu')),
                new HideHud(Translation.string('Shows to you hud.','OptionsMenu')),
                new ShowCombo(Translation.string('Combo sprite appearance.','OptionsMenu')),
                new ScoreZoom(Translation.string("Zoom score on 2'nd beat.",'OptionsMenu')),
                new HealthBarAlpha(Translation.string('Healthbar Transparceny.','OptionsMenu')),
                new BlurNotes(Translation.string("(CONTAINS FPS ISSUES)/Make notes a bit 'blurred'.",'OptionsMenu')),
			    new TimeBarType(Translation.string("Change the song's current position bar.",'OptionsMenu')),
			]),
			new OptionCata(522, 40, Translation.string('Misc','OptionsMenu'), [
				new FlashingLightsOption(Translation.string('Toggle flashing lights that can cause epileptic seizures and strain.','OptionsMenu')),
				new ColorBlindOption(Translation.string('You can set colorblind filter (makes the game more playable for colorblind people).','OptionsMenu')),
				new FPSOption(Translation.string('Toggle the FPS Counter.','OptionsMenu')),
                new MEMOption(Translation.string('Toggle the MEM Counter.','OptionsMenu')),
				#if desktop
				new FPSCapOption(Translation.string('Change your FPS Cap.','OptionsMenu')),
				#end
				new AutoPause(Translation.string('Stops game, when its unfocused','OptionsMenu')),
                new AntialiasingOption(Translation.string('Toggle antialiasing, improving graphics quality at a slight performance penalty.','OptionsMenu')),
				new QualityLow(Translation.string('Turn off some object on stages','OptionsMenu')),
				new Imagepersist(Translation.string('Images loaded will stay in memory until the game is closed.','OptionsMenu')),
				new GreenScreenMode(Translation.string('Makes screen green.','OptionsMenu')),
        		]),
			new OptionCata(758, 40, Translation.string('Extra','OptionsMenu'), [
				new AutoSave(Translation.string('Turn AutoSaves your chating in Charting state.','OptionsMenu')),
				new AutoSaveInt(Translation.string('Change Chart AutoSave Interval.','OptionsMenu')),
				new SkipTitleOption(Translation.string('Skips TitleState.','OptionsMenu')),
				new PauseCountDownOption(Translation.string("Toggle countdown after pressing 'Resume' in Pause Menu.",'OptionsMenu')),
			]),
			new OptionCata(994, 40, Translation.string('Language','OptionsMenu'), [
				new LangOption(Translation.string('Language.','OptionsMenu')),
			]),
			new OptionCata(-1, 125, "Editing Keybinds", [/* nothing here lol - PurSnake*/], true),

			new OptionCata(-1, 125, "Editing Judgements", [
				new SickMSOption(Translation.string('How many milliseconds are in the SICK hit window','OptionsMenu')),
				new GoodMsOption(Translation.string('How many milliseconds are in the GOOD hit window','OptionsMenu')),
				new BadMsOption(Translation.string('How many milliseconds are in the BAD hit window','OptionsMenu')),
			], true)
		];

		instance = this;

		menu = new FlxTypedGroup<FlxSprite>();

		shownStuff = new FlxTypedGroup<FlxText>();

		background = new FlxSprite(50, 40).makeGraphic(1180, 640, FlxColor.BLACK);
		background.alpha = 0.5;
		background.scrollFactor.set();
		menu.add(background);

		descBack = new FlxSprite(50, 640).makeGraphic(1180, 38, FlxColor.BLACK);
		descBack.alpha = 0.3;
		descBack.scrollFactor.set();
		menu.add(descBack);

		if (isInPause)
		{
			var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			bg.alpha = 0;
			bg.scrollFactor.set();
			menu.add(bg);

			background.alpha = 0.5;
			bg.alpha = 0.6;

			cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		}

		selectedCat = options[0];

		selectedOption = selectedCat.options[0];

		add(menu);

		add(shownStuff);

		for (i in 0...options.length - 1)
		{
			if (i >= 5)
				continue;
			var cat = options[i];
			add(cat);
			add(cat.titleObject);
		}

		descText = new FlxText(62, 648);
		descText.setFormat(Paths.font("VCR OSD Mono Cyr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.borderSize = 2;

		add(descBack);
		add(descText);

		isInCat = true;

		switchCat(selectedCat);

		selectedOption = selectedCat.options[0];

		super.create();
	}

	public function switchCat(cat:OptionCata, checkForOutOfBounds:Bool = true)
	{
		try
		{
			visibleRange = [114, 640];
			if (cat.middle)
				visibleRange = [Std.int(cat.titleObject.y), 640];
			if (selectedOption != null)
			{
				var object = selectedCat.optionObjects.members[selectedOptionIndex];
				object.text = selectedOption.getValue();
			}

			if (selectedCatIndex > options.length - 3 && checkForOutOfBounds)
				selectedCatIndex = 0;

			if (selectedCat.middle)
				remove(selectedCat.titleObject);

			selectedCat.changeColor(FlxColor.BLACK);
			selectedCat.alpha = 0.3;

			for (i in 0...selectedCat.options.length)
			{
				var opt = selectedCat.optionObjects.members[i];
				opt.y = selectedCat.titleObject.y + 54 + (46 * i);
			}

			while (shownStuff.members.length != 0)
			{
				shownStuff.members.remove(shownStuff.members[0]);
			}
			selectedCat = cat;
			selectedCat.alpha = 0.2;
			selectedCat.changeColor(FlxColor.WHITE);

			if (selectedCat.middle)
				add(selectedCat.titleObject);

			for (i in selectedCat.optionObjects)
				shownStuff.add(i);

			selectedOption = selectedCat.options[0];

			if (selectedOptionIndex > options[selectedCatIndex].options.length - 1)
			{
				for (i in 0...selectedCat.options.length)
				{
					var opt = selectedCat.optionObjects.members[i];
					opt.y = selectedCat.titleObject.y + 54 + (46 * i);
				}
			}

			selectedOptionIndex = 0;

			if (!isInCat)
				selectOption(selectedOption);

			for (i in selectedCat.optionObjects.members)
			{
				if (i.y < visibleRange[0] - 24)
					i.alpha = 0;
				else if (i.y > visibleRange[1] - 24)
					i.alpha = 0;
				else
				{
					i.alpha = 0.4;
				}
			}
		}
		catch (e)
		{
			//Debug.logError("oops\n" + e);
			selectedCatIndex = 0;
		}

		//Debug.logTrace("Changed cat: " + selectedCatIndex);
	}

	public function selectOption(option:Option)
	{
		var object = selectedCat.optionObjects.members[selectedOptionIndex];

		selectedOption = option;

		if (!isInCat)
		{
			object.text = "> " + option.getValue();

			descText.text = option.getDescription();
		}
		//Debug.logTrace("Changed opt: " + selectedOptionIndex);

		//Debug.logTrace("Bounds: " + visibleRange[0] + "," + visibleRange[1]);
	}

	public static function openControllsState()
		{
			//close();

		MusicBeatState.switchState(new  options.ControlsSubState());
		ClientPrefs.saveSettings();
		}
public static function openNotesState()
		{
			//close();

		MusicBeatState.switchState(new options.NotesSubState());
		ClientPrefs.saveSettings();
		}
        public static function openAjustState()
		{
			//close();

		LoadingState.loadAndSwitchState(new options.NoteOffsetState());
		ClientPrefs.saveSettings();
		}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if(FlxG.keys.justPressed.F11)
			{
			FlxG.fullscreen = !FlxG.fullscreen;
			}

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		var accept = false;
		var right = false;
		var left = false;
		var up = false;
		var down = false;
		var any = false;
		var escape = false;

		accept = FlxG.keys.justPressed.ENTER || (gamepad != null ? gamepad.justPressed.A : false);
		right = FlxG.keys.justPressed.RIGHT || (gamepad != null ? gamepad.justPressed.DPAD_RIGHT : false);
		left = FlxG.keys.justPressed.LEFT || (gamepad != null ? gamepad.justPressed.DPAD_LEFT : false);
		up = FlxG.keys.justPressed.UP || (gamepad != null ? gamepad.justPressed.DPAD_UP : false);
		down = FlxG.keys.justPressed.DOWN || (gamepad != null ? gamepad.justPressed.DPAD_DOWN : false);

		any = FlxG.keys.justPressed.ANY || (gamepad != null ? gamepad.justPressed.ANY : false);
		escape = FlxG.keys.justPressed.ESCAPE || (gamepad != null ? gamepad.justPressed.B : false);

		if (selectedCat != null && !isInCat)
		{
			for (i in selectedCat.optionObjects.members)
			{
				if (selectedCat.middle)
				{
					i.screenCenter(X);
				}

				// I wanna die!!!
				if (i.y < visibleRange[0] - 24)
					i.alpha = 0;
				else if (i.y > visibleRange[1] - 24)
					i.alpha = 0;
				else
				{
					if (selectedCat.optionObjects.members[selectedOptionIndex].text != i.text)
						i.alpha = 0.4;
					else
						i.alpha = 1;
				}
			}
		}

		try
		{
			if (isInCat)
			{
				descText.text = Translation.string('Please select a category','OptionsMenu');
				if (right)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
					selectedCatIndex++;

					if (selectedCatIndex > options.length - 3)
						selectedCatIndex = 0;
					if (selectedCatIndex < 0)
						selectedCatIndex = options.length - 3;

					switchCat(options[selectedCatIndex]);
				}
				else if (left)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
					selectedCatIndex--;

					if (selectedCatIndex > options.length - 3)
						selectedCatIndex = 0;
					if (selectedCatIndex < 0)
						selectedCatIndex = options.length - 3;

					switchCat(options[selectedCatIndex]);
				}

				if (accept)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					selectedOptionIndex = 0;
					isInCat = false;
					selectOption(selectedCat.options[0]);
				}

				if (escape)
				{
					if (!isInPause) {
					    ClientPrefs.saveSettings();
						MusicBeatState.switchState(new MainMenuState());
                                                FlxG.sound.music.stop();
						ControlsSubState.fromcontrols = false;
					    }
					else
					{
						PauseSubState.goBack = true;
						ClientPrefs.saveSettings();
						close();
					}
				}
			}
			else
			{
				if (selectedOption != null)
					if (selectedOption.acceptType)
					{
						if (escape && selectedOption.waitingType)
						{
							FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
							selectedOption.waitingType = false;
							var object = selectedCat.optionObjects.members[selectedOptionIndex];
							object.text = "> " + selectedOption.getValue();
							//Debug.logTrace("New text: " + object.text);
							return;
						}
						else if (any)
						{
							var object = selectedCat.optionObjects.members[selectedOptionIndex];
							selectedOption.onType(gamepad == null ? FlxG.keys.getIsDown()[0].ID.toString() : gamepad.firstJustPressedID());
							object.text = "> " + selectedOption.getValue();
						//	Debug.logTrace("New text: " + object.text);
						}
					}
				if (selectedOption.acceptType || !selectedOption.acceptType)
				{
					if (accept)
					{
						var prev = selectedOptionIndex;
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.press();

						if (selectedOptionIndex == prev)
						{
							ClientPrefs.saveSettings();

							object.text = "> " + selectedOption.getValue();
						}
					}

					if (down)
					{
						if (selectedOption.acceptType)
							selectedOption.waitingType = false;
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
						selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
						selectedOptionIndex++;

						// just kinda ignore this math lol

						if (selectedOptionIndex > options[selectedCatIndex].options.length - 1)
						{
							for (i in 0...selectedCat.options.length)
							{
								var opt = selectedCat.optionObjects.members[i];
								opt.y = selectedCat.titleObject.y + 54 + (46 * i);
							}
							selectedOptionIndex = 0;
						}

						if (selectedOptionIndex != 0
							&& selectedOptionIndex != options[selectedCatIndex].options.length - 1
							&& options[selectedCatIndex].options.length > 6)
						{
							if (selectedOptionIndex >= (options[selectedCatIndex].options.length - 1) / 2)
								for (i in selectedCat.optionObjects.members)
								{
									i.y -= 46;
								}
						}

						selectOption(options[selectedCatIndex].options[selectedOptionIndex]);
					}
					else if (up)
					{
						if (selectedOption.acceptType)
							selectedOption.waitingType = false;
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
						selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
						selectedOptionIndex--;

						// just kinda ignore this math lol

						if (selectedOptionIndex < 0)
						{
							selectedOptionIndex = options[selectedCatIndex].options.length - 1;

							if (options[selectedCatIndex].options.length > 6)
								for (i in selectedCat.optionObjects.members)
								{
									i.y -= (46 * ((options[selectedCatIndex].options.length - 1) / 2));
								}
						}

						if (selectedOptionIndex != 0 && options[selectedCatIndex].options.length > 6)
						{
							if (selectedOptionIndex >= (options[selectedCatIndex].options.length - 1) / 2)
								for (i in selectedCat.optionObjects.members)
								{
									i.y += 46;
								}
						}

						if (selectedOptionIndex < (options[selectedCatIndex].options.length - 1) / 2)
						{
							for (i in 0...selectedCat.options.length)
							{
								var opt = selectedCat.optionObjects.members[i];
								opt.y = selectedCat.titleObject.y + 54 + (46 * i);
							}
						}

						selectOption(options[selectedCatIndex].options[selectedOptionIndex]);
					}

					if (right)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.right();

						ClientPrefs.saveSettings();

						object.text = "> " + selectedOption.getValue();
						//Debug.logTrace("New text: " + object.text);
					}
					else if (left)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
						var object = selectedCat.optionObjects.members[selectedOptionIndex];
						selectedOption.left();

						ClientPrefs.saveSettings();

						object.text = "> " + selectedOption.getValue();
						//Debug.logTrace("New text: " + object.text);
					}

					if (escape)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);

						if (selectedCatIndex >= 4)
							selectedCatIndex = 0;

						for (i in 0...selectedCat.options.length)
						{
							var opt = selectedCat.optionObjects.members[i];
							opt.y = selectedCat.titleObject.y + 54 + (46 * i);
						}
						selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
						isInCat = true;
						if (selectedCat.optionObjects != null)
							for (i in selectedCat.optionObjects.members)
							{
								if (i != null)
								{
									if (i.y < visibleRange[0] - 24)
										i.alpha = 0;
									else if (i.y > visibleRange[1] - 24)
										i.alpha = 0;
									else
									{
										i.alpha = 0.4;
									}
								}
							}
						if (selectedCat.middle)
							switchCat(options[0]);
					}
				}
			}
		}
		catch (e)
		{
			//Debug.logError("wtf we actually did something wrong, but we dont crash bois.\n" + e);
            FlxG.log.add("wtf we actually did something wrong, but we dont crash bois.\n" + e);
			selectedCatIndex = 0;
			selectedOptionIndex = 0;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
			if (selectedCat != null)
			{
				for (i in 0...selectedCat.options.length)
				{
					var opt = selectedCat.optionObjects.members[i];
					opt.y = selectedCat.titleObject.y + 54 + (46 * i);
				}
				selectedCat.optionObjects.members[selectedOptionIndex].text = selectedOption.getValue();
				isInCat = true;
			}
		}
	}
}
