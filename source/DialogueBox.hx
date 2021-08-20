package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	var cutscene:FlxSprite;

	public var finishThing:Void->Void;


	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);

			
			case 'skill':
				FlxG.sound.playMusic(Paths.music('breakbeatintro'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);

			case 'adaptation':
					FlxG.sound.playMusic(Paths.music('Getit'), 0);
					FlxG.sound.music.fadeIn(1, 0, 0.8);

			case 'breakbeat':
				FlxG.sound.playMusic(Paths.music('Tension'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);

				
				
				
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;

		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			
			case 'skill':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/mainbox');
				box.y = 200;
				box.animation.addByPrefix('normalOpen', 'dabox', 24, false);
				box.animation.addByIndices('normal', 'dabox', [4], "", 24);

			case 'adaptation':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/mainbox');
				box.y = 200;
				box.animation.addByPrefix('normalOpen', 'dabox', 24, false);
				box.animation.addByIndices('normal', 'dabox', [4], "", 24);

			case 'achievement':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/mainbox');
				box.y = 200;
				box.animation.addByPrefix('normalOpen', 'dabox', 24, false);
				box.animation.addByIndices('normal', 'dabox', [4], "", 24);
			
			case 'breakbeat':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/mainbox');
				box.y = 200;
				box.animation.addByPrefix('normalOpen', 'dabox', 24, false);
				box.animation.addByIndices('normal', 'dabox', [4], "", 24);

			case 'hopeless':
				hasDialog = true;
				box.frames =Paths.getSparrowAtlas('weeb/pixelUI/mainbox');
				box.y = 200;
				box.animation.addByPrefix('normalOpen', 'dabox', 24, false);
				box.animation.addByIndices('normal', 'dabox', [4], "", 24);

			case 'nightlife':
				hasDialog = true;
				box.frames =Paths.getSparrowAtlas('weeb/pixelUI/mainbox');
				box.y = 200;
				box.animation.addByPrefix('normalOpen', 'dabox', 24, false);
				box.animation.addByIndices('normal', 'dabox', [4], "", 24);

			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(60, 0);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		if(songLowercase == 'breakbeat')
			{

				portraitRight = new FlxSprite(60, 0);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/ultrabfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

			}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFF8280C4;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFFDEEBFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			
			


			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'left':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				box.flipX = true;

			case 'right':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				box.flipX = false;

			case 'rian1':

				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Rian_EXP_1');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);
			
			case 'rian2':
				
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Rian_EXP_2');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);
			
			case 'rian3':
				
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Rian_EXP_3');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);
			
			case 'rian4':
				
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Rian_EXP_4');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'rian5':
			
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Rian_EXP_5');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);




			case 'motive1':
			
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Motive_EXP_1');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'motive2':
			
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Motive_EXP_2');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);
			case 'motive3':
			
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(520, 490);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Motive_EXP_3');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'urza1':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
				FlxG.watch.add(portraitLeft.y,"Portraitcoords:");
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Urza_EXP_1');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'urza2':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Urza_EXP_2');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'urza3':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Urza_EXP_3');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'urza4':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Urza_EXP_4');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'urza5':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Urza_EXP_5');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'hyper1':
				
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Hyper_EXP_1');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'hyper2':
				
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Hyper_EXP_2');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);

			case 'hyper3':
				
				portraitRight.visible = false;
				portraitLeft.visible = true;
				box.flipX = true;
				remove(portraitLeft);
				portraitLeft = new FlxSprite(240, 175);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/Hyper_EXP_3');
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
				add(portraitLeft);
			//CUTSCENE IMAGES
			case '1':
					portraitRight.visible = false;
					portraitLeft.visible = true;
					remove(portraitLeft);
					remove(box);
					portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/1'));
					portraitLeft.scrollFactor.set();
					add(portraitLeft);
					box.alpha = 120;
					add(box);
					
					
	
	
			case '2':
					portraitRight.visible = false;
					portraitLeft.visible = true;
					remove(portraitLeft);
					remove(box);
					portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/2'));
					portraitLeft.scrollFactor.set();
					add(portraitLeft);
					box.alpha = 120;
					add(box);
					
	
			case '3':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/3'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				box.alpha = 120;
				add(box);
				
			case '4':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/4'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				box.alpha = 120;
				add(box);
				
	
			case '5':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/5'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '6':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/6'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
	
			case '7':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/7'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
	
			case '8':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/8'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '9':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/9'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '10':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/10'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '11':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/11'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '12':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/12'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '13':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/13'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '14':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/14'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '15':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/15'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case '16':
				portraitRight.visible = false;
				portraitLeft.visible = true;
				remove(portraitLeft);
				remove(box);
				portraitLeft = new FlxSprite().loadGraphic(Paths.image('weeb/16'));
				portraitLeft.scrollFactor.set();
				add(portraitLeft);
				add(box);
				box.alpha = 120;
			case 'nobg':
					remove(portraitLeft);
					box.alpha = 255;

			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}

			case 'gf':
				portraitRight.visible = true;
				portraitLeft.visible = false;
				remove(portraitLeft);
				remove(portraitRight);
				portraitRight = new FlxSprite().loadGraphic(Paths.image('weeb/15'));
				portraitRight.scrollFactor.set();
				add(portraitRight);
				box.alpha = 120;
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
