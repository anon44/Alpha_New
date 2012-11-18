package  
{
	import org.flixel.*;
	import PlayState;
	import Elevator1;
	import com.greensock.*;
	import humanReg;
	
	/**
	 * This is the Menu State  
	 */
	public class MenuState extends FlxState
	{
		public var title:FlxText;
		public var info2:FlxText;
		public var human:humanReg;
		public var elevator:Elevator1;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			title = new FlxText(-200, 80, 400, "Title");
			title.setFormat(null, 24, 0xffffff, "center");
			title.antialiasing = true;
			title.velocity.x = FlxG.width;
			add(title);
			
			//Human
			human = new humanReg( -50, 80);
			human.acceleration.y = 0;
			add(human);
			
			//G
			elevator = new Elevator1(FlxG.width / 2 + 50, -250);
			elevator.startPoint.y = -250;
			elevator.endPoint.y = -115;
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
			FlxG.overlap(elevator, human, killHuman);
			if ( title.x > FlxG.width / 6-150)
			{
				title.velocity.x = 0;
				human.velocity.x = 150;
				if (human.x > FlxG.width / 2+10)
				{
					elevator.moves = true;
					elevator.x = human.x -25;
					TweenLite.to(elevator, 1, { x:human.x });
				}
			}
			
			if (FlxG.keys.any() && !FlxG.keys.I)
			{
				FlxG.fade(0xff000000, 2, onPlay);
				//FlxG.music.fadeOut(2);
			}
			else if (FlxG.keys.I)
			{
				FlxG.switchState(new Info());
			}
			
		}
		
		private function killHuman(_elevator:FlxObject, _human:FlxObject):void
		{
			_human.kill()
			info2.visible = true;
		}
		
		protected function onPlay():void
		{
			//playButton.exists = false;
			FlxG.switchState(new PlayState());
		}
		public function MenuState() 
		{
			
		}
		
	}

}