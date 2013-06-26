//
//  NSSetBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSSet+BlocksKit.h>

@interface NSSetBlocksKitTest : XCTestCase

- (void)testEach;
- (void)testMatch;
- (void)testNotMatch;
- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;
- (void)testReduceWithBlock;
- (void)testAny;
- (void)testAll;
- (void)testNone;

@end
