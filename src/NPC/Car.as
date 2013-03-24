package NPC 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import GameAssets;
	import Registry;
	
	/**
	 * Car
	 */
	
	public class Car extends FlxSprite
	{
		
		public var _health:Number;
		public var _gibs:FlxEmitter;
		public var _timer:Number;

		
		public function Car(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(GameAssets.suv1PNG, false, true, 90, 34);
			facing = FlxObject.LEFT;
			_health = 1;
			solid = true;
			drag.x = 15; 
			acceleration.y = 25;
			
			//Create Animations
			addAnimation("idle", [1], 0);
			addAnimation("killed", [0], 3, false);
		}
		
		override public function update():void
		{
			super.update();
			if (alive)
			{	
				var a:Number = FlxVelocity.distanceBetween(this, Registry.followO);
				var b:Number = FlxVelocity.angleBetween(this, Registry.followO);
				if (a <= 145)
				{
					if (b > -1 && facing == FlxObject.RIGHT)
					{
						velocity.x = -50;
						facing = LEFT;
					}
					
					if (b > -45 && facing == FlxObject.LEFT)
					{
						velocity.x = 50;
						facing = RIGHT;
					}
				}
	
				if (velocity.x > 0 || velocity.x < -1)
					play("idle"); 
				else 
					play("idle");
			}
						
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
			//FlxG.play(GameAssets.humanHit, .75);//Replace this
			
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.wheel1PNG, 4, 10, true, 0.5);
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
			//Gibs creator
			_gibs = new FlxEmitter(0,0, -1.5);
			_gibs.setXSpeed(-150,170);
			_gibs.setYSpeed(-200,0);
			_gibs.setRotation(-720,-720);
			_gibs.gravity = 300;
			_gibs.bounce = 0.1;
			_gibs.makeParticles(GameAssets.glass1PNG, 20, 10, true, 0.5);
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
		
	}//End of Class

}//End of Package 