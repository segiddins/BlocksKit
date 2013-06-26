//
//  NSObjectAssociatedObjectTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSObject+AssociatedObjects.h>

@interface NSObjectAssociatedObjectTest : XCTestCase

- (void)testAssociatedRetainValue;
- (void)testAssociatedCopyValue;
- (void)testAssociatedAssignValue;
- (void)testAssociatedNotFound;

@end
