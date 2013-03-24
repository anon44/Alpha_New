package Menus
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
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			var title:FlxText = new FlxText(FlxG.width *0.5 -200, 20, 400, "Info");
			title.setFormat(null, 24, 0xffffff, "center");
			add(title);
			
			var game:FlxText = new FlxText(FlxG.width *0.5 -200, 60, 400, "Hurry and get to the bunker before the Giantess catches you");	
			game.setFormat(null, 8, 0xffffff, "center");
			add(game);
			
			var info:FlxText = new FlxText(FlxG.width *0.5 -200, 80, 400, "Use the arrow keys to move and the space bar to jump");	
			info.setFormat(null, 8, 0xffffff, "center");
			add(info);
			
			var info2:FlxText = new FlxText(FlxG.width *0.5 -85, 100, 400, "Press any key to start the game.");
			info.setFormat(null, 8, 0xffffff, "center");
			add(info2);
			
			var info3:FlxText = new FlxText (FlxG.width * 0.5 -150, 140, 300, "This game was made with Actionscript 3, Flixel, Flixel Power Tools, and GreenSock API. Some of the sprites weres rip from Photostorm.com and spriters-resource.com");
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