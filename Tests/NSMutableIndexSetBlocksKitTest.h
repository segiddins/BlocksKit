//
//  NSMutableIndexSetBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSMutableIndexSet+BlocksKit.h>

@interface NSMutableIndexSetBlocksKitTest : XCTestCase

- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedNone;

@end
