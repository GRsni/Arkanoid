    class Paddle {
      float x;
      float y=height-38;
      int padWidth=10;
    
      Paddle() {
        x=width/2;
      }
    
      void show() {
        fill(255);
        rectMode(CENTER);
        stroke(255);
        rect(x, y, 100, padWidth);
      }
    
      void edges() {
        if (x-50<0) {
          x=50;
        }
        if (x+50>width) {
          x=width-50;
        }
      }
      void leftMove(float X) {
        x-=X;
      }
    
      void rightMove(float X) {
        x+=X;
      }
    }