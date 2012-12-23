package  
{
	import org.flixel.*;
	import GameAssets;
	/**
	 * Coin
	 * 
	 */
	public class Coin extends FlxParticle
	{
		
		public function Coin() 
		{
			super();
			
			loadGraphic(GameAssets.coin16x16PNG, true, false, 16, 16);
			addAnimation("spin", [1, 2, 3, 4, 5, 6], 12, true);
			solid = true;
			exists = false;
		}
		
		override public function onEmit():void
		{
			elasticity = Math.random();
			drag = new FlxPoint(4, 0);
			
			play("spin");
		}
		
		override public function update():void
		{
			super.update();
			
		}
		
	}

}