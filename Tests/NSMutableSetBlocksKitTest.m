//
//  NSMutableSetBlocksKitTest.m
//  BlocksKit Unit Tests
//
//  Created by Kai Wu on 7/7/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "NSMutableSetBlocksKitTest.h"


@implementation NSMutableSetBlocksKitTest {
	NSMutableSet *_subject;
	NSInteger _total;
}

- (void)setUp {
	_subject = [NSMutableSet setWithArray: @[ @"1", @"22", @"333"]];;
	_total = 0;
}

- (void)testSelect {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 300) ? YES : NO;
		return match;
	};
	[_subject performSelect:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	NSMutableSet *target = [NSMutableSet setWithArray: @[ @"1", @"22" ]];
	XCTAssertEqualObjects(_subject,target,@"selected items are %@",_subject);
}

- (void)testSelectedNone {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] > 400) ? YES : NO;
		return match;
	};
	[_subject performSelect:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertEquals(_subject.count,(NSUInteger)0,@"no item is selected");
}

- (void)testReject {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] > 300) ? YES : NO;
		return match;
	};
	[_subject performReject:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	NSMutableSet *target = [NSMutableSet setWithArray: @[ @"1", @"22" ]];
	XCTAssertEqualObjects(_subject,target,@"not rejected items are %@",_subject);
}

- (void)testRejectedAll {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 400) ? YES : NO;
		return match;
	};
	[_subject performReject:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertEquals(_subject.count,(NSUInteger)0,@"all items are rejected");
}

- (void)testMap {
	BKTransformBlock transformBlock = ^(NSString *obj) {
		_total += [obj length];
		return [obj substringToIndex:1];
	};
	[_subject performMap:transformBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	NSMutableSet *target = [NSMutableSet setWithArray: @[ @"1", @"2", @"3" ]];
	XCTAssertEqualObjects(_subject,target,@"transformed items are %@",_subject);
}

@end
