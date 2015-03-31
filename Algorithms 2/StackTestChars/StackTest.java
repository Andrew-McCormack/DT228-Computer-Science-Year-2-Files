// StackTest.java
// Linked list implementation of Stack

class Stack {
    
    class Node {
        char data;
        Node next;  
    }
    private Node top;
      
    public Stack()
    { 
        top = null;
    }
        
	// Pushes character onto top of stack
    public void push(char x) 
	{
        Node  t = new Node();
        t.data = x;
        t.next = top;
        top = t;
    }

    // pop() method here
    public char pop()
	{
			char x = top.data;
			top = top.next;
			return (x);
	}

	// Deals with all output of the program
    public void display()
	{
        Node t = top;
		
		// Checks to make sure stack is not empty, otherwise returns from display() method
		if (!isEmpty())
		{
			System.out.println("\nStack contents are:  ");
		}
		
		else
		{
			System.out.println("\nStack is now empty!");
			return;
		}
        
		// while the end of stack has not been reached
        while (t != null) {
            System.out.print(t.data + " ");
            t = t.next;
        }
		
		System.out.println("\n");
		
		//Checks to see if b is on the stack at every iteration of display() method
		if (isMember('b'))
		{
			System.out.println("b is on the stack");
		}
		
		else
		{
			System.out.println("b is not on the stack");
		}

		//Checks to see if g is on the stack at every iteration of display() method
		if (isMember('g'))
		{
			System.out.println("g is on the stack");
		}
		
		else
		{
			System.out.println("g is not on the stack");
		}
		
		// Attempts to remove c off the stack at every iteration of display() method
		if (remove('a'))
		{
			System.out.println("Just removed a off stack");
		}
		
		else
		{
			System.out.println("Could not remove a, a is not on the stack");
		}	
		
	}

	// Checks to make sure the strack is not empty
	public boolean isEmpty()
	{
		if (top == null)
		{
			return true;
		}
		return false;
    }    
	
	// Checks to see if the character x is on the stack
	public boolean isMember(char x)
	{
		Node t = top;
		while (t != null)
		{
			if (t.data == x)
			{
				return (true);
			}
			t = t.next;
		}
		
		return (false);
	}
	
	// Attempts to remove character x from the stack, returning true if succssfull
	public boolean remove(char x)
	{
		Node curr = top;
		Node currPlusOne = top;
		
		if (top != null)
		{
			currPlusOne = currPlusOne.next;
		}
		
		while (currPlusOne != null)
		{
			if (curr.data == x  && top.data == x)
			{
				curr.data = currPlusOne.data;
				curr.next = currPlusOne.next;
				return (true);
			}
			curr = curr.next;
			currPlusOne = currPlusOne.next;
		}
		
		return (false);
	}
}


public class StackTest
{
    public static void main( String[] arg)
	{
        Stack s = new Stack();
        System.out.println("Stack is created\n");
        
        s.push('a'); s.push('b'); s.push('c'); s.push('d'); s.push('e'); s.push('f');
        s.display();
        
		while (!s.isEmpty())
		{
			char i = s.pop();
			System.out.println("Just popped " + i);
			s.display();
		}
    }
}


