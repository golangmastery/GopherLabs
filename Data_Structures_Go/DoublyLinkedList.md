##  Doubly Linked List

A linked list is a linear collection of data elements, whose order is not given by their physical placement in memory. <br>
The elements are not stored at the contiguous memory location.
Instead, each element points to the next and the previous element. <br>
It is a data structure consisting of a collection of nodes that together represent a sequence.<br>

In a doubly-linked list, each node has some data and a pointer(reference) to the next node in the list, and a pointer(reference) to the previous node in the list.

### Representation :

A doubly linked list is represented using a pointer to the first node in the list, often referred to as `head` of the linked list.

When the list is empty, we say that `head is nil`.
Each node in the list consists of 2 parts :

1. `Data` 
2. `Pointer(reference) to the next node`
3. `Pointer(reference) to the previous node`
 
In Go, we can represent a node using structures. 
Let us learn how to implement the doubly linked list step by step.

#### 1. Creating the structure

We will create two structures, one for the node and one for the list.
For node :
```
type Node struct {
	country string
	next    *Node
	prev    *Node
}
```

The node consists of string data here, and two pointers - next and prev. <br>
For list :

```
type DoublyLinkedList struct {
	length int
	head   *Node
}
```
The `length` refers to the length of the Linked List, and `head *Node` refers to the `head` of the linked list.

#### 2. Inserting an element at the front of Linked List

Let us define a function where 

Input :` string data `  <br>
Functionality : Creates a new node with the given data, and inserts the node at the starting of the linked list.

```
func (dll *DoublyLinkedList) InsertFront(name string) {

	// Create a new node
	newCountry := &Node{
		country: name,
	}

	// Insert the node
	if dll.head == nil {
		dll.head = newCountry
	} else {
		dll.head.prev = newCountry
		newCountry.next = dll.head
		newCountry.prev = nil
		dll.head = newCountry
	}
	dll.length++
	return

}
```

Here, we defined the method `InsertFront` on `*DoublyLinkedList`.

#### 3. Inserting a node at the end of Linked List

Let us define a function where 

Input :` string data ` <br>
Functionality : Creates a new node with the given data, and inserts the node at the end of the linked list.

```
func (dll *DoublyLinkedList) InsertEnd(name string) {

	// Create a new node
	newCountry := &Node{
		country: name,
	}

	// Insert the new node
	if dll.head == nil {
		dll.head = newCountry
	} else {
		temp := dll.head
		for temp.next != nil {
			temp = temp.next
		}
		newCountry.prev = temp
		newCountry.next = nil
		temp.next = newCountry
	}
	dll.length++
	return
}
```
Here, we defined the method `InsertEnd` on `*DoublyLinkedList`.

#### 4. Deleting a node from front
Let us define a function where 
Functionality : Deletes a node from the start of a linked list

```
func (dll *DoublyLinkedList) DeleteFront() error {

	// Check for empty list before deleting
	if dll.head == nil {
		return fmt.Errorf("Cannot delete, List is empty")
	}

	// Delete the node
	dll.head.next.prev = nil
	dll.head = dll.head.next
	dll.length--
	return nil
}
```
Here, we defined the method `DeleteFront` on `*DoublyLinkedList`.

#### 4. Deleting a node from the end
Let us define a function where 

Functionality : Deletes a node from the end of a linked list

```
func (dll *DoublyLinkedList) DeleteEnd() error {

	// Check for empty list before deleting
	if dll.head == nil {
		return fmt.Errorf("Cannot delete, List is empty")
	}

	// Delete the node
	var prev *Node
	cur := dll.head

	// Traversing till the end of list
	for cur.next != nil {
		prev = cur
		cur = cur.next
	}

	if prev != nil {
		prev.next = nil
	} else {
		dll.head = nil
	}
	dll.length--
	return nil
}
```

Here, we defined the method `DeleteEnd` on `*DoublyLinkedList`.

#### 5. Getting the node at the front 

Functionality : Returns the data of the node at the start.
```
func (dll *DoublyLinkedList) getFront() (string, error) {
	if dll.head == nil {
		return "", fmt.Errorf("Error : The List is empty !")
	}
	return dll.head.country, nil
}
```

Here, we defined the method ```getFront``` on `*DoublyLinkedList`.

#### 6. Getting the length of the linked list

Functionality : Returns the length of the linked list

```
func (dll *DoublyLinkedList) getLength() int {
	return dll.length
}
```
Here, we defined the method ```getLength``` on `*DoublyLinkedList`.

#### 7. Displaying the linked list in the forward direction

Functionality : Prints the entire linked list in the forward direction.

```
func (dll *DoublyLinkedList) displayForward() error {
	fmt.Println("Printing the list in forward direction - ")
	if dll.head == nil {
		return fmt.Errorf("Cannot print, List is empty")
	}
	current := dll.head
	for current != nil {
		fmt.Println(current.country)
		current = current.next
	}
	return nil
}
```
Here, we defined the method ```displayForward``` on `*DoublyLinkedList`.

#### 8. Displaying the linked list in the backward direction

Functionality : Prints the entire linked list in the backward direction.

```
func (dll *DoublyLinkedList) displayBackwards() error {
	fmt.Println("Printing the list in backward direction - ")
	if dll.head == nil {
		return fmt.Errorf("Cannot print, List is empty")
	}
	current := dll.head

	for current.next != nil {
		current = current.next
	}

	for current != nil {
		fmt.Println(current.country)
		current = current.prev
	}
	return nil
}
```
Here, we defined the method ```displayBackwards``` on `*DoublyLinkedList`.

#### 9. Initialising the Linked List

Functionality : Initialises the doubly linked list.

```
func initList() *DoublyLinkedList {
	return &DoublyLinkedList{}
}
```

#### 9. The main method

Now, we can use all these methods in our `main()` method to see how all of it functions together.

```
func main() {
	head := initList()
	fmt.Printf("Inserting at start : India\n")
	head.InsertFront("India")
	fmt.Printf("Inserting at start: USA\n")
	head.InsertFront("USA")
	fmt.Printf("Inserting at end: China\n")
	head.InsertEnd("China")
	fmt.Printf("Inserting at end: Russia\n")
	head.InsertEnd("Russia")

	fmt.Printf("Length of the list : %d\n", head.getLength())

	err := head.displayBackwards()
	if err != nil {
		fmt.Println(err.Error())
	}

	err = head.displayForward()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Deleted element from front \n")
	err = head.DeleteFront()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.displayForward()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Deleted element from end \n")
	err = head.DeleteEnd()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.displayForward()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("The element at front is \n")
	var country, error = head.getFront()
	if error != nil {
		fmt.Printf(error.Error())
	} else {
		fmt.Println(country)
	}

	fmt.Printf("Deleted element from end\n")
	err = head.DeleteEnd()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.displayForward()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Deleted element from end\n")
	err = head.DeleteEnd()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.displayForward()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Length of the List: %d\n", head.getLength())
}
```

The above program gives us the following output :

```
Inserting at start : India
Inserting at start: USA
Inserting at end: China
Inserting at end: Russia
Length of the list : 4
Printing the list in backward direction - 
Russia
China
India
USA
Printing the list in forward direction - 
USA
India
China
Russia
Deleted element from front 
Printing the list in forward direction - 
India
China
Russia
Deleted element from end 
Printing the list in forward direction - 
India
China
The element at front is 
India
Deleted element from end
Printing the list in forward direction - 
India
Deleted element from end
Printing the list in forward direction - 
Cannot print, List is empty
Length of the List: 0
```

