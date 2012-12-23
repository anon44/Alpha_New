package  
{
	import org.flixel.*;

	/**
	 * Player-controlled entity
	 * Nothing for now 
	 * Recreate player for next release
	 */
	public class Player extends FlxSprite
	{
		public var _gibs:FlxEmitter;
		public var startPosition:FlxPoint = new FlxPoint(150, 200);
		
		/**
		 * Constructor
		 */
		public function Player(X:int, Y:int)
		{
			super(X, Y);
			loadGraphic(GameAssets.player, true, true, 26, 25);
			maxVelocity.x = 100;			//walking speed
			acceleration.y = 400;			//gravity
			drag.x = maxVelocity.x*4;		//deceleration (sliding to a stop)
			health = 5;                    //Start off with 5 health points
			solid = true;
			
			width = 26;
			height = 25;
			offset.x = 3;
			offset.y = 0;
			
			addAnimation("idle",[10],0,false);
			addAnimation("walk",[2, 3, 4, 5, 6, 7, 8, 9],10,true);
			addAnimation("walk_back",[3,2,1,0],10,true);
			addAnimation("flail",[2, 3, 4, 5, 6, 7, 8, 9],18,true);
			addAnimation("jump",[2, 3, 4, 5, 6, 7, 8, 9],10,false);
		}
		
		
		/**
		 * Check for uaer input to control this entity 
		 */
		override public function update():void
		{
			super.update();
			//check keys
			var movement:FlxPoint = new FlxPoint(); 
			//Smooth slidey walking controls
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
				acceleration.x -= drag.x;
			if(FlxG.keys.RIGHT)
				acceleration.x += drag.x;
			if(isTouching(FLOOR))
			{
				//Jump controls
				if(FlxG.keys.justPressed("SPACE"))
				{
					velocity.y = -acceleration.y*0.51;
					play("jump");
				}//Animations
				else if (velocity.x > 0)
				{
					play("walk");
					facing = RIGHT;
				}
				else if(velocity.x < 0)
				{
					play("walk");
					facing = LEFT;
				}
				else
					play("idle");
			}
			else if(velocity.y < 0)
				play("jump");
			else
				play("flail")
			
			//Here we are stopping the player form moving off the screen
			//with a little border or margin of 4 pixels
			if (x > FlxG.worldBounds.width - 4)
				x = FlxG.worldBounds.width - 4;
			if (x < 4)
				x = 4;			
		}
		
		public function hit():void
		{
			if (flickering)
				return
			FlxG.play(GameAssets.playerHit);
			flicker(1.3);
			health -= 1;
		}
		
		/**
		 * Check to see if the object is gone
		 */
		override public function kill():void
		{
			if (!alive)
				return;
			super.kill();
			//Play sound
			play("squished");
			FlxG.play(GameAssets.gLaugh);
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.blood, 15, 10, true, 0.5);
			FlxG.state.add(_gibs);
			
			_gibs.x = this.x + width / 2;
			_gibs.x = this.y + height / 2;
			_gibs.recycle();
			//Gibs emitted upon death
			if (_gibs != null)
			{
				_gibs.at(this);
				_gibs.start(true, 5, 0, 50);
			}
		}
		
		  /**
         * This resets values of the Frog instance.
         */
        public function restart():void
        {
			x = startPosition.x;
			y = startPosition.y;
        }
	}//End of class

}//End of namespace