int cols = 50;
int rows = 50;

float[] circles = new float[cols * rows];

int fieldWidth;
int fieldHeight;

int offsetX;
int offsetY;

float t = 0f;
float tdelta = 0.01;

void setup() {
    size(500, 500);
    background(255, 255, 255);
    fill(53, 53, 53);
    
    fieldWidth = width / cols;
    fieldHeight = height / rows;
    offsetX = fieldWidth / 2;
    offsetY = fieldHeight / 2;
    
    for (int i = 0; i < circles.length; i++) {
        circles[i] = noise(i);
    }
    print(circles);
}

void draw()  {
    // Redraw the background
    background(255, 255, 255);
    
    // Update the time (for the Perlin noise generator)
    t += tdelta;
    
    for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
            // origin
            int x = i * fieldWidth + offsetX;
            int y = j * fieldHeight + offsetY;
            
            // The index of the current field in the array
            int index = i * cols + j;
            
            // Calculate some noise and turn it into an angle in radians
            float n = noise(circles[index] + t);
            float theta = n * PI * 4;
            
            // Calculate the coords for the other end of the line segment
            // http://www.processing.org/learning/tutorials/trig/
            float xd = cos(theta) * offsetX;
            float yd = sin(theta) * offsetY;
            
            // Draw the line
            line(x, y, x+xd, y+yd);
        }
    }
}