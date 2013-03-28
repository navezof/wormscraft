ArrayList objects = new ArrayList();
Launcher launcher;
Bullet newBullet;

void setup()
{
  size(640, 380);
  launcher = new Launcher(50, height - 200);
  objects.add(launcher);
}

void draw()
{
  background(255);
  for  (int i = objects.size() - 1; i >= 0; i--)
  {
    GraObject obj = (GraObject) objects.get(i);
    obj.update();
    obj.draw();
  }
}

void mousePressed()
  {
    launcher.mouseDown = true;
  }
  
void mouseReleased()
  {
    newBullet = (Bullet) launcher.shoot(mouseX, mouseY);
    objects.add(newBullet);
  }
