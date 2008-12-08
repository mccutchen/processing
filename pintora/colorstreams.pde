class ColorStream {
    color c;
    
    int colorDelta = COLOR_DELTA;
    int colorMin = COLOR_MIN;
    int colorMax = COLOR_MAX;
    int rDelta = rand(0, colorDelta);
    int gDelta = rand(0, colorDelta);
    int bDelta = rand(0, colorDelta);
    
    public ColorStream() {
        this(rand(0,255), rand(0,255), rand(0,255));
    }
    public ColorStream(int r, int g, int b) {
        c = color(r, g, b);
    }
    
    private void update() {
        c = fudge(c, rDelta, gDelta, bDelta, colorMin, colorMax);
    }

    public color next() {
        this.update();
        return this.c;
    }
}

class UniformColorStream extends ColorStream {
    int r, g, b;
    int rmin, rmax;
    int gmin, gmax;
    int bmin, bmax;
    int maxdelta = 6;
    
    public UniformColorStream() {
        this(rand(0,255), rand(0,255), rand(0,255));
    }
    public UniformColorStream(int nr, int ng, int nb) {
        c = color(nr, ng, nb);
        r = nr;
        g = ng;
        b = nb;
        rmin = this.getMin(r);
        rmax = this.getMax(r);
        gmin = this.getMin(g);
        gmax = this.getMax(g);
        bmin = this.getMin(b);
        bmax = this.getMax(b);
    }
    
    private void update() {
        r = fudge(r, colorDelta, rmin, rmax);
        g = fudge(g, colorDelta, gmin, gmax);
        b = fudge(b, colorDelta, bmin, bmax);
        c = color(r, g, b);
    }
    
    private int getMin(int channel) {
        return max(channel - maxdelta, 0);
    }
    private int getMax(int channel) {
        return min(channel + maxdelta, 255);
    }
}

class GrayStream extends ColorStream {
    int gray;
    
    public GrayStream() {
        this(rand(0, 255));
    }
    public GrayStream(int gray) {
        this.gray = gray;
    }
    
    void update() {
        gray = fudge(gray, COLOR_DELTA, colorMin, colorMax);
        c = color(gray);
    }
}