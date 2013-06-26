//
//  UIWebViewBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/UIWebView+BlocksKit.h>

@interface UIWebViewBlocksKitTest : XCTestCase <UIWebViewDelegate>

- (void)testShouldStartLoad;
- (void)testDidStartLoad;
- (void)testDidFinishLoad;
- (void)testDidFinishWithError;

@end
