class Sketch {
  PVector skCplane;
  PVector[]pts = new PVector [numPtsMax];
  PVector[]ptsOriented = new PVector [numPtsMax];
  int numPts;
  float sketchSize = 50;
  int sketchTrait;
  float x0, x1, y0, y1;
  color c1;

  Sketch(PVector tempCplane, float x0, float x1, float y0, float y1, color tempc1) {
    this.x0=x0;
    this.x1=x1;
    this.y0=y0;
    this.y1=y1;

    c1 =  color(tempc1);

    //copy tempCplanes to the skCplanes array
    skCplane = new PVector(tempCplane.x, tempCplane.y, tempCplane.z );

    //choose number of pts in each sketch
    numPts = numPtsMax;


    //initialize random points
    for (int i = 0; i<numPtsMax; i++) {
      pts[i] = new PVector(random(x0,x1), random(y0,y1), 0);
      ptsOriented[i] = new PVector(0, 0, 0);
    }
  }

  void update(PVector tempCplane, float x0, float x1, float y0, float y1, int newNumPts) {
    this.x0=x0;
    this.x1=x1;
    this.y0=y0;
    this.y1=y1;
    skCplane.x = tempCplane.x;
    skCplane.y = tempCplane.y;
    skCplane.z = tempCplane.z;
    //choose number of pts in each sketch
    numPts = newNumPts;

    //randomly place points
    boolean stillIntersecting = true;
    boolean looping = true;
    while (looping) {
      while (stillIntersecting) {
        sketchTrait = int (random(0, 3));
        //sketchTrait = 0;
        if (sketchTrait==0) {
          skRandom();
        }
        if (sketchTrait==1) {
          rectilinear();
        }
        if (sketchTrait==2) {
          symmetry();
        }
        stillIntersecting = isSelfIntersecting(pts, numPts);
      }
      if (int(random(0, 4))==1) {
        looping=false;
      }
    }


    pts=mapVectorArray(pts, x0, x1, y0, y1, numPts); //remap PVector to a domain

    //add pts to the skCplane array to get the final position
    for (int i = 0; i<numPts; i++) {
      ptsOriented[i].x = pts[i].x + skCplane.x;
      ptsOriented[i].y = pts[i].y + skCplane.y;
      ptsOriented[i].z = pts[i].z + skCplane.z;
    }
  }

  void display() {
    displaySketch();
    //superFormula();
  }

  void displaySketch() {
    fill(c1);
    stroke(0);
    beginShape();
    for (int i = 0; i<numPts; i++) {
      vertex(ptsOriented[i].x, ptsOriented[i].y, ptsOriented[i].z);
    }
    endShape(CLOSE);
    fill(0);
    for (int i = 0; i<numPts; i++) {
      text(i, ptsOriented[i].x, ptsOriented[i].y, ptsOriented[i].z+1);
    }
  }

  void inherit(PVector []tempArray) {
    for (int i = 0; i<numPtsMax; i++) {
      pts[i] = tempArray[i];
    }
  }

  PVector[] getPoints() {
    return pts;
  }

  void skRandom() {
    for (int i = 0; i<numPts; i++) {
      pts[i].x = random(x0,x1);
      pts[i].y = random(y0,y1);
      pts[i].z = 0;
    }
  }

  void rectilinear() {
    if (numPts%2!=0) {
      numPts = numPts-1;
    }
    for (int i = 0; i<numPts; i++) {
      if (i%2==0 && i!=0) { //even
        pts[i].y = pts[i-1].y;
      }
      if (i%2!=0) { //odd
        pts[i].x = pts[i-1].x;
      }
      if (i%2==0 && i!=0) { //even
        pts[numPtsMax-1].x=pts[0].x;
      }
      if (i%2!=0) { //odd
        pts[numPtsMax-1].y=pts[0].y;
      }
      if (i==numPts-1) {
        pts[i].y=pts[0].y;
      }
    }
  }

  void symmetry() {
    int tempNumPts = numPts;
    float mirrorX = random((x1-x0)/2);
    for (int i = 0; i<tempNumPts; i++) {
      if (i==(tempNumPts/2)-1) {
        //mirrorX = pts[i].x;
      }
      if (i>(tempNumPts/2-1)) { //symmetry
        pts[i].x = (mirrorX - pts[((tempNumPts)-i)-1].x)+mirrorX;
        pts[i].y = pts[(tempNumPts-i-1)].y;
      }
    }
  }

  void superFormula() {

    int num = 60;
    float x, y, z;
    float r, th=0, step=.1, epi=200;
    float m = 1, n1=-1, n2=0, n3=0;
    float b=1, a=1;
    m=int(random(3, 40));
    n1=random(.5);
    n2=random(6.);
    //n3=random(6.);
    epi=random(100, 200);
    step=random(.05, 10);
    int numDetail = 60;
    beginShape();
    for (int i=1; i < numDetail; i++) {
      r = epi*pow(((pow(abs(cos(m*th/4)/a), n2))+(pow(abs(sin(m*th/4)/b), n3))), (-1/n1)); 
      th = th + step;
      x = r*cos(th);
      y = r*sin(th);
      curveVertex(x, y);
    }
    endShape();
  }
}

