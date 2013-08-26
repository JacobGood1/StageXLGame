part of main;

abstract class GameSprite extends DisplayObjectContainer implements Animatable
{
  Bitmap _bit;
  GameSprite(String bitMapLocation)
  {
    _bit = new Bitmap(resourceManager.getBitmapData(bitMapLocation));
    addChild(_bit);
  }
  
  num get distanceToMouse => math.sqrt((mouseX - x) * (mouseX - x) + (mouseY - y) * (mouseY - y));
  
  num get mouseDistanceX => mouseX - x;
  num get mouseDistanceY => mouseY - y;
  
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
    lvl.removeChild(this);
  }
  
  Point get center => new Point(x + width / 2, y + height / 2); 
  
}