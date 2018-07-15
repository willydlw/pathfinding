
#include <stdio.h>			// fprintf
#include <stdint.h>			// uint8_t
#include <stdlib.h>			// malloc
#include "linkedList.h"


/* Add node to start of list
*
*  Parameters:
*	input 	
*		headPtr			 points to first node in the list
*		dataPtr			 points to data to be added to list
*       dataSize		 number of bytes of data to be added
*/
void push(Node** headPtr, void *dataPtr, size_t dataSize)
{
	// allocate memory for node
	Node* newNode = (Node*) malloc(sizeof(Node));

	newNode->data = malloc(dataSize);
	newNode->next = (*headPtr);

	// copy the data to which dataPtr points, to the newly allocated memory
	int i;
	for(i = 0; i < dataSize; i++){
		// copy one byte at a time, assumes 8 bits per byte
		*(uint8_t*)(newNode->data + i) = *(uint8_t*)(dataPtr + i);
	}

	// change head pointer to point to new node, to add to beginning of list
	(*headPtr) = newNode;
}

/* Insert a new node in the list, after the given previous node
*
*  Parameters
*	input
*		prevNode		points to node location after which new node is to be added
*		dataPtr			points to data to be added to list
*		dataSize		number of bytes of data to be added
*/
void insertAfter(Node *prevNode, void *dataPtr, size_t dataSize)
{
	if(prevNode == NULL){
		fprintf(stderr, "error: %s:%s, line: %d, prevNode cannot be NULL \n", 
			__FILE__, __func__, __LINE__);
		return;
	}

	// allocate memory for new node
	Node* newNode = (Node*)malloc(sizeof(Node));

	// allocate memory for new data
	newNode->data = malloc(dataSize);

	// copy the data to the newly allocated memory
	int i;
	for(i = 0; i < dataSize; i++){
		// copy one byte at a time, assumes 8 bits per byte
		*(uint8_t*)(newNode->data + i) = *(uint8_t*)(dataPtr + i);
	}

	// new node points to next node in the list
	newNode->next = prevNode->next;

	// previous node points to new node
	prevNode->next = newNode;
}


/* Add a new node to end of the list
*
*  Parameters
*	input
*		headPtr			points to start of list
*		dataPtr			points to data to be added to list
*		dataSize		number of bytes of data to be added
*/
void append(Node **headPtr, void *dataPtr, size_t dataSize)
{
	// create a temporary pointer for the last node in the list
	// point it to the start of list
	Node* lastPtr = *headPtr;

	// allocate memory for new node
	Node* newNode = (Node*)malloc(sizeof(Node));

	// allocate memory for new data
	newNode->data = malloc(dataSize);

	// copy the data to the newly allocated memory
	int i;
	for(i = 0; i < dataSize; i++){
		*(uint8_t*)(newNode->data + i) = *(uint8_t*)(dataPtr + i);
	}

	// end of list is NULL pointer
	newNode->next = NULL;

	// empty linked list?
	if(*headPtr == NULL){
		*headPtr = newNode;
		return;
	}

	// find the end of the list
	while(lastPtr->next != NULL){
		lastPtr = lastPtr->next;
	}

	// add new node to end of list
	lastPtr->next = newNode;
}


/* Delete node at location pointed to by removePtr
*
*  Parameters
*	input
*		headPtr			points to start of list
*		removePtr	    points to node to be removed
*/
void deleteNode(Node **headPtr, Node *removePtr)
{
	Node *tempPtr = *headPtr;
	Node *prevPtr = *headPtr;

	if( tempPtr != NULL && tempPtr->next == removePtr){
		*headPtr = tempPtr->next;
		free(tempPtr->data);
		free(tempPtr);
		return;
	}

	while(tempPtr != NULL && tempPtr->next != removePtr){
		prevPtr = tempPtr;
		tempPtr = tempPtr->next;
	}

	// node not in list
	if(tempPtr == NULL){
		return;
	}

	prevPtr->next = tempPtr->next;

	free(tempPtr->data);
	free(tempPtr);

}