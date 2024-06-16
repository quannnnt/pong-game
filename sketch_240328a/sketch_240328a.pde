int ballx, bally, wall1x, wall1y, wall2x, wall2y;
int ballDiameter = 8;
int wallWidth = 8;
int wallHeight = 40;
int scoreLeft = 0;
int scoreRight = 0;
int ballSpeedx = 5;
int ballSpeedy = 5;
int speedWall = 10;
boolean wall1UP = false;
boolean wall1DOWN = false;
boolean wall2UP = false;
boolean wall2DOWN = false;

void setup() {
  size(400, 300);
  ballx = width/2;
  bally = height/2;
  wall1x = 7;
  wall1y = height/2 - wallHeight/2;
  wall2x = width - wallWidth - 7;
  wall2y = height/2 - wallHeight/2;
  float ballStartx = random(1);
  if (ballStartx < 0.5) {
    ballSpeedx = -1 * ballSpeedx;
  } else {
    ballSpeedx = ballSpeedx;
  }
  float ballStarty = random(1);
  if (ballStarty < 0.5) {
    ballSpeedy = -1 * ballSpeedy;
  } else {
    ballSpeedy = ballSpeedy;
  }
}

// ----------------------------------------------------- static
void fillBackground() {
  fill(0);
  rect(0, 0, width, height);
}
void ball() {
  fill(245);
  ellipse(ballx, bally, ballDiameter, ballDiameter);
}
void wallLeft() {
  fill(171);
  rect(wall1x, wall1y, wallWidth, wallHeight);
}
void wallRight() {
  fill(171);
  rect(wall2x, wall2y, wallWidth, wallHeight);
}
void score() {
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text(scoreLeft, width/2 - 30, 40);
  text(scoreRight, width/2 + 30, 40);
}
void lines() {
  stroke(255);
  strokeWeight(1);
  line(width/2, 0, width/2, height);
  strokeWeight(10);
  line(0, 4, width, 4);
  line(0, height - 5, width, height - 5);
}

// ------------------------------------------------------ movement
void moveBall() {
  //vertical
  bally = bally + ballSpeedy;
  if (bally + ballDiameter/2 >= height - 10) {
    bally = height - ballDiameter/2 - 10;
    ballSpeedy = -1 * ballSpeedy;
  }
  if (bally - ballDiameter/2 <= 10) {
    bally = 10 + ballDiameter/2;
    ballSpeedy = -1 * ballSpeedy;
  }
  //horizontal
  ballx = ballx + ballSpeedx;
  
  //score
  if(ballx <= 0 - ballDiameter){
    ballx = width/2;
    bally = height/2;
    scoreRight += 1;
  }
  if(ballx >= width + ballDiameter){
    ballx = width/2;
    bally = height/2;
    scoreLeft += 1;
  }
}
void colision() {
  //wall 1 - left
  if (ballx - ballDiameter/2 <= wall1x + wallWidth && ballSpeedx < 0 && ballx - ballDiameter/2 >= wall1x) {
    if (bally + ballDiameter/2 >= wall1y && bally - ballDiameter/2 <= wall1y + wallHeight) {
      ballx = wall1x + wallWidth + ballDiameter/2;
      ballSpeedx = -ballSpeedx;
    }
  }

  //wall 2 - right
  if (ballx + ballDiameter/2 >= wall2x && ballSpeedx > 0 && ballx + ballDiameter/2 <= wall2x + wallWidth) {
    if (bally + ballDiameter/2 >= wall2y && bally - ballDiameter/2 <= wall2y + wallHeight) {
      ballx = wall2x - ballDiameter/2;
      ballSpeedx = -ballSpeedx;
    }
  }
}

// ------------------ wall movement
void keyPressed() {
  if(key == 'w'){
    wall1UP = true;
  }
  if(key == 's'){
    wall1DOWN = true;
  }
  if(keyCode == UP){
    wall2UP = true;
  }
  if(keyCode == DOWN){
    wall2DOWN = true;
  }
}
void keyReleased(){
  if(key == 'w'){
    wall1UP = false;
  }
  if(key == 's'){
    wall1DOWN = false;
  }
  if(keyCode == UP){
    wall2UP = false;
  }
  if(keyCode == DOWN){
    wall2DOWN = false;
  }
}
void moveWalls() {
  // wall 1 - left
  if(wall1UP){
      wall1y = wall1y - speedWall;
      if(wall1y <= 10){
        wall1y = 10;
      }
  }
  if(wall1DOWN){
      wall1y = wall1y + speedWall;
      if(wall1y + wallHeight >= height - 10){
        wall1y = height - wallHeight - 10;
      }
  }
  //wall 2 - right
  if(wall2UP){
      wall2y = wall2y - speedWall;
      if(wall2y <= 10){
        wall2y = 10;
      }
  }
  if(wall2DOWN){
      wall2y = wall2y + speedWall;
      if(wall2y + wallHeight >= height - 10){
        wall2y = height - wallHeight - 10;
      }
  }
}

void draw() {
  frameRate(40);
  noStroke();
  fillBackground();
  lines();
  noStroke();
  score();
  ball();
  wallLeft();
  wallRight();
  moveBall();
  moveWalls();
  colision();  
}
