part of main;

Sprite _line  = new Sprite(),
       _lNorm = new Sprite(),
       _rNorm = new Sprite();

Shape _shape = new Shape();

class Vector implements Animatable
{
  var _a = new Point(0,0),
      _b = new Point(0,0),
      _vx = 0,
      _vy = 0;
  
  
  
  Vector({animateIt: true, startX: 0, startY: 0, endX: 0, endY: 0, newVx: 0, newVy: 0})
  {
    update(startX, startY, endX, endY, newVx, newVy); 
    if(animateIt)
    {
      stage.addChild(_line);
      stage.addChild(_lNorm);
      stage.addChild(_rNorm);
      juggler.add(this);
    }
  }
  
  
  
  update([startX = 0, startY = 0, endX = 0, endY = 0, newVx = 0, newVy = 0])
  {
    if(newVx == 0 && newVy == 0)
    {
      _a
        ..x = startX
        ..y = startY;
      _b
        ..x = endX
        ..y = endY;
    }
    else
    {
      _vx = newVx;
      _vy = newVy;
    }
  }
  
  Point get a
  {
    return _a;
  }
  Point get b
  {
    return _b;
  }
  
  num get vx
  {
    if(_vx == 0)
    {
      return _b.x - _a.x;
    }
    else
    {
      return _vx;
    }
  }
  
  num get vy
  {
    if(_vy == 0)
    {
      return _b.y - _a.y;
    }
    else
    {
      return _vy;
    }
  }
  
  num get angle
  {
    var radians = math.atan2(vy, vx),
        degrees = radians * 180 / math.PI;
    return degrees;
  }
  
  num get magnitude
  {
    if(vx != 0 || vy != 0)
    {
      return math.sqrt(vx *vx + vy * vy);
    }
    else
    {
      return 0.001;
    }
  }
  
  Vector get leftNormal
  {
    Vector leftNorm = new Vector(animateIt: false);
    if(_vx == 0 && _vy == 0)
    {
      leftNorm.update(a.x, a.y, a.x + this.lx, a.y + this.ly);
    }
    else
    {
      leftNorm.update(0,0,0,0,vx,vy);
    }
    return leftNorm;
  }
  
  Vector get rightNormal
  {
    Vector rightNorm = new Vector(animateIt: false);
    if(_vx == 0 && _vy == 0)
    {
      rightNorm.update(a.x, a.y, a.x + this.rx, a.y + this.ry);
    }
    else
    {
      rightNorm.update(0,0,0,0,vx,vy);
    }
    return rightNorm;  
  }
  
  num get rx
  {
    return -vy;
  }
  
  num get ry
  {
    return vx;
  }
  
  num get lx
  {
    return vy;
  }
  
  num get ly
  {
    return -vx;
  }
  
  num get dx
  {
    if(magnitude != 0)
    {
      return vx / magnitude;  
    }
    else
    {
      return 0.001;
    }
  }
  
  num get dy
  {
    if(magnitude != 0)
    {
      return vy / magnitude;  
    }
    else
    {
      return 0.001;
    }  
  }
  
  draw({color: Color.Black, width: 1})
  {
    _shape.graphics
      ..beginPath()
      ..moveTo(a.x, a.y)
      ..lineTo(b.x, b.y)
      ..strokeColor(color, width)
      ..closePath();    
    _line.addChild(_shape);
  }
  
  drawWithNorms({colorMain: Color.Black, widthMain: 1,leftNormalColor: Color.Red, leftNormalWidth: 1, rightNormalColor: Color.Red, rightNormalWidth: 1})
  {
    _shape.graphics
      ..beginPath()
      ..moveTo(a.x, a.y)
      ..lineTo(b.x, b.y)
      ..strokeColor(colorMain, widthMain)
      ..closePath();    
    _line.addChild(_shape);
    
    
    _shape.graphics
      ..beginPath()
      ..moveTo(leftNormal.a.x, leftNormal.a.y)
      ..lineTo(leftNormal.b.x, leftNormal.b.y)
      ..strokeColor(leftNormalColor, leftNormalWidth)
      ..closePath();    
    _lNorm.addChild(_shape);
    
    
    _shape.graphics
      ..beginPath()
      ..moveTo(rightNormal.a.x, rightNormal.a.y)
      ..lineTo(rightNormal.b.x, rightNormal.b.y)
      ..strokeColor(rightNormalColor, rightNormalWidth)
      ..closePath();    
    _rNorm.addChild(_shape);
    
  }
  
  drawToPlayer(x,y)
  {
    update(x, y, player.center.x, player.center.y);
  }
  
  bool advanceTime(num time)
  {
    return true;
  }
  
}

class DrawVector extends Vector
{
  Vector v;
  DrawVector(this.v){}//:super(animateIt: false){}
  
  bool advanceTime(num time)
  {
    _shape.graphics.clear();
    v.draw();
    return true;  
  }    
}

class DrawVectorWithNorms extends Vector
{
  //DrawVectorWithNorms():super(animateIt: false){}
  bool advanceTime(num time)
  {
    _shape.graphics.clear();
    drawToPlayer(400, 400);
    drawWithNorms();
    return true;  
  }
}