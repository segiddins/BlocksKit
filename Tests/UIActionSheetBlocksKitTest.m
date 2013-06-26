//
//  UIActionSheetBlocksKitTest.m
//  BlocksKit Unit Tests
//
//  Created by Kai Wu on 7/7/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "UIActionSheetBlocksKitTest.h"

@implementation UIActionSheetBlocksKitTest {
	UIActionSheet *_subject;
}

- (void)setUp {
	_subject = [[UIActionSheet alloc] initWithTitle:@"Hello BlocksKit"];
}

- (void)testInit {
	XCTAssertTrue([_subject isKindOfClass:[UIActionSheet class]],@"subject is UIActionSheet");
	XCTAssertFalse([_subject.delegate isEqual: _subject.dynamicDelegate], @"the delegate is not the dynamic delegate");
	XCTAssertEqualObjects(_subject.title,@"Hello BlocksKit",@"the UIActionSheet title is %@",_subject.title);
	XCTAssertEquals(_subject.numberOfButtons,0,@"the action sheet has %d buttons",_subject.numberOfButtons);
	XCTAssertFalse(_subject.isVisible,@"the action sheet is not visible");
}

- (void)testAddButtonWithHandler {
	__block NSInteger total = 0;

	NSInteger index1 = [_subject addButtonWithTitle:@"Button 1" handler:^{ total++; }];
	NSInteger index2 = [_subject addButtonWithTitle:@"Button 2" handler:^{ total += 2; }];
	
	XCTAssertEquals(_subject.numberOfButtons,2,@"the action sheet has %d buttons",_subject.numberOfButtons);

	NSString *title = @"Button";
	title = [_subject buttonTitleAtIndex:index1];
	XCTAssertEqualObjects(title,@"Button 1",@"the UIActionSheet adds a button with title %@",title);

	title = [_subject buttonTitleAtIndex:index2];
	XCTAssertEqualObjects(title,@"Button 2",@"the UIActionSheet adds a button with title %@",title);
	
	[_subject.dynamicDelegate actionSheet:_subject clickedButtonAtIndex:index1];
	[_subject.dynamicDelegate actionSheet:_subject clickedButtonAtIndex:index2];
	
	XCTAssertEquals(total, 3, @"Not all block handlers were called.");
}
 
- (void)testSetDestructiveButtonWithHandler {
	__block BOOL blockCalled = NO;
	
	NSInteger index = [_subject setDestructiveButtonWithTitle:@"Delete" handler:^{ blockCalled = YES; }];
	XCTAssertEquals(_subject.numberOfButtons,1,@"the action sheet has %d buttons",_subject.numberOfButtons);
	XCTAssertEquals(_subject.destructiveButtonIndex,index,@"the action sheet destructive button index is %d",_subject.destructiveButtonIndex);

	NSString *title = [_subject buttonTitleAtIndex:index];
	XCTAssertEqualObjects(title,@"Delete",@"the UIActionSheet adds a button with title %@",title);
	
	[_subject.dynamicDelegate actionSheet:_subject clickedButtonAtIndex:index];

	XCTAssertTrue(blockCalled, @"Block handler was not called.");
}

- (void)testSetCancelButtonWithHandler {
	__block BOOL blockCalled = NO;
	
	NSInteger index = [_subject setCancelButtonWithTitle:@"Cancel" handler:^{ blockCalled = YES; }];
	XCTAssertEquals(_subject.numberOfButtons,1,@"the action sheet has %d buttons",_subject.numberOfButtons);
	XCTAssertEquals(_subject.cancelButtonIndex,index,@"the action sheet cancel button index is %d",_subject.cancelButtonIndex);

	NSString *title = [_subject buttonTitleAtIndex:index];
	XCTAssertEqualObjects(title,@"Cancel",@"the UIActionSheet adds a button with title %@",title);
	
	[_subject.dynamicDelegate actionSheetCancel:_subject];
	
	XCTAssertTrue(blockCalled, @"Block handler was not called.");
}

- (void)testDelegationBlocks {
	__block BOOL willShow = NO;
	__block BOOL didShow = NO;
	
	_subject.willShowBlock = ^(UIActionSheet *sheet) { willShow = YES; };
	_subject.didShowBlock = ^(UIActionSheet *sheet) { didShow = YES; };
	
	[_subject.dynamicDelegate willPresentActionSheet:_subject];
	[_subject.dynamicDelegate didPresentActionSheet:_subject];
	
	XCTAssertTrue(willShow, @"willShowBlock not fired.");
	XCTAssertTrue(didShow, @"didShowblock not fired.");
}

@end
