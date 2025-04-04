int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 0.7;
float D_COEF = 1;
float K_CONSTANT = 8.99 * pow(10, 4);

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;

int MOVING = 0;
int BOUNCE = 1;
int ATTRACTION = 2;
int SPRING = 3;
int GRAVITY = 4;
int DRAGF = 5;
int FIELD = 6;

boolean[] toggles = new boolean[7];
String[] modes =
  {"Moving", "Bounce", "Attraction", "Spring", "Gravity", "Drag", "Field"};

String simulation = "Attraction";

FixedOrb earth;
FixedOrb sun;
FixedOrb sourceCharge;

OrbList slinky;
ArrayList<Orb> orbs = new ArrayList<Orb>(NUM_ORBS);

void setup() {
  size(600, 600);

  earth = new FixedOrb(width/2, height * 200, 1, 20000);
  sun = new FixedOrb(width/2, height/2, 100, 160);
  sun.c = color(255, 255, 102);

  slinky = new OrbList();
  createArray();
}//setup

void draw() {
  background(255);
  displayMode();
  textSize(30);
  textAlign(RIGHT, TOP);
  stroke(0);
  text(simulation, width, 0);
  if (simulation != "Attraction") {
    slinky.display();
  }
  if (toggles[FIELD]) {
    slinky.setChargeColor();
    sourceCharge.c = color(0, 0, 255);
    sourceCharge.display();
  }
  if (!toggles[FIELD]) {
    slinky.setColor();
  }

  if (toggles[ATTRACTION]) {
    sun.display();
  }

  if (simulation == "Attraction") {
    toggles[ATTRACTION] = true;
    //toggles[SPRING] = false;
    //toggles[GRAVITY] = false;
    //toggles[DRAGF] = false;
    toggles[FIELD] = false;
    for (int i = 0; i < orbs.size(); i++) {
      orbs.get(i).display();
    }
    if (toggles[MOVING]) {
      for (int i = 0; i < orbs.size(); i++) {
        orbs.get(i).move(toggles[BOUNCE]);
        orbs.get(i).applyForce(orbs.get(i).getGravity(sun, G_CONSTANT));
      }
    }
  }

  if (simulation == "Spring Force") {
    //toggles[ATTRACTION] = false;
    toggles[SPRING] = true;
    //toggles[GRAVITY] = false;
    //toggles[DRAGF] = false;
    toggles[FIELD] = false;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }
  }

  if (simulation == "Drag") {
    //toggles[ATTRACTION] = false;
    //toggles[SPRING] = false;
    toggles[DRAGF] = true;
    toggles[FIELD] = false;
    fill(0, 0, 255);
    rect(width/2, 0, width/2, height/2);
    fill(240, 230, 140);
    rect(0, height/2, width/2, height/2);
    textSize(30);
    textAlign(RIGHT, TOP);
    fill(0);
    text(simulation, width, 0);
    displayMode();
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      if (toggles[GRAVITY]) {
        slinky.applyGravity(earth, G_CONSTANT);
      }
      slinky.applyDrag(D_COEF);
    }
    slinky.display();
  }

  if (simulation == "Field Force") {
    //toggles[ATTRACTION] = false;
    //toggles[SPRING] = false;
    //toggles[GRAVITY] = false;
    //toggles[DRAGF] = false;
    toggles[FIELD] = true;
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      slinky.applyElectricForce(sourceCharge, K_CONSTANT);
    }
  }

  if (simulation == "Combination") {
    toggles[ATTRACTION] = true;
    toggles[SPRING] = true;
    toggles[DRAGF] = true;
    toggles[FIELD] = true;
    fill(0, 0, 255);
    rect(width/2, 0, width/2, height/2);
    fill(240, 230, 140);
    rect(0, height/2, width/2, height/2);
    textSize(30);
    textAlign(RIGHT, TOP);
    fill(0);
    text(simulation, width, 0);
    displayMode();
    if (toggles[MOVING]) {
      slinky.run(toggles[BOUNCE]);
      if (toggles[GRAVITY]) {
        slinky.applyGravity(earth, G_CONSTANT);
      }
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
      slinky.applyDrag(D_COEF);
    }
    slinky.display();
    sourceCharge.display();
  }
}//draw

void mousePressed() {
  OrbNode selected = slinky.getSelected(mouseX, mouseY);
  if (selected != null) {
    selected.charge *= -1;
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == 'b') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == 'g') {
    toggles[GRAVITY] =  !toggles[GRAVITY];
  }
  if (key == 's') {
    toggles[SPRING] = !toggles[SPRING];
  }
  if (key == 'd') {
    toggles[DRAGF] = !toggles[DRAGF];
  }
  if (key == 'a') {
    toggles[ATTRACTION] = !toggles[ATTRACTION];
  }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
    orbs.add(new Orb());
  }
  if (key == '-') {
    slinky.removeFront();
    orbs.remove(orbs.size());
  }
  if (key == '1') {
    simulation = "Attraction";
    for (int i = orbs.size() - 1; i>= 0; i--) {
      orbs.remove(i);
    }
    createArray();
  }
  if (key == '2') {
    simulation = "Spring Force";
    slinky.populate(NUM_ORBS, false);
  }
  if (key == '3') {
    simulation = "Drag";
    slinky.populate(NUM_ORBS, false);
    toggles[GRAVITY] = true;
  }
  if (key == '4') {
    simulation = "Field Force";
    slinky.populate(NUM_ORBS, false);
    sourceCharge = new FixedOrb(width/2, height/2,
      random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
  }
  if (key == '5') {
    simulation = "Combination";
    slinky.populate(NUM_ORBS, false);
    sourceCharge = new FixedOrb(width/2, height/2,
      random(MIN_SIZE, MAX_SIZE), random(MIN_MASS, MAX_MASS));
    toggles[GRAVITY] = true;
  }
}//keyPressed

void createArray() {
  for (int i = 0; i < NUM_ORBS/2 - 1; i++) {
    float size = random(MIN_SIZE, MAX_SIZE);
    float mass = random(MIN_MASS, MAX_MASS);
    orbs.add(new Orb(width/NUM_ORBS + (SPRING_LENGTH * (i+1)),
      random(height*0.25, height*0.75), size, mass));
  }
  orbs.add(sun);
  for (int i = NUM_ORBS/2; i < NUM_ORBS; i++) {
    float size = random(MIN_SIZE, MAX_SIZE);
    float mass = random(MIN_MASS, MAX_MASS);
    orbs.add(new Orb(width/NUM_ORBS + (SPRING_LENGTH * (i+1)),
      random(height*0.25, height*0.75), size, mass));
  }
}

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
