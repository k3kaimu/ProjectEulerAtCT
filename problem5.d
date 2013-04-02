import std.algorithm,
       std.conv,
       std.range;

import util;

pragma(msg, problem5());

///1から20までですべて割れる数の最小数は？　→　1から20までの最小公倍数 Ans.232792560
int problem5(){
    return iota(2,21).reduce!lcm;
}