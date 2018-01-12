class Node {
  int r;
  PVector pos, vel, acc;
  boolean act;
  int num, used;
  Node parent;

  Node(int _r, int _num) {
    r = _r;
    pos = new PVector(mouseX, mouseY);
    vel = acc = new PVector(0, 0);
    act = false;
    num = _num;
    used = 0;
    parent = null;
  }

  void appForce(PVector force) {
    acc.add(force);
  }

  void move() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void show() {
    if (act) {
      strokeWeight(str_weight_out_node);
      stroke(out_Node_col);
    } else
      noStroke();
      
    fill(in_Node_col);
    if (this.used == 1)
      fill(used1_Node_col);
    else if (this.used == 2)
      fill(used2_Node_col);
      
    ellipse(pos.x, pos.y, r, r);
    fill(text_col);
    text(num, pos.x - text_size/2, pos.y + text_size/4);
  }
}