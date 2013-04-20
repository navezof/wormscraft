class Pickaxe extends Consumable
{
  int _lvl;
  boolean used = false;
  Charater player;
  
    Pickaxe(Charater ply, int lvl)
   {
      _lvl = lvl;
      player = ply;
    }
  
    void update() {
       if (mouseClick && _lvl > 0) {
         //récupération cube devant moi
         print("Player position: ");
         int xpos = (int)(player.getXPos());
         int ypos = (int)(player.getYPos());
         println(xpos + " " + ypos);

         PVector pos = new PVector(xpos, ypos);
         PVector mouse = new PVector((int)(mouseX / caseWidth), (int)(mouseY / caseWidth));
         println("clickPosition: " + mouse.x + " " + mouse.y);
         mouse.sub(pos);
         mouse.limit(1);
         pos.add(mouse);
         println("clickDiff: " + pos.x + " " + pos.y);
         game.removeMapCube((int)pos.x, (int)pos.y);
         //--_lvl;
         if (_lvl == 0) {
            used = true;
          }
       }
    }

  void draw() {
   //Draw de l'image
  //positionner en bas à droite, et tourner vers le cursuer   
  }
  
  boolean usingOver() {
    return used;
 } 
}
