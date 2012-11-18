package  
{
	import org.flixel.*;
	/**
	 * This is the gameover state
	 * 
	 */
	public class GameOver extends FlxState
	{
		public var title:FlxText;
		public var score:FlxText;
		public var timer:Number = 0;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff3f3f3f;
			
			//Title
			title = new FlxText(-200, 80, 400, "Game Over");
			title.setFormat(null, 24, 0xffffff, "center");
			title.antialiasing = true;
			title.velocity.x = FlxG.width;
			add(title);
			
			//Score
			score = new FlxText(FlxG.width /2+55, 92 ,400);
			score.text = "Score: " + FlxG.score.toString();
			score.visible = false;
			add(score);	
			
			
		}
		
		override public function update():void
		{
			super.update();	
			
			timer += FlxG.elapsed;
			
			if (title.x > FlxG.width / 6 -150)
				title.velocity.x = 0;
			if ( timer > 2)
			{
				score.visible = true;
				if (FlxG.keys.any())
				{
					FlxG.fade(0xff000000, 2, onPlay);
					//FlxG.music.fadeOut(2);
				}
			}
			
		}
		
		protected function onPlay():void
		{
			//playButton.exists = false;
			FlxG.switchState(new MenuState());
		}
		
		 override public function destroy():void
		 {
			 
		 }
		
	}

}