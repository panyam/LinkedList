//
//  LinkedList.h
//
//  Created by Sri Panyam on 4/06/2015.
//  Copyright (c) 2015 Sri Panyam. All rights reserved.
//

#include "LinkedList.h"

#pragma LinkedListNode implementation
typedef struct LinkedListNode {
    struct LinkedListNode *prev;
    struct LinkedListNode *next;
    size_t dataSize;
    char data[1];
} LinkedListNode;

LinkedListNode *LinkedListNodeNext(LinkedListNode *node) { return node->next; }
LinkedListNode *LinkedListNodePrev(LinkedListNode *node) { return node->prev; }
void 		   *LinkedListNodeData(LinkedListNode *node) { return node->data; }

#pragma LinkedList implementation
typedef struct LinkedList {
    struct LinkedListNode *head;
    struct LinkedListNode *tail;
} LinkedList;

LinkedList *LinkedListNew()
{
    LinkedList *out = malloc(sizeof(LinkedList));
    out->head = out->tail = 0;
    return out;
}

LinkedListNode *LinkedListHead(LinkedList *list) { return list->head; }
LinkedListNode *LinkedListTail(LinkedList *list) { return list->tail; }

void LinkedListRelease(LinkedList *list, void (^beforeFree)(void *obj, NSInteger index))
{
    if (list != NULL)
    {
        NSInteger index = 0;
        for (LinkedListNode *curr = list->head;curr != NULL;index++)
        {
            LinkedListNode *next = curr->next;
            if (beforeFree)
                beforeFree(curr->data, index);
            free(curr);
            curr = next;
        }
        free(list);
    }
}

void *LinkedListAddObject(LinkedList *list, size_t size)
{
    LinkedListNode *node = malloc(sizeof(LinkedListNode) + size);
    bzero(node, sizeof(LinkedListNode) + size);
    node->next = NULL;
    node->dataSize = size;
    if (list->head)
    {
        list->tail->next = node;
        node->prev = list->tail;
        list->tail = node;
    } else {
        list->tail = list->head = node;
    }
    return node->data;
}

void LinkedListIterate(LinkedList *list, void (^block)(void *obj, NSUInteger idx, BOOL *stop))
{
    if (list && block)
    {
        NSInteger index = 0;
        BOOL stop = NO;
        for (LinkedListNode *curr = list->head;curr != NULL && !stop;index++)
        {
            LinkedListNode *next = curr->next;
            block(curr->data, index, &stop);
            curr = next;
        }
    }
}


#pragma LinkedListIterator implementation
typedef struct LinkedListIterator {
    struct LinkedList *list;
    struct LinkedListNode *curr;
	int index;
} LinkedListIterator;

LinkedListIterator *LinkedListIterator(LinkedList *list)
{
	if (!list)
		return NULL;
	LinkedListIterator *iterator = calloc(1, sizeof(LinkedListIterator));
	iterator->list = list;
	iterator->curr = list->head;
	return iterator;
}

void LinkedListIteratorRelease(LinkedListIterator *iterator)
{
	if (iterator)
	{
		free(iterator);
	}
}

BOOL LinkedListIteratorHasNext(LinkedListIterator *iterator)
{
	return iterator && iterator->curr && iterator->curr->next;
}

BOOL LinkedListIteratorHasPrev(LinkedListIterator *iterator)
{
	return iterator && iterator->curr && iterator->curr->prev;
}

BOOL LinkedListIteratorForward(LinkedListIterator *iterator)
{
	if (iterator && iterator->curr)
	{
		iterator->curr = iterator->curr->next;
		iterator->index++;
	}
	return iterator->curr != NULL;
}

BOOL LinkedListIteratorBackward(LinkedListIterator *iterator)
{
	if (iterator && iterator->curr)
	{
		iterator->curr = iterator->curr->prev;
		iterator->index--;
	}
	return iterator->curr != NULL;
}

int LinkedListIteratorIndex(LinkedListIterator *iterator)
{
	return iterator ? iterator->index : -1;
}

LinkedListNode *LinkedListIteratorCurrent(LinkedListIterator *iterator)
{
	return iterator ? iterator->curr : NULL;
}

void *LinkedListIteratorValue(LinkedListIterator *iterator)
{
	return iterator && iterator->curr ? iterator->curr->data : NULL;
}

