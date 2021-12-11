class Key {
  
  // audio/visual attributes
  PVector pos;  // x, y
  PVector size; // sizeX, sizeY
  color keyColor;
  color currColor;
  color hoverColor;
  color clickColor;
  PShape shape; // circle, rectangle, or square
  int amplitude;
  int pitch;
  
  // control
  boolean isHover; // is the mouse hovering over the key
  boolean isClicked;
  
  Key(PVector pos, PVector size, color keyColor, PShape shape, int pitch) {
    this.pos = pos;
    this.size = size;
    this.keyColor = keyColor;
    this.shape = shape;
    this.pitch = pitch;
    
    colorsInit();
  }
  
  void update() {
    checkKey();
    drawKey();
  }

  void colorsInit(){
    hoverColor = blendColor(keyColor, color(50), ADD);
    clickColor = blendColor(keyColor, color(10), ADD);
  }
  
  
  /*
    check if the mouse is hover or if the key is clicked
  */
  void checkKey() {
    // check if the mouse is hovering
    isHover = mouseHover();
    
    if (isHover) {
     if (mousePressed) {
      isClicked = true; 
     } else {
      isClicked = false; 
     }
    }
  }
  
  void playSound() {
    myBus.sendNoteOn(0, pitch, int(map(mouseY, 480 - size.y, 480, 0, 127)));
  }
  
  boolean mouseHover() {
    return (mouseX >= pos.x + size.x &&
            mouseX <= pos.x + 2 * size.x && 
            mouseY >= pos.y &&
            mouseY <= pos.y + size.y);
  }
  
  void drawKey() {
    // set color
    pg.strokeWeight(random(10, 20));
    if (isHover && !isClicked) {
      currColor = hoverColor;
    } else if (isHover && isClicked) {
      currColor = clickColor;
      playSound();
      pg.stroke(currColor);
      pg.strokeWeight(2);
      pg.line(pos.x + 3 * size.x / 2.0, pos.y, random(0,640), 0);
    } else {
      currColor = keyColor;
    }
    
    rect(pos.x, pos.y, size.x, size.y);
    fill(currColor);
  }
  
  void delay(int time) {
    int current = millis();
    while (millis () < current+time) Thread.yield();
  }
}
