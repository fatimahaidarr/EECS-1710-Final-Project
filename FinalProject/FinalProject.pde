PShader shader_ripple;
PGraphics pg;

import themidibus.*;

MidiBus myBus;

ArrayList<Key> keys = new ArrayList<Key>();
ArrayList<CircleKey> circleKeys = new ArrayList<CircleKey>();

int keyWidth = 40;
int keyHeight = 160;

float minRadius = 40;
float maxRadius = 100;


void setup() {
  size(640, 480, P2D);
  pg = createGraphics(640, 480 - keyHeight, P2D);
  
  shader_ripple = loadShader("example.glsl");
  shader_ripple.set("resolution", float(480), float(480 - keyHeight));
  shader_ripple.set("rate", 1);
  
  for (int i = 0; i < 640; i += keyWidth) {
    keys.add(new Key(new PVector(i, 480 - keyHeight), new PVector(keyWidth, keyHeight), 
    color(((640 - i) / 640.0) * 255, 0, (i / 640.0) * 255), new PShape(), int(map(i, 0, 640, 0, 16)))
    );
  }
  
  pg.beginDraw();
  pg.background(0);
  pg.endDraw();
   
   myBus = new MidiBus(this, -1, 2);
}

void draw() {
  background(0);
  
  pg.beginDraw();
  
  for (Key key: keys) {
    key.update();
  }
  
  for (CircleKey circleKey: circleKeys) {
    circleKey.update();
  }
  
  
  if (random(0, 1) < 0.5) pg.blendMode(ADD);
  
  shader_ripple.set("time", float(millis())/1000.0);
  shader_ripple.set("tex0", pg);
  pg.filter(shader_ripple);

  pg.blendMode(BLEND);
  pg.noStroke();
  pg.fill(0, 5);
  pg.rect(0, 0, width, height);

  pg.endDraw();
  
  image(pg, 0, 0);
  
  surface.setTitle("" + frameRate);
}
