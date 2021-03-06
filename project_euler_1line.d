import std.algorithm;
import std.stdio;
import std.range;
import std.functional;
import std.file;
import std.string;
import std.conv;
import std.typecons;
import std.bigint;

import alice.arith.squence;
import alice.arith.method;

import dranges.algorithm;
import dranges.range;

pragma(lib,"alice");
pragma(lib, "dranges");

void main(){
	writeln(problem_1);
	writeln(problem_2);
	writeln(problem_3);
	writeln(problem_4);
	writeln(problem_5);
	writeln(problem_6);
	writeln(problem_7);
	writeln(problem_8);
	writeln(problem_9);
	writeln(problem_10);
    writeln(problem_11);
	writeln(problem_12);
    writeln(problem_13);
	writeln(problem_14);
	writeln(problem_16);
}

int problem_1(){
	return iota(1, 1000)
	.filter!"!(a%3)||!(a%5)"
	.sum;
}

int problem_2(){
	return recurrence!"a[n-2] + a[n-1] * 4"(2, 8)
	.until!"a >= b"(4000000)
	.sum;
}

long problem_3(){
	return primefactor(600851475143)
	.Reverse!(reduce!"max(a, b[0])")(0L);
}

int problem_4(){
	return iota(100, 1000)
	.choose(2)
	.map!"a[0]*a[1]"
	.filter!isPalindromic
	.reduce!"max(a,b)";
}

int problem_5(){
	return iota(2, 20).reduce!lcm;
}

int problem_6(){
	return iota(1, 101).reduce!"a+b"^^2 - iota(1, 101).curry!(reduce!"a+b^^2", 0);
}

int problem_7(){
	return primeSquence(2)
	.zip(iotaInfinite(1))
	.filter!"a[1]==10001"
	.front[0];
}

int problem_8(){
    return readText("problem_8.txt").splitLines
    .Reverse!(reduce!"a~cast(char[])b")(cast(char[])[])
    .map!(a => a-'0')
    .unaryFun!(a => segment!5(a).tmap!"a*b*c*d*e".reduce!max)
}

int problem_9(){
	return iota(1,500)
	.choose(2)
	.filter!(a => isSquare(a[0]^^2+a[1]^^2))
	.tmap!"[a, b, cast(int)sqrt(cast(float)(a^^2 + b^^2))]"
	.tfilter!"a + b + c == 1000"
	.tmap!"a * b * c"
	.front;
}

long problem_10(){
	return primeSquence(2L)
	.until!"a >= b"(2_000_000L)
	.sum;
}

int problem_11(){
	return chain(
		exhaustive(iota(0,20).array,iota(0,20).array).map!"[[a[0],a[1]],[a[0],a[1]+1],[a[0],a[1]+2],[a[0],a[1]+3]]",
		exhaustive(iota(0,20).array,iota(0,20).array).map!"[[a[0],a[1]],[a[0]+1,a[1]+1],[a[0]+2,a[1]+2],[a[0]+3,a[1]+3]]",
		exhaustive(iota(0,20).array,iota(0,20).array).map!"[[a[0],a[1]],[a[0]+1,a[1]-1],[a[0]+2,a[1]-2],[a[0]+3,a[1]-3]]"
	)
	.filter!(a => reduce!"a && 0<=b[0] && b[0]<20 && 0<=b[1] && b[1]<20"(true,a))
	.map!(a => 
		reduce!((b,c) => b * readText("problem_11.txt")
			.splitLines.map!(a => 
				a.split(" ").map!(b => 
					parse!int(b))
				.array)
			.array[c[0]][c[1]])(1,a)
		)
	.reduce!max;
}

int problem_12(){
	return recurrence!"a[n-1]+n"(0)
	.map!(a => tuple(a,divisor(a)))
	.filter!"a[1].length > 500"
	.front[0];
}

long problem_13(){
	return "problem_13.txt".readText.splitLines
	.map!(a => parse!long(a[0..12]))
	.reduce!"a+b"
	.to!string()[0..10].parse!long;
}

int problem_14(){
	return iota(1L,1_000_000L)
	.map!(a => 
		recurrence!"!(a[n-1]&1)?(a[n-1]/2):(a[n-1]*3+1)"(a)
		.until!"a == b"(1).array.length)
	.zip(iota(1, 1_000_000))
	.reduce!"a[0] > b[0] ? a : b"[1];
}

int problem_16(){
	return (BigInt(1)<<1000).splitdigit.reduce!"a+b";
}