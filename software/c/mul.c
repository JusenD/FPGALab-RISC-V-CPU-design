unsigned int __mulsi3(unsigned int a, unsigned int b) {
    unsigned int res = 0;
    while (a) {
        if (a & 1) res += b;
        a >>= 1;
        b <<= 1;
    }
    return res;
}

unsigned int __umodsi3(unsigned int a, unsigned int b) {
    unsigned int bit = 1;
    unsigned int res = 0;

    while (b < a && bit && !(b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return a;
}

unsigned int __udivsi3(unsigned int a, unsigned int b) {
    unsigned int bit = 1;
    unsigned int res = 0;

    while (b < a && bit && !(b & (1UL << 31))) {
        b <<= 1;
        bit <<= 1;
    }
    while (bit) {
        if (a >= b) {
            a -= b;
            res |= bit;
        }
        bit >>= 1;
        b >>= 1;
    }
    return res;
}

int __divsi3(int a, int b) {
    int neg = a*b < 0, flag = 0;
    if(a < 0) {
        flag = 1;
        a = -a;
    }
    if(b < 0) {
        flag = 1;
        b = -b;
    }
    if(neg){
        return -1 * __udivsi3(a, b);
    }
    else if(flag){
        return __udivsi3(a + b-1, b);
    }
    else return __udivsi3(a, b);
}

int __modsi3(int a, int b){
    return a - __divsi3(a, b) * b;
}
