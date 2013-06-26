//
//  NSArrayBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSArray+BlocksKit.h>

@interface NSArrayBlocksKitTest : XCTestCase

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
- (void)testCorresponds;

@end
