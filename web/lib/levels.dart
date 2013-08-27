part of main;

class GameLoop extends Animatable
{
  advanceTime(num time)
  {
    gameSprites.forEach((GameSprite sprite)
        {
          sprite
            ..update()
            ..collision()
            ..stageBounds()
            ..x = sprite.xPos
            ..y = sprite.yPos;
        });
  }
}


abstract class GameWorld extends DisplayObjectContainer
{
  GameWorld()
  {
    //init stage and render loop
    canvas = html.query('#stage');
    stage = new Stage('stage', canvas);
    renderLoop = new RenderLoop();
    renderLoop.addStage(stage);
    juggler = renderLoop.juggler;  
    gameSurface = new GlassPlate(800, 600);
  }
}

class Level1 extends GameWorld
{
  Level1()  
  {
    resourceManager
      ..addBitmapData('mario', 'Assets/MARIO.png')
      ..addBitmapData('bomb', 'Assets/bomb.png')
      ..addBitmapData('minotaur', 'http://guerrasdraconicas.files.wordpress.com/2009/03/minoaturo1.jpg')
      ..addBitmapData('buttonUp', 'http://www.clker.com/cliparts/a/9/3/e/1194984754884631372button-blue_benji_park_01.svg.hi.png')
      
      ..load().then((result)
        {
        gameSurface.onMouseMove.listen((me)
          {
            mouseX = me.localX;
            mouseY = me.localY;
          });
        
        canvas.onMouseDown.listen((me)
            {
              addChild(new Bomb());
            });
        
        addChild(gameSurface);
        
        player = new Player();
        addChild(player);
        
        addChild(new Minotaur());
        juggler.add(new GameLoop());
        // resourceManager end
        });;
        
  }
}