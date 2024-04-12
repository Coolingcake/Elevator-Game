class Player {
  PVector pos;
  PVector projectedPos;
  PVector previousPos;
  float size = 50;

  Player() {
    pos = new PVector(0, 0);
    projectedPos = new PVector(0, 0);
    previousPos = new PVector(0, 0);
  }

  void move() {
    pos.x = platforms.get(1).projectedPos.x + platformLength;
    pos.y = platforms.get(1).projectedPos.y;
    projectedPos.x = lerp(projectedPos.x, pos.x, 0.2);
    projectedPos.y = lerp(projectedPos.y, pos.y, 0.4);
  }

  void render() {
    stroke(0);
    fill(255);
    rect(projectedPos.x-(size/2), projectedPos.y-size-0.5, size, size);
  }
}
