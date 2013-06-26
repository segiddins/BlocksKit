//
//  MFMailComposeViewControllerBlocksKitTest.h
//  BlocksKit Unit Tests
//

#import <XCTest/XCTest.h>
#import <BlocksKit/MFMailComposeViewController+BlocksKit.h>

@interface MFMailComposeViewControllerBlocksKitTest : XCTestCase <MFMailComposeViewControllerDelegate>

- (void)testCompletionBlock;

@end
