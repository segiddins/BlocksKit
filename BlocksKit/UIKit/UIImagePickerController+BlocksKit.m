//
//  UIImagePickerController+BlocksKit.m
//  BlocksKit
//
//  Created by Samuel E. Giddins on 7/24/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "UIImagePickerController+BlocksKit.h"

#pragma mark Delegate

@interface A2DynamicUIImagePickerControllerDelegate : A2DynamicDelegate

@end

@implementation A2DynamicUIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)])
        [realDelegate imagePickerController:picker didFinishPickingMediaWithInfo:info];
    void (^block)(UIImagePickerController *, NSDictionary *) = [self blockImplementationForMethod:_cmd];
    if (block)
        block(picker, info);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)])
        [realDelegate imagePickerControllerDidCancel:picker];
    void (^block)(UIImagePickerController *) = [self blockImplementationForMethod:_cmd];
    if (block)
        block(picker);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingImage:editingInfo:)])
        [realDelegate imagePickerController:picker didFinishPickingImage:image editingInfo:editingInfo];
    void (^block)(UIImagePickerController *, UIImage *, NSDictionary *) = [self blockImplementationForMethod:_cmd];
    if (block)
        block(picker, image, editingInfo);
}

@end

#pragma mark - Category

@implementation UIImagePickerController (BlocksKit)

@dynamic didFinishPickingMediaWithInfoBlock, didCancelBlock, didFinishPickingImageWithEditingInfoBlock;

+ (void)load {
	@autoreleasepool {
		[self registerDynamicDelegate];
		[self linkDelegateMethods: @{
		 @"didFinishPickingMediaWithInfoBlock": @"imagePickerController:didFinishPickingMediaWithInfo:",
		 @"didCancelBlock": @"imagePickerControllerDidCancel:",
		 @"didFinishPickingImageWithEditingInfoBlock": @"imagePickerController:didFinishPickingImage:editingInfo:"
         }];
	}
}

+ (instancetype)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
                 didFinishPickingMediaWithInfoBlock:(void (^)(UIImagePickerController *, NSDictionary *))didFinishPickingMediaWithInfoBlock
                                     didCancelBlock:(void (^)(UIImagePickerController *))didCancelBlock
{
    UIImagePickerController *picker = [[self alloc] init];
    picker.didFinishPickingMediaWithInfoBlock = didFinishPickingMediaWithInfoBlock;
    picker.didCancelBlock = didCancelBlock;
    picker.sourceType = sourceType;
    return picker;
}

@end
