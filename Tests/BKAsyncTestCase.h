//
//  BKAsyncTestCase.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>

typedef NS_ENUM(NSUInteger, XCTestCaseWaitStatus) {
	XCTestCaseWaitStatusUnknown = 0,
	XCTestCaseWaitStatusSuccess,
	XCTestCaseWaitStatusFailure,
	XCTestCaseWaitStatusCancelled
};

@interface BKAsyncTestCase : XCTestCase

@property (strong, nonatomic) NSArray *runLoopModes;

- (void)prepare;
- (void)prepare:(SEL)selector;
- (void)waitForStatus:(NSInteger)status timeout:(NSTimeInterval)timeout;
- (void)waitFor:(NSInteger)status timeout:(NSTimeInterval)timeout;
- (void)waitForTimeout:(NSTimeInterval)timeout;
- (void)notify:(NSInteger)status forSelector:(SEL)selector;
- (void)notify:(NSInteger)status;
- (void)runForInterval:(NSTimeInterval)interval;

@end
