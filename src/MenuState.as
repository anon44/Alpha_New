package  
{
	import org.flixel.*;
	import PlayState;
	import Elevator1;
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
		//public var followobject:followObject;
		public var _human:human;
		public var elevator:FlxSprite;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			title = new FlxText(-200, 80, 400, "Title");
			title.setFormat(null, 24, 0xffffff, "center");
			title.antialiasing = true;
			title.velocity.x = FlxG.width;
			add(title);
			
			//Follow Object
			/*followobject = new followObject( -50, 80);
			Registry.followO = followobject;
			add(followobject);*/
			
			//Human
			_human = new human( -50, 80);
			_human.acceleration.y = 0;
			add(_human);
			
			//G
			//elevator = new Elevator1(FlxG.width / 2 + 50, -250);
			elevator = new FlxSprite(FlxG.width / 2 + 50, -250);
			elevator.loadGraphic(GameAssets.elevatorPIC, true, false, 133, 240);
			elevator.addAnimation("down", [0], 0);
			elevator.addAnimation("up", [1]);
			//elevator.startPoint.y = -250;
			//elevator.endPoint.y = -115;
			add(elevator);
			
			
			
			//Info
			//var info:FlxText = new FlxText(FlxG.width * 0.5 -205, 80, 400, "Info: Press 'R' to reload the stage.");
			//info.setFormat(null, 8, 0xffffff, "center");
			//add(info);
			
			info2 = new FlxText(FlxG.width *0.5 -205, 120, 400, "Press any key to start");
			info2.setFormat(null, 8, 0xffffff, "center");
			info2.visible = false;
			add(info2);
			
			var info3:FlxText = new FlxText(FlxG.width *0.5 -205, 120, 400, "Press 'i' for more information");
			info3.setFormat(null, 8, 0xffffff, "center");
			//add(info3);
			
			//playbutton
			//playButton = new FlxButton(FlxG.width/2-40,FlxG.height / 3 + 100, "Click To Play", onPlay);
			//playButton.color = 0xffffff;
			
			//playButton.label.color = 0xff3f3f3f;
			//add(playButton);
			
			
			//Show the mouse
			//FlxG.mouse.show();
			
		}
		override public function update():void
		{
			super.update();	
			if (FlxG.keys.any() && !FlxG.keys.I)
			{
				FlxG.fade(0xff000000, 2, onPlay);
				//FlxG.music.fadeOut(2);
			}
				else if (FlxG.keys.I)
			{
				FlxG.switchState(new Info());
			}
			
		
			if ( title.x > FlxG.width / 6-150)
			{
				title.velocity.x = 0;
				_human.velocity.x = 150;
				if (_human.x > FlxG.width / 2+10)
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
			//playButton.exists = false;
			FlxG.switchState(new PlayState());
		}
		private function killHuman(_elevator:FlxObject, _human:FlxObject):void
		{
			_human.kill()
			info2.visible = true;
		}
		
	
		public function MenuState() 
		{
			
		}
		
	}

}