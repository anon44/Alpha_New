package NPC 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import GameAssets;
	import Registry;
	import Menus.*;
	/** Human Class for the Menu
	 * 
	 * 
	 */
	public class human extends FlxSprite
	{
		public var _health:Number;
		public var _gibs:FlxEmitter;
		public var _timer:Number;
		private var originalX:int;
		protected var frontBumper:FlxObject;
		protected var speed:Number;
		public function human(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(GameAssets.imgHuman, true, true, 26, 25);
			facing = FlxObject.LEFT;
			_health = 1;
			//solid = true;
			originalX = x;
			speed = 30;
			maxVelocity.x = speed;
			//drag.x = 20; //This is here only for this stage, remove or adjust for the game
			acceleration.y = 50;
			addAnimation("idle", [10], 0);
			addAnimation("running", [2, 3, 4, 5, 6, 7, 8, 9], 10, true);
			addAnimation("killed", [0, 1], 3, false);
			//velocity.x = 30;
			frontBumper = new FlxObject(x -1, y , 1, height);
		
		}
		
		override public function update():void
		{
			super.update();
			if (alive || FlxG.state.active != MenuState)
			{
		    	if (velocity.x > 0 || velocity.x < -1)
					play("running");
				else 
					play("idle");
					
				if (x > FlxG.worldBounds.width - 4)
				{
					x = FlxG.worldBounds.width - 4;
					facing = LEFT;
				}
				if (x < 4)
				{
					x = 4;
					facing = RIGHT;
				}
			}		
		}
		
		//This will help with the random movement
		private function turnAround():void
		{
			if (facing == FlxObject.RIGHT)
			{
				facing = LEFT;
				
				velocity.x = -velocity.x
			}
			else 
			{
				facing = RIGHT;
				
				velocity.x = -velocity.x
			}
	
		}
		
		public function updateBumpers():void
		{
			frontBumper.x = (facing == LEFT) ? (x - 1) : (x + width);
			frontBumper.y = y;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_gibs = null;
		}
		
		override public function kill():void
		{
			if (!alive)
				return;
			alive = false;
			moves = false; 
			solid = false;
			play("killed");
			frame = 0;
			//Play sound 
			//FlxG.play(GameAssets.humanHit, .75);
			
			
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.blood, 20, 10, true, 0.5);
			FlxG.state.add(_gibs);
			
			
			_gibs.x = this.x + width / 2;
			_gibs.x = this.y + height / 2;
			_gibs.recycle();
			//Gibs emitted upon death
			if (_gibs != null)
			{
				_gibs.at(this);
				_gibs.start(true, 5, 0, 40);
			}

			//End of Gibs creator
			FlxG.elapsed += _timer;
			if (_timer >= 5)
			{
				super.kill();
			}
		}		
	}//End Class
}//End Package