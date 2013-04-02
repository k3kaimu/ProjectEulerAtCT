import util;

pragma(msg, problem3());

///Ans. 6857
long problem3()
{
    return primeFactorize(600851475143L)[$-1][0];
}