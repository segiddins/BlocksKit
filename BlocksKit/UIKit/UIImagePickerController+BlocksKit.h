//
//  UIImagePickerController+BlocksKit.h
//  BlocksKit
//
//  Created by Samuel E. Giddins on 7/24/13.
//  Copyright (c) 2013 Pandamonia LLC. All rights reserved.
//

#import "BKGlobals.h"

/** Block callbacks for UIImagePickerController.
 
 @warning UIImagePickerController is only available on a platform with UIKit.
 */
@interface UIImagePickerController (BlocksKit)

@property (nonatomic, copy) void(^didFinishPickingMediaWithInfoBlock)(UIImagePickerController *, NSDictionary *);

@property (nonatomic, copy) void(^didCancelBlock)(UIImagePickerController *);

@property (nonatomic, copy) void(^didFinishPickingImageWithEditingInfoBlock)(UIImagePickerController *, UIImage *, NSDictionary *) NS_DEPRECATED_IOS(2_0, 3_0);

+ (instancetype)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
                 didFinishPickingMediaWithInfoBlock:(void (^)(UIImagePickerController *picker, NSDictionary *info))didFinishPickingMediaWithInfoBlock
                                     didCancelBlock:(void (^)(UIImagePickerController *picker))didCancelBlock;

@end
