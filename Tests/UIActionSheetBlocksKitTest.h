//
//  UIActionSheetBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/UIActionSheet+BlocksKit.h>

@interface UIActionSheetBlocksKitTest : XCTestCase

- (void)testInit;
- (void)testAddButtonWithHandler;
- (void)testSetDestructiveButtonWithHandler;
- (void)testSetCancelButtonWithHandler;
- (void)testDelegationBlocks;

@end
