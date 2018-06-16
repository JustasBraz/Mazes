public class newLine {
  public PVector start, end;
  newLine(PVector Start, PVector End) {
    this.start= new PVector(Start.x, Start.y, Start.z);
    this.end = new PVector(End.x, End.y, End.z);
  }

  void show(float stroke_, color c) {
    strokeWeight(stroke_);
    stroke(c);
    line(start.x, start.y, start.z, end.x, end.y, end.z);
  }

  void showPoints(float stroke_, color c) {
    strokeWeight(stroke_);
    stroke(c);
    point(start.x, start.y, start.z);
    point(end.x, end.y, end.z);
  }
}