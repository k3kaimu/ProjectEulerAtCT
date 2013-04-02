import std.conv,
       std.range;

pragma(msg, problem4());

int problem4(){
/+
3桁の二つの数の積で表せれる回文数の最大値をもとめるため、
3桁*3桁=6桁について考えれば良い。
まず、先頭三桁から後ろの3桁を算出する。
その後、その数字の約数を列挙し、その約数内の3桁の数tについて
n / t が3桁になればnが解である。
+/
    foreach(m; iota(999, 99, -1)){
        auto n = m * 1000 + (m%10)*100 + (m/10)%10*10 + m/100%10;
        
        foreach(d; m .. 1000){
            if(!(n%d)){
                if((n/d).to!string.length == 3)
                    return n;
            }
        }
    }
    assert(0);
}