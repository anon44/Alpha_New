//This is the right G

package Giantess
{
	import Giantess.elevatorMain
	import org.flixel.*;
	import GameAssets;
	import Registry;
	
	public class Elevator1 extends elevatorMain
	{
		/**
		 * Constructor
		 */
		public static var _x:int;
		
		public function Elevator1(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(GameAssets.elevatorPIC, true, true, 133, 240);
			startPoint = new FlxPoint(-75, -50);
			endPoint = new FlxPoint(0, 55); 
			moves = false;
			velocity.y = RUNSPEED;
			immovable = true;
			allowCollisions = FlxObject.ANY;
			solid = true; 
		}
		
		override protected function createAnimations():void
		{
			addAnimation("down", [0], 0);
			addAnimation("up", [1]);
			addAnimation("Ldown", [2], 0);
			addAnimation("Lup", [3]);
		}
		/**
		 * Update each frame
		 */
		override protected function updateControls():void
		{
			super.updateControls();
			//Updating the animations in the game
			if (facing == LEFT && down == true)
				frame = 2;
			else if (facing == LEFT && down == true)
				frame = 3;
			if (down == true)
				frame = 0;
			else
				frame = 1;
		}
	
	/**
	 * To fix our little playstate issue
	*/
	override public function destroy():void
	 {
			 
	 }
	}//End of Class

}//End of Package