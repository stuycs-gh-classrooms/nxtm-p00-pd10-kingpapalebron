class OrbList {

  OrbNode front;

  OrbList() {
    front = null;
  }//constructor

  void addFront(OrbNode o) {
    if (front == null) {
      front = o;
    } else {
      o.next = front;
      front.previous = o;
      front = o;
    }
  }//addFront

  void populate(int n, boolean ordered) {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      OrbNode nextOrb = currentOrb.next;
      currentOrb.previous = null;
      currentOrb = nextOrb;
    }
    front = null;
    int OrbY = height / 2;
    front = new OrbNode(width/n + SPRING_LENGTH,
      OrbY, random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
    OrbNode previousOrb = front;
    for (int i = 1; i < n; i++) {
      float size = random(MIN_SIZE, MAX_SIZE);
      float mass = random(MIN_MASS, MAX_MASS);
      OrbNode newOrb;
      if (ordered) {
        newOrb = new OrbNode(width/n + (SPRING_LENGTH * (i+1)),
          OrbY, size, mass);
      } else {
        newOrb = new OrbNode(random(width), random(height), size, mass);
      }
      previousOrb.next = newOrb;
      newOrb.previous = previousOrb;
      previousOrb = newOrb;
    }
  }//populate

  void display() {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      currentOrb.display();
      currentOrb = currentOrb.next;
    }
  }//display

  void applySprings(int springLength, float springK) {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      currentOrb.applySprings(springLength, springK);
      currentOrb = currentOrb.next;
    }
  }//applySprings

  void applyGravity(Orb other, float gConstant) {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      currentOrb.applyForce(currentOrb.getGravity(other, gConstant));
      currentOrb = currentOrb.next;
    }
  }//applySprings
  
  void applyDrag(float cd) {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      currentOrb.applyForce(currentOrb.getDragForce(cd));
      currentOrb = currentOrb.next;
    }
  }//applyDrag

  void run(boolean bounce) {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      currentOrb.move(bounce);
      currentOrb = currentOrb.next;
    }
  }//applySprings

  void removeFront() {
    if (front != null && front.next != null) {
     front = front.next;
     front.previous = null;
    }
  }//removeFront

  OrbNode getSelected(int x, int y) {
    OrbNode currentOrb = front;
    while (currentOrb != null) {
      if (currentOrb.isSelected(x, y)){
       return currentOrb; 
      }
      currentOrb = currentOrb.next;
    }
    return null;
  }//getSelected
  
  void removeNode(OrbNode o) {
    if (o == front) {
     front = o.next;
     if (front != null) {
      front.previous = null; 
     }
    }
    else {
     if (o.previous != null) {
      o.previous.next = o.next; 
     }
     if (o.next != null) {
      o.next.previous = o.previous; 
     }
    }
    o = null;
  }
}//OrbList
