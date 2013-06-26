//
//  NSMutableDictionaryBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSMutableDictionary+BlocksKit.h>

@interface NSMutableDictionaryBlocksKitTest : XCTestCase

- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;

@end
