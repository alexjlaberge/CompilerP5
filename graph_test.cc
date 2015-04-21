#include "graph.h"
#include <cassert>
#include <iostream>

using std::cout;
using std::endl;

int main() {
        /* Example from slides */
        Graph a;

        a.add_edge("a", "b");
        a.add_edge("a", "c");
        a.add_edge("a", "d");

        a.add_edge("b", "a");
        a.add_edge("b", "c");
        a.add_edge("b", "d");
        a.add_edge("b", "e");
        a.add_edge("b", "f");

        a.add_edge("c", "a");
        a.add_edge("c", "b");
        a.add_edge("c", "d");
        a.add_edge("c", "e");

        a.add_edge("d", "a");
        a.add_edge("d", "b");
        a.add_edge("d", "c");

        a.add_edge("e", "b");
        a.add_edge("e", "c");
        a.add_edge("e", "f");

        a.add_edge("f", "b");
        a.add_edge("f", "e");

        cout << "graph_test";

        assert(a.can_color(1).size() == 4);
        cout << ".";
        assert(a.can_color(2).size() == 2);
        cout << ".";
        assert(a.can_color(3).size() == 1);
        cout << ".";
        assert(a.can_color(4).size() == 0);
        cout << ".";
        assert(a.can_color(5).size() == 0);
        cout << "." << endl;

        return 0;
}
