class Ball {
  PVector location;
  PVector speed;
  float r=6.5;

  Ball() {
    location=new PVector(width/2, height-50);
    speed=new PVector(0, 0);
  }

  void show() {
    noStroke();
    fill(0);

    ellipseMode(CENTER);
    ellipse(location.x, location.y, r*2, r*2);
    point(location.x, location.y);
  }

  void update() {
    location.add(speed);
    edges();
    padCollision(pad);
  }

  void edges() {
    if (location.y<0+r) {
      speed.y=speed.y*-1;
    }
    if (location.x>width-r) {
      speed.x=speed.x*-1;
    } else if (location.x<r) {
      speed.x=speed.x*-1;
    }
    if (location.y>height) {
      resetPos(pad);
      score-=100;
      lives--;
      lose=true;
      if (lives<1) {
        score=0;

        gameStart=false;
        lose=false;
        println("fail");
        resetGame();
      }
    }
  } 

  void resetPos(Paddle pad) {
    location.x=pad.x;
    location.y=pad.y-5-r;
    speed.x=0;
    speed.y=0;
  }

  void padCollision(Paddle pad) {
    if (location.x>pad.x-50&&location.x<pad.x+50) {
      if (location.y+r>pad.y-pad.padWidth/2&&location.y<pad.y+pad.padWidth/2) {
        float diff=location.x-(pad.x-50);
        float rad=radians(60);
        float angle=map(diff, 0, 100, -rad*3/2, rad*3/2);

        speed.x=4*sin(angle);
        speed.y=-4*cos(angle);
      }
    }
  }

  void blockCollision(Block block) {
    rectMode(CORNER);
    if (block.alive==1) {
      if (speed.x>0) {
        if (location.y>block.y&&location.y<block.y+block.blockHeight) {
          if (location.x+r>block.x&&location.x-r<block.x+block.blockWidth) {
            location.x-=3;
            speed.x=speed.x*-1;
            block.alive--;
            aliveBlocks--;
            deadBlocks++;

            score+=20;
            counter++;

            if (hitSound) {
              file.play();
            }
          }
        }
      } else if (speed.x<0) {
        if (location.y>block.y&&location.y<block.y+block.blockHeight) {
          if (location.x-r<block.x+block.blockWidth&&location.x+r>block.x) {
            location.x+=3;
            speed.x=speed.x*-1;
            block.alive--;
            aliveBlocks--;

            deadBlocks++;
            score+=20;
            counter++;
            if (hitSound) {
              file.play();
            }
          }
        }
      }

      if (speed.y>0) {
        if (location.x>block.x&&location.x<block.x+block.blockWidth) {
          if (location.y+r>block.y&&location.y-r<block.y+block.blockHeight) {
            location.y-=3;
            speed.y=speed.y*-1;
            block.alive--;
            aliveBlocks--;
            deadBlocks++;
            score+=20;
            counter++;
            if (hitSound) {
              file.play();
            }
          }
        }
      } else if (speed.y<0) {
        if (location.x>block.x&&location.x<block.x+block.blockWidth) {
          if (location.y-r<block.y+block.blockHeight&&location.y+r>block.y) {
            location.y+=3;
            speed.y=speed.y*-1;
            block.alive--;
            aliveBlocks--;
            deadBlocks++;
            score+=20;
            counter++;
            if (hitSound) {
              file.play();
            }
          }
        }
      }
    }
  }
}