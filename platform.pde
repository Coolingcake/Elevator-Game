class Platform {
  int side;
  PVector pos;

  float projectedY;
  float projectedX;

  Platform (int s) {
    side = s;
    initialize();
  }

  void initialize() {
    if (side == 0) {
      pos = new PVector(0, 0);
    }
    if (side == 1) {
      pos = new PVector(width/2, 0);
    }
    
    
    projectedY = pos.y;
    projectedX = pos.x;
  }

  void moveY(float num) {
    pos.y += num;
  }
  
  void moveX(float num) {
    pos.x += num;
  }

  void render(int c) {
    stroke(c);
    projectedY = lerp(projectedY, pos.y, 0.1);
    projectedX = lerp(projectedX, pos.x, 0.1);
    line(projectedX, projectedY, projectedX+width/2, projectedY);
  }
}
