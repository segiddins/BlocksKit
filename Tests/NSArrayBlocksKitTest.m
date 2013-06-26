//
//  NSArrayBlocksKitTest.m
//  BlocksKit Unit Tests
//
//  Created by Kai Wu on 7/3/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "NSArrayBlocksKitTest.h"

@implementation NSArrayBlocksKitTest {
	NSArray *_subject;
	NSInteger _total;
}

- (void)setUp {
	_subject = @[ @"1", @"22", @"333" ];
	_total = 0;
}

- (void)tearDown {
	_subject = nil;
}

- (void)testEach {
	BKSenderBlock senderBlock = ^(NSString *sender) {
		_total += [sender length];
	};
	[_subject each:senderBlock];
	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
}

- (void)testMatch {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] == 22) ? YES : NO;
		return match;
	};
	id found = [_subject match:validationBlock];

	//match: is functionally identical to select:, but will stop and return on the first match
	XCTAssertEquals(_total, (NSInteger)3, @"total length of \"122\" is %d", _total);
	XCTAssertEquals(found, @"22", @"matched object is %@", found);
}

- (void)testNotMatch {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] == 4444) ? YES : NO;
		return match;
	};
	id found = [_subject match:validationBlock];

	// @return Returns the object if found, `nil` otherwise.
	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
	XCTAssertNil(found, @"no matched object");
}

- (void)testSelect {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 300) ? YES : NO;
		return match;
	};
	NSArray *found = [_subject select:validationBlock];

	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
	NSArray *target = @[ @"1", @"22" ];
	XCTAssertEqualObjects(found, target, @"selected items are %@", found);
}

- (void)testSelectedNone {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] > 400) ? YES : NO;
		return match;
	};
	NSArray *found = [_subject select:validationBlock];

	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
	XCTAssertTrue(found.count == 0, @"no item is selected");
}

- (void)testReject {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] > 300) ? YES : NO;
		return match;
	};
	NSArray *left = [_subject reject:validationBlock];

	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
	NSArray *target = @[ @"1", @"22" ];
	XCTAssertEqualObjects(left, target, @"not rejected items are %@", left);
}

- (void)testRejectedAll {
	BKValidationBlock validationBlock = ^(NSString *obj) {
		_total += [obj length];
		BOOL match = ([obj intValue] < 400) ? YES : NO;
		return match;
	};
	NSArray *left = [_subject reject:validationBlock];

	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
	XCTAssertTrue(left.count == 0, @"all items are rejected");
}

- (void)testMap {
	BKTransformBlock transformBlock = ^(NSString *obj) {
		_total += [obj length];
		return [obj substringToIndex:1];
	};
	NSArray *transformed = [_subject map:transformBlock];

	XCTAssertEquals(_total, (NSInteger)6, @"total length of \"122333\" is %d", _total);
	NSArray *target = @[ @"1", @"2", @"3" ];
	XCTAssertEqualObjects(transformed, target, @"transformed items are %@", transformed);
}

- (void)testReduceWithBlock {
	BKAccumulationBlock accumlationBlock = ^id(id sum,id obj) {
		return [sum stringByAppendingString:obj];
	};
	NSString *concatenated = [_subject reduce:@"" withBlock:accumlationBlock];
	XCTAssertTrue([concatenated isEqualToString: @"122333"], @"concatenated string is %@", concatenated);
}

- (void)testAny {
	// Check if array has element with prefix 1
	BKValidationBlock existsBlockTrue = ^BOOL(id obj) {
		return [obj hasPrefix: @"1"];
	};
	
	BKValidationBlock existsBlockFalse = ^BOOL(id obj) {
		return [obj hasPrefix: @"4"];
	};
	
	BOOL letterExists = [_subject any: existsBlockTrue];
	XCTAssertTrue(letterExists, @"letter is not in array");
	
	BOOL letterDoesNotExist = [_subject any: existsBlockFalse];
	XCTAssertFalse(letterDoesNotExist, @"letter is in array");
}

- (void)testAll {
	NSArray *names = @[ @"John", @"Joe", @"Jon", @"Jester" ];
	NSArray *names2 = @[ @"John", @"Joe", @"Jon", @"Mary" ];
	
	// Check if array has element with prefix 1
	BKValidationBlock nameStartsWithJ = ^BOOL(id obj) {
		return [obj hasPrefix: @"J"];
	};

	BOOL allNamesStartWithJ = [names all: nameStartsWithJ];
	XCTAssertTrue(allNamesStartWithJ, @"all names do not start with J in array");
	
	BOOL allNamesDoNotStartWithJ = [names2 all: nameStartsWithJ];
	XCTAssertFalse(allNamesDoNotStartWithJ, @"all names do start with J in array");  
}

- (void)testNone {
	NSArray *names = @[ @"John", @"Joe", @"Jon", @"Jester" ];
	NSArray *names2 = @[ @"John", @"Joe", @"Jon", @"Mary" ];
	
	// Check if array has element with prefix 1
	BKValidationBlock nameStartsWithM = ^BOOL(id obj) {
		return [obj hasPrefix: @"M"];
	};
	
	BOOL noNamesStartWithM = [names none: nameStartsWithM];
	XCTAssertTrue(noNamesStartWithM, @"some names start with M in array");
	
	BOOL someNamesStartWithM = [names2 none: nameStartsWithM];
	XCTAssertFalse(someNamesStartWithM, @"no names start with M in array");
}

- (void)testCorresponds {
	NSArray *numbers = @[ @(1), @(2), @(3) ];
	NSArray *letters = @[ @"1", @"2", @"3" ];
	BOOL doesCorrespond = [numbers corresponds: letters withBlock: ^(id number, id letter) {
		return [[number stringValue] isEqualToString: letter];
	}];
	XCTAssertTrue(doesCorrespond, @"1,2,3 does not correspond to \"1\",\"2\",\"3\"");
	
}

@end
