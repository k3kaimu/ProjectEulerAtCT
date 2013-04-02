module util;

import core.bitop;

import std.algorithm,
       std.functional,
       std.math,
       std.numeric,
       std.range,
       std.traits,
       std.typecons;

///素数かどうか判定する。遅い
bool isPrime_lowspeed(T)(T prime) if(__traits(isIntegral,T))
{
    if(prime <= 1)return false;
    else if(prime == 2)return true;
    else if(!(prime%2))return false;
    
    T root = cast(T)sqrt(cast(float)prime) + 1;
    
    for(T i = 3; i < root; i+=2)
        if((prime % i) == 0) return false;
    
    //もしfalseされなかったら
    return true;
}

///素数かどうか判定する。ちょっと高速
bool isPrime(T)(T src) if(__traits(isIntegral,T))
{
    if(src <= 1)return false;
    else if(src < 4)return true;
    else if(!(src&1))return false;
    else if(((src+1)%6) && ((src-1)%6))return false;
    
    T root = cast(T)sqrt(cast(float)src) + 1;
    
    for(T i = 5; i < root; i += 6)
        if(!((src%i) && ((src)%(i+2))))
            return false;

    return true;
}
unittest{
    import std.range;
    assert(iota(1000000L).unaryFun!(a => a.adjoin!(
                        (a => a.filter!isPrime),
                        (a => a.filter!isPrime_lowspeed))
           ).unaryFun!(a => a[0].equal(a[1])));
}


/++フェルマーの方法(平方差分法)から素因数分解を行います。
Example:
---
assert(equal(primefactor(128),[tuple(2,7u)]));
assert(equal(primefactor(412),[tuple(2,2u),tuple(103,1u)]));
assert(equal(primefactor(512),[tuple(2,9u)]));
assert(equal(primefactor(27),[tuple(3,3u)]));
assert(equal(primefactor(153),[tuple(3,2u),tuple(17,1u)]));
assert(equal(primefactor(14402),[tuple(2,1u),tuple(19,1u),tuple(379,1u)]));
assert(equal(primefactor(75),[tuple(3,1u),tuple(5,2u)]));
---
+/
Tuple!(T,uint)[] primeFactorize(T)(T n) if(isSigned!T)
in{
    assert(n >= 0);
}
body{
    typeof(return) dst;
    alias E = ElementType!(typeof(dst));

    if(!(n&1)){ //if(n.isEven)
        if(n == 0)
            return dst;
        
        static if(is(T == int) || is(T == uint))
        {
            dst ~= E(2, bsf(cast(uint)n));
            n >>= dst[0][1];
        }
        else
        {
            dst ~= E(2, 0);
            while(!(n&1)){
                n >>= 1;
                ++dst[0][1];
            }
        }

        if(n == 1)
            return dst;
    }
    
    if(isPrime(n))
        return dst ~ E(n, 1u);
    
    T x = cast(T)sqrt(cast(real)n),
      y,
      diff = x^^2 - y^^2 - n;

    while(diff != 0){
        if(diff < 0){
            diff += x;
            ++x;
            diff += x;
        }else{
            diff -= y;
            ++y;
            diff -= y;
        }
    }

    T p = x + y,
      q = x - y;

    if(p == q){
        auto tmp = primeFactorize(p);

        foreach(ref tp; tmp)
            tp[1] += tp[1];

        return dst ~ tmp;
    }

    
    bool bp = !isPrime(p), bq = !isPrime(q);
    
    if(bp || bq){
        auto ps = appender!(T[])();
        if(bp)
            foreach(g; primeFactorize(p))
                foreach(i; 0 .. g[1])
                    ps.put(g[0]);
        else
            ps.put(p);
        
        if(bq)
            foreach(g; primeFactorize(q))
                foreach(i; 0 .. g[1])
                    ps.put(g[0]);
        else
            ps.put(q);
        
        auto psd = ps.data;
        auto d = sort(psd).group;
        if(d.front[0] == 1)
            d.popFront;
        
        return dst ~ array(d);
    }

    return dst ~ ((p == q) ? [Tuple!(T,uint)(q, 2u)]
                           : [Tuple!(T,uint)(q, 1u),Tuple!(T,uint)(p, 1u)]);
}
unittest{
    assert(equal(primeFactorize(128),  [tuple(2,7u)]));
    assert(equal(primeFactorize(412),  [tuple(2,2u), tuple(103,1u)]));
    assert(equal(primeFactorize(512),  [tuple(2,9u)]));
    assert(equal(primeFactorize(27),   [tuple(3,3u)]));
    assert(equal(primeFactorize(153),  [tuple(3,2u), tuple(17,1u)]));
    assert(equal(primeFactorize(14402),[tuple(2,1u), tuple(19,1u), tuple(379,1u)]));
    assert(equal(primeFactorize(75L),  [tuple(3L,1u), tuple(5L,2u)]));

    enum a = 12.primeFactorize();
    enum b = 12L.primeFactorize();
}


///数をbase進の桁ごとに区切った配列を返す。例123→[1,2,3].reverse
int[] splitdigit(uint base = 10, T)(T a){
    auto dst = appender!(int[])();
    //Tを桁ごとに区切ったものを配列として返す。
    while(a != 0){
        static if(base != 2){
            dst.put(a%base);
            a /= base;
        }else{
            dst.put(a&1);
            a >>= 1;
        }
    }
    return dst.data;
}
unittest{
    assert(equal(splitdigit(123), [1,2,3].reverse));
}

///回文数かどうか判定
bool isPalindromic(uint Base = 10,T)(T a){
    auto spdg = splitdigit!Base(a);
    return equal(spdg,spdg.dup.reverse);
}
unittest{
    assert(121.isPalindromic);
    assert(111.isPalindromic);
    assert(!123.isPalindromic);
    assert(1221.isPalindromic);
    assert(!1233.isPalindromic);
}

///最小公倍数を返す
T lcm(T)(T x,T y){
    if(x==0 || y==0)
        return 0;
    
    return x*(y/gcd(x,y));
}
unittest{
    assert(lcm(1, 1) == 1);
    assert(lcm(2, 1) == 2);
    assert(lcm(1, 2) == 2);
    assert(lcm(2, 2) == 2);
    assert(lcm(2, 3) == 6);
}