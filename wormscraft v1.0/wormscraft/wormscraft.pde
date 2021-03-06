MainMenu menu;
Game game;
boolean mouseClick = false;
boolean mouseStillPressed = false;
int caseSize = 32;
int caseWidth = 32;
int caseHeight = 32;

void setup() {
  size(800, 600);
  menu = new MainMenu();
  game = null;
}


void update() {
  if (mouseClick)
    mouseClick = false;
  if (mousePressed) {
    if (!mouseStillPressed) {
      mouseStillPressed = true; 
      mouseClick =  true;
    }
  } 
  else if (mouseStillPressed) {
    mouseStillPressed = false;
  } 
  if (game != null) {
    //ln("Update Main");
    game.update();
  } 
  else {
    menu.update();
  }
}

void draw() {
  background(100);
  update();
  if (game != null) {
    game.draw();
  } 
  else {
    menu.draw();
  }
}

