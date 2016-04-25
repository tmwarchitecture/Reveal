class Piece {
  PVector origin;
  Cplane cplanes;
  BBox bbox;
  Sketch []sketches = new Sketch [numPartsMax]; 
  Operation []operations = new Operation [numPartsMax];
  int numParts;
  int []numPtsArray = new int [numPtsMax];
  color c1 = color(random(100, 250), random(100, 250), random(100, 250));
  float x0;
  float x1;
  float y0;
  float y1;
  float z0;
  float z1;

  Piece(PVector tempOrigin) {
    origin = new PVector(tempOrigin.x, tempOrigin.y, tempOrigin.z);
    numParts = int(random(5, numPartsMax));
    bbox = new BBox();
    x0=bbox.x0;
    x1=bbox.x1;
    y0=bbox.y0;
    y1=bbox.y1;
    z0=bbox.z0;
    z1=bbox.z1;
    cplanes = new Cplane(origin, numParts,x0,x1,y0,y1,z0,z1);
    for (int i = 0; i<numPartsMax; i++) {
      sketches[i] = new Sketch(cplanes.cps[i], x0, x1, y0, y1, c1);
      operations[i] = new Operation (sketches[i].pts, sketches[i].numPts, numParts, z0,z1);
    }
  }

  void update() {
    numParts = int(random(1, numPartsMax));
    bbox.update();
    x0=bbox.x0;
    x1=bbox.x1;
    y0=bbox.y0;
    y1=bbox.y1;
    z0=bbox.z0;
    z1=bbox.z1;
    cplanes.update(numParts,x0,x1,y0,y1,z0,z1);
    setNumPts();
    for (int i = 0; i<numParts; i++) {
      sketches[i].update(cplanes.cps[i], x0, x1, y0, y1, numPtsArray[i]);
      operations[i].update(sketches[i].ptsOriented, sketches[i].numPts, numParts, z0,z1);
    }

    //Duplicate some shapes
    sketches[1].inherit(sketches[0].getPoints());
  }

  void display() {
    //cplanes.display();
    fill(c1);
    stroke(0);
    for (int i = 0; i<numParts; i++) {
      //sketches[i].display();
      operations[i].display();
      //bbox.display();
    }
  }

  void setNumPts() {
    int numPtsType = int (random(0, 3));
    int firstNum = int(random(3, numPtsMax));
    int weirdIndex = int(random(0, numPartsMax));
    //numPtsType = 2;
    if (numPtsType==0) {//random number
      for (int i = 0; i <numPtsMax; i++) {
        numPtsArray[i] = int(random(3, numPtsMax));
      }
    }
    if (numPtsType==1) {//one random number
      for (int i = 0; i <numPtsMax; i++) {
        numPtsArray[i] = firstNum;
      }
    }
    if (numPtsType==2) {//one strange number
      for (int i = 0; i <numPtsMax; i++) {
        numPtsArray[i] = firstNum;
      }
      numPtsArray[weirdIndex]=int(random(3, numPtsMax));
    }
  }
}

