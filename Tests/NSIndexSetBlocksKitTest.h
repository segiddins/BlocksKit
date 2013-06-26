//
//  NSIndexSetBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSIndexSet+BlocksKit.h>

@interface NSIndexSetBlocksKitTest : XCTestCase

- (void)testEach;
- (void)testMatch;
- (void)testNotMatch;
- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedNone;
- (void)testAny;

@end
