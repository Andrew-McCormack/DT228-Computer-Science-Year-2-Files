// Sorted linked list with a sentinel node
// Skeleton code

class SortedQueue
{
    // internal data structure and
	private class Node {
        int data;
        Node next;
    }
	
	Node z;
    Node head;
    Node tail;
	
    // constructor code to be added here
	public SortedQueue()
	{
		z = new Node(); z.next = z;
        head = z;  tail = null;
	}
    
    // this is the crucial method
    public void insert(int x)
    {
        Node prev = new Node();
		Node curr = new Node();
		Node t = new Node();
               
        // write code to insert x into sorted list
		curr = head;
		
		while (curr.data >  x)
		{
			prev = curr;
			curr = curr.next;
		}
		
		t.next = curr;
		prev.next = t;
		
		
		t.data = x;
		t.next = z;

		if(head == z)    // case of empty list
		{
			head = t;
		}
		else
		{// case of list not empty
			tail.next = t;
		}
		
		tail = t;        // new node is now at the tail
    }    

    public void display()
    {
        Node t = head;
        System.out.println("\nHead -> ");
        while( t != z) {
            System.out.println("{0} -> " + t.data);
            t = t.next;
        }
        System.out.println("Z\n");
    }
}//End of Queue
class SortedLL
{    
    public static void main(String[] arg)
    {
        SortedQueue list = new SortedQueue();
        list.display();
        
        int i, x;
		
        
        for(i=0; i<10; ++i) {
            x = (int )(Math.random() * 20 + 1);
            list.insert(x);
            System.out.println("\nInserting {0}" + x);
            list.display();            
        }
        //Console.ReadKey();
    }
}
