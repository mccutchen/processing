void save() {
    String filename = "" + year() + zeropad(month()) +
        zeropad(day()) + "-" + zeropad(hour()) + "h" +
        zeropad(minute()) + "m" + zeropad(second()) + "s";
    save(filename + ".png");
}

String zeropad(int n) {
    if (n >= 10) return "" + n;
    else return "0" + n;
}


//---------------------------------------------------------------------
// Fudge functions
// Take an number n and return a different number within +/- delta,
// constraining the results to a certain range
//---------------------------------------------------------------------
int fudge(int n, int delta) {
    if (delta == 0) return n;
    return n + rand(-delta, delta);
}

// Use constrain to limit the results
int fudge(int n, int delta, int lo, int hi) {
    return constrain(fudge(n, delta), lo, hi);
}
int fudge(float n, int delta, int lo, int hi) {
    return fudge(int(n), delta, lo, hi);
}
color fudge(color c, int rdelta, int gdelta, int bdelta, int lo, int hi) {
    return color(
        fudge(c >> 16 & 0xFF, rdelta, lo, hi),
        fudge(c >> 8 & 0xFF, gdelta, lo, hi),
        fudge(c >> 0 & 0xFF, bdelta, lo, hi)
    );
}
int fudgeWrap(int n, int delta, int lo, int hi) {
    return wrap(fudge(n, delta), lo, hi);
}


//---------------------------------------------------------------------
// Wrap functions
// Take a number n and ensure that it falls between lo and hi.
//---------------------------------------------------------------------
int wrap(int n, int lo, int hi) {
    return (n >= lo && n <= hi) ? n : (n < lo) ? hi + n : n - hi;
}


//---------------------------------------------------------------------
// rand
// Generates a random integer between lo and hi
//---------------------------------------------------------------------
int rand(int lo, int hi) {
    return int(random(lo,hi));
}

int noisyRandom(int x, int y, int d) {
     float n = noise(x, y);
    int hi = d;
    int lo = -d;
    return floor(n * (hi - lo)) + lo;
}