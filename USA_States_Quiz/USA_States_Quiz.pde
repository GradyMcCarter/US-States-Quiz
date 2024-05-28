//importing classes used as tools later on
import java.awt.Rectangle;
import java.awt.Point;
import java.awt.Dimension;

//initializing evrey state as an enum (a data type that can be set to predefined constants)
enum State {
  ALABAMA, ALASKA, ARIZONA, ARKANSAS, CALIFORNIA, COLORADO, CONNECTICUT, DELAWARE, FLORIDA, GEORGIA, HAWAII, IDAHO, ILLINOIS, INDIANA, IOWA, KANSAS, KENTUCKY, LOUISIANA, MAINE, MARYLAND, MASSACHUSETTS, MICHIGAN, MINNESOTA, MISSISSIPPI, MISSOURI, MONTANA, NEBRASKA, NEVADA, NEW_HAMPSHIRE, NEW_JERSEY, NEW_MEXICO, NEW_YORK, NORTH_CAROLINA, 
  NORTH_DAKOTA, OHIO, OKLAHOMA, OREGON, PENNSYLVANIA, RHODE_ISLAND, SOUTH_CAROLINA, SOUTH_DAKOTA, TENNESSEE, TEXAS, UTAH, VERMONT, VIRGINIA, WASHINGTON, WEST_VIRGINIA, WISCONSIN, WYOMING, NONE
}

//Declaring all variables and arrays used throughout the code
PImage shownUSA;
int numStates = State.NONE.ordinal();
State[][] coordToState;

//Creates an array of images corresponding to each state
PImage[] states = new PImage[numStates];
Rectangle[] stateArea = new Rectangle[numStates];

//Variable randState is used to generate random state for the game\
State randState = State.values()[(int)(Math.random() * numStates)];
State chosenState; 

//Declaring a list of string variables for the name of each state
String[] stateNames = {"Alabama" , "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", 
"North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvannia", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"};
boolean[] pickedStates = new boolean[numStates];

//Declaring all the variables used for using a timer
int countPicked;
int correctStates;
int tenMinutes;
int oneMinutes;
int tenSeconds;
int oneSeconds;
float scaleW;
float scaleH;
int currSeconds;
int actualSeconds;

//Everything shown in setup is to create the picture initially displayed on the screen and make all the states distinguishable so they can be selected
void setup(){
  //displays the USA map from image stored in folder
  fullScreen();
  PImage tempUSA = loadImage("USA_Map.png");
  
  //Scales map to fit screen
  tempUSA.resize(displayWidth, displayHeight);
  coordToState = new State[tempUSA.height][tempUSA.width];
  shownUSA = tempUSA.copy();
  int range = 10;
  scaleW = displayWidth/2560.0;
  scaleH = displayHeight/1440.0;
  
  //An Array is constructed with the color of each state specified. To distinguish state we used a multicolored state map where each state's color is identified in the array
  color[] stateColors = {color(27, 190, 207), color(224, 182, 46), color(18, 166, 166), color(223, 133, 36), color(231, 90, 231), color(255, 89, 247), color(232, 231, 0), color(230, 1, 0), color(207, 182, 27), color(182, 108, 231), color(223, 53, 46), color(198,166,239), 
  color(141,123,231), color(223,81,191), color(183,255,191), color(240,215,133), color(223,198,80), color(182,133,240), color(133,0,231), color(223,231,0), color(0,149,231), color(231,116,149), color(18,134,247), color(133,239,149), color(255,182,215), color(216,239,167), 
  color(132,133,239), color(141,123,231), color(231,157,0), color(231,0,231), color(208,255,175), color(231,73,0), color(239,248,133), color(231,18,248), color(123,215,254), color(182,133,240), color(232,231,123), color(134,255,124), color(231,2,0), color(223,133,36), color(240,247,19),
  color(215,36,223), color(254,255,115), color(223,157,45), color(1,231,0), color(240,133,247), color(223,108,45), color(181,124,255), color(223,141,55), color(190,27,116)};
  
  //Some states had a similar color to each other so we created rectangular "hit boxes" around them so they could be distinguished
  stateArea[State.ARKANSAS.ordinal()] = new Rectangle(new Point((int)(1374 * scaleW), (int)(830 * scaleH)), new Dimension((int)(265 * scaleW),(int)(220 * scaleH)));
  stateArea[State.DELAWARE.ordinal()] = new Rectangle(new Point((int)(2235 * scaleW), (int)(566 * scaleH)), new Dimension((int)(63 * scaleW), (int)(82 * scaleH)));
  stateArea[State.LOUISIANA.ordinal()] = new Rectangle(new Point((int)(1411 * scaleW), (int)(1022 * scaleH)), new Dimension((int)(296 * scaleW), (int)(237 * scaleH)));
  stateArea[State.OKLAHOMA.ordinal()] = new Rectangle(new Point((int)(959 * scaleW), (int)(787 * scaleH)), new Dimension((int)(454 * scaleW),(int)(224 * scaleH)));
  stateArea[State.RHODE_ISLAND.ordinal()] = new Rectangle(new Point((int)(2355 * scaleW), (int)(394 * scaleH)), new Dimension((int)(63 * scaleW), (int)(63 * scaleH)));
  stateArea[State.SOUTH_CAROLINA.ordinal()] = new Rectangle(new Point((int)(1944 * scaleW),(int)(848 * scaleH)), new Dimension((int)(256 * scaleW), (int)(204 * scaleH)));
  stateArea[State.ILLINOIS.ordinal()] = new Rectangle(new Point((int)(1507 * scaleW), (int)(500 * scaleH)), new Dimension((int)(219 * scaleW), (int)(321 * scaleH)));
  stateArea[State.NEVADA.ordinal()] = new Rectangle(new Point((int)(179 * scaleW), (int)(398 * scaleH)), new Dimension((int)(344 * scaleW), (int)(476 * scaleH)));
  stateArea[State.CONNECTICUT.ordinal()] = new Rectangle(new Point((int)(2269 * scaleW), (int)(393 * scaleH)), new Dimension((int)(131 * scaleW), (int)(112 * scaleH)));
  stateArea[State.MARYLAND.ordinal()] = new Rectangle(new Point((int)(2049 * scaleW), (int)(531 * scaleH)), new Dimension((int)(254 * scaleW), (int)(155 * scaleH)));
  stateArea[State.NEBRASKA.ordinal()] = new Rectangle(new Point((int)(917 * scaleW), (int)(457 * scaleH)), new Dimension((int)(460 * scaleW), (int)(232 * scaleH)));
  stateArea[State.CALIFORNIA.ordinal()] = new Rectangle(new Point((int)(18 * scaleW), (int)(345 * scaleH)), new Dimension((int)(430 * scaleW), (int)(704 * scaleH)));
  stateArea[State.COLORADO.ordinal()] = new Rectangle(new Point((int)(677 * scaleW), (int)(553 * scaleH)), new Dimension((int)(380 * scaleW), (int)(288 * scaleH)));
  stateArea[State.NORTH_CAROLINA.ordinal()] = new Rectangle(new Point((int)(1852 * scaleW), (int)(704 * scaleH)), new Dimension((int)(506 * scaleW), (int)(259 * scaleH)));
  stateArea[State.OREGON.ordinal()] = new Rectangle(new Point((int)(43 * scaleW), (int)(134 * scaleH)), new Dimension((int)(452 * scaleW), (int)(372 * scaleH)));
  
  //For loops cycle through every pixel on the screen and sets the pixels to the appropriate color for the map shown on screen
  for(int x = 0; x < tempUSA.width; x++){
    for(int y = 0; y < tempUSA.height; y++){
       if(red(tempUSA.get(x,y)) + blue(tempUSA.get(x,y)) + green(tempUSA.get(x,y)) > 720)
         shownUSA.set(x, y, color(137, 193, 214));
       if((tempUSA.get(x, y) != color(255)) && (red(tempUSA.get(x,y)) + blue(tempUSA.get(x,y)) + green(tempUSA.get(x,y)) > 150) && (red(tempUSA.get(x,y)) + blue(tempUSA.get(x,y)) + green(tempUSA.get(x,y)) < 720)){
          shownUSA.set(x, y, color(30, 125, 40));
       }
    }
  }
  for(int i = 0; i < numStates; i++) {
    states[i] = createImage(tempUSA.width, tempUSA.height, PConstants.ARGB);
  }
  for(int x = 0; x < tempUSA.width; x++){
    for(int y = 0; y < tempUSA.height; y++){
      coordToState[y][x] = State.NONE;
      for(int i = 0; i < numStates; i++) {
        if((Math.abs(red(stateColors[i]) - red(tempUSA.get(x,y))) < range) && (Math.abs(blue(stateColors[i]) - blue(tempUSA.get(x,y))) < range) && (Math.abs(green(stateColors[i]) - green(tempUSA.get(x,y))) < range) && ((stateArea[i] == null) || stateArea[i].contains(x, y))) {
           states[i].set(x, y, color(255, 255, 255, 120));
           coordToState[y][x] = State.values()[i];
           break;
        }
      }
    }
  }
  
}

void draw(){
  //Displays proper US map used in the game
  background(255);
  image(shownUSA, 0, 0);
  
  //Checks if the random state has been picked yet so there are no repeats and displays "Click on State"
  if(pickedStates[randState.ordinal()] == false){
    text("Click on " + stateNames[randState.ordinal()], (int)(600 * displayWidth / 1920), (int)(68 * displayHeight / 1080));
  }
  
  if((mouseY < shownUSA.height) && (mouseX < shownUSA.width) && (coordToState[mouseY][mouseX] != State.NONE) && countPicked < 50 && !pickedStates[coordToState[mouseY][mouseX].ordinal()]){
    image(states[coordToState[mouseY][mouseX].ordinal()], 0, 0);
  }
  
  //Essentially a while loop that will keep changing the timer while the number of states picked is less than the total states. The timer will stop when all states have been clicked
  if(countPicked < numStates){
    if (oneMinutes == 10){
      oneMinutes = 0;
      tenMinutes ++;
    }
    if( tenSeconds == 6){
      tenSeconds = 0;
      oneMinutes ++;
    }
     if(oneSeconds % 10 == 0 && currSeconds != actualSeconds){
      tenSeconds ++;
      currSeconds = actualSeconds;
    }
    actualSeconds = (millis() / 1000);
    oneSeconds = (millis() / 1000) % 10;
    textSize(40);
    
    //Prints out the timer and scales the coordinates to make it fit the screen
    if(countPicked < numStates){
      text("Time: ", (int)(1550 * scaleW), (int)(90 * scaleH));
      text(tenMinutes, (int)(1760 * scaleW), (int)(90 * scaleH));
      text(oneMinutes, (int)(1800 * scaleW), (int)(90 * scaleH));
      text(":", (int)(1840 * scaleW), (int)(87 * scaleH));
      text(tenSeconds, (int)(1880 * scaleW), (int)(90 * scaleH));
      text(oneSeconds, (int)(1920 * scaleW), (int)(90 * scaleH));
    }
    
    //Checks to see if the state selected is the correct state
    if(mousePressed && mouseButton == LEFT && !coordToState[mouseY][mouseX].equals(State.NONE) && !pickedStates[randState.ordinal()] && !pickedStates[coordToState[mouseY][mouseX].ordinal()]){
      countPicked++;
      text("Click on " + stateNames[randState.ordinal()], (int)(800*displayWidth/1920), (int)(68*displayHeight/1080));
      chosenState = coordToState[mouseY][mouseX];
      
      //If correct it will increment correct states and change all the pixels in the image to the color white
      if (chosenState.equals(randState)){
        correctStates++;
        for(int x = 0; x < shownUSA.width; x++){
          for(int y = 0; y < shownUSA.height; y++){
            if (coordToState[y][x].equals(randState)){
              shownUSA.set(x, y, color(255, 255, 255, 255));
            }
          }
        }
        //Changes the boolean of the state to true so it won't be repeated
         pickedStates[randState.ordinal()] = true;
         randState = State.values()[(int)(Math.random() * 50)];
         
         //If more states are unused the program will get a new random state and repeat
         if(countPicked < numStates){
           while(pickedStates[randState.ordinal()] == true){
             randState = State.values()[(int)(Math.random() * 50)];
           }
         }
         else{
           for(int x = 0; x < shownUSA.width; x++){
              for(int y = 0; y < shownUSA.height; y++){
                if(coordToState[y][x].equals(randState)){
                  shownUSA.set(x, y, color(255, 255, 255, 255));
                }
              }
           }
         } 
         //prints out the text so the program can repeat
         text("Click on " + stateNames[randState.ordinal()], (int)(800*displayWidth/1920), (int)(68*displayHeight/1080) );
         delay(100);
      }
      else{
        //if the state selected was incorrect then the all the pixels within the state wil turn red
        for(int x = 0; x < shownUSA.width; x++){
          for(int y = 0; y < shownUSA.height; y++){
            if (coordToState[y][x].equals(randState)){
              shownUSA.set(x, y, color(255, 0, 0, 255));
            }
          }
        }
        //Will change the random state so the game can continue on despite a wrong answer
        pickedStates[randState.ordinal()] = true;
        randState = State.values()[(int)(Math.random() * 50)];
        if(countPicked < numStates){
          while(pickedStates[randState.ordinal()] == true){
             randState = State.values()[(int)(Math.random() * 50)];
          }
        }
        else{
          for(int x = 0; x < shownUSA.width; x++){
             for(int y = 0; y < shownUSA.height; y++){
               if(coordToState[y][x].equals(randState)){
                 shownUSA.set(x, y, color(255, 255, 255, 255));
               }
             }
          }
        }
        if(countPicked < numStates){
          text("Click on " + stateNames[randState.ordinal()], (int)(800*displayWidth/1920), (int)(68*displayHeight/1080));
          delay(100);
        }
      }
    }
  }
  //else will be evaluated once every state has been used
  else{
      image(shownUSA, 0, 0);
      delay(150);
      pickedStates[randState.ordinal()] = true;
      
      //loads in a new backround that is solid blue as a background
      shownUSA = loadImage("USA_Quiz_Background.png");
      image(shownUSA, 0, 0);
      shownUSA.resize(displayWidth, displayHeight);
      textSize(40);
      //Displays the accuracy and time onto the final screen for the user's game
      text("Accuracy: " + (100 * ((double) correctStates / numStates)) + "%", (displayWidth / 2) - (displayWidth / 12), displayHeight / 2);
      text("Time: ", (displayWidth / 2) - (displayWidth / 12), (displayHeight / 2) + (displayHeight / 24));
      text(tenMinutes, (displayWidth / 2) - (displayWidth / 12) + 100, (displayHeight / 2) + (displayHeight / 24));
      text(oneMinutes, (displayWidth / 2) - (displayWidth / 12) + 120, (displayHeight / 2) + (displayHeight / 24));
      text(" : ", (displayWidth / 2) - (displayWidth / 12) + 135, (displayHeight / 2) + (displayHeight / 24));
      text(tenSeconds, (displayWidth / 2) - (displayWidth / 12) + 155, (displayHeight / 2) + (displayHeight / 24));
      text(oneSeconds, (displayWidth / 2) - (displayWidth / 12) + 175, (displayHeight / 2) + (displayHeight / 24));
  }
}
