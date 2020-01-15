import controlP5.*;
import processing.serial.*;

Serial port;

ControlP5 cp5;
CheckBox checkbox;
PFont font, bFont;

int LANE_TIMES = 54;

byte laneArr[] = new byte[LANE_TIMES+1];
byte lane = 0;

byte lane_1[]  = new byte[LANE_TIMES];
byte lane_2[]  = new byte[LANE_TIMES];
byte lane_3[]  = new byte[LANE_TIMES];
byte lane_4[]  = new byte[LANE_TIMES];
byte lane_5[]  = new byte[LANE_TIMES];
byte lane_6[]  = new byte[LANE_TIMES];
byte lane_7[]  = new byte[LANE_TIMES];
byte lane_8[]  = new byte[LANE_TIMES];
byte lane_9[]  = new byte[LANE_TIMES];
byte lane_10[] = new byte[LANE_TIMES];
byte lane_11[] = new byte[LANE_TIMES];
byte lane_12[] = new byte[LANE_TIMES];
byte lane_13[] = new byte[LANE_TIMES];
byte lane_14[] = new byte[LANE_TIMES];
byte lane_15[] = new byte[LANE_TIMES];
byte lane_16[] = new byte[LANE_TIMES];

String textVal = "Select Lane";

boolean startUp = true;

void setup() {
  size(1050, 500);
  smooth();
  surface.setTitle("Lap Lane Availability");
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[Serial.list().length - 1], 9600);
  println("Successfully connected to Port: " + Serial.list()[Serial.list().length - 1]);
  font = createFont("Calibri", 13);
  bFont = createFont("Calibri", 16);
  createMainMenu(); 
}

void draw() {
  background(100, 100, 100);
  fill(0, 0, 0);
  textSize(40);
  textAlign(CENTER);
  text("Lap Lane Availability", 525, 50);
  textSize(30);
  text(textVal, 525, 250);
  if (startUp == false) {
    textSize(20);
    text("GREEN means OPENS at that time", 165, 440);
    text("RED means CLOSES at that time", 165, 480);
  }
}

void createMainMenu() {
  int buttonSize = 60;
  cp5 = new ControlP5(this);
  cp5.setFont(font);
  cp5.setColorActive(color(0, 155, 0));
  for (int i = 0; i < 8; i++) {
    cp5.addButton("Lane" + char(49+i))
      .setFont(bFont)
      .setPosition(150 + (i*100), 75)
      .setSize(buttonSize, 55);
  }
  cp5.addButton("Lane9")
    .setFont(bFont)
    .setPosition(150, 150)
    .setSize(buttonSize, 55);
  for (int i = 0; i < 7; i++) {
    cp5.addButton("Lane1" + char(48+i))
      .setFont(bFont)
      .setPosition(250 + (i*100), 150)
      .setSize(buttonSize, 55);
  }
  timeCheckBoxes();
}

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

void Submit() {
  if (textVal != "Select Lane") {
    println("\n" + "Lane: " + lane);
    laneArr[0] = lane;
    for(int i = 0; i < LANE_TIMES; i++) {
      laneArr[i+1] = byte(checkbox.getState(i));
      print(byte(checkbox.getState(i)) + ", ");
      if ((i+1) % 18 == 0) println();
    }
    checkArr(laneArr);
    port.write(laneArr);
    println("Lane " + laneArr[0] + " submitted.");
    checkbox.deactivateAll();
    lane = 0;
    textVal = "Select Lane";
  }
}

void checkArr(byte arr[]) {
  if (arr[0] == 1) {
    fillArray(lane_1);
  }
  else if (arr[0] == 2) {
    fillArray(lane_2);
  }  
  else if (arr[0] == 3) {
    fillArray(lane_3);
  }  
  else if (arr[0] == 4) {
    fillArray(lane_4);
  } 
  else if (arr[0] == 5) {
    fillArray(lane_5);
  } 
  else if (arr[0] == 6) {
    fillArray(lane_6);
  } 
  else if (arr[0] == 7) {
    fillArray(lane_7);
  } 
  else if (arr[0] == 8) {
    fillArray(lane_8);
  } 
  else if (arr[0] == 9) {
    fillArray(lane_9);
  } 
  else if (arr[0] == 10) {
    fillArray(lane_10);
  } 
  else if (arr[0] == 11) {
    fillArray(lane_11);
  } 
  else if (arr[0] == 12) {
    fillArray(lane_12);
  } 
  else if (arr[0] == 13) {
    fillArray(lane_13);
  } 
  else if (arr[0] == 14) {
    fillArray(lane_14);
  } 
  else if (arr[0] == 15) {
    fillArray(lane_15);
  } 
  else if (arr[0] == 16) {
    fillArray(lane_16);
  } 
}

void fillArray(byte arr[]) {
  for (int i = 0; i < LANE_TIMES; i++) {
    arr[i] = laneArr[i+1];
  }
}

void activateBoxes(byte arr[]) {
  for (int i = 0; i < arr.length; i++) {
    if (arr[i] != 0) {
      checkbox.activate(i);
    }
  }
}

void extraButtons() {
  startUp = false;
  checkbox.show();
  cp5.addButton("All")
    .setFont(bFont)
    .setPosition(20, 225)
    .setSize(30, 25);
  cp5.addButton("Saturday")
    .setFont(bFont)
    .setPosition(60, 225)
    .setSize(80, 25);
  cp5.addButton("Sunday")
    .setFont(bFont)
    .setPosition(150, 225)
    .setSize(70, 25);
  cp5.addButton("None")
    .setFont(bFont)
    .setPosition(230, 225)
    .setSize(50, 25);  
  cp5.addButton("Submit")
    .setFont(bFont)
    .setPosition(460, 425)
    .setSize(130, 50);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    if (startUp == true) {
      extraButtons();
    }
  }
}

void All() {
  if (textVal != "Select Lane") {
    checkbox.activateAll();
  }
}

void Saturday() {
  if (textVal != "Select Lane") {
    checkbox.deactivateAll();
    for (int i = 6; i < 46; i++) {
      checkbox.activate(i);
    }
  }
}

void Sunday() {
  if (textVal != "Select Lane") {
    checkbox.deactivateAll();
    for (int i = 10; i < 46; i++) {
      checkbox.activate(i);
    }
  }
}

void None() {
  checkbox.deactivateAll();
}

void Lane1() {
  checkbox.deactivateAll();
  lane = 1;
  textVal = "Lane 1";
  activateBoxes(lane_1);
}

void Lane2() {
  checkbox.deactivateAll();
  lane = 2;
  textVal = "Lane 2";
  activateBoxes(lane_2);
}

void Lane3() {
  checkbox.deactivateAll();
  lane = 3;
  textVal = "Lane 3";
  activateBoxes(lane_3);
}

void Lane4() {
  checkbox.deactivateAll();
  lane = 4;
  textVal = "Lane 4";
  activateBoxes(lane_4);
}

void Lane5() {
  checkbox.deactivateAll();
  lane = 5;
  textVal = "Lane 5";
  activateBoxes(lane_5);
}

void Lane6() {
  if (startUp == true) {
   extraButtons();
  }
  checkbox.deactivateAll();
  lane = 6;
  textVal = "Lane 6";
  activateBoxes(lane_6);
}

void Lane7() {
  checkbox.deactivateAll();
  lane = 7;
  textVal = "Lane 7";
  activateBoxes(lane_7);
}

void Lane8() {
  checkbox.deactivateAll();
  lane = 8;
  textVal = "Lane 8";
  activateBoxes(lane_8);
}

void Lane9() {
  checkbox.deactivateAll();
  lane = 9;
  textVal = "Lane 9";
  activateBoxes(lane_9);
}

void Lane10() {
  checkbox.deactivateAll();
  lane = 10;
  textVal = "Lane 10";
  activateBoxes(lane_10);
}

void Lane11() {
  checkbox.deactivateAll();
  lane = 11;
  textVal = "Lane 11";
  activateBoxes(lane_11);
}

void Lane12() {
  checkbox.deactivateAll();
  lane = 12;
  textVal = "Lane 12";
  activateBoxes(lane_12);
}

void Lane13() {
  checkbox.deactivateAll();
  lane = 13;
  textVal = "Lane 13";
  activateBoxes(lane_13);
}

void Lane14() {
  checkbox.deactivateAll();
  lane = 14;
  textVal = "Lane 14";
  activateBoxes(lane_14);
}

void Lane15() {
  checkbox.deactivateAll();
  lane = 15;
  textVal = "Lane 15";
  activateBoxes(lane_15);
}

void Lane16() {
  checkbox.deactivateAll();
  lane = 16;
  textVal = "Lane 16";
  activateBoxes(lane_16);
}
