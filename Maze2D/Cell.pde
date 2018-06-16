class Cell {
  int i, j;
  boolean [] walls;
  boolean visited;
  
  Cell (int c, int d){
   this.i = c;
   this.j = d;
   walls = new boolean[]{true, true, true, true};
   this.visited = false;
  }
  
    void show() {
    int x = this.i*w;
    int y = this.j*w;
    stroke(255);
    if (this.walls[0]) {
      line(x    , y    , x + w, y);
    }
    if (this.walls[1]) {
      line(x + w, y    , x + w, y + w);
    }
    if (this.walls[2]) {
      line(x + w, y + w, x    , y + w);
    }
    if (this.walls[3]) {
      line(x    , y + w, x    , y);
    }

    if (this.visited) {
      noStroke();
      fill(255, 0, 255, 100);
      rect(x, y, w, w);
    }
  }
  
  Cell checkNeighbors () {
    ArrayList <Cell> neighbors = new ArrayList<Cell>();

    Cell top    = grid.get(index(i, j -1));
    Cell right  = grid.get(index(i+1, j));
    Cell bottom = grid.get(index(i, j+1));
    Cell left   = grid.get(index(i-1, j));

    if (top!=null && !top.visited) {
      neighbors.add(top);
    }
    if (right!=null && !right.visited) {
      neighbors.add(right);
    }
    if (bottom!=null && !bottom.visited) {
      neighbors.add(bottom);
    }
    if (left!=null && !left.visited) {
      neighbors.add(left);
    }

    if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else {
      return null;
    }


  }
 

  void highlight() {
    int x = this.i*w;
    int y = j*w;
    noStroke();
    fill(0, 255, 25, 100);
    rect(x, y, w, w);

  }

}