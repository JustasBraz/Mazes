class wavyLine {

  int posStart;
  int posFinish;
  int colorR, colorB, colorG;
  float strWeight;
  int xOffset;
  int yOffset;
  int movSpeed;
  int step_=0;
  int step=0;

  wavyLine(int xloc, int zloc, int xOff, int yOff) {
    posStart=xloc;
    posFinish=zloc;
    xOffset=xOff;
    yOffset=yOff;

    colorR=(int)random(0, 255);
    colorG=(int)random(0, 255);
    colorB=(int)random(0, 255);
    strWeight=random(1, 7);
    movSpeed=(int)random(-5, 5);
    if (movSpeed==0) {
      movSpeed=5;
    }
  }


  void music() {
    if ((movSpeed>0)&&(step>-40)&&(step<40)) {//&&(step>10)&&(step<20)
      in.play();
    }

    if ((movSpeed<0)&&(step>-40)&&(step<40)) {//&&(step>10)&&(step<20)
      out.play();
    }
  }

  void show() {
    noFill();
    stroke(colorR, colorG, colorB);
    strokeWeight(strWeight);
    beginShape();
    for (int l=0; l<20; l++) {
      vertex(xOffset, yOffset+((posStart*cos(step_))/20), (posFinish+l+step));
      step_+=movSpeed;
    }
    endShape();
    //println(step);

    if (step>500) {
      step=-500;
    }

    if (step<-1001) {
      step=500;
    } else {
      step+=movSpeed*10;
    }
  }
}