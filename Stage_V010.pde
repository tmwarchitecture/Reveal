// import processing.dxf.*;
// import peasy.*;
// PeasyCam cam;

int stageSize = 100;
int numPiecesX = 2; 
int numPiecesY = 2;
int numPiecesZ = 1;
int numPtsMax = 9;
int numPieces = numPiecesX*numPiecesY*numPiecesZ;
int numPartsMax = 6;
int step = 0;
boolean updateBoo = true;
boolean record = false;
PFont font;
Stage stages;
Piece[] pieces = new Piece [numPieces];


void setup() {
  size(displayWidth, displayHeight, P3D);
    if (frame != null) {
    frame.setResizable(true);
  }
  
  smooth();
  font = loadFont("SansSerif-48.vlw");
  textFont(font, 6);
  stages = new Stage(numPiecesX, numPiecesY, numPiecesZ, stageSize); 

  for (int i = 0; i<numPieces; i++) {
    pieces[i] = new Piece(stages.stageOrigin[i]);
  }
}


void draw() {
  directionalLight(126, 126, 126, 0, -1, -1);
  ambientLight(102, 105, 250);
  step++;
  if (record) {
    beginRaw(DXF, "output.dxf");
  }
  background(100);
  camera(mouseX*cos(map(step,0,1000,0,2*PI))+((stageSize*numPiecesX)/2), mouseX*sin(map(step,0,1000,0,2*PI))+((stageSize*numPiecesY)/2), mouseY, (stageSize*numPiecesX)/2, (stageSize*numPiecesY)/2,stageSize, 0.0, 0, -1.0);

  if (updateBoo) {
    for (int i = 0; i<numPieces; i++) {
      pieces[i].update();
    }
    updateBoo = false;
  }

  stages.display();


  if (record) {
    endRaw();
    record = false;
  }
  for (int i = 0; i<numPieces; i++) {
    pieces[i].display();
  }
  if (step>1000){
   step = 0; 
  }

  //fog();
}

