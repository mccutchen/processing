// Assumes equal height and width
int gridsize = 25;
float[] grid = new float[gridsize * gridsize];

int cellsize;
int offset;

float t = 0f;
float tdelta = 0.01;

void setup() {
    size(500, 500);
    background(255, 255, 255);
    fill(53, 53, 53);
    
    cellsize = width / gridsize;
    offset = cellsize / 2;
    
    for (int i = 0; i < grid.length; i++) {
        grid[i] = noise(i);
    }
}

void draw()  {
    // Redraw the background
    background(255, 255, 255);
    
    // Update the time (for the Perlin noise generator)
    t += tdelta;
    
    for (int i = 0; i < gridsize; i++) {
        for (int j = 0; j < gridsize; j++) {
            // origin
            int x = i * cellsize + offset;
            int y = j * cellsize + offset;
            
            // The index of the current field in the array
            int index = i * gridsize + j;
            
            // Calculate some noise and turn it into an angle in radians
            float n = noise(grid[index] + t);
            float theta = n * PI * 4;
            
            // Calculate the coords for the other end of the line segment
            // http://www.processing.org/learning/tutorials/trig/
            float xd = cos(theta) * offset / 2;
            float yd = sin(theta) * offset / 2;
            
            // Draw the line
            line(x, y, x+xd, y+yd);
        }
    }
}