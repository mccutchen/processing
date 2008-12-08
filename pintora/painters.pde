abstract class Painter {
    int strokeDelta = STROKE_DELTA;
    int strokeMin = STROKE_MIN;
    int strokeMax = STROKE_MAX;
    
    int targetDelta = TARGET_DELTA;
    
    ColorStream cs;
    int s;
    
    Painter(ColorStream colorStream) {
        cs = colorStream;
        s = rand(strokeMin, strokeMax);
    }
    
    void update() {
        s = fudge(s, strokeDelta, strokeMin, strokeMax);
        strokeWeight(s);
        stroke(cs.next());
        noFill();
    }
    
    abstract void paint();
}

class LinePainter extends Painter {
    int x, y;
    int oldx, oldy;
    
    LinePainter(ColorStream colorStream) {
        super(colorStream);
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
        line(oldx, oldy, x, y);
    }
}

class CurvePainter extends Painter {
    int numCoords = 20;
    int[] x = new int[numCoords];
    int[] y = new int[numCoords];
    
    public CurvePainter(ColorStream colorStream) {
        super(colorStream);
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
        beginShape();
        for (int i = 0; i < numCoords; i++) {
            curveVertex(x[i], y[i]);
        }
        endShape();
    }
}

class BezierPainter extends CurvePainter {
    int numCoords = 4;
    int targetDelta = 50;
    
    public BezierPainter(ColorStream colorStream) {
        super(colorStream);
    }
        
    void update() {
        super.update();
        x = reverse(x);
        y = reverse(y);
        for(int i = 1; i < numCoords; i++) {
            x[i] = fudge(x[i - 1], targetDelta, 0, width);
            y[i] = fudge(y[i - 1], targetDelta, 0, height);
        }
    }
    
    void paint() {
        beginShape();
        vertex(x[0], y[0]);
        for (int i = 1; i < numCoords; i++) {
            bezierVertex(x[1], y[1], x[2], y[2], x[3], y[3]);
        }
        endShape();
    }
}