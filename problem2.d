import std.algorithm, std.range;

pragma(msg, problem_2());

///1,2,3,5,8,13,21,34,55,89,…というフィボナッチ数列の400万を超えない範囲での偶数項の総和。
int problem_2(){
    //上記フィボナッチ数列では2+8*4 = 34, 8+34*4 = 55+ 89という具合になっている。つまり偶数項だけではa[n] = a[n-1]*4+a[n-2]
    return recurrence!"a[n-2] + a[n-1] * 4"(2, 8).until!"a >= b"(4000000).reduce!"a + b";
}