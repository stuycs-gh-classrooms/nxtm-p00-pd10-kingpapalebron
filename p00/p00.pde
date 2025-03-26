int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;
float K_CONSTANT = 1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int SPRING = 3;
int DRAGF = 4;
int FIELD = 5;

boolean[] toggles = new boolean[6];
String[] modes = {"Moving", "Bounce", "Gravity", "Spring", "Drag", "Field"};

String simulation = "Gravity";

FixedOrb earth;
FixedOrb sourceCharge;

OrbList slinky;

void setup() {
  size(600, 600);

  earth = new FixedOrb(width/2, height * 200, 1, 20000);
  sourceCharge = new FixedOrb(width/2, height/2,
      random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));

  slinky = new OrbList();
  slinky.populate(NUM_ORBS, true);
}//setup

void draw() {
  background(255);
  displayMode();
  textSize(30);
  textAlign(RIGHT, TOP);
  stroke(0);
  text(simulation, width, 0);
  slinky.display();
  if (toggles[FIELD]) {
   sourceCharge.display(); 
  }

  if (simulation == "Gravity") {
    toggles[GRAVITY] = true;
    toggles[SPRING] = false;
    toggles[DRAGF] = false;
    toggles[FIELD] = false;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applyGravity(earth, G_CONSTANT);
    }
  }

  if (simulation == "Spring Force") {
    toggles[GRAVITY] = false;
    toggles[SPRING] = true;
    toggles[DRAGF] = false;
    toggles[FIELD] = false;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }
  }

  if (simulation == "Drag") {
    toggles[GRAVITY] = false;
    toggles[SPRING] = false;
    toggles[DRAGF] = true;
    toggles[FIELD] = false;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applyDrag(D_COEF);
    }
  }

  if (simulation == "Field Force") {
    toggles[GRAVITY] = false;
    toggles[SPRING] = false;
    toggles[DRAGF] = false;
    toggles[FIELD] = true;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applyElectricForce(sourceCharge, K_CONSTANT);
    }
  }

  if (simulation == "Combination") {
    toggles[GRAVITY] = true;
    toggles[SPRING] = true;
    toggles[DRAGF] = true;
    toggles[FIELD] = true;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applyGravity(earth, G_CONSTANT);
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
      slinky.applyDrag(D_COEF);
    }
  }
}//draw

void mousePressed() {
  OrbNode selected = slinky.getSelected(mouseX, mouseY);
  if (selected != null) {
    slinky.removeNode(selected);
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == 'b') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
  }
  if (key == '-') {
    slinky.removeFront();
  }
  if (key == '1') {
    simulation = "Gravity";
  }
  if (key == '2') {
    simulation = "Spring Force";
  }
  if (key == '3') {
    simulation = "Drag";
  }
  if (key == '4') {
    simulation = "Field Force";
  }
  if (key == '5') {
    simulation = "Combination";
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display
