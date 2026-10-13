// URL: $(URL)
#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#ifndef ONLINE_JUDGE
#include "algo/debug.h"
#else
#define debug(...) 146;
#endif
using namespace std;
using namespace __gnu_pbds;
template<class T> using ordered_set =tree<T, null_type, less<T>, rb_tree_tag,tree_order_statistics_node_update>;
template<class T> using ordered_multiset =tree<T, null_type, less_equal<T>, rb_tree_tag,tree_order_statistics_node_update>;
#define int long long int
#define f(i,a,b) for(int i=a;i<b;i++)
#define crm ios::sync_with_stdio(false),cin.tie(NULL);
#define in(v) for (auto &_x : v) cin >> _x;
#define out(v) for (auto _y : v) cout << _y << ' ';
#define all(x) x.begin(),x.end()
#define rall(x) x.rbegin(),x.rend()
#define endl "\n" 
#define br cout << "\n";
#define abs llabs
#define ac(a) accumulate(all(a),0ll)
#define bcnt(x) __builtin_popcountll(x) // -> Number of set bits int
#define bctz(x) __builtin_ctzll(x) // -> Count trailing zeros in binary
#define bclz(x) __builtin_clzll(x) // -> Count leading zeros in binary
template<class T> bool smin(T &a, const T b) { return b < a ? a = b, 1 : 0;}
template<class T> bool smax(T &a, const T b) { return a < b ? a = b, 1 : 0;}

/*

██████╗  █████╗ ██████╗ ██╗  ██╗███╗   ██╗██╗███╗   ██╗     ██╗ █████╗ 
██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝████╗  ██║██║████╗  ██║     ██║██╔══██╗
██║  ██║███████║██████╔╝█████╔╝ ██╔██╗ ██║██║██╔██╗ ██║     ██║███████║
██║  ██║██╔══██║██╔══██╗██╔═██╗ ██║╚██╗██║██║██║╚██╗██║██   ██║██╔══██║
██████╔╝██║  ██║██║  ██║██║  ██╗██║ ╚████║██║██║ ╚████║╚█████╔╝██║  ██║
╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚════╝ ╚═╝  ╚═╝


Author:       Anirudh Singh Rajora
Institute:    IIIT Lucknow

*/

void solve(){
    
}

int32_t main(){
    crm
    int _ = 1;
    cin >> _;
    while(_--){
        solve();
    }
    return 0;
}
