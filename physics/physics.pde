int objects = 5;
float f[] = new float[objects];
float e[] = new float[objects];
float r[] = new float[objects];
float vx[] = new float[objects];
float vy[] = new float[objects];
int x[] = new int[objects];
int y[] = new int[objects];

void setup() {
    size(500, 500);
    background(color(255));
    
    // Initialize physics stuff
    for (int i = 0; i < objects; i++) {
        f[i] = 12;
        e[i] = 1.01;
        r[i] = 50;
        x[i] = rand(0, width);
        y[i] = rand(0, height);
    }
    
    drawObjects();
}

void draw() {
    //background(color(255));
    updateObjects();
    drawObjects();
}

void updateObjects() {
    for (int i = 0; i < objects; i++) {
        int dx = mouseX - x[i];
        int dy = mouseY - y[i];
        
        vx[i] = velocity(i, dx, vx);
        vy[i] = velocity(i, dy, vy);
        
        for (int j = 0; j < objects; j++) {
            if (j != i) {
                dx = abs(x[j] - x[i]);
                dy = abs(y[j] - y[i]);
                if (dx < r[i])
                    vx[i] = velocity(i, dx, vx);
                if (dy < r[i])
                    vy[i] = velocity(i, dy, vy);
            }
        }
        
        x[i] += round(vx[i]);
        y[i] += round(vy[i]);
    }
}

float velocity(int i, int d, float[] v) {
    return (v[i] + (d / f[i])) / e[i];
}

void drawObjects() {
    noStroke();
    fill(color(200, 0, 0));
    for (int i = 0; i < objects; i++) {
        ellipse(x[i], y[i], 10, 10);
    }
}

int rand(int lo, int hi) {
    return int(random(lo,hi));
}