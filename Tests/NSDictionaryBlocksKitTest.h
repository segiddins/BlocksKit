//
//  NSDictionaryBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <Blockskit/NSDictionary+BlocksKit.h>

@interface NSDictionaryBlocksKitTest : XCTestCase

- (void)testEach;
- (void)testMatch;
- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;
- (void)testAny;
- (void)testAll;
- (void)testNone;

@end
