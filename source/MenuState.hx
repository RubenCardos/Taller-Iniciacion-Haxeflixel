package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	var _txt : FlxText;
	var _btn : FlxButton;
	
	override public function create():Void
	{
		super.create();
		
		_txt = new FlxText(0,0,0,"FlxCalamar",32);
		add(_txt);
		
		_btn = new FlxButton(FlxG.width/2,FlxG.height/2,"Play!",clickBtnPlay);
		add(_btn);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
	
	private function clickBtnPlay(){
		FlxG.switchState(new PlayState());
	}
}