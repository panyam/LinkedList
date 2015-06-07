//
//  LinkedList.h
//
//  Created by Sri Panyam on 4/06/2015.
//  Copyright (c) 2015 Sri Panyam. All rights reserved.
//

#ifndef __LINKED_LIST_H__
#define __LINKED_LIST_H__

#import <CoreFoundation/CoreFoundation.h>

typedef struct LinkedListNode LinkedListNode;
typedef struct LinkedList LinkedList;

extern LinkedListNode *LinkedListNextNode(LinkedListNode *node);
extern LinkedListNode *LinkedListPrevNode(LinkedListNode *node);

extern LinkedList *LinkedListNew();
extern LinkedListNode *LinkedListHead(LinkedList *list);
extern LinkedListNode *LinkedListTail(LinkedList *list);
extern void *LinkedListAddObject(LinkedList *list, size_t size);
extern void *ListNodeData(LinkedListNode *node);
void LinkedListRelease(LinkedList *list, void (^beforeFree)(void *obj, NSInteger index));
extern void LinkedListIterate(LinkedList *list, void (^)(void *obj, NSUInteger idx, BOOL *stop));

#endif
