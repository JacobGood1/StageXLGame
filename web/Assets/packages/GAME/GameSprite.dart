part of main;

abstract class GameSprite extends DisplayObjectContainer implements Animatable
{
  String collisionSide = "";
  Bitmap _bit;
  GameSprite(String bitMapLocation)
  {
    _bit = new Bitmap(resourceManager.getBitmapData(bitMapLocation));
    addChild(_bit);
    gameSprites.add(this);
    
  }
  
  num get distanceToMouse => math.sqrt((mouseX - x) * (mouseX - x) + (mouseY - y) * (mouseY - y));
  
  num get mouseDistanceX => mouseX - x;
  num get mouseDistanceY => mouseY - y;
  
  num get centerX => width / 2 + x;
  num get centerY => height / 2 + y;
  
  Point get center => new Point(x + width / 2, y + height / 2); 
  
  get stageBounds
  {
    var boundsHit = false;
    
    if(x - width / 2 < 0)
    {
      boundsHit = true;
    }
    if(stage.stageWidth < x + width)
    {
      boundsHit = true;
    }
    if(y - height / 2 < 0)
    {
      boundsHit = true;
    }
    if(stage.stageHeight < y + height / 2)
    {
      boundsHit = true;
    }
    
    return boundsHit;
  }
  
  get terminate
  {
    
    gameSprites.remove(this);
    lvl.removeChild(this);
  }
  
  
  
  collide(GameSprite other)
  {
    
    num dx = other.center.x - center.x,
        dy = other.center.y - center.y,
        combinedHalfHeights = height / 2 + other.height / 2,
        combinedHalfWidths = width / 2 + other.width / 2;
    
    if(dx.abs() < combinedHalfWidths)
    {
      if(dy.abs() < combinedHalfWidths)
      {
        num overLapX = combinedHalfWidths - dx.abs(),
            overLapY = combinedHalfHeights - dy.abs();
        if(overLapX >= overLapY)
        {
          if(dy > 0 )
          {
            collisionSide = "top";
            y += overLapY;
            return true;
          }
          else
          {
            collisionSide = "bottom";
            y -= overLapY;
            return true;
          }     
        }
        else
        {
          if(dx > 0 )
          {
            collisionSide = "left";
            x += overLapX;
            return true;
          }
          else
          {
            collisionSide = "right";
            x -= overLapX;
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
  
 bool isHit([List aL ])
  {
    if(aL == null)
    {
      for(var i = 0 ; i < gameSprites.length; i++)
      {
        if(gameSprites[i] != this)
        {

            if(collide(gameSprites[i]))
            {
              
              return true;
            }
          
          
        }
      };
    }
    else{ 
      for(var i = 0 ; i < gameSprites.length; i++)
          {
            if(gameSprites[i] != this)
            {
              if(aL.contains(gameSprites[i]))
              {
                if(collide(gameSprites[i]))
                {
                  return true;
                }
              }
              
            }
          };
      }
    return false;
  }
 
}