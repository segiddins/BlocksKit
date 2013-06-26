//
//  MFMessageComposeViewControllerBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/MFMessageComposeViewController+BlocksKit.h>

@interface MFMessageComposeViewControllerBlocksKitTest : XCTestCase <MFMessageComposeViewControllerDelegate>

- (void)testCompletionBlock;

@end
