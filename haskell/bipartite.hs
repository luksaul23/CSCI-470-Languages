{-
Module      : bipartite.hs
Description : bipartite graph, checks and partitions bipartite graph
Copyright   : Lukas Saul
License     : none

Maintainer  : Lukas Saul
Stability   : stable
Portability : portable

bipartite graph
  This function takes a graph, represented as an adjacency matrix, and
  partitions the vertices into left and right partitions using a Depth First
  Search algorithm for Dr. Guerin's spring 2019 CSCI470 class.
  Graphs are assumed to be characters only. The functions reflect this.
-}

import Data.List
graph = [('a','f'),('a','h'),('b','g'),('b','j'),('c','f'),('c','i'),('c','j'),('d','f'),('d','g'),('e','i'),('e','j')]

--pushes the first vertice of the graph to the stack
stack = (fst . head) graph : ""

--assigns the first thing to the left partition
left = (fst . head) graph : ""

bipartite :: [(Char,Char)] -> ([Char],[Char])
{-
Cleans up bipartite output for readability (left,right,stack) -> (left,right).
Also, brings the function call into the form in the assignment.
-}
bipartite graph = (\ (x,y,z) -> (x,y)) (bipartite' graph)

whileLoop :: ([Char],[Char],[Char]) -> ([Char],[Char],[Char])
{-
whileLoop is the equivalent of the while loop in the algorithm,
takes a tuple of left and right partitions and the stack.
-}
whileLoop (left, right, []) = (left, right, "")
whileLoop (left, right, stack) = (whileLoop  (assignLoop (neighbors' (head stack)) (head stack) (left,right, tail stack)))

assignLoop :: [Char] -> Char -> ([Char],[Char],[Char]) -> ([Char],[Char],[Char])
{-
assignLoop is the equivalent of the for loop in the algorithm,
takes the tuple containing the partitions and the stack along with
current, uses the stack to cycle through the neighbors of current.
-}
assignLoop [] current (left, right, stack) = (left, right, stack)
assignLoop (v:vs) current (left, right, stack) = assignLoop vs current (assignPart v current (left, right, stack))

assignPart :: Char -> Char -> ([Char],[Char],[Char]) -> ([Char],[Char],[Char])
{-
assignPart takes the neighbor of current (v), current, the tuple,
it checks to see if the neighbor is in a partition and assigns it to
the correct partition, bipartite-ness is checked here as well. Throws
an error if it is not bipartite.
-}
assignPart v current (left, right, stack)
  | elem v left == False && elem v right == False = opposite v current (left, right, stack)
  | elem v left == True && elem current left == True = error "Graph is not bipartite"
  | elem v right == True && elem current right == True = error "Graph is not bipartite"
  | otherwise = (left, right, stack)

opposite :: Char -> Char -> ([Char],[Char],[Char]) -> ([Char],[Char],[Char])
{-
opposite takes the neighbor of current (v), current, and the tuple,
assigns the neighbor to the appropriate partition and adds it to
the stack.
-}
opposite v current (left, right, stack)
  | elem current left = (left, (v : right), v : stack)
  | elem current right = ((v : left), right, v : stack)
  | otherwise = (left,right,stack)

neighbors :: Char -> [(Char,Char)] -> [Char]
{-
neighbors takes the vertex in question (x) and the graph and
returns its neighbors.
-}
neighbors x [] = []
neighbors x (v:vs)
  | x == fst v = snd v : neighbors x vs
  | x == snd v = fst v : neighbors x vs
  | otherwise = neighbors x vs

bipartite' :: [(Char,Char)] -> ([Char],[Char],[Char])
{- ^
The bipartite' function takes the adjacency list, graph,
and begins the process for partitioning it.
-}
bipartite' graph =  whileLoop (left,"", stack)

neighbors' :: Char -> [Char]
{-
Helper function for neighbors, takes a character and calls
neighbors on that function with the graph, for easier readability
in code.
-}
neighbors' current = neighbors current graph
