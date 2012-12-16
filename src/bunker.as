package  
{
	/* 
	 *Add ligthing effects
	 * 
	 * 
	 * 
	 * */
	
	import org.flixel.*;
	import GameAssets;
	import PlayState;
	
	public class bunker extends FlxSprite
	{
		public var _timer:Number;
		public var _gibs:FlxEmitter; //Gibs to emit whe that object is destoryed 
		public var _gibs2:FlxEmitter; //Another gib to emit more little objects
		
		public function bunker(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(GameAssets.bunkerPNG, true, false, 70, 48);
			solid = true;
			addAnimation("not-active", [0]);
			addAnimation("active", [1]);
			frame = 0;
		}

		override public function update():void
		{
			acceleration.x = 0;
			super.update();
		}
		
		/**
		 * Destory object 
		 */
		override public function destroy():void
		{
			super.destroy();
		}
		
		
		
	}//End of Class

}//End of Package