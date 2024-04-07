import processing.sound.*;
ArrayList<Platform> platforms = new ArrayList<Platform>();
int platformDistance = 100;

int cooldownDuration = 100;
int lastPlatformAddedTime = 0;

int stepCount = 0;

int platformLength = 500/4;

boolean shifted = false;

float stamina = 100;

SoundFile stepSound;
SoundFile spawnSound;
boolean played = false;

void setup() {
  size(500, 1000);
  //fullScreen();
  stepSound = new SoundFile(this, "Sounds/Step Up Sound.wav");
  spawnSound = new SoundFile(this, "Sounds/Player Spawn Sound.wav");
  platformLength = width/2 - platformLength;
  for (int i = ((height+platformDistance) / platformDistance)-1; i >= 0; i--) {
    platforms.add(new Platform(int(random(0, 2))));
    for (int j = platforms.size()-1; j >= 0; j--) {
      platforms.get(j).moveY(platformDistance);
    }
  }
  platforms.add(new Platform(int(random(0, 2))));
  platforms.remove(0);

  for (int j = platforms.size()-1; j > 0; j--) {
    if (j == 1) {
      if (platforms.get(j).side == 0) {
        platforms.get(j).moveX(platformLength);
      } else if (platforms.get(j).side == 1) {
        platforms.get(j).moveX(-platformLength);
      }
    } else {
      shift(j-2, j-1);
    }
  }
  for (int i = 0; i < platforms.size(); i++) {
    move();
  }
  
  if (stepCount == 0) {
    
  }
  stepCount = 0;

  float firstPlatformX = platforms.get(1).pos.x;
  float targetX = platformLength;
  float offsetX = targetX - firstPlatformX;

  for (int i = 0; i < platforms.size(); i++) {
    Platform platform = platforms.get(i);
    platform.moveX(offsetX);
  }
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
    stamina = 100;
    stepCount = 0;
  } else {
    stamina -= 0.4;
  }
}

void move() {
  for (int i = 0; i < platforms.size(); i++) {
    platforms.get(i).moveY(platformDistance);
  }

  platforms.add(new Platform(int(random(0, 2))));

  shift(platforms.size()-2, platforms.size()-1);

  platforms.remove(0);
  stepCount++;
}

void shift(int prev, int post) {
  platforms.get(post).setX(platforms.get(prev).pos.x);
  if (platforms.get(post).side == 0) {
    platforms.get(post).moveX(-platformLength);
  } else if (platforms.get(post).side == 1) {
    platforms.get(post).moveX(platformLength);
  }
}

void keyPressed() {
  if (keyCode == SHIFT) {
    shifted = true;
  }
  if (millis() - lastPlatformAddedTime >= cooldownDuration) {
    if (key == 'a' || keyCode == LEFT) {
      if (platforms.get(2).side == 0) {
        move();
        stepSound.play();
        stamina = 100;
        for (int i = 0; i < platforms.size(); i++) {
          platforms.get(i).moveX(platformLength);
        }
      } else {
        stepCount = 0;
        played = false;
      }
    }
    if (key == 'd' || keyCode == RIGHT) {
      if (platforms.get(2).side == 1) {
        move();
        stepSound.play();
        stamina = 100;
        for (int i = 0; i < platforms.size(); i++) {
          platforms.get(i).moveX(-platformLength);
        }
      } else {
        stepCount = 0;
        played = false;
      }
    }
    lastPlatformAddedTime = millis();
  }
}
void keyReleased() {
  if (keyCode == SHIFT) {
    shifted = false;
  }
}
