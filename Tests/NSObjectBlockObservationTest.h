//
//  NSObjectBlockObservationTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/NSObject+BlockObservation.h>

@interface NSObjectBlockObservationTest : XCTestCase

- (void)testBoolKeyValueObservation;
- (void)testNSNumberKeyValueObservation;
- (void)testNSArrayKeyValueObservation;
- (void)testNSSetKeyValueObservation;
- (void)testMultipleKeyValueObservation;
- (void)testMultipleOnlyOneKeyValueObservation;


@end
