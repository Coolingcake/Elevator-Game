import processing.sound.*;
import java.util.Random;
ArrayList<Platform> platforms = new ArrayList<Platform>();
int platformDistance = 100;

int stepCount = 0;

int platformLength = 125;
Random r = new Random();
boolean shifted = false;

float stamina = 100;

SoundFile stepSound;
SoundFile spawnSound;
boolean played = false;

boolean setup = true;

void setup() {
  size(1000, 1000);
  stepSound = new SoundFile(this, "Sounds/Step Up Sound.wav");
  spawnSound = new SoundFile(this, "Sounds/Player Spawn Sound.wav");

  platforms.add(new Platform(r.nextInt(3)-1));

  for (int i = 0; i < ((height+platformDistance) / platformDistance)-1; i++) {
    move();
  }

  stepCount = 0;

  float offsetX = (width/2 - platformLength) - (platforms.get(1).pos.x);

  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i).moveX(offsetX);
  }
  setup = false;
}

void draw() {
  background(255);
  textSize(100);
  if (stepCount == 0) {
    fill(#FF0000);
    if (!played) {
      spawnSound.play();
      played = true;
    }
  } else {
    fill(100);
  }
  text(stepCount, 25, 75);

  for (int i = 0; i < platforms.size(); i++) {
    if (i == 1) {
      platforms.get(i).render(#FF0000);
    } else
      platforms.get(i).render(#000000);
  }

  fill(#00FF00);
  rect(0, height -10, map(stamina, 0, 100, 0, width), height);
  if (stamina < 0) {
    kill();
  } else {
    stamina -= 0.4;
  }
}

void kill() {
  stamina = 100;
  stepCount = 0;
  played = false;
}

void movePlayer(int direction) {
  if ((direction == 0 && platforms.get(2).side == 0) ||
    (direction == 1 && platforms.get(2).side == 1) ||
    (direction == -1 && platforms.get(2).side == -1)) {
    move();
    stepSound.play();
    stamina = 100;

    if (direction != 0) {
      for (Platform platform : platforms) {
        platform.moveX(-direction * platformLength);
      }
    }
    return;
  }
  kill();
}

void move() {
  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i).moveY(platformDistance);
  }
  platforms.add(new Platform(r.nextInt(3)-1));
  shift(platforms.size()-2, platforms.size()-1);
  if (!setup) {
    platforms.remove(0);
  }
  stepCount++;
}

void shift(int prev, int post) {
  Platform postPlatform = platforms.get(post);
  postPlatform.setX(platforms.get(prev).pos.x);
  postPlatform.moveX(platformLength * postPlatform.side);
}

void keyPressed() {
  if (keyCode == SHIFT) {
    shifted = true;
  }
  if (key == 'a' || keyCode == LEFT) {
    movePlayer(-1);
  } else if (key == 'd' || keyCode == RIGHT) {
    movePlayer(1);
  } else if (key == 'w' || keyCode == UP) {
    movePlayer(0);
  }
}

void keyReleased() {
  if (keyCode == SHIFT) {
    shifted = false;
  }
}
