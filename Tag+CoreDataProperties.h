//
//  Tag+CoreDataProperties.h
//  Receipts++
//
//  Created by Anton Moiseev on 2016-05-26.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tagName;
@property (nullable, nonatomic, retain) NSOrderedSet<Receipt *> *receipt;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)insertObject:(Receipt *)value inReceiptAtIndex:(NSUInteger)idx;
- (void)removeObjectFromReceiptAtIndex:(NSUInteger)idx;
- (void)insertReceipt:(NSArray<Receipt *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeReceiptAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInReceiptAtIndex:(NSUInteger)idx withObject:(Receipt *)value;
- (void)replaceReceiptAtIndexes:(NSIndexSet *)indexes withReceipt:(NSArray<Receipt *> *)values;
- (void)addReceiptObject:(Receipt *)value;
- (void)removeReceiptObject:(Receipt *)value;
- (void)addReceipt:(NSOrderedSet<Receipt *> *)values;
- (void)removeReceipt:(NSOrderedSet<Receipt *> *)values;

@end

NS_ASSUME_NONNULL_END
