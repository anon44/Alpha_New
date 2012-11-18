package 
{
	import org.flixel.*;
	import PlayState;
	/**
	 * ...
	 * 
	 */
	public class Info extends FlxState
	{
		override public function create():void
		{
			FlxG.bgColor = 0x000000;
			
			//Title
			var title:FlxText = new FlxText(FlxG.width *0.5 -200, 40, 400, "Info");
			title.setFormat(null, 24, 0xffffff, "center");
			add(title);
			
			var info:FlxText = new FlxText(FlxG.width * 0.5 -75, 80, 400, "Use the arrow keys to move.");		
			
			var info2:FlxText = new FlxText(FlxG.width *0.5 -75, 100, 400, "Press any key to start the game.");
			info.setFormat(null, 8, 0xffffff, "center");
			add(info2);
			
			var info3:FlxText = new FlxText (FlxG.width * 0.5 -75, 140, 175, "This game was made with Actionscript 3, Flixel, Flixel Power Tools, and GreenSock.");
			info.setFormat(null, 8, 0xffffff, "center");
			add(info3);
		}
		
		override public function update():void
		{
			if (FlxG.keys.any())
			{
				FlxG.fade(0xff000000, 2, onPlay);
			}
			super.update();
		}
		
		protected function onPlay():void
		{
			FlxG.switchState(new PlayState());
		}
		
		public function Info() 
		{
			
		}
		
	}

}