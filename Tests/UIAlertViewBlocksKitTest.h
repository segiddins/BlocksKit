//
//  UIAlertViewBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/UIAlertView+BlocksKit.h>

@interface UIAlertViewBlocksKitTest : XCTestCase

- (void)testInit;
- (void)testAddButtonWithHandler;
- (void)testSetCancelButtonWithHandler;
- (void)testDelegationBlocks;

@end
