int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int SPRINGF = 4;
int COLLISIONS = 5;
int GRAVSIM = 0;
boolean[] toggles = new boolean[6];
boolean[] sims = new boolean[5];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Spring", "Collisions"};
String[] sim = {"Gravity", "Spring", "Drag", "Electrostatic_Force", "Combo"};

FixedOrb earth;
FixedOrb sun;

OrbList slinky;
OrbList planets;

void setup() {
  size(600, 600);

  earth = new FixedOrb(width/2, height * 200, 1, 20000);

  slinky = new OrbList();
  slinky.populate(NUM_ORBS, true);
}//setup

void draw() {
  background(255);
  displayMode();

  slinky.display();
  
  if (sims[GRAVSIM]) {
    sun.display();
    
    slinky.applyGravity(sun, GRAVITY);
  }

  if (toggles[MOVING]) {
    
    //if (toggles[SPRINGF]) {
    slinky.applySprings(SPRING_LENGTH, SPRING_K);
    //slinky.applyforce(slinky.getSpring(slinky, SPRING_LENGTH, SPRING_K));
  //  }

    if (toggles[GRAVITY]) {
      slinky.applyGravity(earth, GRAVITY);
    }
    slinky.run(toggles[BOUNCE]);
  }//moving
}//draw

void mousePressed() {
  OrbNode selected = slinky.getSelected(mouseX, mouseY);
  if (selected != null) {
    slinky.removeNode(selected);
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') { toggles[MOVING] = !toggles[MOVING]; }
  if (key == 'g') { toggles[GRAVITY] = !toggles[GRAVITY]; }
  if (key == 'b') { toggles[BOUNCE] = !toggles[BOUNCE]; }
  if (key == 'd') { toggles[DRAGF] = !toggles[DRAGF]; }
  if (key == 's') { toggles[SPRINGF] = !toggles[SPRINGF]; }
  if (key == 'c') { toggles[COLLISIONS] = !toggles[COLLISIONS]; }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
  }
  if (key == '-') {
    slinky.removeFront();
  }
  if (key == '1') {
    slinky.populate(NUM_ORBS, true);
  }
  if (key == '2') {
    slinky.populate(NUM_ORBS, false);
  }
  if (key == '3') {
    sims[GRAVSIM] = !sims[GRAVSIM];
    displayMode();
    sun = new FixedOrb(width/2, height / 2, 50, 20000);
    Orb planet = new Orb(random(0, width), random(0,height), 20, 10);
    planets.populate(8, true);
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;
  int y = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) { fill(0, 255, 0); }
    else { fill(255, 0, 0); }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
  for (int p=0; p<sims.length; p++) {
    //set box color
    if (sims[p]) { fill(0, 255, 0); }
    else { fill(255, 0, 0); }

    float l = textWidth(sim[p]);
    rect(y, 20, l+5, 20);
    fill(0);
    text(sim[p], y+2,22);
    y+= l+5;
  }
}//display
