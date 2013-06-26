//
//  NSObjectBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSObject+BlocksKit.h>
#import "BKAsyncTestCase.h"

@interface NSObjectBlocksKitTest : BKAsyncTestCase

- (void)testPerformBlockAfterDelay;
- (void)testClassPerformBlockAfterDelay;
- (void)testCancel;

@end
