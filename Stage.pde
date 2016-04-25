class Stage {
  int numStageX, numStageY, numStageZ;
  int StageSize;
  int bufferSize = 10;
  PVector [] stageOrigin;

  Stage(int tempNumStageX, int tempNumStageY, int tempNumStageZ, int tempStageSize) {
    numStageX = tempNumStageX;
    numStageY = tempNumStageY;
    numStageZ = tempNumStageZ;
    StageSize = tempStageSize;
    stageOrigin = new PVector [numPieces];

    float tempX = 0;
    float tempY = 0;
    float tempZ = 0;
    int colNum = 1;
    int rowNum = 1;

    //set all the origins in a 1-D array
    for (int i = 0; i<numPieces; i++) {
      tempY = (StageSize*rowNum)-StageSize;
      tempX = (StageSize*colNum)-StageSize;
      stageOrigin[i] =  new PVector(tempX, tempY, tempZ);
      rowNum++;
      if (rowNum>numStageY) {
        colNum = colNum+1;
        rowNum = 1;
      }
    }
  }

  void display() {
    //draw the stage to the screen;
    for (int i = 0; i<numPieces; i++) {
      //stageShape(stageOrigin[i].x, stageOrigin[i].y, stageOrigin[i].z, StageSize);
    }
    float []tempDash = new float[2];
    tempDash[0] = 5;
    tempDash[1] = 3;


    stroke(255);
    for (int i = 0; i<numPieces; i++) {

      dashline(stageOrigin[i].x, stageOrigin[i].y, stageOrigin[i].x, stageOrigin[i].y+StageSize, tempDash); 
      dashline(stageOrigin[i].x, stageOrigin[i].y+StageSize, stageOrigin[i].x+StageSize, stageOrigin[i].y+StageSize, tempDash); 
      dashline(stageOrigin[i].x+StageSize, stageOrigin[i].y+StageSize, stageOrigin[i].x+StageSize, stageOrigin[i].y, tempDash); 
      dashline(stageOrigin[i].x, stageOrigin[i].y,stageOrigin[i].x+StageSize, stageOrigin[i].y, tempDash);
    }
  }

  void stageShape(float tempX, float tempY, float tempZ, float tempSize) { 
    //Basically a rect for 3D
    noFill();
    //fill(255);
    stroke(255);
    beginShape();
    vertex(tempX, tempY, tempZ);
    vertex(tempX+tempSize, tempY, tempZ);
    vertex(tempX+tempSize, tempY+tempSize, tempZ);
    vertex(tempX, tempY+tempSize, tempZ);
    endShape(CLOSE);
  }

  //PVector origin(int stageNum) {
  //  return  stageOrigin[stageNum];
  //}
}

