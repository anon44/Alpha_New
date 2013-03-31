//This is the left G

package Giantess
{
	import org.flixel.*;
	import Giantess.*;
	import GameAssets;
	
	public class Elevator2 extends elevatorMain
	{	
		/**
		 * Constructor
		 */
		public static var _x:int;
		 
		public function Elevator2(X:int, Y:int):void
		{
			super(X, Y);
			loadGraphic(GameAssets.elevatorPIC, true, true, 133, 240);
			topPoint = new FlxPoint(-75, -50);
			bottomPoint = new FlxPoint(0, 55);
			down = true;
			moves = false;
			velocity.y = RUNSPEED;
			immovable = true;
			allowCollisions = FlxObject.DOWN;
			solid = true;
		}
		
		override protected function createAnimations():void
		{
			addAnimation("Ldown", [0], 0);
			addAnimation("Lup", [1]);
			addAnimation("down", [2]);
			addAnimation("up", [3]);
		}
		/**
		 * Update each frame
		 */
		override public function update():void
		{
			super.updateControls();			
			//Updating the animations in the game
			if (facing == LEFT && down == true)
				frame = 0;
			else if (facing == LEFT && down == true)
				frame = 1;
			if (down == true)
				frame = 2;
			else
				frame = 3;
		}
	
	/**
	 * To fix our little playstate issue
	*/
	override public function destroy():void
	 {
			 
	 }
	}//End of Class

}//End of Package