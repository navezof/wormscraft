class ItemShop
{
  PImage bg;
  int initX = 135;
  int initY = 220;
  int endX = 615;
  int endY = 380;
  int initXImg = 110;
  int initYImg = 200;
  int sizeCaseX = 54;
  int sizeCaseY = 54;
  int cancelX = 628;
  int cancelY = 330;
  int okayX = 628;
  int okayY = 220;

  int tmpWeapon = 0;
  int tmpWeaponX = 0;
  int tmpWeaponY = 0;
  
  ItemShop() {
     bg = loadImage("./data/img/itemsMenu.png");
  }
  
  void display() {
       image(bg, initXImg, initYImg);
       fill(0, 0, 0, 0);
       rect((tmpWeaponX * sizeCaseX) + initX, (tmpWeaponY * sizeCaseY) + initY, sizeCaseX, sizeCaseY);
  }
  
  void init() {
    tmpWeapon = 0;
    tmpWeaponX = 0;
    tmpWeaponY = 0;
  }
  
  void update() {
   if (mousePressed) {
    if (mouseX >= cancelX && mouseX <= cancelX + sizeCaseX
        && mouseY >= cancelY && mouseY <= cancelY + sizeCaseY)
        game.getCurrentCharacter().inItemShop = false;
    if (mouseX >= initX && mouseX <= endX
     && mouseY >= initY && mouseY <= endY)
     {
      tmpWeaponX = (mouseX - initX) /  sizeCaseX;
      tmpWeaponY = (mouseY - initY) /  sizeCaseY;
      tmpWeapon = tmpWeaponX + (tmpWeaponY * 9);
     }
    if (mouseX >= okayX && mouseX <= okayX + sizeCaseX
        && mouseY >= okayY && mouseY <= okayY + sizeCaseY) {
        game.getCurrentCharacter().inItemShop = false;
        game.getCurrentCharacter().takeWeapon(tmpWeapon);
        }
   }
  } 
};
