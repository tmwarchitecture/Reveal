class BBox {
  float x0;
  float x1;
  float y0;
  float y1;
  float z0;
  float z1;

  BBox() {
    smallSize();
  }

  void update() {
    randomSize();
    //smallSize();
    //print("   x0:"+x0+" x1:"+x1);
  }
  
  void display(){
    //box(x1-x0,y1.y0,z1-z0);
  }

  void randomSize() {
    float end = stageSize*.5;
    float beginning = stageSize *.1;
    x0 = beginning;
    x1 = random(beginning, end);
    y0 = beginning;
    y1 = random(beginning, end);
    z0 = 0;
    z1 = random(beginning, end);
  }
  void smallSize() {
    x0 = 0;
    x1 = 10;
    y0 = 0;
    y1 = 50;
    z0 = 0;
    z1 = 100;
  }
}

