# Lists

- A list is a collection of ordered elements that are used to store list of items. Unlike array lists, these can expand and shrink dynamically.

- Lists also be used as a base for other data structures, such as stack and queue. Lists can be used to store lists of users, car parts, ingredients, to-do items, and various other such elements.Lists are the most commonly used linear data structures. These were introduced in the lisp programming language. In this chapter, linked list and doubly linked list are the lists we will cover in the Go language.

- Let's discuss the operations related to add, update, remove, and lookup on linked list and doubly linked list in the following section.

   - LinkedList

      - LinkedList is a sequence of nodes that have properties and a reference to the next node in the sequence. It is a linear data structure that is used to store data. The data structure permits the addition and deletion of components from any node next to another node. They are not stored contiguously in memory, which makes them different arrays.

      -  The following sections will look at the structures and methods in a linked list.
    - The Node class

        - The Node class has an integer typed variable with the name property. The class has another variable with the name nextNode, which is a node pointer. Linked list will have a set of nodes with integer properties, as follows:
        
        ```
        //Node class
        type Node struct {
         property int
         nextNode *Node
         }
        
        ```
 -  The LinkedList class

 - The LinkedList class has the headNodepointer as its property. By traversing to nextNode from headNode, you can iterate through the linked list, as shown in the following code:
 
 ```
 // LinkedList class
type LinkedList struct {
    headNode *Node
}
 

 ```
 
 The different methods of the LinkedList class, such as AddtoHead, IterateList, LastNode, AddtoEnd, NodeWithValue, AddAfter, and the main method, are discussed in the following sections.
The AddToHead method

The AddToHead method adds the node to the start of the linked list. The AddToHead method of the LinkedList class has a parameter integer property. The property is used to initialize the node. A new node is instantiated and its property is set to the property parameter that's passed. The nextNode points to the current headNode of linkedList, and headNode is set to the pointer of the new node that's created, as shown in the following code:

```
//AddToHead method of LinkedList class
func (linkedList *LinkedList) AddToHead(property int) {
    var node = Node{}
    node.property = property
    if node.nextNode != nil {
        node.nextNode = linkedList.headNode
    }
    linkedList.headNode = &node
}

```

When the node with the 1 property is added to the head, adding the 1 property to the head of linkedList sets head Node to currentNode with a value of 1, as you can see in the following 
 ```
 
 add to head method 
 headnode set to currentnode  1 
 ```
        
        
