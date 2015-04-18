#ifndef GRAPH_H
#define GRAPH_H

#include <map>
#include <vector>

class Graph
{
public:
        /* Add an edge between two variables if it doesn't already exist */
        void add_edge(const char *a, const char *b);

        /* Check if graph can be colored with 'k' colors */
        bool can_color(int k);

private:
        std::map<const char*, std::vector<const char*> > edges;
};

#endif /* GRAPH_H */
