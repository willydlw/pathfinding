#ifndef LINKED_LIST_H_INCLUDED
#define LINKED_LIST_H_INCLUDED

#include <stddef.h>			// size_t


typedef struct node_t{
	// can store any data type in this node
	void *data;

	struct node_t *next;
} Node;


void push(Node** headPtr, void *dataPtr, size_t dataSize);

void insertAfter(Node *prevNode, void *dataPtr, size_t dataSize);

void append(Node **headPtr, void *dataPtr, size_t dataSize);

void deleteNode(Node **headPtr, Node *removePtr);

#endif