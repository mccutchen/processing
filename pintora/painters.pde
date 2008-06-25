abstract class Painter {
    int colorDelta = 5;
    int colorMin = 0;
    int colorMax = 255;
    int rDelta = rand(0, colorDelta);
    int gDelta = rand(0, colorDelta);
    int bDelta = rand(0, colorDelta);
    
    int strokeDelta = 3;
    int strokeMin = 20;
    int strokeMax = 100;
    
    int targetDelta = 25;
    
    color c;
    int s;
    
    Painter() {
        c = color(rand(0,255), rand(0,255), rand(0,255));
        s = rand(strokeMin, strokeMax);
    }
    
    abstract void update();
    abstract void paint();
}

abstract class FudgePainter extends Painter {
    FudgePainter() {
        super();
    }
    void update() {
        c = fudge(c, rDelta, gDelta, bDelta, colorMin, colorMax);
        s = fudge(s, strokeDelta, strokeMin, strokeMax);
    }
}

abstract class OneColorPainter extends FudgePainter {
    OneColorPainter() {
        super();
        int r = int(red(c));
        int g = int(green(c));
        int b = int(blue(c));
        
        if (r >= g && r >= b) rDelta = 0;
        else if (g > r && g > b) gDelta = 0;
        else bDelta = 0;
    }
}

class LinePainter extends FudgePainter {
    int x, y;
    int oldx, oldy;
    
    LinePainter() {
        super();
        x = oldx = rand(0, width);
        y = oldy = rand(0, height);
    }
    
    void update() {
        super.update();
        oldx = x; oldy = y;
        x = fudge(x, targetDelta, 0, width);
        y = fudge(y, targetDelta, 0, height);
    }
    
    void paint() {
        stroke(c);
        strokeWeight(s);
        noFill();
        line(oldx, oldy, x, y);
    }
}

class CurvePainter extends FudgePainter {
    int numCoords = 20;
    int[] x = new int[numCoords];
    int[] y = new int[numCoords];
    
    public CurvePainter() {
        super();
        int x1 = rand(0, width);
        int y1 = rand(0, height);
        for (int i = 0; i < numCoords; i++) {
            x[i] = x1;
            y[i] = y1;
        }
    }
    
    void update() {
        super.update();
        for(int i = 1; i < numCoords; i++) {
            x[i - 1] = x[i];
            y[i - 1] = y[i];
        }
        x[x.length - 1] = fudgeWrap(x[y.length - 1], targetDelta, 0, width);
        y[y.length - 1] = fudgeWrap(y[y.length - 1], targetDelta, 0, height);
    }
    
    void paint() {
        stroke(c);
        strokeWeight(s);
        noFill();
        beginShape();
        for (int i = 0; i < numCoords; i++) {
            curveVertex(x[i], y[i]);
        }
        endShape();
    }
}