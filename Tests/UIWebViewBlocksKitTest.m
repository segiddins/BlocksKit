//
//  UIWebViewBlocksKitTest.m
//  BlocksKit Unit Tests
//
//  Created by Zachary Waldowski on 12/20/11.
//  Copyright (c) 2011-2012 Pandamonia LLC. All rights reserved.
//

#import "UIWebViewBlocksKitTest.h"

@implementation UIWebViewBlocksKitTest {
	UIWebView *_subject;
	BOOL shouldStartLoadDelegate, didStartLoadDelegate, didFinishLoadDelegate, didFinishWithErrorDelegate;
}

- (void)setUp {
	_subject = [[UIWebView alloc] initWithFrame: (CGRect){0, 0, 0, 0}];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	shouldStartLoadDelegate = YES;
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	didStartLoadDelegate = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	didFinishLoadDelegate = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	didFinishWithErrorDelegate = YES;
}

- (void)testShouldStartLoad {
	_subject.delegate = self;
	
	__block BOOL shouldStartLoadBlock = NO;
	_subject.shouldStartLoadBlock = ^BOOL(UIWebView *view, NSURLRequest *req, UIWebViewNavigationType type){
		shouldStartLoadBlock = YES;
		return YES;
	};
	
	BOOL shouldStartLoad = [_subject.dynamicDelegate webView:_subject shouldStartLoadWithRequest:nil navigationType:UIWebViewNavigationTypeLinkClicked];
	
	XCTAssertTrue(shouldStartLoad, @"Web view is allowed to load");
	XCTAssertTrue(shouldStartLoadBlock, @"Block handler was called");
	XCTAssertTrue(shouldStartLoadDelegate, @"Delegate was called");
}

- (void)testDidStartLoad {
	_subject.delegate = self;
	
	__block BOOL didStartLoadBlock = NO;
	_subject.didStartLoadBlock = ^(UIWebView *view){
		didStartLoadBlock = YES;
	};
	
	[_subject.dynamicDelegate webViewDidStartLoad:_subject];
	
	XCTAssertTrue(didStartLoadBlock, @"Block handler was called");
	XCTAssertTrue(didStartLoadDelegate, @"Delegate was called");
}

- (void)testDidFinishLoad {
	_subject.delegate = self;
	
	__block BOOL didFinishLoadBlock = NO;
	_subject.didFinishLoadBlock = ^(UIWebView *view){
		didFinishLoadBlock = YES;
	};
	
	[_subject.dynamicDelegate webViewDidFinishLoad:_subject];
	
	XCTAssertTrue(didFinishLoadBlock, @"Block handler was called");
	XCTAssertTrue(didFinishLoadDelegate, @"Delegate was called");
}

- (void)testDidFinishWithError {
	_subject.delegate = self;
	
	__block BOOL didFinishWithErrorBlock = NO;
	_subject.didFinishWithErrorBlock = ^(UIWebView *view, NSError *err){
		didFinishWithErrorBlock = YES;
	};
	
	[_subject.dynamicDelegate webView:_subject didFailLoadWithError:nil];
	
	XCTAssertTrue(didFinishWithErrorBlock, @"Block handler was called");
	XCTAssertTrue(didFinishWithErrorDelegate, @"Delegate was called");
}

@end
