//
//  NSMutableArrayBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSMutableArray+BlocksKit.h>

@interface NSMutableArrayBlocksKitTest : XCTestCase

- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;

@end
