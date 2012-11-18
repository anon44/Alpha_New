package  
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
		/*private var myRadians:int;
		private var myDegrees:int;
		private var yChange:int;
		private var xChange:int;
		private var yMove:int;
		private var xMove:int;*/
		public static var _x:int;
		public static var _a:int;
		
		
		public function followObject(X:int , Y:int) 
		{
			super(X, Y);
			visible = false;
			solid = false;
			maxVelocity.x = 100;
		}
		
		override public function update():void
		{
			this.y = 240;
			var a:Number = FlxVelocity.distanceBetween(this, Registry.player);
			var b:Number = FlxVelocity.distanceBetween(this, Registry._humanShooter);
			var c:Number = FlxVelocity.distanceBetween(this, Registry._humanReg);
			velocity.x = 25;
			if ( a <= 155)
				FlxVelocity.moveTowardsObject(this, Registry.player, 75); 
			else if ( b <= 150)
				FlxVelocity.moveTowardsObject(this, Registry._humanShooter, 75); 
			else if ( c <= 100)
				FlxVelocity.moveTowardsObject(this, Registry._humanReg, 75); 
			
			/*TweenLite.to(this, 5, { x:Player._x } );
			if (Player._x < this.x+20)
			{
				TweenLite.to(this, 5, { x:Player._x - 60 } );
			}*/
			/*myRadians = Math.atan2(Player._y - this.y, Player._x - this.x);
			myDegrees = Math.round((myRadians*180/Math.PI))
			//this.yChange = Math.round(PlayState4._player.y - this.y);
			this.xChange = Math.round(Player._x - this.x);
			//this.yMove = Math.round(yChange / 20);
			this.xMove = Math.round(xChange / 20);*/
			//this.y += yMove;
			//velocity.x += 10;
			_x = x;
			_a = velocity.x;
		}
	}

}