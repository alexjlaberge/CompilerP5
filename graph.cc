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

bool Graph::can_color(int k) {
        stack<const char *> s;
        vector<const char *> added;
        map<const char *, int> colors;
        auto g = edges;

        while (s.size() < edges.size()) {
                int init_size = s.size();

                for (const auto &node : g) {
                        Comp c(node.first);
                        bool add = false;

                        assert(c(node.first));

                        if (node.second.size() < k) {
                                s.push(node.first);
                                added.push_back(node.first);
                                g.erase(g.find(node.first));

                                for (auto &n : g) {
                                        n.second.erase(remove_if(n.second.begin(),
                                                        n.second.end(),
                                                        c), n.second.end());
                                }

                                break;
                        }
                }

                if (init_size == s.size()) {
                        return false;
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

                if (color == 0) {
                        return false;
                }

                colors[s.top()] = color;
                s.pop();
        }

        return true;
}
