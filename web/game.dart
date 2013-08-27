library main;

import 'package:stagexl/stagexl.dart';

import 'dart:html' as html;
import 'dart:math' as math;

part '../lib/Player.dart';
part '../lib/Bomb.dart';
part '../lib/enemies.dart';
part '../lib/GameSprite.dart';
part '../lib/Vector.dart';

math.Random rand = new math.Random();

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager = new ResourceManager();
html.Element canvas;
GameSprite player;
List<GameSprite> gameSprites = [];

var lvl;

GlassPlate gameSurface;

num mouseX,
    mouseY;



class GameWorld extends DisplayObjectContainer
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
  Vector buttonVector;
  Level1()  
  {
    
    
    resourceManager
      ..addBitmapData('mario', 'Assets/MARIO.png')
      ..addBitmapData('bomb', 'Assets/bomb.png')
      ..addBitmapData('goomba', 'http://guerrasdraconicas.files.wordpress.com/2009/03/minoaturo1.jpg')
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
          //print(gameSprites);
        });
    addChild(gameSurface);
    
          player = new Player(300,300); 
          addChild(player);
          addChild(new Goomba());
          var kek = new Vector(startX: 0, startY: 0, endX: 200, endY: 200);
          new DrawVector(kek);
         
        });;
  }
}


main()
{
  lvl = new Level1();
  stage.addChild(lvl);
}