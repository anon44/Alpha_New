package  
{
	import org.flixel.*;
	import PlayState;
	import Elevator1;
	import org.flixel.plugin.photonstorm.*;
	import com.greensock.*;
	import human;
	import Registry;
	import followObject;
	/**
	 * This is the Menu State  
	 */
	public class MenuState extends FlxState
	{
		public var title:FlxText;
		public var info2:FlxText;
		public var _human:human;
		public var elevator:FlxSprite;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			title = new FlxText(-200, 80, 400, "Giantess Run");
			title.setFormat(null, 24, 0xffffff, "center");
			title.antialiasing = true;
			title.velocity.x = FlxG.width;
			add(title);
			
			//Human
			_human = new human( -50, 80);
			_human.acceleration.y = 0;
			add(_human);
			
			//G
			elevator = new FlxSprite(FlxG.width / 2 + 100, -250);
			elevator.loadGraphic(GameAssets.elevatorPIC, true, false, 133, 240);
			elevator.addAnimation("down", [0], 0);
			elevator.addAnimation("up", [1]);
			add(elevator);
			
			
			info2 = new FlxText(FlxG.width *0.5 -205, 120, 400, "Press any key to start");
			info2.setFormat(null, 8, 0xffffff, "center");
			info2.visible = true;
			add(info2);
			
			var info3:FlxText = new FlxText(FlxG.width *0.5 -205, 140, 400, "Press 'i' for more information");
			info3.setFormat(null, 8, 0xffffff, "center");
			add(info3);
			
		}
		override public function update():void
		{
			super.update();	
			if (FlxG.keys.any() && !FlxG.keys.I)
			{
				FlxG.fade(0xff000000, 2, onPlay);
			}
				else if (FlxG.keys.I)
			{
				FlxG.switchState(new Info());
			}
			
			/*var a:Number = FlxVelocity.distanceBetween(_human, elevator);
			
				if (a < 400 && _human.alive)
				{
					FlxG.play(GameAssets.humanScream1, .15);
				}*/
			if ( title.x > FlxG.width / 6-150)
			{
				title.velocity.x = 0;
				_human.velocity.x = 150;
				if (_human.x > FlxG.width / 2+45)
				{
					elevator.velocity.y += 150;
					elevator.x = _human.x -25;
					TweenLite.to(elevator, 1, { x:_human.x });
				}
				if (elevator.y >= -136)
				{
					elevator.velocity.y = 0;
				}
			}
				FlxG.overlap(elevator, _human, killHuman);

		
			
		}
		protected function onPlay():void
		{
			FlxG.switchState(new PlayState());
		}
		private function killHuman(_elevator:FlxObject, _human:FlxObject):void
		{
			_human.kill()
			FlxG.play(GameAssets.stompBoom);
			FlxG.play(GameAssets.gLaugh);
			info2.visible = true;
		}
		
	
		public function MenuState() 
		{
			
		}
		
	}

}