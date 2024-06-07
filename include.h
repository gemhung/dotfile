// ============================ short version =========================
const int mod = 1e9+7;
const int MOD = 1e9+7;
using ll = long long;
constexpr int dir[] = {1,0,-1,0,1};
template<typename T> using VEC = vector<T>; // Ex: vec<std::pair<int, int>
template<typename T> using HEAP_MIN = priority_queue<T, vector<T>, std::greater<T>>;
template<typename T> using HEAP_MAX = priority_queue<T>;
template<typename T> using USET = std::unordered_set<T>;
template<typename T1, typename T2> using UMAP = std::unordered_map<T1, T2>;
#define pb push_back
#define fi first
#define se second
#define all(v) v.begin(), v.end()
#define FOR(i,m,n) for(ll i=(ll)(m);i<(ll)(n);i++)
#define N(v) const int n = v.size()
#define MN(v) const int m = v.size(), n = v[0].size()
#define NM(v) const int m = v.size(), n = v[0].size()

// ============================ long version ==========================
const int mod = 1e9+7;
const int MOD = 1e9+7;
constexpr int dir[] = {1,0,-1,0,1};
bool invalid(int x, int y, int m, int n) {return x < 0 || x >= m || y < 0 || y >= n;}
bool valid(int x, int y, int m, int n) {return x >=0 && x< m && y >= 0 && y < n;}
using LL = long long;
using ll = long long;
using TIII = std::tuple<int, int, int>;
using TLLL = std::tuple<ll, ll, ll>;
using PII = std::pair<int, int>;
using PLL = std::pair<long, long>;
using PSI = std::pair<string, int>;
using PIS = std::pair<int, string>;
using PSL = std::pair<string, ll>;
using PLS = std::pair<ll, string>;
template<typename ...Args> using TU = std::tuple<Args...>;
template<typename T> using VEC = vector<T>; // Ex: vec<std::pair<int, int>
template<typename T> using V = vector<T>; // Ex: vec<std::pair<int, int>
template<typename T> using VV = VEC<VEC<T>>;
template<typename T1, typename T2> using PA = std::pair<T1,T2>; // std::pair<int, int> = PA<int, int> 
template<typename T> using HEAP_MIN = priority_queue<T, vector<T>, std::greater<T>>;
template<typename T> using HEAP_MAX = priority_queue<T>;
template<typename T> using USET = std::unordered_set<T>;
template<typename T1, typename T2> using UMAP = std::unordered_map<T1, T2>;
template<typename T> bool chkmin(T &x, T y) { return (x < y) ? x = y, 1 : 0; }
template<typename T> bool chkmax(T &x, T y) { return (x > y) ? x = y, 1 : 0; }
#define MEMSET(v, init) memset(v, (init), sizeof(v))
#define MEM(v) MEMSET(v, -1)
#define RREP(i,n) for(ll i=(ll)(n)-1;i>=0;i--)
#define FOR(i,m,n) for(ll i=(ll)(m);i<(ll)(n);i++)
#define REPN(n) for(;(ll)n;n--)
#define pb push_back
#define fi first
#define se second
#define mp make_pair
#define PAIR make_pair
#define TUPLE make_tuple
#define all(v) v.begin(), v.end()
#define N(v) const int n = v.size()
#define MN(v) const int m = v.size(), n = v[0].size()

// ================ find all factors
    vector<int> help(int n)
    {
        // Note that this loop runs till square root
        vector<int> ret;
        for (int i=1; i<=std::sqrt(n); i++)
        {
            if (n%i == 0){
                // If divisors are equal, print only one
                if (n/i == i)
                    ret.push_back(i);
                else{ // Otherwise print both
                    ret.push_back(i);
                    ret.push_back(n/i);
                }
            }
        }
        
        return ret;
    }

// ================ 往左找 ================ 
int left_bound(int[] nums, int target) {
    if (nums.length == 0) return -1;
    int left = 0;
    int right = nums.length; // 注意

    while (left < right) { // 注意
        int mid = (left + right) / 2;
        if (nums[mid] == target) {
            right = mid;
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid; // 注意
        }
    }

    // return left;
    if (left >= nums.length || nums[left] != target)
        return -1;
    return left;
}

// ================ 往右找 ================ 
int right_bound(int[] nums, int target) {
    if (nums.length == 0) return -1;
    int left = 0, right = nums.length;

    while (left < right) {
        int mid = (left + right) / 2;
        if (nums[mid] == target) {
            left = mid + 1; // 注意
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid;
        }
    }
    //return left - 1; // 注意
    if (left == 0) return -1;
    return nums[left-1] == target ? (left-1) : -1;
}

// ================ is prime =====================
bool isPrime(int number){
    if(number < 2) return false;
    if(number == 2) return true;
    if(number % 2 == 0) return false;
    for(int i=3; (i*i)<=number; i+=2){
        if(number % i == 0 ) return false;
    }
    return true;
}

// ================ all prime factors ===============
    vector<int> all_primes(int n) {
       vector<int> ret;
       while (n%2 == 0){
           ret.push_back(2);
           n = n/2;
       }
       for (int i = 3; i <= sqrt(n); i = i+2){
          while (n%i == 0){
             ret.push_back(i);
             n = n/i;
          }
       }
        
       if (n > 2)
           ret.push_back(n);
	    
	    return ret;
    }
// ============== union-find, disjoint-set ==========
class DSU {
private:
    vector<int> v, rank, count;
public:
    int group_size;
    DSU(int n): 
        v(vector<int>(n, -1)),
        rank(vector<int>(n, -1)),
        count(vector<int>(n, 1))
    {
        // empty constructor
    }
    int find(int i) {
        if (v[i] != -1) {
            auto r = find(v[i]);
            v[i] = r;
            return r;
        }

        return i;
    }
    void uni(int i, int j) {
        auto r1 = find(i);
        auto r2 = find(j);
        if (r1 == r2) 
            return;
        count[r1] = count[r2] = count[r1] + count[r2];
        if (rank[r1] < rank[r2]) 
            v[r1] = r2;
        else 
            v[r2] = r1; 
        if (rank[r1] == rank[r2]) 
            ++rank[r1];
    }
    // how many verticles in a group in which x is
    int size(int x) {
        return count[find(x)];
    }
};
struct Trie {
    bool is_word = false;
    string word = "";
    int cnt = 0;
    Trie* v[26] = {};

    Trie() {
        for(auto i = 0 ; i < 26; i++)
            v[i] = nullptr;
    }

    void add(const string& s) {
        auto root = this;
        for(auto& c: s) {
            if(!root->v[c-'a'])
                root->v[c-'a'] = new Trie();
            root = root->v[c-'a'];
        }

        root->is_word=true;
        root->word = s;
        root->cnt++;
    }
}
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

// ================ find all occurrence for some substring ==================
    vector<int>help(string& str, string& sub) {

        vector<int> positions; // holds all the positions that sub occurs within str

        int pos = str.find(sub, 0);
        while(pos != string::npos)
        {
            positions.push_back(pos);
            pos = str.find(sub,pos+1);
        }

        return positions;
    }

// ============== math =============================
const int MOD = 1e9+7;
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

// ============== binary index tree (sum) ================
class BIT {
    vector<long long> bt;
public:
    BIT(int n): bt(vector<long long>(n+1, 0)) {
    }
    long long prefix_sum(int i){
        long long sum = 0;
        for (i = i + 1; i > 0; i -= i & (-i))
            sum += bt[i];
        return sum;
    }
    void add(int i, int val){
        for (i = i + 1; i < bt.size() ; i += i & (-i))
            bt[i] += val;
    } 
};


// ============== binary index tree (max) ================
class BIT {
    vector<long long> bt;
public:
    BIT(int n): bt(vector<long long>(n+1, 0)) {
    }
    long long prefix_max(int i){
        long long max = 0;
        for (i = i + 1; i > 0; i -= i & (-i))
            max = std::max(max, bt[i]);
        return max;
    }
    void update(int i, int val){
        for (i = i + 1; i < bt.size() ; i += i & (-i))
            bt[i] = std::max(bt[i], (long long)val);
    } 
};

// ============== segment tree (range max)===========
class SegTreeNode{
    public:
    SegTreeNode* left = NULL;
    SegTreeNode* right = NULL;
    int start, end;
    int info;  // the minimum value of the range
    int pos;
        
    SegTreeNode(int a, int b, int val){  // init for range [a,b] with val
        start = a, end = b;
        if (a==b){
            this->info = val;
            this->pos = a;
            return;
        }        
        int mid = (a+b)/2;
        left = new SegTreeNode(a, mid, val);
        right = new SegTreeNode(mid+1, b, val);            
        if(left->info < right->info){
            this->info = left->info;
            this->pos = left->pos;
        }else {
            this->info = right->info;
            this->pos = right->pos;
        }
    }    
    SegTreeNode(int a, int b, vector<int>& target){  // init for range [a,b] with val
        start = a, end = b;
        if (a==b)
        {
            this->info = target[a];
            this->pos = a;
            return;
        }        
        int mid = (a+b)/2;
        left = new SegTreeNode(a, mid, target);
        right = new SegTreeNode(mid+1, b, target);            
        if(left->info < right->info){
            this->info = left->info;
            this->pos = left->pos;
        }else {
            this->info = right->info;
            this->pos = right->pos;
        }
    }    
    
    void updateRange(int a, int b, int val){     // set range [a,b] with val
        if (b < start || a > end ) // not covered by [a,b] at all
            return;        
        if (a <= start && end <=b){  // completely covered within [a,b]
            info = val;
            pos = a;
            return;
        }
        left->updateRange(a, b, val);
        right->updateRange(a, b, val);
        if(left->info < right->info){
            info = left->info;
            pos = left->pos;
        }else {
            info = right->info;
            pos = right->pos;
        }
    }
    
    std::pair<int, int> queryRange(int a, int b){     // query the maximum value within range [a,b]
        if (b < start || a > end )
            return {INT_MAX, a};  // check with your own logic
        if (a <= start && end <=b)
            return {this->info, this->pos};  // check with your own logic
        
        auto L = this->left->queryRange(a, b);
        auto R = this->right->queryRange(a, b);
        if (L.first < R.first)
            return L;
        else
            return R;
    }  
};

// ============== Merge sort technique ==============
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

// ======================= Range minimum query(rmq) =======================
int tree[10000000] = {};
int build(vector<int>& arr,int start,int end,int i){
    if(start==end)
        return tree[i]=start;
    int q=start+(end-start)/2;
    int left=build(arr,start,q,2*i+1);
    int right=build(arr,q+1,end,2*i+2);

    return tree[i]=arr[left]<arr[right]?left:right;
}

int query(vector<int>& arr,int start,int end,int low,int high,int i){ // start, end is the query range and low, high is the current range
    if(start<=low&&high<=end)
        return tree[i];
    if(high<start||end<low)
        return -1;
    int q=(high+low)/2;
    int left=query(arr,start,end,low,q,2*i+1);
    int right=query(arr,start,end,q+1,high,2*i+2);
    if(left==-1)
        return right;
    if(right==-1)
        return left;

    return arr[left]<arr[right]?left:right;
}

// =======================
long largest_power(long N) {
    //changing all right side bits to 1.
    N = N | (N>>1);
    N = N | (N>>2);
    N = N | (N>>4);
    N = N | (N>>8);
    N = N | (N>>16);
    return (N+1)>>1;
}

int right_most_index(int n) {
    return ffs(n)-1; // 11100 return 2
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
