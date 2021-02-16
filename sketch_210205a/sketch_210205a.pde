import gab.opencv.*;

OpenCV opencv;
PImage original, canny, sobel;

float rotx = PI/4;
float roty = PI/4;

void setup() {
  size(1000, 720, P3D);
  original = loadImage("img/b.jpg");
  
  opencv = new OpenCV(this, original);
  opencv.findCannyEdges(20, 75);
  canny = opencv.getSnapshot();
  
  opencv.loadImage(original);
  opencv.findSobelEdges(1, 0);
  sobel = opencv.getSnapshot();
  
  textureMode(NORMAL);
  fill(255);
  stroke(color(255,48,32));
}

void draw() {
  background(255);
  noStroke();
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty);
  scale(150);
  TexturedCube(original); // trocar a imagem do cubo (original/canny/sobel)
}

void TexturedCube(PImage img) {
  beginShape(QUADS);
  texture(canny);

  // +Z "front" face
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1,  1,  1, 0, 0);
  vertex( 1,  1,  1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1,  1, 1, 1);
  vertex(-1, -1,  1, 0, 1);

  // +X "right" face
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  endShape();
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}
