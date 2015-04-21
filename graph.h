#ifndef GRAPH_H
#define GRAPH_H

#include <map>
#include <vector>

class Graph
{
public:
        /* Add an edge between two variables if it doesn't already exist */
        void add_edge(const char *a, const char *b);

        /* Returns a list of variables that have to be spilled. An empty list
         * means no spilling is necessary.
         */
        std::vector<const char *> can_color(int k);

private:
        std::map<const char*, std::vector<const char*> > edges;
};

#endif /* GRAPH_H */
