class Operation {
  PVector[]opPts = new PVector[numPtsMax];
  int numPts;
  int numParts;
  float exHeight;
  float z0, z1;
  int opType;
  float scaleFactor;


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
    opType = int(random(0, 2));
    scaleFactor = random(0,2);
    z0 = tempz0;
    z1 = tempz1;
    for (int j = 0; j<numPts; j++) {
      opPts[j].x = tempPts[j].x;
      opPts[j].y = tempPts[j].y;
      opPts[j].z = tempPts[j].z;
    }
  }


  void display() {
    noStroke();
    //extrude(opPts, z1);
    if (opType==0) {
      extrudeEven(opPts, z1);
    }
    if (opType==1) {
      extrudeEvenTapered(opPts, z1, scaleFactor);
    }
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

  void extrudeEvenTapered(PVector []tempPts, float tempz1, float scalef) {
    float exStep = tempz1/numParts;
    PVector [] tempPtsTop = new PVector [numPtsMax];
    PVector ctrPt = new PVector(0, 0, 0);
    float avgX = 0;
    float avgY = 0;
    float avgZ = 0;
    for (int i = 0; i<numPtsMax; i++) {
      tempPtsTop[i] = tempPts[i].get();
    } 
    for (int i = 0; i<numPts; i++) {
      avgX = avgX+tempPtsTop[i].x;
      avgY = avgY+tempPtsTop[i].y;
      avgZ = avgZ+tempPtsTop[i].z;
    }
    ctrPt.set(avgX/numPts, avgY/numPts, avgZ/numPts);//ctrPt is average of PVector list
    for (int i = 0; i<numPts; i++) {
      float tempDistX, tempDistY, tempDistZ;
      tempDistX =scalef*(ctrPt.x-tempPtsTop[i].x);
      tempDistY =scalef*(ctrPt.y-tempPtsTop[i].y);
      tempDistZ =scalef*(ctrPt.z-tempPtsTop[i].z);

      tempPtsTop[i].set(ctrPt.x-tempDistX, ctrPt.y-tempDistY, ctrPt.z-tempDistZ);
    }   

    //CAP BOTTOM
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z);
    }

    for (int i = 0; i<numPts; i++) {
      //tempPts[i];
    } 

    //SIDES
    endShape(CLOSE);
    for (int i = 0; i<numPts-1; i++) {
      beginShape();
      vertex(tempPts[i].x, tempPts[i].y, tempPts[i].z);
      vertex(tempPts[i+1].x, tempPts[i+1].y, tempPts[i+1].z);
      vertex(tempPtsTop[i+1].x, tempPtsTop[i+1].y, tempPtsTop[i+1].z+exStep);
      vertex(tempPtsTop[i].x, tempPtsTop[i].y, tempPtsTop[i].z+exStep);
      endShape(CLOSE);
    }

    beginShape();
    vertex(tempPts[numPts-1].x, tempPts[numPts-1].y, tempPts[numPts-1].z);
    vertex(tempPts[0].x, tempPts[0].y, tempPts[0].z);
    vertex(tempPtsTop[0].x, tempPtsTop[0].y, tempPtsTop[0].z+exStep);
    vertex(tempPtsTop[numPts-1].x, tempPtsTop[numPts-1].y, tempPtsTop[numPts-1].z+exStep);
    endShape();

    //CAP TOP
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(tempPtsTop[i].x, tempPtsTop[i].y, tempPtsTop[i].z+exStep);
    }
    endShape(CLOSE);
  }
}
