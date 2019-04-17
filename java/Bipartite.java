/**
 *Bipartite.java
 *
 *@author Lukas Saul
 *@version 1.0
 *@since 2019-04-01
 */

import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;

public class Bipartite {
    public static void main(String args[]){
	Bipartite b = new Bipartite();
	Graph graph = new Graph();
	Map<String,String> partition = new TreeMap<String,String>();

	graph = b.readFromFile(args[0],graph);
	b.printGraph(graph);
	
	partition.put(graph.getKeySet().toArray()[0].toString(),"left");
	partition = b.partitionGraph(partition,graph);
	System.out.println("Partition:");
	if(partition.containsKey("Error")){
	    System.out.println("Graph is not bipartite.");
	}
	else{
	    
	    System.out.println(partition);
	}
	
    }

    /**
     *This method reads in the nodes from the file into the graph.
     *@param file a string containing the file name that has the graph data.
     *@param graph The graph object used to store the data.
     *@return graph Returns the graph object for further use.
     */
    public Graph readFromFile(String file, Graph graph){
	try {
	    Scanner inFile = new Scanner(new File(file));
	    
	    while(inFile.hasNextLine()){
		String[] line = inFile.nextLine().split(" ");
		graph.add(line[0],line[1]);
		graph.add(line[1],line[0]);
	    }
	    
	    inFile.close();
	    
	}
	catch (FileNotFoundException e){
	    System.out.println("Error: File not found");
	    e.printStackTrace();
	}
	
	return graph;
    }

    /**
     *This method partitions the graph into a left and right partition.
     *@param partition , The TreeMap used to store the nodes and their partition, used because it is sorted.
     *@param g The graph which is being partitioned
     *@return partition returns the partition for printing in main
     */

    public Map partitionGraph(Map partition, Graph g){
	Stack s = new Stack();
	String firstNode = g.getKeySet().toArray()[0].toString();
	s.push(firstNode);

	while(!s.empty()){
	    String current = s.pop().toString();
	    for(String v : g.getNeighbors(current)){
		if(!partition.containsKey(v)){
		    partition.put(v,opposite(partition,current));
		    s.push(v);
		}
		else if((partition.get(v).equals("left")) & (partition.get(current).equals("left"))){
		    partition.put("Error","Error");
		    return partition;
		}
		else if((partition.get(v).equals("right")) & (partition.get(current).equals("right"))){
		    partition.put("Error","Error");
		    return partition;
		}
		else{
		}
		  
	    
	    }
	}
	return partition;
    }
    
    /**
     *printGraph, this method prints out the nodes of the graph and their neighbors.
     *@param graph The original graph that was provided from the file.
     */
    public void printGraph(Graph graph){
	System.out.println("Graph:");
	for(String k : graph.getKeySet()){
	    System.out.println(k + " : " + graph.getNeighbors(k));
	}
    }

    /**
     *opposite, returns a string left or right depending on which partition current belongs to.
     *@param partition The TreeMap that stores the nodes and their partitions.
     *@param current The string that contains the current variable so we can check to see its partition.
     *@return "left" or "right" Strings that tell you the opposite partition of current.
     */
    public String opposite(Map partition, String current){
	if(partition.get(current).equals("left")){
	    return "right";
	}
	else{
	    return "left";
	}
    }
		
}
