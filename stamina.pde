class StaminaBar {
  float stamina;
  float maxStamina;
  color staminaColor;

  StaminaBar(float s) {
    maxStamina = s;
    stamina = maxStamina;
  }
  
  void changeColor() {
    if (stamina > 50) {
      staminaColor = lerpColor(color(0, 255, 0), color(255, 255, 0), map(stamina, maxStamina, maxStamina/2, 0, 1));
    } else {
      staminaColor = lerpColor(color(255, 255, 0), color(255, 0, 0), map(stamina, maxStamina/2, 10, 0, 1));
    }
  }
  
  void changeStamina(float num) {
    stamina += num;
  }
  
  void setToMax() {
    stamina = maxStamina;
  }

  void render() {
    fill(staminaColor);
    rect(0, height - 10, map(stamina, 0, 100, 0, width), 10);
  }
}
