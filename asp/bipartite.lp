%Lukas Saul

% Bipartite.lp

% Model graph for testing
node(a). node(b). node(c). node(d). node(e).
node(f). node(g). node(h). node(i). node(j).
edge(a,f). edge(a,h).
edge(b,g). edge(b,j).
edge(c,f). edge(c,i). edge(c,j).
edge(d,f). edge(d,g).
edge(e,h). edge(e,j).

% Edges are undirected
edge(Y,X) :- edge(X,Y).

% Stick everything in a left and right partition
partition(X,right) : node(X).
partition(Y,left) : node(Y).

% Specify that in any solutions if X is in right, Y is in left
% and vice versa
partition(X,right) :- partition(Y,left), edge(X,Y).
partition(Y,left) :- partition(X,right), edge(X,Y).


% Get rid of any models where a node doesn't have an edge
:- partition(X,left),partition(Y,left), edge(X,Y).

#show partition/2.
