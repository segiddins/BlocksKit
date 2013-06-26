//
//  NSMutableIndexSetBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSMutableOrderedSet+BlocksKit.h>

@interface NSMutableOrderedSetBlocksKitTest : XCTestCase

- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;

@end
