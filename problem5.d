import std.algorithm,
       std.conv,
       std.range,
       std.typetuple;

import util;

pragma(msg, problem5());
pragma(msg, TProblem5!());

///1から20までですべて割れる数の最小数は？　→　1から20までの最小公倍数 Ans.232792560
int problem5(){
    return iota(2,21).reduce!lcm;
}

template TProblem5()
{
    enum TProblem5 = TReduce!(lcm, 1, TIota!(2, 21));
}