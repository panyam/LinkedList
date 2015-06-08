//
//  LinkedList.h
//
//  Created by Sri Panyam on 4/06/2015.
//  Copyright (c) 2015 Sri Panyam. All rights reserved.
//

#include "LinkedList.h"

typedef struct LinkedListNode {
    struct LinkedListNode *prev;
    struct LinkedListNode *next;
    size_t dataSize;
    char data[1];
} LinkedListNode;

typedef struct LinkedList {
    struct LinkedListNode *head;
    struct LinkedListNode *tail;
} LinkedList;

LinkedListNode *LinkedListNodeNext(LinkedListNode *node) { return node->next; }
LinkedListNode *LinkedListNodePrev(LinkedListNode *node) { return node->prev; }
void *LinkedListNodeData(LinkedListNode *node) { return node->data; }

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
