import std.algorithm, std.range;

pragma(msg, problem_1());

int problem_1()
{
    return iota(1, 1000).filter!"(!(a%3) || !(a%5))".reduce!"a+b";
}
