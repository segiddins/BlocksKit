//
//  UIAlertViewBlocksKitTest.m
//  BlocksKit
//
//  Created by Zachary Waldowski on 12/20/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "UIAlertViewBlocksKitTest.h"

@implementation UIAlertViewBlocksKitTest {
	UIAlertView *_subject;
}

- (void)setUp {
	_subject = [[UIAlertView alloc] initWithTitle:@"Hello BlocksKit" message:@"This is a message."];
}

- (void)testInit {
	XCTAssertTrue([_subject isKindOfClass:[UIAlertView class]],@"subject is UIAlertView");
	XCTAssertFalse([_subject.delegate isEqual: _subject.dynamicDelegate], @"the delegate is not dynamic");
	XCTAssertEqualObjects(_subject.title,@"Hello BlocksKit",@"the UIAlertView title is %@",_subject.title);
	XCTAssertEquals(_subject.numberOfButtons, (NSInteger)0,@"the action sheet has %d buttons",_subject.numberOfButtons);
	XCTAssertFalse(_subject.isVisible,@"the action sheet is not visible");
}

- (void)testAddButtonWithHandler {
	__block NSInteger total = 0;
	
	NSInteger index1 = [_subject addButtonWithTitle:@"Button 1" handler:^{ total++; }];
	NSInteger index2 = [_subject addButtonWithTitle:@"Button 2" handler:^{ total += 2; }];
	
	XCTAssertEquals(_subject.numberOfButtons,(NSInteger)2,@"the alert view has %d buttons",_subject.numberOfButtons);
	
	NSString *title = @"Button";
	title = [_subject buttonTitleAtIndex:index1];
	XCTAssertEqualObjects(title,@"Button 1",@"the UIActionSheet adds a button with title %@",title);
	
	title = [_subject buttonTitleAtIndex:index2];
	XCTAssertEqualObjects(title,@"Button 2",@"the UIActionSheet adds a button with title %@",title);
	
	[_subject.dynamicDelegate alertView:_subject clickedButtonAtIndex:index1];
	[_subject.dynamicDelegate alertView:_subject clickedButtonAtIndex:index2];
	
	XCTAssertEquals(total, 3, @"Not all block handlers were called.");
}

- (void)testSetCancelButtonWithHandler {
	__block BOOL blockCalled = NO;
	
	NSInteger index = [_subject setCancelButtonWithTitle:@"Cancel" handler:^{ blockCalled = YES; }];
	XCTAssertEquals(_subject.numberOfButtons,1,@"the alert view has %d buttons",_subject.numberOfButtons);
	XCTAssertEquals(_subject.cancelButtonIndex,index,@"the alert view cancel button index is %d",_subject.cancelButtonIndex);
	
	NSString *title = [_subject buttonTitleAtIndex:index];
	XCTAssertEqualObjects(title,@"Cancel",@"the UIActionSheet adds a button with title %@",title);
	
	[_subject.dynamicDelegate alertViewCancel:_subject];
	
	XCTAssertTrue(blockCalled, @"Block handler was not called.");
}

- (void)testDelegationBlocks {
	__block BOOL willShow = NO;
	__block BOOL didShow = NO;
	
	_subject.willShowBlock = ^(UIAlertView *view) { willShow = YES; };
	_subject.didShowBlock = ^(UIAlertView *view) { didShow = YES; };
	
	[_subject.dynamicDelegate willPresentAlertView:_subject];
	[_subject.dynamicDelegate didPresentAlertView:_subject];
	
	XCTAssertTrue(willShow, @"willShowBlock not fired.");
	XCTAssertTrue(didShow, @"didShowblock not fired.");
}

@end
