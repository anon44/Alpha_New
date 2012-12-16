package  
{

/**
	 * This is the main class for the elevator
	 * UPDATE: It looks like I got the new code working.
	 * Add sounds to the turnAround and Kill functions 
	 *  Other Things:
	 *   Add kick functions
	 * 
	 */
	import org.flixel.*;
	
	import org.flixel.plugin.photonstorm.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	public class elevatorMain extends FlxSprite
	{
		/**
		 * Constants
		 */
		public var startPoint:FlxPoint;
		public var endPoint:FlxPoint;
		public var down:Boolean;
		public static const RUNSPEED:int = 25;
		
		/**
		 * Constructor
		 */
		public function elevatorMain(X:int, Y:int):void
		{
			super(X, Y)
			startPoint = new FlxPoint();
			endPoint = new FlxPoint();
			moves = false;
			velocity.y = RUNSPEED;
			immovable = false;
			allowCollisions = FlxObject.ANY;
			down = true;
			drag.x = 20;
		}
		/**
		 * Create the animations 
		 */
		protected function createAnimations():void
		{
			
		} 
	
		 /**
		  * Update each time step
		  */
		 override public function update():void
		 {
			 
			 updateControls();
			 updateAnimation();
			 super.update();
		 }
		 //This is for to create the turn around animation for the step
		// This should work with the code
		private function turnAround():void
		{
			if (facing == FlxObject.LEFT)
			{
				facing = FlxObject.RIGHT;
			}
			else
			{
				facing = FlxObject.LEFT;
			}
		}
		 /**
		  * The basic movement of the elevators 
		  */
		 protected function updateControls():void
		  {
			if(moves) //If move is true then move
			{		//Going down
					if(y >= endPoint.y)
					{   
						y = endPoint.y;
						
						down = true;
						
						FlxG.shake(.005, .1); // Shake the level
						//FlxG.play(GameAssets.stompBoom);
						velocity.y = -155;
						solid = true;
						
					}
				
					else if (y <= startPoint.y)//If the elevator has not reached the upper limit then send the elevator up
					{
						solid = false;
			
						/*var b:Number = FlxVelocity.angleBetween(this, Registry.followO);
						//To test if the player is to the right or the left of the g
						
						if (b > -1 && facing == FlxObject.RIGHT)
						{
							//turnAround();
							facing = LEFT;
						}
						if (b > -45 && facing == FlxObject.LEFT)
						{
							facing = RIGHT;
							//turnAround();
						}*/
						//To test if the player is to the right or the left of the g
						if (Registry.followO.x> x-40 && facing == FlxObject.LEFT)
						{
							turnAround();
						}
						if (Registry.followO.x < x+40 && facing == FlxObject.RIGHT)
						{
							turnAround();
						}
						
						var a:Number = FlxVelocity.distanceBetween(Registry.followO, Registry.player)
						if (a<=45) //To detect if the player is near the step
						{
								this.x = Registry.player.x-75;
								velocity.y = +500; //Hard stomp
								//Sound here
								y = startPoint.y; //Reached the bottom 
						}
						else
						{
								//Using GreenSock for the easing 
								TweenLite.to(this, .5, { x:Registry.followO.x-40, ease:Sine.easeInOut} );
								velocity.y = +200;
								down = false;
								y = startPoint.y; //Reached the bottom 
							
						}
					}//End of else if
		
			}//End of movement 
			 
		 }//End of update
		
		
		 /**
		  * To fix our little playstate issue
		  */
		 override public function destroy():void
		 {
			 
		 }
		
	}//End of Class
	
}//End of Package