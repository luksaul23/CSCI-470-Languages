/**
 *Graph.java
 *
 *@author Lukas Saul
 *@version 1.0
 *@since 2019-04-01
 */

import java.util.*;

public class Graph {
    private String node;
    private String neighbor;
    private Map<String, List<String>> m;

    /**
     *This method initializes the graph object.
     */
    public Graph(){
	m = new HashMap<String,List<String>>();
    }
    /**
     *This method adds a node and one of it's neighbors to the map.
     *@param node , one of the nodes of the graph.
     *@param neighbor , one of the neighbors of the node.
     */
    public void add(String node, String neighbor){
	List<String> neighbors = m.get(node);
	if(neighbors == null){
	    neighbors = new ArrayList<String>();
	    neighbors.add(neighbor);
	    m.put(node,neighbors);
	}
	else{
	    if(!neighbors.contains(neighbor)){
		neighbors.add(neighbor);
	    }
	}
    }

    /**
     *This method returns the neighbors or a specified node.
     *@param key , key (node) that you want the neighbors for.
     *@return m.get(key) , returns the values for which the key maps to
     */
    public List<String> getNeighbors(String key){
	return m.get(key);
    }

    /**
     *This method returns the set of keys for the map.
     *@return m.keySet() , the set of all keys of map m.
     */
    public Set<String> getKeySet(){
	return m.keySet();
    }

}
