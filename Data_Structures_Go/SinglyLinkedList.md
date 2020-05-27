##  Singly Linked List

A linked list is a linear collection of data elements, whose order is not given by their physical placement in memory. <br>
The elements are not stored at the contiguous memory location.
Instead, each element points to the next. <br>
It is a data structure consisting of a collection of nodes that together represent a sequence.<br>

Each node has some data and a pointer(reference) to the next node in the list.

### Advantages of Linked List over Arrays :

1. The size of a linked list is dynamic, while the array size is fixed.
2. Linked List provides us ease of insertion/ deletion since we need not shift elements as in the case of arrays.

### Representation :

A linked list is represented using a pointer to the first node in the list, often referred to as `head` of the linked list.

When the list is empty, we say that `head is nil`.
Each node in the list consists of 2 parts :

1. `Data` 
2. `Pointer(reference) to the next node`
 
In Go, we can represent a node using structures. 
Let us learn how to implement the singly linked list step by step.

#### 1. Creating the structure

We will create two structures, one for the node and one for the list.

For node :

```
type Node struct {
	country string
	next    *Node
}
```

The node consists of string data here. <br>
For list :

```
type SinglyLinkedList struct {
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
func (sll *SinglyLinkedList) InsertFront(name string) {

	// Create a new node
	newCountry := &Node{
		country: name,
	}

	// Insert the node
	if sll.head == nil {
		sll.head = newCountry
	} else {
		newCountry.next = sll.head
		sll.head = newCountry
	}
	sll.length++
	return

}
```

Here, we defined the method `InsertFront` on `*SinglyLinkedList`.

#### 3. Inserting a node at the end of Linked List

Let us define a function where 

Input :` string data ` <br>
Functionality : Creates a new node with the given data, and inserts the node at the end of the linked list.

```
func (sll *SinglyLinkedList) InsertEnd(name string) {

	// Create a new node
	newCountry := &Node{
		country: name,
	}

	// Insert the new node
	if sll.head == nil {
		sll.head = newCountry
	} else {
		temp := sll.head
		for temp.next != nil {
			temp = temp.next
		}
		temp.next = newCountry
	}
	sll.length++
	return
}
```
Here, we defined the method `InsertEnd` on `*SinglyLinkedList`.

#### 4. Deleting a node from front
Let us define a function where 

Functionality : Deletes a node from the start of a linked list

```
func (sll *SinglyLinkedList) DeleteFront() error {

	// Check for empty list before deleting
	if sll.head == nil {
		return fmt.Errorf("Cannot delete, List is empty")
	}

	// Delete the node
	sll.head = sll.head.next
	sll.length--
	return nil
}
```
Here, we defined the method `DeleteFront` on `*SinglyLinkedList`.

#### 4. Deleting a node from the end
Let us define a function where 

Functionality : Deletes a node from the end of a linked list

```
func (sll *SinglyLinkedList) DeleteEnd() error {

	// Check for empty list before deleting
	if sll.head == nil {
		return fmt.Errorf("Cannot delete, List is empty")
	}

	// Delete the node
	var prev *Node
	cur := sll.head

	// Traversing till the end of list
	for cur.next != nil {
		prev = cur
		cur = cur.next
	}

	if prev != nil {
		prev.next = nil
	} else {
		sll.head = nil
	}
	sll.length--
	return nil
}
```

Here, we defined the method `DeleteEnd` on `*SinglyLinkedList`.

#### 5. Getting the node at the front 

Functionality : Returns the data of the node at the start.
```
func (sll *SinglyLinkedList) getFront() (string, error) {
	if sll.head == nil {
		return "", fmt.Errorf("Error : The List is empty !")
	}
	return sll.head.country, nil
}
```

Here, we defined the method ```getFront``` on `*SinglyLinkedList`.

#### 6. Getting the length of the linked list

Functionality : Returns the length of the linked list

```
func (sll *SinglyLinkedList) getLength() int {
	return sll.length
}
```
Here, we defined the method ```getLength``` on `*SinglyLinkedList`.

#### 7. Displaying the linked list

Functionality : Prints the entire linked list

```
func (sll *SinglyLinkedList) display() error {
	fmt.Println("The List is - ")
	if sll.head == nil {
		return fmt.Errorf("Cannot print, List is empty")
	}
	current := sll.head
	for current != nil {
		fmt.Println(current.country)
		current = current.next
	}
	return nil
}
```
Here, we defined the method ```display``` on `*SinglyLinkedList`.

#### 8. Initialising the Linked List

Functionality : Initialises the singly linked list.

```
func initList() *SinglyLinkedList {
	return &SinglyLinkedList{}
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

	err := head.display()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Deleted element from front \n")
	err = head.DeleteFront()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.display()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Deleted element from end \n")
	err = head.DeleteEnd()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.display()
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

	err = head.display()
	if err != nil {
		fmt.Println(err.Error())
	}

	fmt.Printf("Deleted element from end\n")
	err = head.DeleteEnd()
	if err != nil {
		fmt.Printf(err.Error())
	}

	err = head.display()
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
The List is - 
USA
India
China
Russia
Deleted element from front 
The List is - 
India
China
Russia
Deleted element from end 
The List is - 
India
China
The element at front is 
India
Deleted element from end
The List is - 
India
Deleted element from end
The List is - 
Cannot print, List is empty
Length of the List: 0
```

