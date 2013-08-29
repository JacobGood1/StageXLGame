part of main;
class QuadTree
{
  int MAX_OBJECTS = 10,
      MAX_LEVELS = 5,
      level;
  
  List<GameSprite> objects;
  Rectangle bounds;
  List<QuadTree> nodes;
  
  QuadTree(int pLevel, Rectangle pBounds)
  {
    level = pLevel;
    objects = <GameSprite>[];
    bounds = pBounds;
    nodes = new List<QuadTree>(4);
  }
  
  clear()
  {
    objects.clear();
    
    for (int i = 0; i < nodes.length; i++) 
    {
      if (nodes[i] != null) 
      {
        nodes[i].clear();
        nodes[i] = null;
      }
    }  
  }
  
  split() 
  {
    int subWidth = (bounds.width / 2).toInt();
    int subHeight = (bounds.height / 2).toInt();
    int x = (bounds.x).toInt();
    int y = (bounds.y).toInt();
    
    nodes[0] = new QuadTree(level+1, new Rectangle(x + subWidth, y, subWidth, subHeight));
    nodes[1] = new QuadTree(level+1, new Rectangle(x, y, subWidth, subHeight));
    nodes[2] = new QuadTree(level+1, new Rectangle(x, y + subHeight, subWidth, subHeight));
    nodes[3] = new QuadTree(level+1, new Rectangle(x + subWidth, y + subHeight, subWidth, subHeight));
  }
  
  getIndex(GameSprite pRect) 
  {
    int index = -1;
    double verticalMidpoint = bounds.x + (bounds.width / 2);
    double horizontalMidpoint = bounds.y + bounds.height / 2;
    
    // Object can completely fit within the top quadrants
    bool topQuadrant = (pRect.y < horizontalMidpoint && pRect.y + pRect.height < horizontalMidpoint);
    // Object can completely fit within the bottom quadrants
    bool bottomQuadrant = (pRect.y > horizontalMidpoint);
    
    // Object can completely fit within the left quadrants
    if (pRect.x < verticalMidpoint && pRect.x + pRect.width < verticalMidpoint) 
    {
      if (topQuadrant) 
      {
        index = 1;
      }
      else if (bottomQuadrant) 
      {
        index = 2;
      }
    }
    // Object can completely fit within the right quadrants
    else if (pRect.x > verticalMidpoint) 
    {
     if (topQuadrant) 
     {
       index = 0;
     }
     else if (bottomQuadrant) 
     {
       index = 3;
     }
   }
 
   return index;
 }
  
  /*
   * Insert the object into the quadtree. If the node
   * exceeds the capacity, it will split and add all
   * objects to their corresponding nodes.
   */
  insert(GameSprite pRect) 
  {
    if (nodes[0] != null) 
    {
      int index = getIndex(pRect);
      
      if (index != -1) {
        nodes[index].insert(pRect);
        
        return;
      }
    }
    
    objects.add(pRect);
    
    if (objects.length > MAX_OBJECTS && level < MAX_LEVELS) {
      if (nodes[0] == null) { 
         split(); 
      }
 
     int i = 0;
     while (i < objects.length) 
     {
       int index = getIndex(objects[i]);
       if (index != -1) 
       {
         nodes[index].insert(objects.removeAt(i));
       }
       else 
       {
         i++;
       }
     }
   }
 }
  
  retrieve(List returnObjects, GameSprite pRect) 
 {
    int index = getIndex(pRect);
    if (index != -1 && nodes[0] != null) 
    {
      nodes[index].retrieve(returnObjects, pRect);
    }
    
    returnObjects.addAll(objects);
    
    return returnObjects;
  }
  
}