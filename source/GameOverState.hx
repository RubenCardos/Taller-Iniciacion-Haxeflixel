package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class GameOverState extends FlxState
{
	var _txt : FlxText;
	var _btn : FlxButton;
	
    override public function create():Void
    {
        super.create();
		
		_txt = new FlxText(0,0,0,"Has Perdido",32);
		add(_txt);
		
		_btn = new FlxButton(FlxG.width/2,FlxG.height/2,"Play Again?",clickBtnPlay);
		add(_btn);
    }

    override public function update():Void
    {
        super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }
	
	private function clickBtnPlay(){
		FlxG.switchState(new PlayState());
	}
}