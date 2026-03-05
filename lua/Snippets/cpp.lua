local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    -- Full competitive programming template
    s("bc+", fmt([[
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
#define in(v) for (auto &i : v) cin >> i;
#define out(v) for (auto i : v) cout << i << ' ';
#define all(x) x.begin(),x.end()
#define rall(x) x.rbegin(),x.rend()
#define endl "\n" 
#define br cout << "\n";
#define abs llabs
#define ac(a) accumulate(all(a),0ll)
#define bcnt(x) __builtin_popcountll(x) // -> Number of set bits int
#define bctz(x) __builtin_ctzll(x) // -> Count trailing zeros in binary
#define bclz(x) __builtin_clzll(x) // -> Count leading zeros in binary

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


int32_t main(){{
    crm
    int _ = 1;
    cin >> _;
    while(_--){{
        {}
    }}
    return 0;
}}
    ]], { i(1, "") })),

    -- Simple main snippet
    s("cpl", fmt([[
#include <bits/stdc++.h>
using namespace std;
        
int main() {{
    {}
    return 0;
}}
    ]], { i(1, "") })),

    -- Test cases loop
    s("test", fmt([[
int t;
cin >> t;
while(t--){{
    {}
}}
    ]], { i(1, "") })),
}

