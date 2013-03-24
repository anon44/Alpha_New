package Giantess
{
	import org.flixel.*;
	import Registry;
	import org.flixel.plugin.photonstorm.*;
	import PlayState;
	/**
	 * This is the follower object that will follow the player accross the screen 
	 * This will help the elevator follow the player better
	 * This object will be the startPoint.x
	 * 
	 */
	
	public class followObject extends FlxSprite
	{
		/**
		 * Constants
		 */
		public static var _x:int;
		public static var _a:int;
		public  var attackNumber:int;
		
		public function followObject(X:int , Y:int) 
		{
			super(X, Y);
			visible = false;
			solid = false;
			attackNumber = 0;
			maxVelocity.x = 100;
		}
		
		override public function update():void
		{
			this.y = 240;
			var a:Number = FlxVelocity.distanceBetween(this, Registry.player);
			var b:Number = FlxVelocity.distanceBetween(this, Registry._humanShooter);
			var c:Number = FlxVelocity.distanceBetween(this, Registry._humanReg);
			velocity.x = 25;
			if ( a <= 155){
				FlxVelocity.moveTowardsObject(this, Registry.player, 75); //Follow the player 
				//this is where the attack will be randomize 
				attackNumber = FlxG.random() * 3;
				//1 = hard stomp
				//2 = kick (not done)
				//3 = hand capture 
			}
			else if ( b <= 150)
				FlxVelocity.moveTowardsObject(this, Registry._humanShooter, 75); //Follow the shooter
			else if ( c <= 100)
				FlxVelocity.moveTowardsObject(this, Registry._humanReg, 75); //Follow the humans

			_x = x;
			_a = velocity.x;
		}
	}

}