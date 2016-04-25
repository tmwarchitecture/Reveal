class Operation {
  PVector[]opPts = new PVector[numPtsMax];
  int numPts;
  int numParts;
  float exHeight;
  float z0, z1;


  Operation(PVector[]tempPts, int tempNumPts, int tempNumParts, float tempz0, float tempz1) {
    numPts = tempNumPts;
    numParts = tempNumParts;
    z0 = tempz0;
    z1 = tempz1;
    //copy tempPts to opPts
    for (int j = 0; j<numPtsMax; j++) {
      opPts[j] = new PVector(tempPts[j].x, tempPts[j].y, tempPts[j].z);
    }
  }


  void update(PVector[]tempPts, int tempNumPts, int tempNumParts, float tempz0, float tempz1) {
    numPts = tempNumPts;
    numParts = tempNumParts;
    z0 = tempz0;
    z1 = tempz1;
    for (int j = 0; j<numPts; j++) {
      opPts[j].x = tempPts[j].x;
      opPts[j].y = tempPts[j].y;
      opPts[j].z = tempPts[j].z;
    }
  }


  void display() {
    //extrude(opPts, z1);
    extrudeEven(opPts, z1);
  }


  void extrude(PVector []tempPts, float tempExHeight) {
    //CAP BOTTOM
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z);
    }

    //SIDES
    endShape(CLOSE);
    for (int i = 0; i<numPts-1; i++) {
      beginShape();
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z);
      vertex(tempPts[i+1].x, tempPts[i+1].y, tempPts[i+1].z);
      vertex(tempPts[i+1].x, tempPts[i+1].y, tempPts[i+1].z+z1);
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z+z1);
      endShape(CLOSE);
    }

    beginShape();
    vertex(tempPts[numPts-1].x, tempPts[numPts-1].y, tempPts[numPts-1].z);
    vertex(tempPts[0].x, tempPts[0].y, tempPts[0].z);
    vertex(tempPts[0].x, tempPts[0].y, tempPts[0].z+z1);
    vertex(tempPts[numPts-1].x, tempPts[numPts-1].y, tempPts[numPts-1].z+z1);
    endShape();

    //CAP TOP
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z+z1);
    }
    endShape(CLOSE);
  }
  
  
  void extrudeEven(PVector []tempPts, float tempz1) {
    float exStep = tempz1/numParts;
    
    //CAP BOTTOM
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z);
    }

    //SIDES
    endShape(CLOSE);
    for (int i = 0; i<numPts-1; i++) {
      beginShape();
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z);
      vertex(tempPts[i+1].x, tempPts[i+1].y, tempPts[i+1].z);
      vertex(tempPts[i+1].x, tempPts[i+1].y, tempPts[i+1].z+exStep);
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z+exStep);
      endShape(CLOSE);
    }

    beginShape();
    vertex(tempPts[numPts-1].x, tempPts[numPts-1].y, tempPts[numPts-1].z);
    vertex(tempPts[0].x, tempPts[0].y, tempPts[0].z);
    vertex(tempPts[0].x, tempPts[0].y, tempPts[0].z+exStep);
    vertex(tempPts[numPts-1].x, tempPts[numPts-1].y, tempPts[numPts-1].z+exStep);
    endShape();

    //CAP TOP
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z+exStep);
    }
    endShape(CLOSE);
  }
}

