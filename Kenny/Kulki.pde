class Kulki
{
  int x, y, vx, vy;
  Kulki(int start_x, int start_y, int x_vel, int y_vel)
  {
    x = start_x;
    y = start_y;
    vx = x_vel;
    vy = y_vel;
  }
   
  void update() {
    x += vx;
    y += vy; //zmiana prędkości względem pozycji
    if (x <= 0 || x >= width) {vx = -vx; } // sprawdzenie kolizji z osią x
    if (y <= 0 || y >= height) {vy = -vy; } // sprawdzenie kolizji z osią y
  }
}
 
