//
//  UIControlBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/UIControl+BlocksKit.h>

@interface UIControlBlocksKitTest : XCTestCase

- (void)testHasEventHandler;
- (void)testInvokeEventHandler;
- (void)testRemoveEventHandler;

@end
