part of main;

/*   void personalUpdate(){}
     void collision(){}
     void terminate(){} 
*/

abstract class GameSprite extends Sprite
{
  List<GameSprite> collideObjects = [];
  bool correction = false;
  double SPEED = 0.0,
         TERMINAL_VELOCITY = 0.0,
         TERMINAL_FRICTION = 0.0,
         
         acceleration = 0.0,
         accelerationX = 0.0,
         accelerationY = 0.0,
         
         friction = 0.5,
         frictionX = 0.0,
         frictionY = 0.0,
         
         direction = 0.0,
         
         previous_x = 0.0,
         previous_y = 0.0,
         
         temporary_x = 0.0,
         temporary_y = 0.0,
         
         xPos = 0.0,
         yPos = 0.0;
  
  String collisionSide = "",
         ID = "";
  Bitmap _bit;
  
  
  GameSprite(String bitMapLocation)
  {
    _bit = new Bitmap(resourceManager.getBitmapData(bitMapLocation));
    addChild(_bit);
    gameSprites.add(this);
  }
  
  void personalUpdate();
  void personalCollision(GameSprite sprite);
  void collision(List<GameSprite> possibleCollisions)
  {
    possibleCollisions.forEach((GameSprite sprite) => personalCollision(sprite));
  }
  void terminate();
  
  void update()
  {
    personalUpdate();
    temporary_x = xPos;
    temporary_y = yPos;
    
    /*if(acceleration >= TERMINAL_VECLOCITY)
    {
      acceleration = TERMINAL_VECLOCITY;
    }*/
    
    frictionX = vx * friction;
    frictionY = vy * friction;
    
    xPos += accelerationX + frictionX;
    yPos += accelerationY + frictionY;
    
    previous_x = temporary_x;
    previous_y = temporary_y;
  }
  
  num get vx => xPos - previous_x;
  set vx(num value) => previous_x = xPos - value;
  set setX(num value) {previous_x = value - vx; xPos = value;}
  
  num get vy => yPos - previous_y;
  set vy(num value) => previous_y = yPos - value;
  set setY(num value) {previous_y = value - vy; yPos = value;}
  
  num get distanceToMouse => math.sqrt((mouseX - xPos) * (mouseX - xPos) + (mouseY - yPos) * (mouseY - yPos));
  
  num get mouseDistanceX => mouseX - xPos;
  num get mouseDistanceY => mouseY - yPos;
  
  num get centerX => width / 2 + xPos;
  num get centerY => height / 2 + yPos;
  
  Point get center => new Point(xPos + width / 2, yPos + height / 2); 
  
  stageBounds()
  {
    if(xPos + width > stage.stageWidth)
    {
      setX = stage.stageWidth.toDouble() - width;
      vx = 0;
    }
    if(xPos < 0)
    {
      setX = 0.0;
      vx = 0;
    }
    if(yPos < 0)
    {
      setY = 0.0;
      vy = 0;
    }
    if(yPos + height > stage.stageHeight)
    {
      setY = stage.stageHeight.toDouble() - height;
      vy = 0;
    }
  }
  
  collide(GameSprite other)
  {
    
    num dx = center.x - other.center.x,
        dy = center.y - other.center.y,
        combinedHalfHeights = height / 2 + other.height / 2,
        combinedHalfWidths = width / 2 + other.width / 2;
    
    if(dx.abs() < combinedHalfWidths)
    {
      if(dy.abs() < combinedHalfHeights)
      {
        num overLapX = combinedHalfWidths - dx.abs(),
            overLapY = combinedHalfHeights - dy.abs();
        if(overLapX >= overLapY)
        {
          if(dy > 0 )
          {
            collisionSide = "top";
            if(correction){yPos += overLapY;};
            return true;
          }
          else
          {
            collisionSide = "bottom";
            if(correction){yPos -= overLapY;};
            return true;
          }     
        }
        else
        {
          if(dx > 0 )
          {
            collisionSide = "left";
            if(correction){xPos += overLapX;};
            return true;
          }
          else
          {
            collisionSide = "right";
            if(correction){xPos -= overLapX;};
            return true;
          }
        }
      }
      else
      {
        collisionSide = "none";
        return false;
        }     
    }
    else
    {
        collisionSide = "none";
        return false;
    }
  }
}

class Player extends GameSprite
{
  int health = 100; 

  List keys = [];
  Map keyCodes = new Map();
  
  Player():super('mario')
  {
    keyCodes[87] = 'w';
    keyCodes[65] = 'a';
    keyCodes[83] = 's';
    keyCodes[68] = 'd';
    
    SPEED = 3.0;
    ID = "player";
    
    x = 100.0;
    y = 100.0;
    
    scaleX = 1/10;
    scaleY = 1/10;
    
    canvas.onKeyDown.listen((keyPressed)
        {
          var key = keyPressed.keyCode;
          if(!keys.contains(key)){keys.add(keyPressed.keyCode);}
        });
    canvas.onKeyUp.listen((keyReleased)
        {
          keys.remove(keyReleased.keyCode);
        });
    
    
  }
  
  void personalUpdate()
  {
    keys.forEach((key) 
        {
          var keyCode = keyCodes[key];
          if(keyCode == 'w'){vy -= SPEED;}
          if(keyCode == 'a'){vx -= SPEED;}
          if(keyCode == 's'){vy += SPEED;}
          if(keyCode == 'd'){vx += SPEED;}
        });
    
  }
  void personalCollision(GameSprite sprite)
  {
    
  }
  void terminate(){}    
}

class Minotaur extends GameSprite
{
  Minotaur():super('minotaur')
  {
    ID = 'minotaur';
    setX = 200.0;
    setY = 200.0;
    scaleX = 1/5;
    scaleY = 1/5;
  }
  void personalUpdate(){}
  void personalCollision(GameSprite sprite)
  {
    
  }
  void terminate(){}  
}







