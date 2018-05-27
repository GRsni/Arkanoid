      class Block {
        float x;
        float y;
        float blockWidth=60;
        float blockHeight=40;
        int alive=-1+(int)random(2)*2;
        color R, G;
      
        Block(float x_, float y_) {
          x=x_;
          y=y_;
          R=int(map(x, 0, width, 0, 255));
          G=int(map(y, 0, height*2/5, 0, 255));
        }
      
        void show() {
          if (alive>0) {
            rectMode(CORNER);
            stroke(255);
            noStroke();
            fill(255);
      
            rect(x, y, blockWidth, blockHeight);
            fill(R, G, 0);
            rect(x+2, y+2, blockWidth-4, blockHeight-4);
          }
        }
      }