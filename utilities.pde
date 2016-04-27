void mousePressed() {
  updateBoo = true;
}

void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}

float [] series(float start, float step, int finalCount) {
  float[]numbers=new float[finalCount];
  for (int i=0; i<finalCount; i++) {
    numbers[i] = (i*step)+start;
  }
  return numbers;
}

void fog() {
  noStroke();
  pushMatrix();
  translate((stageSize*numPiecesX)/2+mouseX, (stageSize*numPiecesY)/2+35.0, mouseY);
  fill(255, 255, 255);
  sphere(300);
  fill(255, 255, 255, 200);
  sphere(200);
  fill(255, 255, 255, 100);
  sphere(100);
  popMatrix();
  stroke(0);
}
boolean isSelfIntersecting(PVector [] ptList, int tempNumPts) {
  boolean selfIntersecting = false;
  for (int i = 0; i<tempNumPts; i++) {
    for (int j = i+1; j<tempNumPts-1; j++) {
      selfIntersecting = segIntersection(ptList[i], ptList[i+1], ptList[j], ptList[j+1]);
      if (selfIntersecting) {
        break;
      }
    }
    if (selfIntersecting) {
      break;
    }
  } 
  if (!selfIntersecting) {
    for (int j = 0; j<tempNumPts-1; j++) {
      selfIntersecting = segIntersection(ptList[tempNumPts-1], ptList[0], ptList[j], ptList[j+1]);
      if (selfIntersecting) {
        break;
      }
    }
  }
  return selfIntersecting;
}


boolean segIntersection(PVector pt1, PVector pt2, PVector pt3, PVector pt4) 
{     
  float x1=pt1.x;
  float y1=pt1.y;
  float x2=pt2.x;
  float y2=pt2.y;
  float x3=pt3.x;
  float y3=pt3.y;
  float x4=pt4.x;
  float y4=pt4.y;

  boolean toggle = false;  
  float bx = x2 - x1; 
  float by = y2 - y1; 
  float dx = x4 - x3; 
  float dy = y4 - y3;
  float b_dot_d_perp = bx * dy - by * dx;
  float cx = x3 - x1;
  float cy = y3 - y1;
  float t = (cx * dy - cy * dx) / b_dot_d_perp;
  float u = (cx * by - cy * bx) / b_dot_d_perp;
  if (u>0 && u<1 && t>0 && t<1) { 
    toggle= true;
  } 
  return toggle;
}

PVector[] boundingBox2d(PVector[] tempArray, float x0, float x1, float y0, float y1, int tempNumPts) {
  //remap array of PVectors to a given domain
  float minX=999;
  float minY=999;
  float minZ=999;
  float maxX=0;
  float maxY=0;
  float maxZ=0;
  //float []tempX = new float[numPartsMax];
  for (int i = 0; i<tempNumPts; i++) {
    //tempX[i]=0;
    if (tempArray[i].x<minX) {
      minX = tempArray[i].x;
    }
    if (tempArray[i].y<minY) {
      minY = tempArray[i].y;
    }
    if (tempArray[i].z<minZ) {
      minZ = tempArray[i].z;
    }
    if (tempArray[i].x>maxX) {
      maxX = tempArray[i].x;
    }
    if (tempArray[i].y>maxY) {
      maxY = tempArray[i].y;
    }
    if (tempArray[i].z>maxZ) {
      maxZ = tempArray[i].z;
    }
  }
  for (int i = 0; i<tempNumPts; i++) {
    //tempArray[i].x = map(tempArray[i].x, minX, maxX, x0, x1);
    //tempArray[i].y = map(tempArray[i].y, minY, maxY, y0, y1);
  }
  return tempArray;
}

/* 
 * Draw a dashed line with given set of dashes and gap lengths. 
 * x0 starting x-coordinate of line. 
 * y0 starting y-coordinate of line. 
 * x1 ending x-coordinate of line. 
 * y1 ending y-coordinate of line. 
 * spacing array giving lengths of dashes and gaps in pixels; 
 *  an array with values {5, 3, 9, 4} will draw a line with a 
 *  5-pixel dash, 3-pixel gap, 9-pixel dash, and 4-pixel gap. 
 *  if the array has an odd number of entries, the values are 
 *  recycled, so an array of {5, 3, 2} will draw a line with a 
 *  5-pixel dash, 3-pixel gap, 2-pixel dash, 5-pixel gap, 
 *  3-pixel dash, and 2-pixel gap, then repeat. 
 */ 
void dashline(float x0, float y0, float x1, float y1, float[ ] spacing) 
{ 
  float distance = dist(x0, y0, x1, y1); 
  float [ ] xSpacing = new float[spacing.length]; 
  float [ ] ySpacing = new float[spacing.length]; 
  float drawn = 0.0;  // amount of distance drawn 
 
  if (distance > 0) 
  { 
    int i; 
    boolean drawLine = true; // alternate between dashes and gaps 
 
    /* 
      Figure out x and y distances for each of the spacing values 
      I decided to trade memory for time; I'd rather allocate 
      a few dozen bytes than have to do a calculation every time 
      I draw. 
    */ 
    for (i = 0; i < spacing.length; i++) 
    { 
      xSpacing[i] = lerp(0, (x1 - x0), spacing[i] / distance); 
      ySpacing[i] = lerp(0, (y1 - y0), spacing[i] / distance); 
    } 
 
    i = 0; 
    while (drawn < distance) 
    { 
      if (drawLine) 
      { 
        line(x0, y0, x0 + xSpacing[i], y0 + ySpacing[i]); 
      } 
      x0 += xSpacing[i]; 
      y0 += ySpacing[i]; 
      /* Add distance "drawn" by this line or gap */ 
      drawn = drawn + mag(xSpacing[i], ySpacing[i]); 
      i = (i + 1) % spacing.length;  // cycle through array 
      drawLine = !drawLine;  // switch between dash and gap 
    } 
  } 
} 

