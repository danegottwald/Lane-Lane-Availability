
import controlP5.*;
import processing.serial.*;

// Debug Printing
public static final boolean DEBUG = false;

// Global Variables
Serial port;
ControlP5 cp5;
CheckBox checkbox;
PFont font, bFont;
public static final byte LANE_TIMES = 54, LANE_COUNT = 16;
byte lane = 0;
byte lanes[][] = new byte[LANE_COUNT][LANE_TIMES + 1];
String textVal = "Select Lane";
boolean startUp = true;
boolean copy = false;

// Sets up the GUI and Serial connection
void setup() {
  size(1050, 500);
  smooth();
  surface.setTitle("Lap Lane Availability");
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
  if (DEBUG) {
    println("Successfully connected to Port: " + Serial.list()[0]);
  }
  font = createFont("Calibri", 13);
  bFont = createFont("Calibri", 16);
  createMainMenu(); 
}

// Draws the GUI
void draw() {
  background(100, 100, 100);
  fill(0, 0, 0);
  textSize(40);
  textAlign(CENTER);
  text("Lap Lane Availability", 525, 50);
  textSize(30);
  text(textVal, 525, 250);
  if (startUp == false) {
    textAlign(LEFT);
    textSize(20);
    text("GREEN means OPENS at that time", 30, 440);
    text("RED means CLOSES at that time", 30, 480);
  }
}

// Create the buttons
void createMainMenu() {
  int buttonSize = 60;
  cp5 = new ControlP5(this);
  cp5.setFont(font);
  cp5.setColorActive(color(0, 155, 0));
  for (int i = 0; i < 8; i++) {
    cp5.addButton("Lane" + char(49+i)).setPosition(150 + (i*100), 75).setSize(buttonSize, 55);
  }
  cp5.addButton("Lane9").setPosition(150, 150).setSize(buttonSize, 55);
  for (int i = 0; i < 7; i++) {
    cp5.addButton("Lane1" + char(48+i)).setPosition(250 + (i*100), 150).setSize(buttonSize, 55);
  }
  timeCheckBoxes();
}

// Create the timeboxes
void timeCheckBoxes() { 
  checkbox = cp5.addCheckBox("checkbox")
    .showLabels()
    .setPosition(8, 275)
    .setSize(20, 20)
    .setItemsPerRow(18)
    .setSpacingColumn(38)
    .setSpacingRow(30)
    .setColorBackground(color(140, 0, 0))
    .addItem("05:30", 530) .addItem("05:45", 545) .addItem("06:00", 600) .addItem("06:15", 615) .addItem("06:30", 630)
    .addItem("06:45", 645) .addItem("07:00", 700) .addItem("07:15", 715) .addItem("07:30", 730) .addItem("07:45", 745)
    .addItem("08:00", 800) .addItem("08:15", 815) .addItem("08:30", 830) .addItem("08:45", 845) .addItem("09:00", 900)
    .addItem("09:15", 915) .addItem("09:30", 930) .addItem("09:45", 945) .addItem("10:00", 1000).addItem("10:15", 1015)
    .addItem("10:30", 1030).addItem("10:45", 1045).addItem("11:00", 1100).addItem("11:15", 1115).addItem("11:30", 1130)
    .addItem("11:45", 1145).addItem("12:00", 1200).addItem("12:15", 1215).addItem("12:30", 1230).addItem("12:45", 1245)
    .addItem("1:00", 1300) .addItem("1:15", 1315) .addItem("1:30", 1330) .addItem("1:45", 1345) .addItem("2:00", 1400)
    .addItem("2:15", 1415) .addItem("2:30", 1430) .addItem("2:45", 1445) .addItem("3:00", 1500) .addItem("3:15", 1515)
    .addItem("3:30", 1530) .addItem("3:45", 1545) .addItem("4:00", 1600) .addItem("4:15", 1645) .addItem("4:30", 1630)
    .addItem("4:45", 1645) .addItem("5:00", 1700) .addItem("5:15", 1715) .addItem("5:30", 1730) .addItem("5:45", 1745)
    .addItem("6:00", 1800) .addItem("6:15", 1815) .addItem("6:30", 1830) .addItem("6:45", 1845);
    checkbox.setColorLabels(color(255, 255, 255));
    checkbox.setColorActive(color(0, 155, 0));
    checkbox.hide();
}

// Create extra buttons
void extraButtons() {
  checkbox.show();
  cp5.addButton("All").setPosition(20, 225).setSize(30, 25);
  cp5.addButton("Clear").setPosition(60, 225).setSize(50, 25);  
  cp5.addButton("Copy").setPosition(120, 225).setSize(40, 25);
  cp5.addButton("Saturday").setPosition(170, 225).setSize(80, 25);
  cp5.addButton("Sunday").setPosition(260, 225).setSize(70, 25);
  cp5.addButton("Submit").setPosition(460, 425).setSize(130, 50);
}

void controlEvent(ControlEvent theEvent) {
  if (startUp == true && theEvent.isController()) {
    startUp = false;
    extraButtons();
  }
}

// Activate the checkboxes according the the values in arr[]
void activateBoxes(byte arr[]) {
  for (int i = 0; i < LANE_TIMES; i++) {
    if (arr[i + 1] != 0) {
      checkbox.activate(i);
    }
  }
}

/*--------Button Functions (Unique for each button)--------*/

// Submit checkboxes to change lights
void Submit() {
  if (DEBUG) {
    println("\n" + "Lane: " + lane);
  }
  lanes[lane - 1][0] = lane;
  for(int i = 0; i < LANE_TIMES; i++) {
    lanes[lane - 1][i + 1] = byte(checkbox.getState(i));
    if (DEBUG) {
      print(byte(checkbox.getState(i)) + ", ");
      if ((i+1) % 18 == 0) { 
        println();
      }
    }
  }
  port.write(lanes[lane - 1]);
  if (DEBUG) {
    println("Lane " + lane + " submitted.");
  }
}

// Activates all checkboxes
void All() {
  if (textVal != "Select Lane") {
    checkbox.activateAll();
  }
}

// Deactivates all checkboxes
void Clear() {
  checkbox.deactivateAll();
}

// Sets the checkboxes that correspond with Satuday operational hours
void Saturday() {
  if (textVal != "Select Lane") {
    checkbox.deactivateAll();
    for (int i = 6; i < 46; i++) {
      if (i < 26 || i > 27) {
        checkbox.activate(i);
      }
    }
  }
}

// Sets the checkboxes that correspond with Sunday operational hours
void Sunday() {
  if (textVal != "Select Lane") {
    checkbox.deactivateAll();
    for (int i = 10; i < 46; i++) {
      checkbox.activate(i);
    }
  }
}

// Enters copy mode
void Copy() {
  copy = true;
}

// Copies one lane times to another
void copyLane(byte arr[]) {
  copy = false;
  for (int i = 0; i < LANE_TIMES; i++) {
    if (arr[i + 1] == 1) {
      checkbox.activate(i); 
    }
  }
}


void Lane1() {
  if (copy == true) {
    copyLane(lanes[0]);
  }
  else {
    checkbox.deactivateAll();
    lane = 1;
    textVal = "Lane 1";
    activateBoxes(lanes[0]);
  }
}

void Lane2() {
  if (copy == true) {
    copyLane(lanes[1]);
  }
  else {
    checkbox.deactivateAll();
    lane = 2;
    textVal = "Lane 2";
    activateBoxes(lanes[1]);
  }
}

void Lane3() {
  if (copy == true) {
    copyLane(lanes[2]);
  }
  else {
    checkbox.deactivateAll();
    lane = 3;
    textVal = "Lane 3";
    activateBoxes(lanes[2]);
  }
}

void Lane4() {
  if (copy == true) {
    copyLane(lanes[3]);
  }
  else {
    checkbox.deactivateAll();
    lane = 4;
    textVal = "Lane 4";
    activateBoxes(lanes[3]);
  }
}

void Lane5() {
  if (copy == true) {
    copyLane(lanes[4]);
  }
  else {
    checkbox.deactivateAll();
    lane = 5;
    textVal = "Lane 5";
    activateBoxes(lanes[4]);
  }
}

void Lane6() {
  if (copy == true) {
    copyLane(lanes[5]);
  }
  else {
    checkbox.deactivateAll();
    lane = 6;
    textVal = "Lane 6";
    activateBoxes(lanes[5]);
  }
}

void Lane7() {
  if (copy == true) {
    copyLane(lanes[6]);
  }
  else {
    checkbox.deactivateAll();
    lane = 7;
    textVal = "Lane 7";
    activateBoxes(lanes[6]);
  }
}

void Lane8() {
  if (copy == true) {
    copyLane(lanes[7]);
  }
  else {
    checkbox.deactivateAll();
    lane = 8;
    textVal = "Lane 8";
    activateBoxes(lanes[7]);
  }
}

void Lane9() {
  if (copy == true) {
    copyLane(lanes[8]);
  }
  else {
    checkbox.deactivateAll();
    lane = 9;
    textVal = "Lane 9";
    activateBoxes(lanes[8]);
  }
}

void Lane10() {
  if (copy == true) {
    copyLane(lanes[9]);
  }
  else {
    checkbox.deactivateAll();
    lane = 10;
    textVal = "Lane 10";
    activateBoxes(lanes[9]);
  }
}

void Lane11() {
  if (copy == true) {
    copyLane(lanes[10]);
  }
  else {
    checkbox.deactivateAll();
    lane = 11;
    textVal = "Lane 11";
    activateBoxes(lanes[10]);
  }
}

void Lane12() {
  if (copy == true) {
    copyLane(lanes[11]);
  }
  else {
    checkbox.deactivateAll();
    lane = 12;
    textVal = "Lane 12";
    activateBoxes(lanes[11]);
  }
}

void Lane13() {
  if (copy == true) {
    copyLane(lanes[12]);
  }
  else {
    checkbox.deactivateAll();
    lane = 13;
    textVal = "Lane 13";
    activateBoxes(lanes[12]);
  }
}

void Lane14() {
  if (copy == true) {
    copyLane(lanes[13]);
  }
  else {
    checkbox.deactivateAll();
    lane = 14;
    textVal = "Lane 14";
    activateBoxes(lanes[13]);
  }
}

void Lane15() {
  if (copy == true) {
    copyLane(lanes[14]);
  }
  else {
    checkbox.deactivateAll();
    lane = 15;
    textVal = "Lane 15";
    activateBoxes(lanes[14]);
  }
}

void Lane16() {
  if (copy == true) {
    copyLane(lanes[15]);
  }
  else {
    checkbox.deactivateAll();
    lane = 16;
    textVal = "Lane 16";
    activateBoxes(lanes[15]);
  }
}
