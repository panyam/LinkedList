//
//  LinkedList.h
//
//  Created by Sri Panyam on 4/06/2015.
//  Copyright (c) 2015 Sri Panyam. All rights reserved.
//

#ifndef __LINKED_LIST_H__
#define __LINKED_LIST_H__

#if defined(_cplusplus) || defined(__cplusplus)
extern "C" {
#endif

#import <CoreFoundation/CoreFoundation.h>

typedef struct LinkedListNode LinkedListNode;
typedef struct LinkedList LinkedList;
typedef struct LinkedList LinkedListIterator;

#pragma LinkedListNode methods
extern LinkedListNode *LinkedListNodeNext(LinkedListNode *node);
extern LinkedListNode *LinkedListNodePrev(LinkedListNode *node);
extern void 		  *LinkedListNodeData(LinkedListNode *node);


#pragma LinkedList methods
extern LinkedList *LinkedListNew();
extern LinkedListNode *LinkedListHead(LinkedList *list);
extern LinkedListNode *LinkedListTail(LinkedList *list);
extern void *LinkedListAddObject(LinkedList *list, size_t size);
extern void LinkedListRelease(LinkedList *list, void (^beforeFree)(void *obj, NSInteger index));
extern void LinkedListIterate(LinkedList *list, void (^)(void *obj, NSUInteger idx, BOOL *stop));

#pragma LinkedListIterator methods
extern LinkedListIterator *LinkedListIterator(LinkedList *list);
extern void LinkedListIteratorRelease(LinkedListIterator *iterator);
extern BOOL LinkedListIteratorHasNext(LinkedListIterator *iterator);
extern BOOL LinkedListIteratorHasPrev(LinkedListIterator *iterator);
extern BOOL LinkedListIteratorForward(LinkedListIterator *iterator);
extern BOOL LinkedListIteratorBackward(LinkedListIterator *iterator);
extern int LinkedListIteratorIndex(LinkedListIterator *iterator);
extern LinkedListNode *LinkedListIteratorCurrent(LinkedListIterator *iterator);
extern void *LinkedListIteratorValue(LinkedListIterator *iterator);

#if defined(_cplusplus) || defined(__cplusplus)
}
#endif

#endif
