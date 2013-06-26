//
//  NSMutableSetBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSMutableSet+BlocksKit.h>

@interface NSMutableSetBlocksKitTest : XCTestCase

- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;

@end
