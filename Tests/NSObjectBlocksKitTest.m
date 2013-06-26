//
//  NSObjectBlocksKitTest.m
//  BlocksKit Unit Tests
//
//  Created by Kai Wu on 7/4/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "NSObjectBlocksKitTest.h"

@implementation NSObjectBlocksKitTest {
	NSMutableString *_subject;	
}

- (void)setUp {
	_subject = [@"Hello " mutableCopy];
}

- (void)tearDown {
	_subject = nil;
}  

- (void)testPerformBlockAfterDelay {
	BKSenderBlock senderBlock = ^(NSObjectBlocksKitTest *sender) {
		[_subject appendString:@"BlocksKit"];
		[sender notify: XCTestCaseWaitStatusSuccess forSelector: @selector(testPerformBlockAfterDelay)];
	};
	[self prepare];
	id block = [self performBlock:senderBlock afterDelay:0.5];
	XCTAssertNotNil(block,@"block is nil");
	[self waitForStatus: XCTestCaseWaitStatusSuccess timeout:1.0];
	XCTAssertEqualObjects(_subject,@"Hello BlocksKit",@"subject string is %@",_subject);
}

- (void)testClassPerformBlockAfterDelay {
	NSObjectBlocksKitTest *test = self;
	NSMutableString *subject = [NSMutableString stringWithString:@"Hello "];
	[self prepare];
	id blk = [NSObject performBlock:^{
		[subject appendString:@"BlocksKit"];
		[test notify: XCTestCaseWaitStatusSuccess forSelector: @selector(testClassPerformBlockAfterDelay)];
	} afterDelay:0.5];
	XCTAssertNotNil(blk,@"block is nil");
	[self waitForStatus: XCTestCaseWaitStatusSuccess timeout:1.0];
	XCTAssertEqualObjects(subject,@"Hello BlocksKit",@"subject string is %@",subject);
}

- (void)testCancel {
	[self prepare];
	id block = [self performBlock:^(NSObjectBlocksKitTest * sender) {
		[_subject appendString:@"BlocksKit"];
		[sender notify: XCTestCaseWaitStatusSuccess];
	} afterDelay:0.1];
	XCTAssertNotNil(block,@"block is nil");
	[NSObject cancelBlock:block];
	[self waitForTimeout:0.5];
	XCTAssertEqualObjects(_subject,@"Hello ",@"subject string is %@",_subject);
}

@end
