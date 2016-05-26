//
//  Receipt+CoreDataProperties.h
//  Receipts++
//
//  Created by Anton Moiseev on 2016-05-26.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Receipt.h"

NS_ASSUME_NONNULL_BEGIN

@interface Receipt (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSDate *timeStamp;
@property (nullable, nonatomic, retain) NSOrderedSet<Tag *> *tag;

@end

@interface Receipt (CoreDataGeneratedAccessors)

- (void)insertObject:(Tag *)value inTagAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTagAtIndex:(NSUInteger)idx;
- (void)insertTag:(NSArray<Tag *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTagAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTagAtIndex:(NSUInteger)idx withObject:(Tag *)value;
- (void)replaceTagAtIndexes:(NSIndexSet *)indexes withTag:(NSArray<Tag *> *)values;
- (void)addTagObject:(Tag *)value;
- (void)removeTagObject:(Tag *)value;
- (void)addTag:(NSOrderedSet<Tag *> *)values;
- (void)removeTag:(NSOrderedSet<Tag *> *)values;

@end

NS_ASSUME_NONNULL_END
