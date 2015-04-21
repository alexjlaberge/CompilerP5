#include "graph.h"

#include <stack>
#include <iostream>
#include <algorithm>
#include <cstring>
#include <vector>
#include <map>
#include <cassert>

using std::map;
using std::cout;
using std::endl;
using std::stack;
using std::any_of;
using std::vector;

class Comp {
public:
        Comp(const char *thing) : mine(thing) {}

        bool operator()(const char *heyo) {
                if (strcmp(heyo, mine) == 0)
                {
                        return true;
                }

                return false;
        }

private:
        const char *mine;
};

void Graph::add_edge(const char *a, const char *b) {
        edges[a].push_back(b);
}

void clean_links(map<const char *, vector<const char*> > &graph, Comp &c)
{
        for (auto &n : graph) {
                n.second.erase(remove_if(n.second.begin(),
                                        n.second.end(),
                                        c), n.second.end());
        }
}

vector<const char *> Graph::can_color(int k) {
        stack<const char *> s;
        vector<const char *> added;
        vector<const char *> spilled;
        map<const char *, int> colors;
        auto g = edges;

        while (s.size() < g.size()) {
                int init_size = s.size();
                const char *most_cons = g.begin()->first;

                for (const auto &node : g) {
                        Comp c(node.first);
                        bool add = false;

                        assert(c(node.first));

                        if (node.second.size() < k) {
                                s.push(node.first);
                                added.push_back(node.first);
                                g.erase(g.find(node.first));

                                clean_links(g, c);

                                break;
                        } else if (node.second.size() > g[most_cons].size()) {
                                most_cons = node.first;
                        }
                }

                if (init_size == s.size()) {
                        g.erase(g.find(most_cons));
                        Comp c(most_cons);
                        clean_links(g, c);
                        spilled.push_back(most_cons);
                }
        }

        while (s.size() > 0) {
                vector<bool> available;
                int color = 0;

                available.resize(k + 1, true);

                for (const auto &n : edges[s.top()]) {
                        available[colors[n]] = false;
                }

                for (int i = 1; i < k + 1; i++) {
                        if (available[i]) {
                                color = i;
                                break;
                        }
                }

                assert(color != 0);

                colors[s.top()] = color;
                s.pop();
        }

        return spilled;
}
