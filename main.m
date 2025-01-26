N = 4;

lens = [0 3 inf 8
       3 0 2 inf
       inf 2 0 3
       8 inf 3 0];

[d,path] = Dijkstra(N,lens);

disp(d);

disp(path);