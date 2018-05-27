import processing.sound.*;

SoundFile file;


Ball ball;
Paddle pad;
Block[] blocks=new Block[300];
powerUp[] pUp=new powerUp[300];


int maxLives=3;//Change the maximum number of lives you get
int Width=900;//Adjust these to change the window size (text might break)
int Height=720;
boolean hitSound=false;//change to false if you don't want to hear a sound everytime you hit a block
boolean largePad;
boolean fastBall;
boolean bigBall;

int lives=maxLives;
int cols;
int rows;
int numBlocks;


int gameState=0;
boolean gameStart=false;
boolean lose=false;

int aliveBlocks=0;
int deadBlocks=0;
int counter=0;

int score=0;


void settings() {
  size(Width, Height);
}

void setup() {
  file=new SoundFile(this, "ding.mp3");
  file.amp(0.25);

  cols=width/60;
  rows=int((2*height/5)/40);
  numBlocks=rows*cols;

  int index=0;
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {

      blocks[index]=new Block(i*60, j*40);
      pUp[index]=new powerUp(blocks[index]);

      if (blocks[index].alive>0) {
        aliveBlocks++;
      } else {
        deadBlocks++;
      }
      index++;
    }
  }
  ball=new Ball();
  pad=new Paddle();

  lives=maxLives;
}

void draw() {


  if (gameState==0) {//intro slide
    background(200, 0, 0);
    textSize(int(43));
    text("Press SPACEBAR to start", 200, 300);
    textSize(30);
    text("Press       to move right", 50, 500);
    fill(255);
    noStroke();
    rect(137, 487, 30, 10);
    triangle(137+30, 480, 137+30, 504, 150+30, 492);
    text("Press       to move left", 520, 500);
    rect(607+17, 487, 30, 10);
    triangle(624, 480, 624, 504, 624-15, 492);
  } else if (gameState==1) {//actual game

    background(120);

    ball.show();
    pad.show();
    pad.edges();

    if (lose) {//put ball on top of the paddle after losing
      loseText();
      ball.resetPos(pad);
    }

    if (gameStart) {//while the ball is moving
      if (keyPressed) {//move the paddle
        if (keyCode==LEFT) {
          pad.leftMove(3.5);
        }
        if (keyCode==RIGHT) {
          pad.rightMove(3.5);
        }
      }

      for (int i=0; i<numBlocks; i++) {
        blocks[i].show();
      }
      for (int i=0; i<numBlocks; i++) {
        ball.blockCollision(blocks[i]);
      }
      ball.update();
      //for (int i=0; i<pUp.length; i++) {
      //  if (pUp[i].alive) {
      //    pUp[i].show();
      //    pUp[i].update();
      //  }
      //}

      checkWinGame();
      fill(255);
      textSize(15);
      text("LIFES:", 10, height-15);
      text( lives, 50, height-15);
      text("SCORE:", width-120, height-15);
      text( score, width-50, height-15);
    }
  } else if (gameState==2) {//end of game slide
    winGame();
  }
}

void keyPressed() {

  if (keyCode==' ') {

    if (gameState==0) {
      gameState=1;
    } else  if (gameState==2) {
      resetGame();
    } else if (gameState==1&&!gameStart) {
      gameStart=true;
      lose=false;

      float angle=random(0.3, 0.6);

      ball.speed.x=4*sin(angle);
      ball.speed.y=-4*cos(angle);
    } else if (gameState==1&&lose) {
      lose=false;
      float angle=random(0.3, 0.6);

      ball.speed.x=4*sin(angle);
      ball.speed.y=-4*cos(angle);
    }
  }
}



void loseText() {

  textSize(30);
  text("You lost one life", width/2-137, height/2);
}

void resetGame() {
  loseText();
  lives=maxLives;

  pad.x=width/2;
  ball.location.x=width/2;
  ball.location.y=height-50;
  ball.speed.x=0;
  ball.speed.y=0;
  resetBlocks();
  counter=0;

  gameStart=false;
  lose=false ;
  gameState=0;
}

void resetBlocks() {
  aliveBlocks=0;
  for (int index=0; index<numBlocks; index++) {

    blocks[index].alive=-1+(int)random(2)*2;
    if (blocks[index].alive>0) {
      aliveBlocks++;
    }
  }
}

void checkWinGame() {
  if (aliveBlocks==0) {
    gameState=2;
    gameStart=false;
  }
}

void winGame() {
  noStroke();
  fill(120, 120, 0);
  rect(0, 0, width, height);
  fill(255);
  textSize(43);
  text("Press SPACEBAR to start again", 147, 450);
  textSize(30);
  text("You win", width/2-75, height/2);
  lives=maxLives;
}