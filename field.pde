class Field {
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  boolean[][] adj;
  Node active;
  boolean[] freeNum;

  Field() {
    nodes = new ArrayList<Node>();
    edges = new ArrayList<Edge>();
    adj = new boolean[maxn][maxn];
    active = null;
    freeNum = new boolean[maxn];
  }

  void create() {
    //find a free number
    int ind = 1;
    for (int i = 1; i < maxn; i++)
      if (!freeNum[i]) {
        ind = i;
        break;
      }
    Node n = new Node(Node_rad, ind);
    freeNum[ind] = true;
    nodes.add(n);
  }

  void clearNodeUsage() {
    for (Node n : nodes)
      n.used = 0;
  }

  void visEdges() {
    for (Edge e : edges)
      e.visible = true;
  }

  void relate() {
    for (Node n1 : nodes)
      for (Node n2 : nodes) 
        if (n1 != n2) {
          //for every 2 distinct nodes separate them
          boolean e = adj[n1.num][n2.num];
          PVector f = n1.relate(n2, e);
          n1.appForce(f);
          n2.appForce(f.mult(-1));
        }

    //separate every node from edges
    for (Node n : nodes) {
      //don't let nodes to escape the box
      if (n.pos.x < n.r)
        n.pos.x = n.r;
      if (n.pos.y < n.r)
        n.pos.y = n.r;
      if (n.pos.x > W - n.r)
        n.pos.x = W - n.r;
      if (n.pos.y > W - n.r)
        n.pos.y = W - n.r;
    }
  }

  void update() {
    for (Edge e : edges)
      e.show();
    for (Node n : nodes) {
      n.show();
      n.move();
    }
    relate();
  }

  void consLogEdges() {
    for (Edge e : edges) 
      println(e.A.num + " " + e.B.num);  
    println();
  }

  Node checkOverlap() {
    for (Node n : nodes)
      if (dist(mouseX, mouseY, n.pos.x, n.pos.y) < Node_rad) {
        return n;
      }
    return null;
  }
}