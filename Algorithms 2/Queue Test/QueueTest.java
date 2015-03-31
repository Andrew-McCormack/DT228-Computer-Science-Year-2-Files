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
		System.out.println("Removing " + deQueue() + "\n");
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
	

  public void enQueue( int x) {
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



class QueueTest {
  
  // try out the ADT Queue using static allocation
  public static void main(String[] arg) {

    Queue q = new Queue();

    System.out.println("Inserting ints from 9 to 1 into queue gives:\n");
    for (int i = 9; i > 0; --i) {
       q.enQueue( i);
    }

    q.display();

   /* if( ! q.isEmpty())
        System.out.println("Deleting value from queue " + q.deQueue() + "\n");

    System.out.println("Adding value to queue " + 27 + "\n");
    q.enQueue(27);
    q.display();
*/
  }

} //end of Test class

