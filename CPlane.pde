class Cplane {
  PVector[]cps = new PVector[numPartsMax];
  PVector[]cpsOriginal = new PVector[numPartsMax];
  int numCplanes;
  int CplaneTrait;
  float x0, x1, y0, y1, z0, z1;

  Cplane(PVector tempCplane, int tempNumCplanes, float tempx0, float tempx1, float tempy0, float tempy1, float tempz0, float tempz1) {
    numCplanes = tempNumCplanes;
    x0=tempx0;
    x1=tempx1;
    y0=tempy0;
    y1=tempy1;
    z0=tempz0;
    z1=tempz1;

    for (int i = 0; i<numPartsMax; i++) {
      cps[i] = new PVector(tempCplane.x, tempCplane.y, tempCplane.z);
      cpsOriginal[i] = new PVector(tempCplane.x, tempCplane.y, tempCplane.z);
    }
  }

  void update(int tempNumCplanes, float tempx0, float tempx1, float tempy0, float tempy1, float tempz0, float tempz1) {
    numCplanes = tempNumCplanes;
    x0=tempx0;
    x1=tempx1;
    y0=tempy0;
    y1=tempy1;
    z0=tempz0;
    z1=tempz1;
    CplaneTrait = int (random(0, 6));
    //CplaneTrait = 5;
    if (CplaneTrait==0) {
      cpRandomOrigin();
    }
    if (CplaneTrait==1) {
      cpVerticalRandom();
    }
    if (CplaneTrait==2) {
      cpVerticalEven();
    }
    if (CplaneTrait==3) {
      cpLinearArray();
    }
    if (CplaneTrait==4) {
      cpCircular();
    }
    if (CplaneTrait==5) {
      cpStack();
    }
    gravity();
    //cps=boundingBox2d(cps, 0, 20, 0, 20);
    keepOnStage();
  }

  void display() {
    for (int i = 0; i<numCplanes; i++) {
      displayAxis(cps[i]);
    }
  }

  void displayAxis(PVector cp_origin) {
    int cp_axisSize=15;
    stroke(255, 0, 0);
    line(cp_origin.x+cp_axisSize, cp_origin.y, cp_origin.z, cp_origin.x, cp_origin.y, cp_origin.z);
    stroke(0, 255, 0);
    line(cp_origin.x, cp_origin.y+cp_axisSize, cp_origin.z, cp_origin.x, cp_origin.y, cp_origin.z);
    stroke(0, 0, 255);
    line(cp_origin.x, cp_origin.y, cp_origin.z, cp_origin.x, cp_origin.y, cp_origin.z+cp_axisSize);
  }

  void cpRandomOrigin() {
    for (int i = 0; i<numPartsMax; i++) {
      cps[i].x = cpsOriginal[i].x + random(stageSize/2)+stageSize/4;
      cps[i].y = cpsOriginal[i].y + random(stageSize/2)+stageSize/4;
      cps[i].z = cpsOriginal[i].z + random(stageSize/2);
    }
  }

  void cpVerticalRandom () {
    float tempX, tempY, tempZ;
    for (int i = 0; i<numPartsMax; i++) {

      tempX = stageSize/2;
      tempY = stageSize/2;
      tempZ = random(stageSize);

      cps[i].x = cpsOriginal[i].x+ tempX;
      cps[i].y = cpsOriginal[i].y+ tempY;
      cps[i].z = cpsOriginal[i].z + tempZ;
    }
  }

  void cpVerticalEven () {
    float tempX, tempY, tempZ;
    for (int i = 0; i<numPartsMax; i++) {

      tempX = stageSize/2;
      tempY = stageSize/2;
      tempZ = i*20;

      cps[i].x = cpsOriginal[i].x+ tempX;
      cps[i].y = cpsOriginal[i].y+ tempY;
      cps[i].z = cpsOriginal[i].z + tempZ;
    }
  }

  void cpCircular () {
    float tempX, tempY, tempZ;
    float radius = random(stageSize*.2, stageSize*.3);
    for (int i = 0; i<numPartsMax; i++) {

      tempX = radius*cos(map(i, 0, numCplanes, 0, 2*PI))+(stageSize/2);
      tempY = radius*sin(map(i, 0, numCplanes, 0, 2*PI))+(stageSize/2);
      tempZ = 0;

      cps[i].x = cpsOriginal[i].x+ tempX;
      cps[i].y = cpsOriginal[i].y+ tempY;
      cps[i].z = cpsOriginal[i].z + tempZ;
    }
  }

  void cpLinearArray() {
    float tempX, tempY, tempZ;
    int temp1=int(random(2));
    int temp2=int(random(2));
    PVector dir = new PVector(random(stageSize/4), random(stageSize/4), random(stageSize/4));
    for (int i = 0; i<numPartsMax; i++) {
      if (temp1==0) {
        tempX = (i+1)*dir.x;
      } else {
        tempX = random(stageSize*.25, stageSize*.75);
      }
      if (temp2==0) {
        tempY = (i+1)*dir.y;
      } else {
        tempY=random(stageSize*.25, stageSize*.75);
      }
      tempZ = 0;

      cps[i].x = cpsOriginal[i].x+ tempX;
      cps[i].y = cpsOriginal[i].y+ tempY;
      cps[i].z = cpsOriginal[i].z + tempZ;
    }
  }

  void cpStack() {
    float tempZ= (z1-z0)/numCplanes;

    for (int i = 0; i<numCplanes; i++) {

      cps[i].x = cpsOriginal[i].x;
      cps[i].y = cpsOriginal[i].y;
      cps[i].z = cpsOriginal[i].z + (tempZ*i);
    }
  }

  void gravity() {
    boolean Grounded = false;
    for (int i = 0; i<numCplanes; i++) {
      if (cps[i].z==0) {
        Grounded = true;
      }
    }
    if (!Grounded) {
      cps[0].z = 0;
    }
  }

  void keepOnStage() {
    for (int i = 0; i<numCplanes; i++) {
      if (cps[i].x>=cpsOriginal[i].x+stageSize) {
        cps[i].x = cpsOriginal[i].x+random(stageSize);
      }
      if (cps[i].y>=cpsOriginal[i].y+stageSize) {
        cps[i].y = cpsOriginal[i].y+random(stageSize);
      }
    }
  }
}

