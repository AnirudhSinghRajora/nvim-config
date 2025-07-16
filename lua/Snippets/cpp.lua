local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    -- Example: Basic Main Function Snippet
    s("bc+", fmt([[
#include <bits/stdc++.h>
using namespace std;
#define int long long int
#define f(i,a,b) for(int i=a;i<b;i++)
#define crm ios::sync_with_stdio(false),cin.tie(NULL);
#define in(v) for (auto &i : v) cin >> i;

/*##############################
#######Anirudh Singh Rajora#####
################################*/

        

int32_t main() {{
    crm
    {}
    return 0;
}}
    ]], { i(1, "") })),

    -- Example: For Loop Snippet
     s("cpl", fmt([[
#include <bits/stdc++.h>
using namespace std;
        
int main() {{
    {}
    return 0;
}}
    ]], { i(1, "") })),
    s("test", fmt([[
int t;
cin >> t;
while(t--){{
    {}
}}
    ]], { i(1, "") })),
}

