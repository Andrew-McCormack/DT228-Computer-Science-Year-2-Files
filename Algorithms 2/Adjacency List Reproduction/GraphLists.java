import java.io.*;

import java.io.*;

// QueueTest.java
// Allocation of Queue objects in main()

class Queue {

    private class Node {
        int key;
        Node next;
    }

    Node z;
    Node head;
    Node tail;

     public Queue() {
        z = new Node(); z.next = z;
        head = z;  tail = null;
    }

  public void display() {
    System.out.println("\nThe queue values are:\n");

    Node temp = head;
    while( temp != temp.next) {
        System.out.print( temp.key + "  ");
        temp = temp.next;
    }
    System.out.println("\n");
    
    System.out.println("Is 12 in the Queue?: ");
    
    if (isMember(12))
    {
        System.out.println("Yes \n");
    }
    
    else
    {
        System.out.println("No \n");
    }
    
    System.out.println("Is 8 in the Queue?: ");
    
    if (isMember(8))
    {
        System.out.println("Yes \n");
    }
    
    else
    {
        System.out.println("No \n");
    }
        
        
    
    System.out.println("\nDequeing value from queue \n");
    
    temp = head;
    while (temp != temp.next)
    {
        System.out.print ("Removing " + deQueue() + "\n");
        temp = temp.next;
        
        Node temp2 = head;
        
        if (!isEmpty())
        {
            System.out.println("\nThe new queue values are:\n");
        }
            
        else
        {
            System.out.println("\nThe queue is now empty");
        }
        
        while( temp2 != z) 
        {
            
            System.out.print( temp2.key + "  ");
            temp2 = temp2.next;
    }
    System.out.println("\n");
    }
    
  }

  public boolean isEmpty()
  {
        Node temp2 = head;
        
        if (temp2.next == z)
        {
            return (true);
        }
        
        else 
        {
            return (false);
        }
   }
    

  public void enQueue( int x) 
  {
    Node temp;

    temp = new Node();
    temp.key = x;
    temp.next = z;

    if(head == z)    // case of empty list
        head = temp;
    else                // case of list not empty
        tail.next = temp;

    tail = temp;        // new node is now at the tail
  }


  // assume the queue is non-empty when this method is called
  public int deQueue() 
  {
    int x = head.key;
    if (head == tail)
    {
        tail = null;
    }
    
    head = head.next;
    return(x);
  }


  public boolean isMember(int x)
    {
        Node t = head;
        
        while (t != z)
        {
            if (t.key == x)
            {
                return true;
            }
            t = t.next;
        }
        
        return false;
    }

} // end of Queue class

// Simple weighted graph representation 
// Uses an Adjacency Linked Lists, suitable for sparse graphs

class GraphLists {
    class Node {
        public int vert;
        public int wgt;
        public Node next;
    }
    
    // V = number of vertices
    // E = number of edges
    // adj[] is the adjacency lists array
    private int V, E;
    private Node[] adj;
    private Node z;
    
    // used for traversing graph
    private int[] visited;
    private int id;
    
    
    // default constructor
    public GraphLists(String graphFile)  throws IOException
    {
        int u, v;
        int e, wgt;
        Node t;

        FileReader fr = new FileReader(graphFile);
		BufferedReader reader = new BufferedReader(fr);
	           
        String splits = " +";  // multiple whitespace as delimiter
		String line = reader.readLine();        
        String[] parts = line.split(splits);
        System.out.println("Parts[] = " + parts[0] + " " + parts[1]);
        
        V = Integer.parseInt(parts[0]);
        E = Integer.parseInt(parts[1]);
        
        // create sentinel node
        z = new Node(); 
        z.next = z;
        
        // create adjacency lists, initialised to sentinel node z
        /* adj = new ...
        for(v = 1; v <= V; ++v)
           adj[v] = z;               
        */

        visited = new int[V+1];
        
        adj = new Node[V + 1];

        for(v = 1; v <= V; ++v)
        {
           adj[v] = z;               
        }
        
        
        // read the edges
        System.out.println("Reading edges from text file");
        for(e = 1; e <= E; ++e)
        {
            line = reader.readLine();
            parts = line.split(splits);
            u = Integer.parseInt(parts[0]);
            v = Integer.parseInt(parts[1]); 
            wgt = Integer.parseInt(parts[2]);
            
            System.out.println("Edge " + toChar(u) + "--(" + wgt + ")--" + toChar(v));    
            // write code to put edge into adjacency node list     
            // missing code here

            t = new Node();
            t.vert = u;            
            t.wgt = wgt;
            t.next = adj[v];

            adj[v] = t;

            t =  new Node();
            t.wgt = wgt;
            t.vert = v;
            t.next = adj[u];

            adj[u] = t;
        }


    }
   
    // convert vertex into char for pretty printing
    private char toChar(int u)
    {  
        return (char)(u + 64);
    }
    
    // method to display the graph representation
    public void display() {
        int v;
        Node n;
        
        for(v=1; v<=V; ++v)
        {
            System.out.print("\nadj[" + toChar(v) + "] ->" );
            for(n = adj[v]; n != z; n = n.next) 
            {
                System.out.print(" |" + toChar(n.vert) + " | " + n.wgt + "| ->");    
            }
        }
        System.out.println("");
    }


    // method to initialise Depth First Traversal of Graph
    public void DF( int s) 
    {
        id = 0;
        
        for (int v = 1; v <= V; v++)
        {
            visited[v] = 0;
        }
        
        dfVisit(0, s);
    }


    // Recursive Depth First Traversal for adjacency matrix
    private void dfVisit( int prev, int v)
    {
        visited[v] = ++id;
        System.out.println("Visited Vertex " + toChar(v) + " along edge " + toChar(prev) + " - " + toChar(v));

        for (int u = 1; u <= V; u++)
        {
            if (adj[v] != null && adj[u] != null)
            {
                if (visited[u] == 0)
                {
                    dfVisit(v, u);
                }
            }
        }        
    }


    public void BF(int s)
    {
        Queue q = new Queue();
        boolean firstRun = true;
        id = 0;

        for (int v = 1; v <= V; v++)
        {
           visited[v] = 0;
        }
 
        q.enQueue(s);
        while (!q.isEmpty() || firstRun) 
        {
            firstRun = false;
            int v = q.deQueue();
            if (visited[v] == 0)
            {
                visited[v] = ++id;
                System.out.println("Visited Vertex " + toChar(v));
                for (int u = 1; u <= V; u++)
                {
                    if (visited[u] == 0)
                    {
                        q.enQueue(u);
                    }
                }
            }
        }
    }
        

    public static void main(String[] args) throws IOException
    {
        int s = 1;
        int s2 = 1;
        String fname = "wGraph3.txt";
        String fname2 = "wGraph2.txt";               

        System.out.println("\n Graph3 adjacency list representation \n");
        GraphLists g = new GraphLists(fname);

        g.display();

        System.out.println("\n Implementing Recursive Depth First search of Graph3! \n");
        
        g.DF(s);

        System.out.println("\n Implementing Iterative Breadth First search of Graph3! \n");
        
        g.BF(s);

        System.out.println("\n Graph2 adjacency list representation \n");
        GraphLists g2 = new GraphLists(fname2);
       
        g2.display();

        System.out.println("\n Implementing Recursive Depth First search of Graph3! \n");
        
        g2.DF(s2);

        System.out.println("\n Implementing Iterative Breadt First search of Graph3! \n");
        
        g2.BF(s2);

    }

}

