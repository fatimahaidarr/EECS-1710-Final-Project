class CircleKey {
  
  // audio/visual attributes
  PVector pos;  // x, y
  float radius;
  color keyColor;
  color currColor;
  color hoverColor;
  color clickColor;
  float audio;
  PShape shape; // circle, rectangle, or square
  
  
  // control
  boolean isHover; // is the mouse hovering over the key
  boolean isClicked;
  
  CircleKey(PVector pos, float radius, color keyColor, float audio) {
    this.pos = pos;
    this.radius = radius;
    this.keyColor = keyColor;
    this.audio = audio;
    
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
  
  //
  boolean mouseHover() {
    return (dist(pos.x, pos.y, mouseX, mouseY) <= radius);
  }
  
  void drawKey() {
    // set color
    if (isHover && !isClicked) {
      currColor = hoverColor;
    } else if (isHover && isClicked) {
      currColor = clickColor;
    } else {
      currColor = keyColor;
    }

    // set shape
    ellipse(pos.x, pos.y, radius, radius);
    fill(currColor);
  }
  
}
