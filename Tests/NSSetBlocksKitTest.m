//
//  NSSetBlocksKitTest.m
//  BlocksKit Unit Tests
//
//  Created by Kai Wu on 7/4/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "NSSetBlocksKitTest.h"

@implementation NSSetBlocksKitTest {
	NSSet *_subject;
	NSInteger _total;
}

- (void)setUp {
	_subject = [NSSet setWithArray: @[ @"1", @"22", @"333" ]];
	_total = 0;
}

- (void)testEach {
	BKSenderBlock senderBlock = ^(NSString *sender) {
		_total += [sender length];
	};
	[_subject each:senderBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
}

- (void)testMatch {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] == 22) ? YES : NO;
		return match;
	};
	id found = [_subject match:validationBlock];
	XCTAssertEquals(_total,(NSInteger)3,@"total length of \"122\" is %d",_total);
	XCTAssertEquals(found,@"22",@"matched object is %@",found);
}

- (void)testNotMatch {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] == 4444) ? YES : NO;
		return match;
	};
	id found = [_subject match:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertNil(found,@"no matched object");
}

- (void)testSelect {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 300) ? YES : NO;
		return match;
	};
	NSSet *found = [_subject select:validationBlock];

	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	NSSet *target = [NSSet setWithArray: @[ @"1", @"22" ]];
	XCTAssertEqualObjects(found,target,@"selected items are %@",found);
}

- (void)testSelectedNone {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] > 400) ? YES : NO;
		return match;
	};
	NSSet *found = [_subject select:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertTrue(found.count == 0,@"no item is selected");
}

- (void)testReject {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] > 300) ? YES : NO;
		return match;
	};
	NSSet *left = [_subject reject:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	NSSet *target = [NSSet setWithArray: @[ @"1", @"22" ]];
	XCTAssertEqualObjects(left,target,@"not rejected items are %@",left);
}

- (void)testRejectedAll {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 400) ? YES : NO;
		return match;
	};
	NSSet *left = [_subject reject:validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertTrue(left.count == 0,@"all items are rejected");
}

- (void)testMap {
	BKTransformBlock transformBlock = ^(NSString *obj) {
		_total += [obj length];
		return [obj substringToIndex:1];
	};
	NSSet *transformed = [_subject map:transformBlock];

	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	NSSet *target = [NSSet setWithArray: @[ @"1", @"2", @"3" ]];
	XCTAssertEqualObjects(transformed,target,@"transformed items are %@",transformed);
}

- (void)testReduceWithBlock {
	BKAccumulationBlock accumlationBlock = ^(NSString *sum, NSString *obj) {
		return [sum stringByAppendingString:obj];
	};
	NSString *concatenated = [_subject reduce:@"" withBlock:accumlationBlock];
	XCTAssertTrue([concatenated isEqualToString: @"122333"], @"concatenated string is %@", concatenated);
}

- (void)testAny {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] == 22) ? YES : NO;
		return match;
	};
	BOOL wasFound = [_subject any:validationBlock];
	XCTAssertEquals(_total,(NSInteger)3,@"total length of \"122\" is %d",_total);
	XCTAssertTrue(wasFound,@"matched object was found");
}

- (void)testAll {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 444) ? YES : NO;
		return match;
	};
	
	BOOL allMatched = [_subject all: validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertTrue(allMatched, @"Not all values matched");
}

- (void)testNone {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 1) ? YES : NO;
		return match;
	};
	
	BOOL noneMatched = [_subject none: validationBlock];
	XCTAssertEquals(_total,(NSInteger)6,@"total length of \"122333\" is %d",_total);
	XCTAssertTrue(noneMatched, @"Some values matched");
}

@end
