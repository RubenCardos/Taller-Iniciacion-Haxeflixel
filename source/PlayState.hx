package;

import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxRandom;
import flixel.util.FlxVelocity;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	
	
	//Mapa 
	var _floor : FlxSprite;
	var _plat :FlxSprite;
	
	//Personaje
	var _pj : FlxSprite;
	var _pjSpeed : Int = 200;
	
	//Cosas
	var _box : FlxSprite;
	var _coin : FlxSprite;
	var _enemy : FlxSprite;
	
	//Sonidos
	var _jumpSound : FlxSound;
	var _bgSound : FlxSound;
	
	//Parallax
	var _BG :FlxBackdrop;
	
	override public function create():Void
	{
		super.create();
		
		//Color Fondo
		
		FlxG.cameras.bgColor = FlxColor.WHITE;
		
		//Parallax
		
		_BG = new FlxBackdrop("assets/images/bgSea.png",0,0,true,false);
		_BG.velocity.x = -150;
		add(_BG);
		
		//Suelo
		_floor = new FlxSprite(0, FlxG.height-10);
		_floor.makeGraphic(FlxG.width, 20, FlxColor.RED);
		_floor.immovable = true;
		add(_floor);
		
		//Plaraforma
		_plat = new FlxSprite(FlxG.width / 2, FlxG.height / 2 +FlxG.height/6);
		_plat.makeGraphic(Std.int(FlxG.width/4),15,FlxColor.AZURE);
		_plat.immovable = true;
		_plat.allowCollisions = FlxObject.UP;
		add(_plat);
		
		//Pj
		_pj = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		_pj.loadGraphic("assets/images/Calamar.png");
		_pj.acceleration.y = _pjSpeed*2;
		_pj.drag.set(_pjSpeed*2,_pjSpeed*2);
		add(_pj);
		
		//Sonidos
		_jumpSound = FlxG.sound.load("assets/sounds/Jump.wav");
		_bgSound = FlxG.sound.load("assets/sounds/BG.ogg");
		_bgSound.play();
		
		//Box 
		_box = new FlxSprite(FlxG.width / 2 -70, FlxG.height / 2);
		_box.loadGraphic("assets/images/Box.png");
		_box.acceleration.y = _pjSpeed*2;
		_box.drag.set(_pjSpeed*2,_pjSpeed*2);
		add(_box);
		
		//Coin
		_coin = new FlxSprite(FlxG.width / 3, FlxG.height / 2);
		_coin.loadGraphic("assets/images/coin.png", true, 32, 32);
		_coin.animation.add("iddle", [0, 1, 2, 3, 4, 5, 6], 12, true);
		_coin.animation.play("iddle");
		add(_coin);
		
		//Enemy
		_enemy = new FlxSprite(0, 0);
		_enemy.loadGraphic("assets/images/Enemy.png");
		add(_enemy);
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
		
		//Colisiones
		
		//FlxG.collide(_floor, _pj);//Personaje y suelo
		//FlxG.collide(_floor, _plat);//Personaje y suelo
		
		if(FlxG.overlap(_pj,_coin)){
			_coin.x = Std.random(FlxG.width);
			_coin.y = Std.random(FlxG.height);
		}
		
		if(FlxG.overlap(_box,_enemy)){
			FlxG.switchState(new GameOverState());
		}
		
		//Todo colisiona con todo 
		FlxG.collide();
		
		
		movimientoPJ();
		movimientoE();
	}
	
	private function movimientoPJ(){
		
		if(FlxG.keys.anyPressed(["D","RIGHT"])){
			_pj.velocity.x = _pjSpeed;
		}
		if(FlxG.keys.anyPressed(["A","LEFT"])){
			_pj.velocity.x = -_pjSpeed;
		}
		if(FlxG.keys.anyPressed(["W","UP","SPACE"]) && _pj.isTouching(FlxObject.DOWN)){
			_pj.velocity.y = -_pjSpeed * 2;
			_jumpSound.play();
		}
	}
	
	private function movimientoE(){
		FlxVelocity.moveTowardsObject(_enemy,_box,50);
	}
}