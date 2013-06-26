//
//  NSOrderedSetBlocksKitTest.h
//  BlocksKit
//
//  Created by Zachary Waldowski on 10/6/12.
//  Copyright (c) 2012 Pandamonia LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSOrderedSet+BlocksKit.h>

@interface NSOrderedSetBlocksKitTest : XCTestCase

- (void)testEach;
- (void)testMatch;
- (void)testNotMatch;
- (void)testSelect;
- (void)testSelectedNone;
- (void)testReject;
- (void)testRejectedAll;
- (void)testMap;
- (void)testReduceWithBlock;
- (void)testAny;
- (void)testAll;
- (void)testNone;
- (void)testCorresponds;

@end
