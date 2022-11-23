const int mod = 1e9+7;
using LL = long long;
using ll = long long;
using PII = std::pair<int, int>;
using PLL = std::pair<long, long>;
using PSI = std::pair<string, int>;
using PSL = std::pair<string, long long>;
constexpr int DY4[]{1, 0, -1, 0}, DX4[]{0, -1, 0, 1};
constexpr int DY8[]{1, 1, 0, -1, -1, -1, 0, 1};
constexpr int DX8[]{0, -1, -1, -1, 0, 1, 1, 1};
#define mem(v, init) memset(v, (init), sizeof(v))
#define RREP(i,n) for(ll i=(ll)(n)-1;i>=0;i--)
#define REP(i,m,n) for(ll i=(ll)(m);i<(ll)(n);i++)
#define REPN(n) for(;(ll)n;n--)
#define pb push_back
#define fi first
#define se second
#define mp make_pair
template <typename T> bool chkMax(T &x, T y) { return (y > x) ? x = y, 1 : 0; }
template <typename T> bool chkMin(T &x, T y) { return (y < x) ? x = y, 1 : 0; }

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
