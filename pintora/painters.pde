abstract class Painter {
    int colorDelta = COLOR_DELTA;
    int colorMin = COLOR_MIN;
    int colorMax = COLOR_MAX;
    int rDelta = rand(0, colorDelta);
    int gDelta = rand(0, colorDelta);
    int bDelta = rand(0, colorDelta);
    
    int strokeDelta = STROKE_DELTA;
    int strokeMin = STROKE_MIN;
    int strokeMax = STROKE_MAX;
    
    int targetDelta = TARGET_DELTA;
    
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
    int r, g, b;
    int rmin, rmax;
    int gmin, gmax;
    int bmin, bmax;
    int maxdelta = 6;
    
    OneColorPainter() {
        super();
        c = color(127, 148, 149);
        r = int(red(c));
        g = int(green(c));
        b = int(blue(c));
        rmin = getMin(r);
        rmax = getMax(r);
        gmin = getMin(g);
        gmax = getMax(g);
        bmin = getMin(b);
        bmax = getMax(b);
    }
    void update() {
        super.update();
        r = fudge(r, colorDelta, rmin, rmax);
        g = fudge(g, colorDelta, gmin, gmax);
        b = fudge(b, colorDelta, bmin, bmax);
        c = color(r, g, b);
    }
    
    int getMin(int channel) {
        return max(channel - maxdelta, 0);
    }
    int getMax(int channel) {
        return min(channel + maxdelta, 255);
    }
}

abstract class GrayScalePainter extends FudgePainter {
    int gray;
    GrayScalePainter() {
        super();
        gray = rand(0, 255);
    }
    void update() {
        super.update();
        gray = fudge(gray, COLOR_DELTA, colorMin, colorMax);
        c = color(gray);
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

class CurvePainter extends GrayScalePainter {
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

class BezierPainter extends CurvePainter {
    int numCoords = 4;
    int targetDelta = 50;
    
    public BezierPainter() {
        super();
    }
    
    void update() {
        x = reverse(x);
        y = reverse(y);
        for(int i = 1; i < numCoords; i++) {
            x[i] = fudge(x[i - 1], targetDelta, 0, width);
            y[i] = fudge(y[i - 1], targetDelta, 0, height);
        }
    }
    
    void paint() {
        noFill();
        beginShape();
        vertex(x[0], y[0]);
        for (int i = 1; i < numCoords; i++) {
            bezierVertex(x[1], y[1], x[2], y[2], x[3], y[3]);
        }
        endShape();
    }
}