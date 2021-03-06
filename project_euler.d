import std.range        : recurrence, iota, popFrontN, zip, take, cycle, retro, until, sequence, ElementType;
import std.algorithm    : map, reduce, filter, sort, equal, find, uniq, group, minCount;
import std.ascii        : isDigit, isAlpha, isAlphaNum;
import std.bigint       : BigInt;
import std.stdio        : writeln, writefln;
import std.functional   : curry;
import std.file         : readText;
import std.math         : log10, sqrt;
import std.string       : splitLines, split;
import std.datetime     : StopWatch;
import std.typecons     : Tuple;
import std.conv         : parse, to;
import std.array        : array, front, empty, popFront, appender;

import alice.arith.method;
import alice.arith.squence;
import alice.arith.fraction;
import alice.util.utility;
import alice.util.tmp;

pragma(lib,"alice");

void main(){
    StopWatch sw;
    sw.start;
    /*
    foreach(i; IotaTuple!(1, 100)){
        static if(__traits(compiles,mixin("problem_"~i.stringof~"()"))){
            StopWatch sw1;
            sw1.start;
            mixin("write(\""~ i.stringof ~"   : \",problem_"~i.stringof~");");
            sw1.stop;
            writeln("\t time :   ",sw1.peek.msecs);
        }
    }*/

    //pragma(msg, problem_1());
    //pragma(msg, problem_2());
    //pragma(msg, problem_3());
    //pragma(msg, problem_4());
    //pragma(msg, problem_5());
    //pragma(msg, problem_6());
    //pragma(msg, problem_7());
    //pragma(msg, problem_8());
    //pragma(msg, problem_9());
    //pragma(msg, problem_10());    //out of memory
    //pragma(msg, problem_11());
    //pragma(msg, problem_12());
    //pragma(msg, problem_13());
    //pragma(msg, problem_14());    //out of memory
    //pragma(msg, problem_15());
    //pragma(msg, problem_16());    //流石にBigIntを実装し直すのは…
    //pragma(msg, problem_17());
    //pragma(msg, problem_18());
    //pragma(msg, problem_19());
    //pragma(msg, problem_20());    //BigInt
    //pragma(msg, problem_21());
/*
    writeln(problem_1);     //233168
    writeln(problem_2);     //4613732
    writeln(problem_3);     //6857
    writeln(problem_4);     //906609
    writeln(problem_5);     //237292560
    writeln(problem_6);     //25164150
    writeln(problem_7);     //104743
    writeln(problem_8);     //40824
    writeln(problem_9);     //31875000
    writeln(problem_10);    //142913828922
    writeln(problem_11);    //70600674
    writeln(problem_12);    //76576500
    writeln(problem_13);    //5537376230
    writeln(problem_14);    //837799
    writeln(problem_15);    //137846528820
    writeln(problem_16);    //1366
    writeln(problem_17);    //21124
    writeln(problem_18);    //1074
    writeln(problem_19);    //171
    writeln(problem_20);    //648
    writeln(problem_21);    //31626
    writeln(problem_22);    //871198282
    writeln(problem_23);    //4179871
    writeln(problem_24);    //2783915460
    writeln(problem_25);    //4782
    writeln(problem_26);    //983
    writeln(problem_27);    //-59231
    writeln(problem_28);    //669171001
    writeln(problem_29);    //9183
    writeln(problem_30);    //443839
    writeln(problem_31);    //73682
    writeln(problem_32);    //45228
    writeln(problem_33);    //100
    writeln(problem_34);    //40730
    writeln(problem_35);    //55
    writeln(problem_36);    //872187
    writeln(problem_37);    //748317
    writeln(problem_38);    //932718654
    writeln(problem_39);    //840
    writeln(problem_40);    //210
    writeln(problem_41);    //7652413
    writeln(problem_42);    //162
    writeln(problem_43);    //16695334890
    writeln(problem_44);    //5482660
    writeln(problem_45);    //1533776805
    writeln(problem_46);    //5777
    writeln(problem_47);    //134043
    writeln(problem_48);    //9110846700
    writeln(problem_49);    //296962999629
    writeln(problem_50);    //997651
    writeln(problem_51);    //121313
    writeln(problem_52);    //142857
    writeln(problem_53);    //4075
    writeln(problem_54);    //376
    writeln(problem_55);    //249
    writeln(problem_56);    //972
    writeln(problem_57);    //153
    writeln(problem_58);    //26241
    writeln(problem_59);    //107359
    writeln(problem_60);    //26033
    writeln(problem_61);    //28684
    writeln(problem_62);    //127035954683
    writeln(problem_63);    //49
    writeln(problem_64);    //1322
    writeln(problem_65);    //272
    writeln(problem_66);    //661
    writeln(problem_67);    //7273
    writeln(problem_68);    //6531031914842725
    writeln(problem_69);    //510510
    writeln(problem_70);    //8319823
    writeln(problem_71);    //428570
    writeln(problem_72);    //303963552391
    writeln(problem_73);    //7295372
    
    
    writeln(problem_77);    //71
    writeln(problem_78);    //55374
    
    writeln(problem_87);    //1097343

    writeln(problem_92);    //8581146
    
    writeln(problem_97);    //8739992577
    
    writeln(problem_99);    //709
*/
    sw.stop;
    writefln("Total Time is %d[ms]",sw.peek().msecs);
}

int problem_1(){
    return reduce!"a+b"(filter!"!(a%3)||!(a%5)"(iota(1,1000)));
}


///1,2,3,5,8,13,21,34,55,89,…というフィボナッチ数列の400万を超えない範囲での偶数項の総和。
int problem_2(){
    //上記フィボナッチ数列では2+8*4 = 34, 8+34*4 = 55+ 89という具合になっている。つまり偶数項だけではa[n] = a[n-1]*4+a[n-2]
    //auto fib = takeWhile(recurrence!"a[n-2]+a[n-1]*4"(2,8),4000000);
    //return reduce!"a+b"(fib);
    return recurrence!"a[n-2] + a[n-1] * 4"(2,8).until!"a >= b"(4000000).reduce!"a + b";
}


///Ans. 6857
long problem_3(){
    auto divs = primefactor(600851475143L);
    return divs[$-1][0];
}

int problem_4(){
/+
3桁の二つの数の積で表せれる回文数の最大値をもとめるため、
3桁*3桁=6桁について考えれば良い。
まず、先頭三桁から後ろの3桁を算出する。
その後、その数字の約数を列挙し、その約数内の3桁の数tについて
n / t が3桁になればnが解である。
+/
    foreach(m; iota(999, 99, -1)){
        auto n = m * 1000 + (m%10)*100 + (m/10)%10*10 + m/100%10;
        
        foreach(d; m..1000){
            if(!(n%d)){
                if((n/d).to!string.length == 3)
                    return n;
            }
        }
    }
    assert(0);
}

///1から20までですべて割れる数の最小数は？　→　1から20までの最小公倍数 Ans.232792560
int problem_5(){
    return reduce!lcm(iota(2,21));
}

int problem_6(){
    auto num = iota(1,101);
    return reduce!"a+b"(num)^^2 - reduce!"a+b"(map!"a*a"(num));
}

int problem_7(){
/+
ガウスによると、N以下の素数の数は
N/logeN
よりも多い。
よって、N/logeN = 10_000となる数について考えよう。
エクセルで10_000以上となる数を探すと、131072で調度良いだろう。
+/
    return eratosthenesSieve(131072)[10_000];
}


auto arrayCTFE(E)(E[] array)
{
    return array;
}


auto arrayCTFE(R)(R range)if(!isArray!R)
{
    ElementType!R[] arr;
    foreach(e; range)
        arr ~= e;
    return arr;
}

int problem_8(){

    int[] nums;
    if(__ctfe)
        nums = arrayCTFE(map!(a=>to!int(cast(string)[a]))(reduce!"a~b"(splitLines(import("problem_8.txt")))));
    else
        nums = array(map!(a=>to!int(cast(string)[a]))(reduce!"a~b"(splitLines(readText("problem_8.txt")))));
    
    int[] muls;
    for(int i=0;i<=nums.length-5;++i)
        muls ~= reduce!"a*b"(nums[i..i+5]);
    sort!"a > b"(muls);
    return muls.front;
}

///a^2+b^2=c^2となるabcでa+b+c=1000となるabcについて、a*b*c
int problem_9(){
/+
原始ピタゴラス数について考える。
原始ピタゴラス数とは、直角三角形の整数比のことである。
原始ピタゴラス数を生成する式が存在して、
mとnは互いに素な自然数で、どちらか一方は偶数とすると、
・a = | m^2 - n^2 |
・b = 2mn
・c = m^2 + n^2
となる。
ここで、周の長さはa+b+c = 2m^2 + 2mn 又は2n^2 +2mnとなる。
前者は(m > n)のときで、後者は(m < n)のときである。
よって2m(m+n)又は2n(m+n)をLとして、
Lの整数倍が500になるようなLを探す。
そのようなLについて、Lが500になるようにa,b,cを整数倍したものの積を返せばよい
+/
    for(int i=2;i<=22;i+=2){
        bool[] euclid;      //互いに素かどうか
        euclid.length = i;
        for(int j=0;j<i;++j)
            euclid[j] = gcd(i,j) == 1 ? true : false;
        
        for(int j=1;j<i;j+=2)
            if(euclid[j]){
                int s = i*(i+j);
                if(s > 500)
                    break;
                if(gcd(s,500) == s){
                    //writeln(tuple(i, j));
                    return (500/s)^^3 * (i^^2 - j^^2) * 2*i*j * (i^^2 + j^^2);
                }
            }
        
        for(int j=i+1;j<=22;j+=2)
            if(euclid[j%i]){
                int s = j*(i+j);
                if(s > 500)
                    break;
                if(gcd(s,500) == s){
                    //writeln(tuple(i, j));
                    return (500/s)^^3 * (j^^2 - i^^2) * 2*i*j * (i^^2 + j^^2);
                }
            }
    }
    assert(0);
}

long problem_10(){
    return reduce!"a+b"(0L,eratosthenesSieve(2_000_000));
}

int problem_11(){
    int[][] nums;
    if(__ctfe)
        nums = import("problem_11.txt").splitLines.map!(a => a.split(" ").map!(a => parse!int(a)).arrayCTFE).arrayCTFE;
    else
        nums = "problem_11.txt".readText.splitLines.map!(a => a.split(" ").map!(a => parse!int(a)).array).array;
    int[] results;
    
    //左右と上下
    for(int i=0;i<20;++i)
        for(int j=3;j<20;++j){
            results ~= nums[i][j-3]*nums[i][j-2]*nums[i][j-1]*nums[i][j];
            results ~= nums[j-3][i]*nums[j-2][i]*nums[j-1][i]*nums[i][j];
        }
    
    //右に降りていく
    for(int i=0;i<16;++i)
        for(int j=0;j<16;++j)
            results ~= nums[i][j]*nums[i+1][j+1]*nums[i+2][j+2]*nums[i+3][j+3];
    
    //左に降りていく
    for(int i=0;i<16;++i)
        for(int j=3;j<20;++j)
            results ~= nums[i][j]*nums[i+1][j-1]*nums[i+2][j-2]*nums[i+3][j-3];
    
    return retro(sort(results))[0];
}

int problem_12(){
/+
約数について、
nを素因数分解を行うと、
n = Π(pk^ek)
と書ける。互いに素な数abの積の約数の数は、a,bの約数の数の積に等しいため、
約数の数をd(n)とすると、
d(n) = d(p1^e1) * d(Π(2..n)(pk^ek))
ここで、d(p1^e1)について考えると、約数の数はe1+1個であることがわかる。
よって、
d(n) = Π(ek+1)
となる。
+/
    auto primes = eratosthenesSieve(10_000);
    //素因数分解
    Tuple!(int,uint)[] primefactor_12(int x){
        //auto pr = satisfysquence!isPrime(2);        //素数列
        auto app = appender!(Tuple!(int,uint)[])();
        bool f;
        
        for(int i=0;x > 1 && i<primes.length;++i){
            f = false;
            while(!(x%primes[i])){
                if(!f)
                    app.put(Tuple!(int,uint)(primes[i],1u));
                else
                    app.data[$-1][1] += 1;
                f = true;
                x /= primes[i];
            }
        }
        int nxt = primes.length;
        if(x > 1){
            //auto pr = satisfysquence!isPrime(primes[$-1]);
            auto pr = sequence!"a[0] + n"(primes[$-1]).filter!isPrime;
            pr.popFront;
            for(;pr.front <= x;pr.popFront)
                primes ~= pr.front;
        }
        for(int i = nxt; x > 1 && i < primes.length; ++i){
            f = false;
            while(!(x%primes[i])){
                if(!f)
                    app.put(Tuple!(int,uint)(primes[i],1u));
                else
                    app.data[$-1][1] += 1;
                f = true;
                x /= primes[i];
            }
        }
        return app.data;
    }
    
    auto nums = recurrence!"a[n-1]+n"(0);    //3角数の数列
    for(;;nums.popFront){
        if(nums.front & 3)
            continue;
        int n = reduce!"a*(b[1]+1)"(1,primefactor_12(nums.front));
        if(n > 500)
            return nums.front;
    }
}

string problem_13(){
    return import("problem_13.txt").splitLines.map!(a => a[0 .. 12].parse!(ulong)).reduce!"a+b".to!string[0 .. 10];
}

int problem_14(){
    int[] result = [0, 0, 1];//2までの長さ
    result.length = 1000000;
    int[] nums;
    int cnt;
    Tuple!(uint,uint) cmpnum = tuple(0u,0u);        //最大のものを所持(num,count)
    foreach(long i; 3..1000000){
        if(result[cast(uint)i] != 0)
            continue;
    
        if(!(i&1)){        //偶数の処理
            result[cast(uint)i] = result[cast(uint)i/2] + 1;
            continue;
        }
        if(!((i+3)&3)){
            result[cast(uint)i] = result[cast(uint)((3*(i+3)/4)-2)] + 3;
            if(i*3+1 < 1000000)
                result[cast(uint)i*3+1] = result[cast(uint)i]-1;
            if((i*3+1)/2 < 1000000)
                result[cast(uint)(i*3+1)/2] = result[cast(uint)i]-2;
            continue;
        }
    
        
        nums = [cast(int)i];
        cnt = 0;
        auto ii = i;
        while(1){
            if(!(ii&1)){
                ii /= 2;
                ++cnt;
                if(ii < 1000000 && result[cast(uint)ii] != 0){
                    for(int j=0;j<nums.length;++j)
                        if(nums[j] != 0)
                            result[nums[j]] = result[cast(uint)ii] + cnt - j;
                    ii = nums[0];    //もとの数の復元
                    
                    //最大値の更新
                    if(cmpnum[1] < result[nums[0]]){
                        cmpnum[1] = result[nums[0]];
                        cmpnum[0] = cast(uint)ii;
                    }
                    break;
                }else{
                    if(ii < 1000000 && result[cast(uint)ii] == 0)
                        nums ~= cast(int)ii;
                    else
                        nums ~= 0;
                }
            }else{
                ++cnt;
                ii = ii*3+1;
                if(ii < 1000000 && result[cast(uint)ii] == 0)
                        nums ~= cast(int)ii;
                    else
                        nums ~= 0;
            }
        }
    }
    return cmpnum[0];
}

long problem_15(){
/+
たとえば、(x,y)の位置に行くのに50通りあれば、(x-1,y)にも50通り、(x,y-1)にも50通りあるので、
通り数を後ろに伝搬させていけば高速に求めれる
+/
    long[21][21] cnt;
    cnt[0][0] = 1;
    for(int s=0;s<41;++s){
        for(int i=0;i<21;++i){
            int j = s - i;
            if(j > 20 || j < 0)
                continue;
            
            if(i == 20 && j == 20){
                return cnt[20][19] + cnt[19][20];
            }
            else if(i == 20)
                cnt[20][j+1] += cnt[20][j];
            else if(j == 20)
                cnt[i+1][20] += cnt[i][20];
            else{
                cnt[i+1][j] += cnt[i][j];
                cnt[i][j+1] += cnt[i][j]; 
            }
        }
    }
    assert(0);
    return -1;
}

int problem_16(){
    BigInt a = 1;
    a <<= 1000;
    return reduce!"a+b"(splitdigit(a));
}

int problem_17(){
    //one,two,three,four,five,six,seven,eight,nine
    int[] one = [0,3,3,5,4,4,3,5,5,4];
    //ten,eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen,nineteen
    int[] ten = [3,6,6,8,8,7,7,9,8,8];
    //ten,twenty,thirty,forty,fifty,sixty,seventy,eighty,ninety
    int[] x10 = [0,3,6,6,5,5,5,7,6,6];
    
    int s = 0;
    for(int i=0;i<1000;++i){
        auto a = splitdigit(i);
        if(a.length == 3){
            s += one[a[2]] + "hundred".length;
            if(a[0] != 0 || a[1] != 0)
                s+= "and".length;
                
            if(a[1] == 1){
                s += ten[a[0]];
            }else{
                s += x10[a[1]] + one[a[0]];
            }
        }else if(a.length == 2){
            if(a[1] == 1){
                s += ten[a[0]];
            }else{
                s += x10[a[1]] + one[a[0]];
            }
        }else if(a.length == 1)
            s += one[a[0]];
    }
    return s + "onethousand".length;
}

int problem_18(){    //ダイクストラ法
    int[][] tri;

    if(__ctfe)
        tri = import("problem_18.txt").splitLines.map!(a => a.split(" ").map!(to!int).arrayCTFE).arrayCTFE;
    else
        tri = readText("problem_18.txt").splitLines.map!(a => a.split(" ").map!(to!int).array).array;

    int[][] dat = tri.dup;
    dat[0][0] = tri[0][0];
    for(int i=1;i<tri.length;++i){
        for(int j=0;j<=i;++j){
            if(j == 0)
                dat[i][j] = tri[i][j]+dat[i-1][j];
            else if(j == i)
                dat[i][j] = tri[i][j]+dat[i-1][j-1];
            else
                dat[i][j] = tri[i][j] + ((dat[i-1][j] > dat[i-1][j-1])? dat[i-1][j] : dat[i-1][j-1]);
        }
    }
    return reduce!"a > b ? a : b"(dat[$-1]);
}

int problem_19(){

    struct DateRange{
        uint _year;
        uint _month;
        uint _date;
        uint _week;
        enum empty = false;
        
        int[] mds = [0,31,28,31,30,31,30,31,31,30,31,30,31];    //閏年でないバージョン
        
        this(uint y,uint m,uint d,uint w){
            _year = y;
            _month = m;
            _date = d;
            _week = w;
        }
        
        void popFront(){
            ++_date;
            if(_date > monthdays(_year,_month)){
                _date = 1;
                ++_month;
            }
            ++_week;
            if(_week > 6)
                _week = 0;
            
            if(_month > 12){
                _month = 1;
                ++_year;
            }
        }
        
        uint[4] front(){
            return [_year,_month,_date,_week];
        }
        
        
        private:
        int monthdays(uint y,uint m){
            if(m != 2)return mds[m];
            else{
                if(!(y%4) && !(!(y%100) && (y%400)))
                    return 29;
                else
                    return 28;
            }
        }
    }
    
    DateRange dr = DateRange(1900,1,1,1);
    
    //まず1901/1/1まで進める。
    while(1){
        dr.popFront;
        auto a = dr.front;
        if(a[0] == 1901 && a[1] == 1 && a[2] == 1)
            break;
    }
    int cnt=0;
    while(1){
        auto a = dr.front;
        if(equal(a[0..$-1],[2000,12,31]))
            break;
        if(a[2] == 1 && a[3] == 0)
            ++cnt;
        dr.popFront;
    }
    return cnt;
}

int problem_20(){
    return iotaInfinite(100,-1)
    //.takeWhile!"a > b"(0)
    .until!"a <= 0"(0)
    .curry!(reduce!"a*b",BigInt(1))()
    .splitdigit()
    .reduce!"a+b"();
}

int problem_21(){
    auto squ = iota(2,10000);
    auto divSum1 = map!(a => reduce!"a+b"(0,divisor(a)[0..$-1]))(squ);
    auto divSum2 = map!(a => reduce!"a+b"(0,divisor(a)[0..$-1]))(divSum1);
    int sum;
    for(int i=0;i<divSum2.length;++i){
        if(squ[i] == divSum2[i]){
            if(!(squ[i] == divSum1[i]))
                sum += squ[i] + divSum1[i];
            
        }
    }
    return sum/2;        //なぜなら、squ[i]とdivSum1[i]で同じ数が2回出現しているので
}

auto problem_22(){
    int NameToScore_22(string name){
        return reduce!"a+(b-'@')"(0,cast(char[])name);
    }

    string[] names = array(map!(a => a[1..$-1])(readText("problem_22.txt").split(",")));
    names.sort;
    auto score = array(map!(a => NameToScore_22(a))(names));
    for(int i=0;i<score.length;++i)
        score[i] *= i+1;
    return reduce!"a+b"(score);
}

///二つの過剰数の和で書き表せれない数の合計
long problem_23(){
    //auto abund = takeWhile(satisfysquence!(isAbundant!int)(1),28124);
    //auto abund = satisfysquence!(isAbundant!int)(1).until!"a >= b"(28124);
    auto abund = sequence!"a[0] + n"(1).filter!(isAbundant!int).until!"a >= b"(28124);
    bool[] a;
    a.length = 28125;
    bool[] alr;
    alr.length = 28125;
    /*
    for(int i=0;i<abund.length;++i)
        a[abund[i]] = true;
    */
    for(;!abund.empty;abund.popFront){
        a[abund.front] = true;
    }
    
    long sum= 0;
    foreach(i;1..28124){
        if(a[i]){
            int lim = 28124-i;
            foreach(j;i..lim){
                if(a[j] && !alr[i+j]){
                    alr[i+j] = true;
                    sum += i + j;
                }
            }
        }
    }
    return 395465626L-sum;
}

string problem_24(){
    long a = 999999;
    long[] result;
    for(int i=9;i>=0;--i){
        result ~= a / factorial(i);
        a %= factorial(i);
    }
    
    int[] n = [0,1,2,3,4,5,6,7,8,9];
    int[] dst;
    for(int i=0;i<10;++i){
        dst ~= n[cast(uint)result[i]];
        n = n[0..cast(uint)result[i]] ~ n[cast(uint)result[i]+1..$];
    }
    return reduce!"a~to!string(b)"("",dst);
}

int problem_25(){
    BigInt a = 1;
    BigInt b = 1;
    BigInt c = 2;
    BigInt lim = 1;
    int n = 3;
    
    for(int i=1;i<1000;++i){    //2桁以上なら10倍,3桁以上なら100倍すればよいので1000桁以上であるから10^999倍すればよい
        lim *= 10;
    }
    
    while(c < lim){
        a = b;
        b = c;
        c = a + b;
        ++n;
    }
    return n;
}

int problem_26(){
    auto num = array(iota(1,1000));
    auto a = array(map!(OnePerNumRepeatingDecimal_26)(num));
    sort!("a[0] > b[0]")(zip(a,num));
    return num.front;
}
///1/numをしたときの循環節
int OnePerNumRepeatingDecimal_26(int num)
in{
    assert(num != 0);
}
body{
    int[] rep = [1];    //たとえば直前までのあまりが順番に1,4,5,7,6で今回が4なら循環節の長さは4となる。
    int now;
    while(rep[$-1]!=0){
        now = (rep[$-1]*10)%num;
        if(find(rep,now).empty)
            rep ~= now;
        else
            return find(rep,now).length;
    }
    //もしループを抜け出せたのなら循環小数でない。
    return 0;
}


int problem_27(){
    int EulerPrimeFormula_27(Tuple!(int, uint) a){
        int k = 0;
        for(int n=0;;++n){
            if(isPrime(n^^2+a[0]*n+a[1]))
                ++k;
            else
                return k;
        }
    }

    //auto a = array(take(recurrence!"a[n-1]+1"(-999),1999)),
         //sa = takeWhile(satisfysquence!isPrime(2),1000);
    auto a = recurrence!"a[n-1] + 1"(-999).take(1999).array,
         //sa = satisfysquence!isPrime(2).until!"a >= b"(1000);
         sa = sequence!"a[0] + n"(2).filter!isPrime.until!"a >= b"(1000);
    auto p = exhaustive(a,array(sa)).array;
    auto b = p.map!(a => EulerPrimeFormula_27(a)).array;
    sort!("a[1] > b[1]")(zip(p,b));

    return p[0][0] * p[0][1];
}


int problem_28(){
    int sum = 1;
    int t = 1;
    for(int i=1;i<=500;++i){
        for(int j=0;j<4;++j){
            t += 2*i;
            sum += t;
        }
    }
    return sum;
}

///9183
int problem_29(){
    alias Tuple!(int,uint) Pdiv;
    
    ///タプルを整数倍する。
    Pdiv[] mul(Pdiv[] src, int times){
        Pdiv[] dst;
        dst.length = src.length;
        for(int i=0;i<src.length;++i){
            dst[i] = src[i];
            dst[i][1] *= times;
        }
        return dst;
    }
    
    ///タプルの大小を比べる
    int Comp(Pdiv[] a,Pdiv[] b){
        if(a.length > b.length)
            return 1;
        else if(a.length < b.length)
            return -1;
        else{
            for(int i=0;i<a.length;++i){
                if(a[i][0] > b[i][0])
                    return 1;
                else if(a[i][0] < b[i][0])
                    return -1;
                else{
                    if(a[i][1] > b[i][1])
                        return 1;
                    else if(a[i][1] < b[i][1])
                        return -1;
                }
            }
        }
        return 0;
    }
    
    auto iot = iota(2,101).array;                //2から100までの数列
    Pdiv[][] pridivs = iot.map!(a => primefactor(a)).array;
    auto perm = exhaustive(iot,iot);            //総当り
    Pdiv[][] maps;                                //結果を入れておく。
    int[] p;
    for(;!perm.empty;perm.popFront){
        p = perm.front;
        maps ~= mul(pridivs[p[0]-2],p[1]);
    }
    sort!((Pdiv[] a,Pdiv[] b){return Comp(a,b) == 1?true:false;})(maps);
    Pdiv[][] dst;
    for(int i=0;i<maps.length;++i){
        if(!dst.length)
            dst ~= maps[i];
        else
            if(Comp(dst[$-1],maps[i]))
                dst ~= maps[i];
    }
    return dst.length;
}

///Ans. 443839
int problem_30(){
    auto iot = iota(0,10).array;
    int[] ruiz = array(map!"a^^5"(iot));
    auto comb = combination(iot,iot,iot,iot,iot,iot);        //6桁計算
    
    ///各桁の5乗の和を返す
    int ruizyou_p30(int[] src){
        int _sum = 0;
        foreach(e;src){
            _sum += ruiz[e];
        }
        return _sum;
    }
    
    ///配列中の0を消す。
    int[] zero_pop(int[] src){
        int[] dst;
        foreach(e;src)
            if(e)
                dst ~= e;
        return dst;
    }
    
    int[] temp1,temp2;
    int tmp,sum=0;
    for(;!comb.empty;comb.popFront){
        temp1 = zero_pop(comb.front).sort;
        tmp = ruizyou_p30(temp1);
        temp2 = zero_pop(splitdigit(tmp)).sort;
        if(equal(temp2,temp1))
            sum += tmp;
    }
    return sum - 1;        //1の分を引く
}


int problem_31(){

    auto n2  = array(iota(0,101));//2までで200以下を作ってしまえば、あとは1の埋め合わせで表現できるよねっていう発想
    auto n5  = array(iota(0,41));
    auto n10 = array(iota(0,21));
    auto n20 = array(iota(0,11));
    auto n50 = array(iota(0,5));
    auto n1d = array(iota(0,3));
    
    auto exh = filter!(a => (a[0]*2+a[1]*5+a[2]*10+a[3]*20+a[4]*50+a[5]*100 <= 200))(exhaustive(n2,n5,n10,n20,n50,n1d));
    return reduce!"a+1"(1,exh);    //200一個の分を足すから1からスタート
}

int problem_32(){
/+
たとえば、a*b=cと考えて、a,b,cの桁数をAm,Bm,Cmとすると、
Am+Bm=Cm+1またはCmになる。
よって、Am+Bm+Cm = 2(Am+Bm)または2(Am+Bm)-1=9である。
故に、Am+Bm=4または5となる。
しかし、Am+Bm=4のときには、
・Am=1,Bm=3のとき、Cm=3,4となり、9に届かない
・Am=2,Bm=2のとき、Cm=3,4となり、9に届かない
ため、Am+Bm=5であることがわかる。
Am+Bm=5のとき、
・Am=1,Bm=4のとき、Cm=4,5となり、9は範囲となる。
・Am=2,Bm=3のとき、Cm=4,5であり、9は範囲となる。
よって、Am=1,2桁について探索すれば良い。
Amは[1..9]から1桁を取る場合と[1..9]から2桁を取る場合なので、9,72通り
Bmは[1..9]から4桁を取る場合と[1..9]から3桁を取る場合なので、3024,504通り
よって、全通り数は9*3024+72*504=63504通りとなる。十分探索可能な範囲である。
+/

    int[] nums = [1,2,3,4,5,6,7,8,9];
    int[] sums;
    //1桁についての探索
    for(int i=1;i<10;++i){
        auto perm = permutations(nums[0..i-1]~nums[i..$],4);
        for(;!perm.empty;perm.popFront){
            int n = reduce!"a*10+b"(perm.front.dup);
            int[] digs = splitdigit(n*i);
            
            if(digs.length == 4){
                //被っているか判定。
                digs = digs ~ [i] ~ perm.front ~ [0];
                digs.sort;
                digs = array(uniq(digs));
                if(digs.length == 10)
                    sums ~= n*i;
            }
        }
    }
    
    //2桁についての探索。
    for(auto an = permutations(nums,2);!an.empty;an.popFront){
        int[] ns = an.front.dup.sort;
        ns = nums[0..ns[0]-1] ~ nums[ns[0]..ns[1]-1] ~ nums[ns[1]..$];    //anの要素を消す。
        auto bn = permutations(ns,3);
        for(;!bn.empty;bn.popFront){
            int n = reduce!"a*10+b"(bn.front.dup);
            int m = an.front[0]*10+an.front[1];
            int[] digs = splitdigit(n*m);
            
            if(digs.length == 4){
                digs = digs ~ an.front ~ bn.front ~ [0];
                digs.sort;
                digs= array(uniq(digs));
                if(digs.length == 10)
                    sums ~= n*m;
            }
        }
    }
    return reduce!"a+b"(uniq(sums.sort));        //重複をなくして足し合わせる。
}

int problem_33(){
    int[] idig,jdig;
    Fraction p = Fraction(1L,1L),a,b;
    for(long i=1;i<10;++i)
        for(long j=1;j<10;++j)
            for(long k=1;k<10;++k){
                a = Fraction(i*10+j,j*10+k);
                b = Fraction(i,k);
                if(a == b)
                    p *= b;
            }
    p.reduce;
    return p.den.toInt;
}

///Ans.40730
int problem_34(){
    int[] kaiz = array(take(recurrence!"a[n-1] * n"(1),10));        //あらかじめ計算しておくと速い。
    auto a = array(iota(0,10));
    auto comb = combination(a,a,a,a,a,a,a);        //7桁計算
    //int[] first;
    
    ///この関数で各桁の階乗の和を出す。
    int kaizyou_p34(int[] src){
        int _sum=0;
        foreach(e;src){
            _sum += kaiz[e];
        }
        return _sum;
    }
    
    ///配列中の0を消す。
    int[] zero_pop(int[] src){
        int[] dst;
        foreach(e;src)
            if(e)
                dst ~= e;
        return dst;
    }
    
    ///配列中の0の数を数える
    int zero_count(int[] src){
        int dst=0;
        foreach(e;src)
            if(!e)
                ++dst;
        return dst;
    }
    
    int zerot,sum=0,tmp;
    int[] temp;
    for(;!comb.empty;comb.popFront){
        temp = comb.front;
        zerot = zero_count(temp);
        temp = zero_pop(temp);
        tmp = kaizyou_p34(temp);
        for(int i=0;i<zerot;++i){
            if(equal(temp.sort,zero_pop(splitdigit(tmp+i)).sort) 
                &&(tmp+i) == kaizyou_p34(splitdigit(tmp+i)))
                sum += tmp+i;
        }
    }
    
    return sum-3;    //1!と2!の分を引く
}

///100万未満の巡回素数
int problem_35(){
    auto primes = filter!isPrime(iota(3,1000000,2));
    auto tmp = map!(rotationPrime_35)(map!(rotation)(primes));
    return reduce!"a+b"(1,tmp);        //2の分も足すから1
}
///sourceのすべての値が素数なら1を返す。
int rotationPrime_35(int[] src){
    for(int i=0;i<src.length;++i)
        if(!isPrime(src[i]))
            return 0;
    return 1;
}

int problem_36(){
    return reduce!((a,b) => a + b)(0,filter!(a => isPalindromic!10(a) && isPalindromic!2(a))(iota(1,1000000,2)));
}
/*
bool ispal_36(int a){
    return isPalindromic!10(a)&&isPalindromic!2(a);
}*/

int problem_37(){

    ///その数を切り詰めた数がすべて素数かどうか判定する。ただしsrc自体の素数判定はしない。
    bool kiritume_p37(int src){
    
        int[] dig = splitdigit!10(src);
        dig.reverse;
        
        //左から右に桁を省く。例123→23→3
        for(int i=dig.length;i>0;--i){
            if(!isPrime(reduce!"a*10+b"(dig[0..i])))
                return false;
        }

        //右から左へ
        for(int i=0;i<dig.length;++i){
            if(!isPrime(reduce!"a*10+b"(dig[i..$])))
                return false;
            
        }
    
        return true;
    }

    //auto primes = satisfysquence!isPrime(10);
    auto primes = sequence!"a[0] + n"(10).filter!isPrime;
    int sum = 0;
    for(int i=0;i<11;primes.popFront){
        if(kiritume_p37(primes.front)){
            ++i;
            sum += primes.front;
        }
    }
    return sum;
}

///Ans. 932718654
int problem_38(){
    int[] pandig_p38(int src){
        int[] dst;
        for(int i=1;dst.length < 9;++i)
            dst ~= splitdigit(src*i).reverse;
        return dst;
    }

    auto a = iota(1,10000);
    auto onenine = array(iota(1,10));
    int dst = 1,tmp;
    int[] temp;
    foreach(int i;a){
        temp = pandig_p38(i);
        if(temp.length == 9){
            tmp = reduce!"a*10+b"(temp);
            if(dst < tmp && equal(onenine,temp.sort))
                dst = tmp;
        }
    }
    return dst;
}

int problem_39(){
    auto limarr = array(iota(1,500));
    auto exh = exhaustive(limarr,limarr);
    auto m1 = map!(a => isSquare(a[0]^^2+a[1]^^2) ? (a[0]+a[1]+cast(int)sqrt(cast(float)(a[0]^^2+a[1]^^2))) : 0)(exh);
    auto m1arr = array(m1);
    m1arr.sort;
    auto g1 = array(group(m1arr))[1..$];    //0を含めない。
    return (reduce!((a,b) => a[1] > b[1] ? a : b)(g1))[0];
}


int problem_40(){
    string s;
    for(int i=1;s.length <= 1000000;++i)
        s ~= to!string(i);

    return cast(int)(s[0]-'0')*cast(int)(s[9]-'0')*cast(int)(s[99]-'0')*cast(int)(s[999]-'0')*cast(int)(s[9999]-'0')*cast(int)(s[99999]-'0')*cast(int)(s[999999]-'0');
}


int problem_41(){
//[1..9]までの総和は45であるから、9桁のpandigital数はすべて3で割り切れる!
//また[1..8]の総和は36であり、8桁も3で割り切れる。
//1..7は28で、1..6は21で割り切れる。1..5は15で割り切れ、1..4は10で割り切れず,1..3は6で割り切れ、1..2は3で割り切れる。
//よって、7,4についてのみ調べれば良い
    foreach(i;[7,4]){
        auto perm = filter!(a => (a[$-1]&1) && isPrime(reduce!"a*10+b"(a.dup)))(permutations(iota(1,i+1).array().reverse));
        if(!perm.empty)
            return reduce!"a*10+b"(perm.front);
    }
    assert(0);
}

int problem_42(){
    int NameToScore_22(string name){
        return reduce!"a+(b-'@')"(0,cast(char[])name);
    }
    
    string[] words = array(map!(a=>a[1..$-1])(readText("problem_42.txt").split(",")));
    auto score = filter!isTraiangular(array(map!(a => NameToScore_22(a))(words)));
    return reduce!"a+1"(0,score);
}

long problem_43(){
    //10桁のパンディジタル数ならtrueで、10桁のpandigitalを返す。
    Tuple!(bool,int[]) pandigital_43(int[] a){
        bool[10] b;
        int s = 45;
        for(int i=0;i<9;++i){        //aの長さが9であることはわかっている
            if(b[a[i]])
                return tuple(false,cast(int[])[]);
            else{
                b[a[i]] = true;
                s -= a[i];
            }
        }
        return tuple(true,[s]~a);
    }
    
    //桁の列挙を数に変換する。
    long tonum_43(int[] a){
        long dst = 0;
        for(int i=0;i<10;++i)        //aの長さが10であることはわかっている
            dst = dst*10 + a[i];
        return dst;
    }
    int[] d1 = array(iota(0,10));
    auto d2d3d4 = filter!"!(a[2]%2)"(permutations(d1,3));
    auto d5d6d7 = filter!"!(a[1]%5) && !((a[0]*100+a[1]*10+a[2])%7)"(permutations(d1,3));
    auto d8d9d0 = filter!"!((a[0]*100+a[1]*10+a[2])%17)"(permutations(d1,3));
    
    //d2からd0までの9桁の数の配列の配列を作る。d1についてはあとで行う
    auto nums9 = map!(a => a[0] ~ a[1] ~ a[2])(exhaustive(array(d2d3d4),array(d5d6d7),array(d8d9d0)));    //[d2,d3,d4,d5,d6,d7,d8,d9,d0]のように格納。
    auto filt3 = filter!"!((a[1]+a[2]+a[3])%3)"(nums9);    //ここまでで、2,3,5,7,17についての探索終了。
    auto filt11 =filter!"!((a[4]-a[5]+a[6])%11)"(filt3);        //ここまでであとは13について調べれば良い
    auto filt13 =filter!"!((a[5]*100+a[6]*10+a[7])%13)"(filt11);//これが終わればあとはpandigitalかどうかの判定のみ
    auto pand = filter!"a[0]"(map!(a => pandigital_43(a))(filt13));    //9桁のpandigital数かどうか判定し、のこり必要な桁を返す。
    return reduce!"a+b"(map!(a => tonum_43(a[1]))(pand));        //総和を取って終わり。
}

int problem_44(){
    int[] five = [1,5,12,22,35,51,70,92,117,145].reverse;
    int n,p;
    
    bool isPentagonalN(int n){  //方程式x(3x-1)/2 = nの判別式から明らか
        return (isSquare(1+24*n) && !((cast(int)sqrt(cast(real)(1+24*n)) +1)%6));
    }
    
    while(1){
        n = five.length + 1;
        p = (n*(3*n-1))/2;
        for(int i=0;i<n-1;++i){
            if(isPentagonalN(p-five[i])){
                int m = p+five[i];
                    if(isPentagonalN(m))
                        return p-five[i];
            }
        }
        five = [p] ~ five;
    }
}

int problem_45(){
    auto tri = recurrence!"(n*(n+1))/2"(1);
    auto pen = recurrence!"(n*(3*n-1))/2"(1);
    auto hex = recurrence!"n*(2*n-1)"(1);
    
    //popFrontWhile(tri,40755);
    //popFrontWhile(pen,40755);
    //popFrontWhile(hex,40755);
    tri = tri.find!"a >= b"(40755);
    pen = pen.find!"a >= b"(40755);
    hex = hex.find!"a >= b"(40755);
    
    while(1){
        hex.popFront();
        //popFrontWhile(tri,hex.front);
        //popFrontWhile(pen,hex.front);
        tri = tri.find!"a >= b"(hex.front);
        pen = pen.find!"a >= b"(hex.front);
        if(hex.front == tri.front && hex.front == pen.front)
            return hex.front;
    }
    assert(0);
}

int problem_46(){
    auto oddc = filter!(a => !isPrime(a))(recurrence!"a[n-1]+2"(1));
    auto psqu = filter!isPrime(recurrence!"a[n-1]+2"(9));
    int[] primes = [3,5,7];        //奇数から2を引けば奇数となり、平方の2倍にならない。
    //popFrontWhile(oddc,9);
    //popFrontWhile(psqu,7);
    oddc = oddc.find!"a >= b"(9);
    psqu = psqu.find!"a >= b"(7);
    
    loop:
    for(;;oddc.popFront){
        while(primes[$-1] < oddc.front){
            psqu.popFront;
            primes ~= psqu.front;
        }
        foreach(p; primes){
            int n = oddc.front - p;
            if(!(n&1) && isSquare(n/2))
                continue loop;
        }
        return oddc.front;
    }
    assert(0);
}

int problem_47(){
    //alice.arith.mathodのprimefactorを外部の素数リストに対応させたバージョン
    int[] primefactor_47(int x,ref int[] primes){
        if(primes.length == 0)
            primes ~= 2;
        if(primes[$-1] < x){    //外部の素数リストがx以下であれば、更新する
            auto pr = filter!isPrime(recurrence!"a[n-1]+1"(primes[$-1]+1));
            primes ~= pr.front;
            pr.popFront;
            while(primes[$-1] < x){
                primes ~= pr.front;
                pr.popFront;
            }
        }
        if(primes[$-1] == x)
            return [x];
        
        auto app = appender!(int[])();
        bool f;
        
        foreach(p;primes){
            f = false;
            while(!(x%p)){
                if(!f){
                    app.put(p);
                    f = true;
                }
                else
                    app.data[$-1] *= p;
                
                x /= p;
            }
            if(app.data.length > 4)
                return app.data;
            if(f && isPrime(x)){
                app.put(x);
                return app.data;
            }
        }
        return app.data;
    }
    
    int[][4] list;
    int[] primes = [2,3,5,7];
    int n = 644;
    
    
    for(int i=0;i<4;++i,++n){
        auto pflist = primefactor_47(n,primes);
        if(pflist.length != 4){
            i = -1;
            continue;
        }
        list[i] = pflist;
        if(i == 3){
            auto tmp = array(reduce!"a~b"(list.dup));
            if(array(uniq(tmp.sort)).length == 16)
                return reduce!"a*b"(list[0]);
            else
                i = -1;
                continue;
        }
    }
    assert(0);
}

long problem_48(){
    long sum=0;
    long n=1;
    for(int i=1;i<1000;++i){
        if(!(i%10))
            continue;
        n = 1;
        for(int j=0;j<i;++j){
            n *= i;
            n %= 10000000000;
        }
        sum += n;
    }
    return sum % 10000000000;
}

string problem_49(){
    auto psqu = array(filter!isPrime(iota(1000,10000)));
    //return "OK";
    auto comb = combination(psqu,psqu);
    for(;!comb.empty;comb.popFront){
        auto f = comb.front;
        if(f[0] < f[1]){
            int a = f[0];
            f[0] = f[1];
            f[1] = a;
        }else if(f[0] == f[1])continue;
        
        int a = (f[0] - f[1]) + f[0];
        if(a <= psqu[$-1]  && !find(psqu,a).empty){
            if(a != 8147 && f[0] != 4817 && f[1] != 1487){
                if(equal(splitdigit(f[1]).sort,splitdigit(f[0]).sort) && equal(splitdigit(f[0]).sort,splitdigit(a).sort))
                    return reduce!((a,b) => a~to!string(b))("",[f[1],f[0],a]);
            }
        }
        
        a = f[1] - (f[0] - f[1]);
        if(a >= psqu[0] && !find(psqu,a).empty){
            if(a != 1487 && f[0] != 8147 && f[1] != 4817){
                if(equal(splitdigit(f[1]).sort,splitdigit(f[0]).sort) && equal(splitdigit(f[0]).sort,splitdigit(a).sort))
                    return reduce!((a,b) => a~to!string(b))("",[a,f[1],f[0]]);
            }
        }
    }
    //assert(0);
    return "end";
}

auto problem_50(){
     Tuple!(int,int)[] dst;
    enum SIZE = 1000000;
    auto psqu = eratosthenesSieve(SIZE);    //素数リスト
    
    //その数が最長で何個の素数の和で示せるか
    int primesumlength_50(int x){
        int n,tmp;
        
        n = 0;
        tmp = x;
        while(1){        //i=0の時。
            tmp -= psqu[n];
            ++n;
            if(tmp == 0)
                return n;
            else if(tmp < 0)
                break;
        }
        
        for(int i=1;psqu[i]<x;++i){
            tmp += psqu[i-1];        //数列の一番最初の分
            --n;
            if(tmp < 0)
                continue;
            else if(tmp == 0)
                return n;
            else{
                while(1){
                    tmp -= psqu[n+i];
                    ++n;
                    if(tmp == 0)
                        return n;
                    else if(tmp < 0)
                        break;
                }
            }
        }
        return 1;
    }
    
   
    foreach(int p;psqu)
        dst ~= tuple(p,primesumlength_50(p));
    sort!"a[1] > b[1]"(dst);
    return dst[0][0];
}

int problem_51(){
/+
    素数リストの素数をすべて桁ごとに区切る
    その桁をすべてソートする。
    groupする。
    含まれている数
+/
    //素数自体の桁数
    for(int pd = 4; pd < 10; ++pd){
        auto psqu = filter!isPrime(iota(10^^pd,10^^(pd+1)));
        if(pd == 4){
            psqu = filter!isPrime(iota(56003,10^^(pd+1)));
        }
        
        for(;!psqu.empty;psqu.popFront){        //素数リストから順番に調べていく。
            //その素数で、一体いくつの桁が重複していて、その桁がどの位置にあるかを調べる。
            auto sd = splitdigit(psqu.front);
            auto gr = array(group(sd.dup.sort));
            foreach(Tuple!(int,uint) g;gr){
                //その桁がsdのどの位置にあるか判定する。
                int[] pos;
                for(int i=0;i<sd.length;++i)
                    if(sd[i] == g[0])
                        pos ~= i;
                
                //入れ替える桁の数
                for(int td = 1; td <= g[1]; ++td){
                    auto comb = combination(pos,td);    //どの桁を入れ替えるのか
                    
                    for(;!comb.empty;comb.popFront){
                        auto digs = sd.dup;
                        auto c = comb.front;
                        
                        for(int i=0;i < td; ++i)        //0に入れ替え
                            digs[c[i]] = 0;
                        auto p1 = reduce!"a*10+b"(digs.dup.reverse);
                        
                        for(int i=0;i < td; ++i)        //1に入れ替え
                            digs[c[i]] = 1;
                        auto p2 = reduce!"a*10+b"(digs.dup.reverse);
                        
                        for(int i=0;i < td; ++i)        //2に入れ替え
                            digs[c[i]] = 2;
                        auto p3 = reduce!"a*10+b"(digs.dup.reverse);
                        
                        if(isPrime(p1) || isPrime(p2) || isPrime(p3)){    //０または1,2に入れ替えればそのうち一つは素数でなければならない
                            int[] pn;pn.length = 10;
                            pn[0..3] = [p1,p2,p3];
                            for(int i=3;i<=9;++i){
                                for(int j=0;j < td; ++j)
                                    digs[c[j]] = i;
                                pn[i] = reduce!"a*10+b"(digs.dup.reverse);
                            }
                            if(array(filter!isPrime(pn)).length == 8){
                                auto p = filter!isPrime(pn).front;
                                if(splitdigit(p).length == (pd+1))        //先頭の0を防止
                                    return p;
                            }
                        }
                    }
                }
            }
        }
    }
    assert(0);
}

int problem_52(){
    int[] tmp,tmp6,tmp5,tmp4,tmp3,tmp2;
    for(int i=10;;++i){
        tmp = splitdigit(i).sort;
        tmp6 = splitdigit(i*6).sort;
        if(tmp6.length > tmp.length){
            //iの桁を一つあげる。
            i = to!int("999999999999999999999999"[0..tmp6.length-1]);
            continue;
        }
        if(!equal(tmp,tmp6))
            continue;
            
        tmp5 = splitdigit(i*5).sort;
        if(!equal(tmp,tmp5))
            continue;
            
        tmp4 = splitdigit(i*4).sort;
        if(!equal(tmp,tmp4))
            continue;
            
        tmp3 = splitdigit(i*3).sort;
        if(!equal(tmp,tmp3))
            continue;
        
        tmp2 = splitdigit(i*2).sort;
        if(!equal(tmp,tmp6))
            continue;
            
        return i;
    }
}

int problem_53(){    //log(nCr)=log(n!) - log(r!) - log((n-r)!)
    real c;
    int s;
    real[] logsum;            //log(idx!)を格納
    logsum.length = 101;
    logsum[0] = 0;    //log(0!) = log(1) = 0
    for(int i=1;i<101;++i)
        logsum[i] = logsum[i-1]+log10(i);    //log(n!) = log((n-1)!) + log(n)
    
    for(int n=1;n<=100;++n){
        for(int r=1;r<=n;++r){            
            c = logsum[n] - logsum[r] - logsum[n-r];
            if(c >= 6)
                ++s;
        }
    }
    return s;
}

//文字を数値に変換する。
int toNum_54(char src){
    switch(src){
        case 'T':return 10;
        case 'J':return 11;
        case 'Q':return 12;
        case 'K':return 13;
        case 'A':return 14;        //通常は1である。
        default:assert(0);
    }
}

//文字列からカードを作る。
Card toCard_54(string src){
    Card dst;
    dst.num = isDigit((cast(char[])src)[0]) ? to!int(src[0..1]) : toNum_54(((cast(char[])src)[0]));
    
    dst.suit = src[1..2];
    return dst;
}

//5枚の役から数値を算出する。
Value card2Value(Card[] src)
in{assert(src.length == 5);}
body{
    //役なし 2～14(Aは14とする)
    //ワンペア:22から34、つまり20から;
    //ツーペア:大きいペアの数をn2,小さい方をn1として、基数は40+n2*2+n1
    //スリーカード:基数は90
    //ストレート:最後の数で判定。基数は110
    //フラッシュ:フラッシュは一律で130
    //フルハウス:スリーカードの数字をn3,ツーペアの数字をn2として、130+n3*2+n2
    //フォーカード:基数は180
    //ストレートフラッシュ:ストレートの最後の数で判定。基数は200
    //ロイヤルストレートフラッシュ:一律220
    //Valueタプルのvalueにこれらの値を格納し、cardsにカードの値をソートしたものを格納する。
    Value dst;
    dst.cards = array(map!"a.num"(src));
    sort!"a > b"(dst.cards);
    bool flash = true;        //フラッシュ判定
    for(int i=1;i<5;++i)
        flash = flash && (src[0].suit == src[i].suit);
    
    if(flash && dst.cards[0] == 10 && dst.cards[1] == 11 && dst.cards[2] == 12 && dst.cards[3] == 13 && dst.cards[4] == 14){//ロイヤルストレートフラッシュ判定
        dst.value = 220;
        return dst;
    }
    
    //ストレート判定
    bool straight;
    if(dst.cards[0] == 2 && dst.cards[1] == 3 && dst.cards[2] == 4 && dst.cards[3] == 5 && dst.cards[4] == 14)
        straight = true;
        
    if(!straight){
        straight = true;
        for(int i=1;i<5;++i)
            if(dst.cards[i] != (dst.cards[0] - i))
                straight = false;
    }
    
    if(straight && flash){    //ストレートフラッシュ判定.
        dst.value = 200+ dst.cards[4];
        return dst;
    }
    
    //4カードとフルハウスはこの時点で、ストレートとフラッシュに直行しているため、返して良い
    if(straight){
        dst.value = 110 + dst.cards[4];
        return dst;
    }
    
    if(flash){
        dst.value = 130;
        return dst;
    }
    
    auto tmp = array(group(dst.cards));
    sort!"a[1] > b[1]"(tmp);
    if(tmp.length == 2){        //4カードまたはフルハウス判定
        if(tmp[0][1] == 4)        //4カード
            dst.value = 140 + tmp[0][0];
        else                    //フルハウス
            dst.value = 90 + tmp[0][0]*2 + tmp[1][0];
        return dst;    
    }
    
    //スリーカード及び2ペア判定
    if(tmp.length == 3){
        if(tmp[0][1] == 3)        //3カード
            dst.value = 90 + tmp[0][0];
        else{                    //2ペア
            sort!"a[0] > b[0]"(tmp[0..2]);
            dst.value = 40 + tmp[0][0]*2 + tmp[1][0];
        }
        return dst;
    }
    
    if(tmp.length == 4){        //1ペア判定
        dst.value = 20 + tmp[0][0];
        return dst;
    }
    
    //役なしの場合は
    dst.value = dst.cards[0];
    return dst;
}

alias Tuple!(int,"num",string,"suit") Card;    //(num,suit)
    alias Tuple!(int,"value",int[],"cards") Value;

int problem_54(){
    alias Tuple!(int,"num",string,"suit") Card;    //(num,suit)
    alias Tuple!(int,"value",int[],"cards") Value;
    
    
    
    Card[][][] games = array(map!(a => [a[0..5],a[5..10]])(map!(a => array(map!toCard_54(split(a," "))))(splitLines(readText("problem_54.txt")))));
    int n;
    foreach(Card[][] game;games){
        auto p1 = card2Value(game[0]);
        auto p2 = card2Value(game[1]);
        if(p1.value > p2.value)++n;
        else if(p1.value == p2.value){
            for(int i=0;i<5;++i){
                if(p1.cards[i] > p2.cards[i]){
                    ++n;
                    break;
                }else if(p1.cards[i] < p2.cards[i])
                    break;
                if(i == 4)
                    assert(0);
            }
        }
    }
    return n;
}

int problem_55(){
    int cnt;
    foreach(int n;1L..10000L){
        int d;
        BigInt m = n;
        while(1){
            m += reduce!((a,b) => a*10+BigInt(b))(BigInt(0),splitdigit(m));
            ++d;
            if(isPalindromic(m))
                break;
            if(d > 50){
                ++cnt;
                break;
            }
        }
    }
    return cnt;
}

int problem_56(){
    int max = 0;
    foreach(int a;2..100){
        BigInt t = 1;
        foreach(int b;1..100){
            t *= a;
            int ds = reduce!"a+b"(splitdigit(t));
            max = max > ds ? max : ds;
        }
    }
    return max;
}

int problem_57(){
    Fraction[] fs;fs.length = 1000;
    fs[0] = Fraction(3,2);
    for(int i=1;i<1000;++i)
        fs[i] = 1 + (1+fs[i-1]).inverse;
    int cnt;
    foreach(Fraction f;fs){
        if(splitdigit(f.num).length > splitdigit(f.den).length)
            ++cnt;
    }
    return cnt;
}

int problem_58(){
    int n=1;        //対角線上の数の数
    int pn;        //素数の数
    int m=1;
    
    for(int i=1;;i++){
        n += 4;
        for(int j=0;j<4;++j){
            m += 2*i;
            if(isPrime(m))
                ++pn;
        }
        if((cast(real)pn/cast(real)n) < 0.1)
            return 2*i+1;
    }
}

int problem_59(){
    //復号する
    char[] decode_59(char[] src,char[] key){
        char[] dst;
        auto ck = cycle(key);
        for(;!src.empty;src.popFront,ck.popFront)
            dst ~= src.front ^ ck.front;
        return dst;
    }
    int alphaLank_59(dchar a){
        if(isAlpha(a)){
            if(a == 'e')
                return 10;
            else
                return 1;
        }else if(isAlphaNum(a) || a==',' || a=='.')
            return 1;
        else if(a == ' ')
            return 10;
        else
            return -5;
    }
    
    char[] text = array(map!(a => cast(char)parse!int(a))(split(readText("problem_59.txt"),",")));
    Tuple!(int,string)[] spaces;
    for(char ca='a';ca<='z';++ca)
        for(char cb='a';cb<='z';++cb)
            for(char cc='a';cc<='z';++cc)
                spaces ~= tuple!(int,string)(reduce!((a,b)=>a+alphaLank_59(b))(decode_59(text[0..20],[ca,cb,cc])),[ca,cb,cc]);
    auto sorted = sort!"a[0]>b[0]"(spaces);
    //writeln(decode_59(text,cast(char[])sorted.front[1]));
    return reduce!"a+b"(0,decode_59(text,cast(char[])sorted.front[1]));
}

auto problem_60(){
    int numconj_60(int a,int b){
        return a*(10^^(cast(int)log10(cast(float)b) +1)) + b;
    }
    
    bool isPrimes_60(int[] src,int a){
        if(src.length < 1)
            return true;
        foreach(p;src){
            if(!isPrime(numconj_60(p,a)))
                return false;
            if(!isPrime(numconj_60(a,p)))
                return false;
        }
        return true;
    }

    int[][] p3n1 = [[3]];    //素数を順番に追加していき連結したものが素数かどうか判定していく。
    int[][] p3n2 = [[3]];
    int[] sums;
    
    auto primes = primeSquence(7);    //2と3と5をけした状態の素数リスト
    
    foreach(p;primes){
        if(!((p.splitdigit().reduce!"a+b"()+1)%3)){
            int[][] tmp;
            for(int i=0;i<p3n1.length;++i){
                if(isPrimes_60(p3n1[i],p)){
                    tmp ~= p3n1[i] ~ p;
                    if(tmp[$-1].length == 5)
                        sums ~= reduce!"a+b"(tmp[$-1]);
                }
            }
            p3n1 ~= tmp;
            p3n1 ~= [p];
        }else{
            int[][] tmp;
            for(int i=0;i<p3n2.length;++i){
                if(isPrimes_60(p3n2[i],p)){
                    tmp ~= p3n2[i] ~ p;
                    if(tmp[$-1].length == 5)
                        sums ~= reduce!"a+b"(tmp[$-1]);
                }
            }
            p3n2 ~= tmp;
            p3n2 ~= [p];
        }
        if(sums.length != 0)
            return minCount!"a > b"(sums)[0];
    }
    assert(0);
}

int problem_61(){
    auto tri = recurrence!"n*(n+1)/2"(0);
    auto squ = recurrence!"n*n"(0);
    auto pen = recurrence!"n*(3*n-1)/2"(0);
    auto hex = recurrence!"n*(2*n-1)"(0);
    auto hep = recurrence!"n*(5*n-3)/2"(0);
    auto oct = recurrence!"n*(3*n-2)"(0);
    
    Tuple!(int,int[],int[])[][int] squence;
    squence[3] = tri.find!"a >= b"(1000).until!"a >= b"(10000).array.map!(a => tuple(a,splitdigit(a))).map!(a => tuple(a[0],a[1][2..4],a[1][0..2])).array;
    squence[4] = squ.find!"a >= b"(1000).until!"a >= b"(10000).array.map!(a => tuple(a,splitdigit(a))).map!(a => tuple(a[0],a[1][2..4],a[1][0..2])).array;
    squence[5] = pen.find!"a >= b"(1000).until!"a >= b"(10000).array.map!(a => tuple(a,splitdigit(a))).map!(a => tuple(a[0],a[1][2..4],a[1][0..2])).array;
    squence[6] = hex.find!"a >= b"(1000).until!"a >= b"(10000).array.map!(a => tuple(a,splitdigit(a))).map!(a => tuple(a[0],a[1][2..4],a[1][0..2])).array;
    squence[7] = hep.find!"a >= b"(1000).until!"a >= b"(10000).array.map!(a => tuple(a,splitdigit(a))).map!(a => tuple(a[0],a[1][2..4],a[1][0..2])).array;
    squence[8] = oct.find!"a >= b"(1000).until!"a >= b"(10000).array.map!(a => tuple(a,splitdigit(a))).map!(a => tuple(a[0],a[1][2..4],a[1][0..2])).array;
    
    //巡回的なものを探すため、8角数から始まっていると仮定してよい
    Tuple!(int[],int[],bool[9],int[])[] tp;
    foreach(s8;squence[8]){
        for(int i=7;i>=3;--i){
            foreach(sn;squence[i]){
                if(equal(s8[2],sn[1])){
                    bool[9] b;
                    b[8] = true;
                    b[i] = true;
                    tp ~= tuple([s8[0],sn[0]],sn[2],b,s8[1]);
                }
            }
        }
    }
    
    Tuple!(int[],int[],bool[9],int[])[] tpn;
    for(int j=0;j<4;++j){
        foreach(t;tp){
            for(int i=7;i>=3;--i){
                if(t[2][i])
                    continue;
                foreach(sn;squence[i]){
                    if(equal(t[1],sn[1])){
                        bool[9] b = t[2];
                        b[i] = true;
                        tpn ~= tuple(t[0]~sn[0],sn[2],b,t[3]);
                    }
                }
            }
        }
        tp = tpn.dup;
        tpn.length = 0;
    }
    foreach(t;tp){
        if(equal(t[1],t[3]))
            return reduce!"a+b"(t[0]);
    }
    assert(0);
}

string problem_62(){
    auto cube = iotaInfinite(1).map!(a => BigInt(a)*a*a);
    
    foreach(dig;iotaInfinite(3)){
        Tuple!(string,int)[string] list;
        //cube.popFrontWhile!((a,b) => splitdigit(a).length < (b-1))(dig-1);
        cube = cube.find!((a, b) => a.splitdigit.length >= (b-1))(dig - 1);
        //auto cns = cube.takeWhile!((a,b) => splitdigit(a).length < b)(dig);
        auto cns = cube.until!((a,b) => splitdigit(a).length >= b)(dig);
        foreach(c; cns){
            auto a = splitdigit(c);
            a.sort;
            string n = reduce!"a*10+b"(BigInt(0), a).to!string;
            if((n in list) == null){
                list[n] = tuple(c.to!string, 1);
            }else
                list[n][1]++;
        }
        foreach(value;list){
            if(value[1] == 5){
                return value[0];
            }
        }
    }
    assert(0);
}

int problem_63(){
/+
    p = m^^nとする。
    log(p) + 1= log(m^^n) + 1= nとなればよい。(ただし、対数の底は10)
    n(1 - log(m)) = 1であるから、mは1~9となり、
    さらにlog(9) ≒ 0.9542であるから、
    nについては22まで調べれば良い。
+/
    int cnt;
    for(int i=1;i<10;++i){
        BigInt a = 1;
        for(int j=1;j<=23;++j){
            a *= i;
            int[] dig = splitdigit(a);
            if(dig.length == j)
                ++cnt;
            else if(dig.length > j)
                break;
        }
    }
    return cnt;
}

int problem_64(){
    int cnt;
    foreach(int N;2..10000){
        if(isSquare(N))
            continue;
        float rtN = sqrt(cast(float)N);
        Tuple!(int,int,int) an0,an1,an2;
        an0 = tuple(cast(int)rtN,0,1);
        an0[1] = an0[0];
        an1 = an0;
        int c;
        {
            int num = an1[2],
                    den = N - an1[1]^^2,
                    a = cast(int)((rtN+an1[1])*num/den),
                    b = an1[1]-a*den/num;
            an2 = tuple(a,-b,den/num);
        }
        an0 = an2;
        do{
            an1 = an2;
            int num = an1[2],
                den = N - an1[1]^^2,
                a = cast(int)((rtN+an1[1])*num/den),
                b = an1[1]-a*den/num;
            an2 = tuple(a,-b,den/num);
            ++c;
        }while(an0 != an2);
        if(c&1)
            ++cnt;
    }
    return cnt;
}

int problem_65(){
    auto f = fraction(1);
    auto squ = recurrence!"a[n-1]+2"(2).take(33).array().retro();
    f += squ.front;
    f.inverse;
    f += 1;
    squ.popFront;
    foreach(sf;squ){
        f.inverse;
        f += 1;
        f.inverse;
        f += sf;
        f.inverse;
        f += 1;
    }
    f.inverse;
    f += 2;
    return f.num.splitdigit().reduce!"a+b"();
}

int problem_66(){
    BigInt pell_66(long m){
        long a1 = cast(long)sqrt(cast(float)m);
        BigInt Pn = 0,Qn = 1,pn = a1,qn = 1,an = a1,Pn_1,Qn_1,pn_1,qn_1,an_1,pn_2,qn_2;
        {        //n = 2
            Pn_1 = Pn;
            Qn_1 = Qn;
            pn_1 = pn;
            qn_1 = qn;
            an_1 = an;
            
            Pn = an_1;
            Qn = m - an_1^^2;
            an = (a1+Pn)/Qn;
            pn = an * an_1 + 1;
            qn = an;
        }
        do{
            pn_2 = pn_1;
            qn_2 = qn_1;
            Pn_1 = Pn;
            Qn_1 = Qn;
            pn_1 = pn;
            qn_1 = qn;
            an_1 = an;
            
            Pn = an_1 * Qn_1 - Pn_1;
            Qn = (m - Pn^^2)/Qn_1;
            an = (a1+Pn)/Qn;
            pn = an * pn_1 + pn_2;
            qn = an * qn_1 + qn_2;
        }while((pn_1^^2 - m*(qn_1^^2)) != 1);
        return pn_1;
    }
    
    return iota(2,1000).filter!(a => !isSquare(a))().map!(a => tuple(a,pell_66(a)))().reduce!((a,b) => a[1] > b[1] ? a : b)()[0];
}

int problem_67(){    //ダイクストラ法.problem18と同じ
    int[][] tri = array(map!(a => array(map!(a => to!int(a))(a)))(
                    map!(a => split(a," "))(splitLines(readText("problem_67.txt")))
                ));
    int[][] dat = tri.dup;
    dat[0][0] = tri[0][0];
    for(int i=1;i<tri.length;++i){
        for(int j=0;j<=i;++j){
            if(j == 0)
                dat[i][j] = tri[i][j]+dat[i-1][j];
            else if(j == i)
                dat[i][j] = tri[i][j]+dat[i-1][j-1];
            else
                dat[i][j] = tri[i][j] + ((dat[i-1][j] > dat[i-1][j-1])? dat[i-1][j] : dat[i-1][j-1]);
        }
    }
    return reduce!"a > b ? a : b"(dat[$-1]);
}

BigInt problem_68(){    ///0[ms]
/+
    16桁ということは、10は内側の5個には含まれず、外側の5個にあるはずである。
    さらに、
    sum(1,2,3,4,5,6,7,8,9,10,1,2,3,4,5) = 70
    sum(1,2,3,4,5,6,7,8,9,10,5,6,7,8,9) = 100
    であることから、各枝の合計は14から20のうちのどれかである。
    よって、1,2,3,4,5,6,7,8,9のうちから、内側の5つに入る数を選ぶ。126(通り)
    ここで、その5つの和が5の倍数でない場合にはその数たちには解は無い。
    次に、その5つから2つ選ぶ。(10通り)
    片方の数字をけした4つから2つ選ぶ(6通り×2)
    さらに、3つから2つ(3通り×2)
    2つから2つを選び、(1通り×2)
    最後に残った一つと最初の一つを選ぶ(1通り)
    以上の60480通り以下の数について行えばよい。
    
    !!:別解 : 手で解く
    最大だというので、外側を[6,7,8,9,10]の5つと仮定する。
    必然的に内側は1,2,3,4,5になる。
    sum(1,2,3,4,5)*2 + sum(6,7,8,9,10) = 30 + 40 = 70
    ここで、各枝の合計は14になることがわかる。
    6　→　8
    7　→　7
    8　→　6
    9　→　5
    10 →　4
    このようになるには、
    10 : 1,3
    9   : 2,3又は1,4
    8   : 1,5又は,2,4
    7   : 2,5又は3,4
    6   : 3,5
    のみであるため、
    9,2,3のペアはなくなり、9,1,4のペアとなる。
    8,1,5のペアもなくなり、8,2,4となる。7,3,4が消え7,2,5のみが残る.
    よって、
    6,3,5
    7,2,5
    8,2,4
    9,1,4
    10,1,3
    となる。
    これを並べ替える。
    635と653では653の方が大きいため、653から順番に並べていくと
    653,1031,914,842,725
    よって答えは6531031914842725となる。
+/
    
    BigInt Ans = BigInt(0);
    auto Ns = [1,2,3,4,5,6,7,8,9,10];
    foreach(cent5;combination([1,2,3,4,5,6,7,8,9],5)){
        int bSum = reduce!"a+b"(cent5) + 55;
        if(bSum%5)
            continue;
        bSum /= 5;
        auto round5 = filter!(a => find(cent5,a).empty)(Ns).array();
        
        foreach(b1;permutations(cent5,2)){        //5つから2つ選ぶ。
            if(find(round5,bSum-(b1[0]+b1[1])).empty)
                continue;
            
            auto round4 = filter!(a => a != (bSum-(b1[0]+b1[1])))(round5).array();
            auto cent3 = filter!(a => a != b1[0])(cent5).filter!(a => a != b1[1])().array();

            foreach(b2_1;cent3){
                if(find(round4,bSum-(b1[1]+b2_1)).empty)
                    continue;
                
                auto round3 = filter!(a => a != (bSum-(b1[1]+b2_1)))(round4).array();
                auto cent2 = filter!(a => a != b2_1)(cent3).array();
                
                foreach(b3_1;cent2){
                    if(find(round3,bSum-(b2_1+b3_1)).empty)
                        continue;
                        
                    auto round2 = filter!(a => a != (bSum-(b2_1+b3_1)))(round3).array();
                    auto cent1 = filter!(a => a != b3_1)(cent2).array();
                    
                    if(find(round2,bSum-(b3_1+cent1[0])).empty)
                        continue;
                    auto round1 = filter!(a => a != (bSum-(b3_1+cent1[0])))(round2).array();
                    
                    if(round1[0] == (bSum - (cent1[0]+b1[0]))){
                        
                        //ここまできて、やっと成立。
                        //枝の数を組み立てる。
                        int[][] bnums = [
                            [bSum-(b1[0]+b1[1]),b1[0],b1[1]],
                            [bSum-(b1[1]+b2_1),b1[1],b2_1],
                            [bSum-(b2_1+b3_1),b2_1,b3_1],
                            [bSum-(b3_1+cent1[0]),b3_1,cent1[0]],
                            [bSum-(cent1[0]+b1[0]),cent1[0],b1[0]]
                        ];
                        int lowround = reduce!((a,b) => a[0] < b[0] ? a : b)(bnums)[0];    //外周でもっとも小さい数
                        auto cybn = cycle(bnums);
                        //popFrontWhile!"a[0] != b"(cybn,lowround);        //もっとも小さいものになるまで進める。
                        cybn = cybn.find!"a[0] == b"(lowround);
                        
                        string s;
                        foreach(elem;cybn.take(5))
                            foreach(ns;elem)
                                s ~= ns.to!string();
                        auto bignum = BigInt(s);
                        if(Ans < bignum)
                            Ans = bignum;
                    }
                }
            }
        }
    }
    return Ans;
}

int problem_69(){    ///0[ms]
/+
・オイラーのφ関数について
nを素因数分解して、
n = Π(pk^ek)とする。
ここで、φ(n) = n*Π(1-1/pk)
= Π(pk^ek - pk^(ek-1))となる。


・別解(紙とペンで解く)
f(n) = n/φ(n) = 1/Π(1 - 1/pk)
= Πpk/Π(pk-1)
= Π (pk/(pk-1))
ここで、pkが素数であることを考えると、
g(p) = p/(p-1)
で、g(pk)は、以下のような順番で減少していく。
2>3>5>7>11>13>17>,...,>1
よって、最大となるのは、これらの素数の積でもっとも長く表せれるものであるため、
2*3*5*7*11*13*17 = 510510となる。
+/

    auto primes = eratosthenesSieve(1_001_000);
    Tuple!(int,uint)[][] pfs;    //Primefactorsのメモ
    auto prs = primes.dup;
    for(int n=2;n<=1_000_000;++n){        //素因数分解を行う。
        if(prs[0] < n)
            //popFrontWhile(prs,n);
            prs = prs.find!"a >= b"(n);
        
        if(prs[0] == n){
            pfs ~= [tuple(n,1u)];
            continue;
        }
        
        foreach(p;primes){
            if(!(n%p)){
                auto ts = pfs[n/p -2].dup;
                bool flag;
                foreach(ref t;ts){
                    if(t[0] == p){
                        t[1] += 1;
                        flag = true;
                        break;
                    }
                }
                if(!flag)
                    ts ~= tuple!(int,uint)(p,1u);
                pfs ~= ts;
                break;
            }
        }
    }
    auto tmp = pfs.map!(a => a.map!(b => tuple(b[0]^^(b[1]-1),b[0])).map!(b => b[0]*b[1] - b[0]).curry!(reduce!"a*b",1));
    return tmp.zip(iota(2, 1_000_001)).filter!(a => !isPrime(a[1])).map!(a => tuple(cast(real)a[1]/a[0],a[1])).array.reduce!("a[0] > b[0] ? a : b")[1];
}

int problem_70(){
/+
φ(n)が十分に大きいためには、素因数分解の結果に小さな素数が含まれていなければ良い
さらに、nが素数のときには絶対にφ(n) = n - 1であるから、桁の置換はありえない。
よって、nは √10_000_000 ≒ 3162　付近の2つの素数の積で表せれる数である。
ここで、n = (3162 - p) * (3162 + q)と仮定すると、
(3162-p)/(3161-p) * (3162+q)/(3161+q)
ここで、p,qがそれほど大きくない場合に近似して、
(3162/3161)^^2 ≒ 1.0006328
よって、n/φ(n)は1.0006328付近に存在することがわかる。
さらに、n = 1_000 * 10_000と仮定して、
(1000/999)*(10000/9999) ≒ 1.0011011
であるから、
以上より、n/φ(n)は1.0012以下について調べれば、十分な精度で得られるはずである。

φ関数について、
    n = p * q (p:素数)と書くことができて、
    qの素因数にpが含まれていれば、
        φ(n) = φ(q) * p
     となる。
     含まれていなければ、
        φ(n) = φ(q) * (p - 1)
     となる。
     これは、
     φ(n) = n Π(1-pk)より、
     = Π(pk - 1)pk^(ek-1)
     であるから、
     φ(n*p)は、
     nがpを素因数に持つとき、
        φ(n*p) = φ(n) * p
     pを約数に持たないとき、
        φ(n*p) = φ(n) * (p-1)
     となることがわかる。
+/
    auto faiapp = appender!(Tuple!(int,int)[])();
    faiapp.put(tuple(0,1));
    faiapp.put(tuple(1,1));
    auto primes = eratosthenesSieve(10_001_000);
    auto prs = primes.dup;
    
    //篩にかけて分ける作業
    bool check_70(int n){
        foreach(p;[2,3,5,7,11,13])
            if(!(n%p))
                return true;
        return false;
    }
    
    for(int n=2;n<10_000_000;n++){
        if(prs[0] < n)
            //popFrontWhile(prs,n);
            prs = prs.find!"a >= b"(n);
        
        if(prs[0] == n){
            faiapp.put(tuple(n, n - 1));
            continue;
        }
        
        if(check_70(n)){
            faiapp.put(tuple(n, 1));
            continue;
        }
        
        for(int i=17;;i+=2){
            if(!(n%i)){
                if(!((n/i)%i))
                    faiapp.put(tuple(n, faiapp.data[n/i][1] * i));
                else
                    faiapp.put(tuple(n, faiapp.data[n/i][1] * (i - 1)));
                break;
            }
        }
    }
    
    auto f1 = faiapp.data[2..$].map!(a => tuple(a[0],a[1],cast(real)a[0]/a[1]))().filter!"a[2] < 1.0012"();
    auto f2 = f1.filter!(a => equal(splitdigit(a[0]).sort,splitdigit(a[1]).sort))();
    return reduce!((a,b) => a[2] < b[2] ? a : b)(f2)[0];
}

int problem_71(){   ///0[ms]
/+
たとえば、a/bとしよう。
3/7 ≒ 0.42857142857142857142857142857143
であるから、
0.42から0.429の付近を探すとしよう。
aの範囲は 0 < b < 1,000,000としたとき、
b * 0.42< a < b * 0.429
となる。
bが10のときのaの範囲は
4.2 < a < 4.29
であるから、整数には存在しないことがわかる。
よって任意のbについて、aの範囲は
cast(int)(b*0.42)+1 <= a < cast(int)(b*0.429) + 1
となる。
b = 1,000,000のとき、
420001 <= a < 429001
なので、内部には9000個存在する。
ここで、a = 428571とすると、
a/b は0.428571となり、結構3/7に近くなる。
よって、以下のように改良しよう。
cast(int)(b*0.428571)+1 <= a < cast(int)(b*0.428572) + 1
この範囲であると、b自体が十分に大きく無ければaに範囲は出てこない。
また、最大のbでもaの範囲は1つである。
最後にa/gcd(a,b)とすれば、既約分数になる。

!!!ハイパー別解!!!
ファレイ数列について考える。
a/b と c/dの間には (a+c)/(b+d)という中間数があることがら、
2/5と3/7の間には、5/12があり、
5/12と3/7の間には8/19がある。
つまり、1,000,000以下の最大の5+7kを満たす数kについて、分子の数は2+3kである。
1,000,000以下で最大の5+7kはk = 142856である。
よって2+3k = 2 + 3*142856 = 428570
+/

    Tuple!(int,int,real) near;
    near = tuple(428571, 1_000_000, 428571.0L / 1_000_000.0L);
    real f37 = 3.0L / 7.0L;
    foreach(b;1..1_000_000){
        int lim1 = cast(int)(b * 0.428571) +1;
        int lim2 = cast(int)(b * 0.428572) +1;
        if(lim1 != lim2){
            real t = cast(real)lim1 / b;
            if(t > near[2] && t < f37){
                near[0] = lim1;
                near[1] = b;
                near[2] = t;
            }
        }
    }
    return near[0]/(gcd(near[0],near[1]));
}

long problem_72(){
/+
    ファレイ数列を考える。
    ファレイ数列とは、ある数n以下の新既約分数をソートした順番に並べた数列のことである。
    このファレイ数列の個数Fnは以下の式で示される。
    Fn = 1 + Σ(1..n)φ(m)
    さらに、漸化式の形式で書くと、
    Fn = F(n-1) + φ(n)
    ただし、この数列は0/1と1/1を含むので、
    解答は F(1_000_000) - 2である。
    
    さらに、φ関数はProblem70で高速に解けるようにされているため、ほぼそのまま使う。
    φ関数について、
    n = p * q (p:素数)と書くことができて、
    qの素因数にpが含まれていれば、
        φ(n) = φ(q) * p
     となる。
     含まれていなければ、
        φ(n) = φ(q) * (p - 1)
     となる。
     これは、
     φ(n) = n Π(1-pk)より、
     = Π(pk - 1)pk^(ek-1)
     であるから、
     φ(n*p)は、
     nがpを素因数に持つとき、
        φ(n*p) = φ(n) * p
     pを約数に持たないとき、
        φ(n*p) = φ(n) * (p-1)
     となることがわかる。
+/
    auto prs = eratosthenesSieve(1_001_000);
    auto primes = prs.dup;
    long farey = 2;
    auto faiapp = appender!(int[])([1,1]);
    
    for(int n=2;n<1_000_001;n++){
        if(prs[0] < n)
            //popFrontWhile(prs,n);
            prs = prs.find!"a >= b"(n);
        
        if(prs[0] == n){
            faiapp.put(n - 1);
            continue;
        }
        
        foreach(i;primes){
            if(!(n%i)){
                if(!((n/i)%i))
                    faiapp.put(faiapp.data[n/i] * i);
                else
                    faiapp.put(faiapp.data[n/i] * (i - 1));
                break;
            }
        }
    }
    auto t = faiapp.data;
    foreach(i;2..1_000_001)
        farey += t[i];
    return farey - 2;
}

int problem_73(){
/+
problem70,problem72と同様にファレイ数列について考える
たとえば、
a/b c/dの中間の値は
(a+c)/(b+d)
である。
ゆえに、
まず、a/b,c/dで、
(a+c)/(b+d)の分母b+dが
・1,200を超えない場合
    c/dを現在待っている状態の数を格納するスタックに入れ、a/bと(a+c)/(b+d)について再帰処理を行う
・1,200を超えた場合
    c/dが確定したとして結果の配列に格納する。次にc/dとスタックの最初の値について再帰処理を行う
たとえば、1/3と1/2の間に分母が8までの数について行うと、
確定配列 | 一時所持 | スタック
1/3 | 1/2 | 
1/3 | 2/5 | 1/2
1/3 | 3/8 | 2/5,1/2
1/3,3/8 | 2/5 | 1/2
1/3,3/8,2/5 | 1/2 |
1/3,3/8,2/5 | 3/7 | 1/2
1/3,3/8,2/5,3/7 | 1/2
1/3,3/8,2/5,3/7,1/2
となる。
+/
    alias Tuple!(int,int) Int2;
    Int2[] stack;
    int result = 1;
    Int2 t = Int2(1,2),s = Int2(1,3);
    
    while(1){
        Int2 a = Int2(t[0]+s[0],t[1]+s[1]);
        
        if(a[1] > 12000){
            ++result;       //確定を一つすすめる。
            s = t;
            if(stack.length == 0)
                break;
            
            t = stack[$-1];
            stack = stack[0..$-1];
        }else{
            stack ~= t;
            t = a;
        }
    }
    return result - 2;
}

int problem_74(){
    int[] results;
    int[10] fac = recurrence!"a[n-1] * n"(1).take(10).array();  //0から9の階乗
    results.length = 2_200_000;    //9!*6ぐらい
    results[] = -1;
    results[169] = results[363601] = results[1454] = 3;
    results[871] = results[872] = results[45361] = results[45362] = 2;
    results[69] = 5;results[363600] = 4;
    results[78] = 4;results[45360] = 3;
    results[540] = 2;
    results[145] = 1;
    
    
    
    LP_74:
    foreach(n;1..1_000_000){
        if(results[n] != -1)
            continue;
    
        int t = reduce!((a,b) => a + fac[b])(0,splitdigit(n));
        if(t == n){
            results[n] = 1;
            continue;
        }
       
        
        int cnt = 1;
        int[] hold = [t];
        while(1){
            if(results[t] != -1){
                results[n] = results[t] + cnt;
                foreach(i,h;hold[0..$-1])
                    results[h] = results[t] + cnt - i - 1;
                continue LP_74;
            }
            if(t == n || t == 169 || t == 363601 || t == 1454 || t == 871 || t == 45361 || t == 872 || t == 45362){
                if(t == 169 || t == 363601 || t == 1454)
                    cnt += 3;
                else if(t == 871 || t == 45361 || t == 872 || t == 45362)
                    cnt += 2;
                results[n] = cnt;
                foreach(i,h;hold[0..$-1])
                    results[h] = cnt - i - 1;
                continue LP_74;
            }
            if((hold.length > 2 && t == hold[$-2])){
                --cnt;
                results[n] = cnt;
                foreach(i,h;hold[0..$-1])
                    results[h] = cnt - i - 1;
                continue LP_74;
            }
            t = reduce!((a,b) => a + fac[b])(0,splitdigit(t));
            ++cnt;
            hold ~= t;
        }
    }
    return reduce!"a + ((b == 60) ? 1 : 0)"(0,results[0..1_000_000+1]);
}

int problem_75(){
/+
ピタゴラスの三組数a,b,cについて考える。
mとnを互いに素な数として、m,nのどちらかを偶数にした時、
・a = |m^2 - n^2|
・b = 2mn
・c = m^2 + n^2
となる。
また、3辺の長さの和はa+b+c = 2m^2 + 2mn = 2m(m+n)
・2m^2 + 2mn = 2m(m+n)(m > nのとき)
・2n^2 + 2mn = 2n(m+n)(n > m のとき)
となる。
よって、
2m(m+n) = 1,500,000となるには、
m,nはせいぜい√750,000までについて調べればよく、
よって、750,000までの偶数mに対して、互いに素な整数nについて調べれば良い。
また、周の長さが偶数であるのは明確なので、L/2について考える。
+/
    int[] ls;               //周の長さの半分を格納
    for(int i=2;i<868;i+=2){
        bool[] euclid;      //互いに素かどうか
        euclid.length = i;
        for(int j=0;j<i;++j)
            euclid[j] = gcd(i,j) == 1 ? true : false;
        
        for(int j=1;j<i;j+=2)
            if(euclid[j]){
                ls ~= i*(i+j);
                if(ls[$-1] > 1_500_000){
                    ls = ls[0..$-1];
                    break;
                }
            }
        
        for(int j=i+1;j<868;j+=2)
            if(euclid[j%i]){
                ls ~= j*(i+j);
                if(ls[$-1] > 1_500_000){
                    ls = ls[0..$-1];
                    break;
                }
            }
        
    }
    int[] rs; rs.length = 750_000;
    foreach(l;ls)
        for(int i=l;i<750_000;i+=l)
            ++rs[i];
    
    return reduce!"a+1"(0,filter!"a == 1"(rs));
}

int problem_76(){
/+
分割数をp(n)として
n:p(n)
0:1
1:1
2:2
3:3
4:5
5:7
となっていて、以下の漸化式
p(k) = p(k-1)+p(k-2)-p(k-5)-p(k-7)+p(k-12)+p(k-15)-p(k-22)....
となる。ここで1,2,5,7,12,15,22は5角数(n=1,-1,2,-2,3,-3,4,-4)となる。
つまり、5角数をf(n)とすると、
p(k) = Σ(n=1→∞)(p(k-f(n))+p(k-f(n)))*(-1)^((n mod 2)+1)

ただし、この問題ではnの分割数にn+0が含まれていないので、解答はp(100)-1となる。
+/
    int[] p = [1,1,2,3,5,7];
    int[] pen = [1,2,5,7,12,15];
    auto pengen = iotaInfinite(4).map!(a => [a*(a*3-1)/2, a*(a*3+1)/2]);
    
    for(int n=6;n<=100;++n){
        int pn;
        
        while(pen[$-1] <= n){
            pen ~= pengen.front;
            pengen.popFront;
        }
        
        for(int i=0;pen[i]<=n;++i){
            if(!((i/2)&1))    //0,1,4,5,8,9…なら+の符号
                pn += p[n-pen[i]];
            else
                pn -= p[n-pen[i]];
        }
        p ~= pn;
    }
    return p[100] - 1;  //なぜなら、nの分割数は
}

int problem_77(){
    //BaseをiにしてBigIntで返す
    BigInt toHash_77(int[] as,int i){
        BigInt dst=0;
        foreach(int a;as){
            dst *= i;
            dst += a;
        }
        return dst;
    }

    int[][][] way = [[],[],[[2]],[[3]],[[2,2]],[[2,3],[5]],[[2,2,2],[3,3]],[[2,5],[2,2,3],[7]]];
    int[] primes = [2,3,5,7];
    auto psqu = filter!isPrime(recurrence!"a[n-1]+2"(9));
    for(int i=8;;++i){
        int[][] tmp;
        foreach(p; primes) foreach(w; way[i - p])
            tmp ~= [p] ~ w;
        
        if(psqu.front == i){
            primes ~= i;
            tmp ~= [i];
            psqu.popFront;
        }
        //sort,uniq
        ///tmpの要素の要素をソートする。
        tmp = array(map!(a => array(sort(a)))(tmp));
        auto tps = array(map!(a => tuple(a,toHash_77(a,i)))(tmp));    //tuple(tmp,hash)
        sort!((a,b) => a[1] < b[1])(tps);                            //一番元の配列を配列でソートする
        tmp = array(map!(a => a[0])(uniq!((a,b)=>a[1]==b[1])(tps)));
        if(tmp.length >= 5000)
            return i;
        way ~= tmp;
    }
    assert(0);
}

int problem_78(){
/+
n:p(n)
0:1
1:1
2:2
3:3
4:5
5:7
となっていて、以下の漸化式
p(k) = p(k-1)+p(k-2)-p(k-5)-p(k-7)+p(k-12)+p(k-15)-p(k-22)....
となる。ここで1,2,5,7,12,15,22は5角数(n=1,-1,2,-2,3,-3,4,-4)となる。
つまり、5角数をf(n)とすると、
p(k) = Σ(n=1→∞)(p(k-f(n))+p(k-f(n)))*(-1)^((n mod 2)+1)
さらに、ラマヌジャンによると、p(n)が5で割り切れるには、n=5k+4の形式でないといけないという。
+/
    BigInt[] p = [BigInt(1),BigInt(1),BigInt(2),BigInt(3),BigInt(5),BigInt(7)];
    int[] pen = [1,2,5,7,12,15];
    auto pengen = iotaInfinite(4).map!(a => [a,-a])().map!(a => [(a[0]*(a[0]*3-1))/2,(a[1]*(a[1]*3-1))/2])();
    for(int n=6;;++n){
        BigInt pn = 0;
        
        while(pen[$-1] <= n){    //5角数リストを更新
            pen ~= pengen.front;
            pengen.popFront;
        }
        
        for(int i=0;pen[i]<=n;++i){
            if(!((i/2)&1))    //0,1,4,5,8,9…なら+の符号
                pn += p[n-pen[i]];
            else
                pn -= p[n-pen[i]];
        }
        if(!((n-4)%5) && !(pn%1_000_000))        //ラマヌジャンでn=5k+4
            return n;
        p ~= pn;
    }
    assert(0);
}

int problem_87(){
    auto primes2 = sequence!"a[0] + n"(2L).filter!isPrime.until!"a >= b"(cast(long)(50000000.0L^^0.5L) + 2L).array;
    auto primes3 = primes2.until!"a >= b"(cast(long)(50000000.0L^^(1.0L/3.0L)) + 2L);
    auto primes4 = primes2.until!"a >= b"(cast(long)(50000000.0L^^(0.25L)) + 2L);
    auto perm = exhaustive(primes2, primes3.array, primes4.array);
    auto prime234 = perm.map!"a[0]^^2+a[1]^^3+a[2]^^4";
    long[] filt = prime234.filter!"a < 50000000".array;
    filt.sort;
    return array(uniq(filt)).length;
}


int problem_92(){
    int count=0;
    int[] iot = array(iota(0,10));
    int[10] sq = [0,1,4,9,16,25,36,49,64,81];
    bool[] isto89;
    
    alias reduce!((a,b) => a + sq[b]) digitsq;
    
    //10000000までの数は１回桁の2乗和を取ると(9^2)*7=567以下になる。
    //よって、まず567までの数が89に収束するかしらべる。
    int tmp;
    isto89.length = 568;
    for(int i=1;i<=567;++i){
        tmp = i;
        while(1){
            if(tmp < i){
                isto89[i] = isto89[tmp];
                break;
            }
            else if(tmp == 1)
                break;
            else if(tmp == 89){
                isto89[i] = true;
                break;
            }
            tmp = digitsq(0,splitdigit(tmp));
        }
    }
    
    //カウントする。
    for(auto comb = combination(iot,iot,iot,iot,iot,iot,iot);!comb.empty;comb.popFront){
        if(isto89[digitsq(0,comb.front)])
            count += NumCountFromDigit(comb.front);
    }
    return count;
}

long problem_97(){
    long n = 28433;
    long tenten = 10_000_000_000;
    for(int i=0;i<7830457;++i){
        n <<= 1;
        n %= tenten;
    }
    return (n+1)%tenten;
}

int problem_99(){
    //int[][] src = array(map!(a=>[to!int(a[0]),to!int(a[1])])(map!(a => split(a,","))(readText("problem_99.txt").splitLines)));
    int[][] src = readText("problem_99.txt").splitLines.map!(a => a.split(",")).map!(a => [a[0].to!int, a[1].to!int]).array;

    //auto srcexp = array(map!(a => log10(a[0])*a[1])(src));
    auto srcexp = src.map!(a => log10(a[0]) * a[1]).array;
    auto iot = iota(1, 1 + srcexp.length).array;
    sort!"a[0] > b[0]"(zip(srcexp,iot));
    return iot.front;
}



