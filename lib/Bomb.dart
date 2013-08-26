part of main;

class Bomb extends GameSprite
{
  num speed = 5.0,
        _vx,
        _vy,
        _dx,
        _dy;
  
  Bomb():super('bomb')
  {
    
      this
        ..pivotX = width / 2
        ..pivotY = height / 2
        ..x = player.center.x
        ..y = player.center.y;
    
    var magnitude = distanceToMouse;
    
    _dx = mouseDistanceX / magnitude;
    _dy = mouseDistanceY / magnitude;
    
    juggler.add(this);
    
  }
  
  bool advanceTime(num time)
  {
    x += _dx * speed;
    y += _dy * speed;
    rotation += 0.1;
    if(stageBounds)
    {
      terminate;
      return false;
    }
    else
    {
      return true;  
    }
      
  }
}