const int mod = 1e9+7;
using LL = long long;
using ll = long long;
template<class ...Args>
using T = std::tuple<Args...>;
using TIII = std::tuple<int, int, int>;
using TLLL = std::tuple<ll, ll, ll>;
using PII = std::pair<int, int>;
using PLL = std::pair<long, long>;
using PSI = std::pair<string, int>;
using PIS = std::pair<int, string>;
using PSL = std::pair<string, ll>;
using PLS = std::pair<ll, string>;
constexpr int dir[] = {1,0,-1,0,1};
#define mem(v, init) memset(v, (init), sizeof(v))
#define RREP(i,n) for(ll i=(ll)(n)-1;i>=0;i--)
#define REP(i,m,n) for(ll i=(ll)(m);i<(ll)(n);i++)
#define REPN(n) for(;(ll)n;n--)
#define pb push_back
#define fi first
#define se second
#define mp make_pair
template <typename T> bool chkmin(T &x, T y) { return (x < y) ? x = y, 1 : 0; }
template <typename T> bool chkmax(T &x, T y) { return (x > y) ? x = y, 1 : 0; }
template<class T>
using vec = vector<T>; // Ex: vec<std::pair<int, int>
#define all(v) v.begin(), v.end()
#define mn(v) const int m = v.size(), n = v[0].size()

// ================ split string with ' ' into vector<string> ==================
    template <typename Out>
    void split(const std::string &s, char delim, Out result) {
        std::istringstream iss(s);
        std::string item;
        while (std::getline(iss, item, delim)) {
            *result++ = item;
        }
    }

    std::vector<std::string> split(const std::string &s, char delim) {
        std::vector<std::string> elems;
        split(s, delim, std::back_inserter(elems));
        return elems;
    }
    
============== math =============================
long long mul(long long a, long long b) {
    return a * b % MOD;
}

long long power(long long base, long long exp = MOD-2) {
    long long res = 1, y = base;
    while (exp) {
        if (exp&1) res = mul(res, y);
        y = mul(y, y);
        exp >>= 1;
    }
    return res;
}

struct math {
    vector<long long> fact, inv;
    
    math(int n = 1) {
        fact.resize(n+1);
        inv.resize(n+1);
        fact[0] = inv[0] = 1;
        for (int i=1; i<=n; i++) {
            fact[i] = mul(fact[i-1], i);
            inv[i] = power(fact[i]);
        }
    }

    long long comb(int n, int k) {
        return mul(mul(fact[n], inv[k]), inv[n-k]);
    }

    long long perm(int n, int k) {
        return mul(fact[n], inv[n-k]);
    }

} 

============== binary index tree ================
constexpr int static max_n = 50001;
long long bt[max_n + 1] = {};
long long prefix_sum(int i){
    long long sum = 0;
    for (i = i + 1; i > 0; i -= i & (-i))
        sum += bt[i];
    return sum;
}
void add(int i, int val){
    for (i = i + 1; i <= max_n; i += i & (-i))
        bt[i] += val;
} 


==================================================
Merge sort technique

    void help(vector<int>& v,  int l, int r){
        if(l+1 == r)
            return;
        auto mid = l + (r-l)/2;
        
        help(v, l, mid);
        help(v, mid, r);

        for(auto i = l, j=mid ; i< mid && j < r;){
		   // todo
            for ( ;i<mid && v[i] <= (long long)2*v[j]; i++);
            if(i == mid)
                break;
            
            ret += mid-i;
            j++;
        }
        
        std::inplace_merge(v.begin()+l, v.begin()+mid, v.begin()+r);
    }

=======================
 
long largest_power(long N) {
    //changing all right side bits to 1.
    N = N | (N>>1);
    N = N | (N>>2);
    N = N | (N>>4);
    N = N | (N>>8);
    N = N | (N>>16);
    return (N+1)>>1;
}


=======================

	•	Set union A | B
	•	Set intersection A & B
	•	Set subtraction A & ~B
	•	Set negation ALL_BITS ^ A or ~A
	•	Set bit A |= 1 << bit
	•	Clear bit A &= ~(1 << bit)
	•	Test bit (A & 1 << bit) != 0
	•	Extract last bit A&-A or A&~(A-1) or x^(x&(x-1))
	•	Remove last bit A&(A-1)
	•	Get all 1-bits ~0


========================
#include <string>
#include <vector>
#include <algorithm>
#include<unordered_map>
#include<map>
#include<unordered_set>
#include<set>
#include<list>
#include<deque>
#include<queue>
#include<stack>
#include<tuple>
#include<utility>
#include<bitset>
#include<stdio.h>
#include<limits.h>
#include<stdint.h>
#include<cstring>
#include<numeric>
#include <functional>

using namespace std;
