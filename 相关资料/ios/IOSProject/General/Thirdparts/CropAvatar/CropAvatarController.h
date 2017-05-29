//
//  CropAvatarController.h
//  DoctorFixBao
//
//  Created by Wan Kiwi on 11/16/14.
//  Copyright (c) 2014 kiwiapp. All rights reserved.
//

#import "BasicViewController.h"

@class CropAvatarCover;

@protocol CropAvatarControllerDelegate <NSObject>
@optional
- (void)cropAvatarControllerDidFinishWithImage:(UIImage*)image;
@end

@interface CropAvatarController : BasicViewController {
    IBOutlet CropAvatarCover * _cropCoverView;
    IBOutlet UIButton * _btnBack;
    IBOutlet UIButton * _btnCommit;
    
    UIScrollView * _scrollView;
    UIImageView * _imageView;
}

@property (unsafe_unretained, nonatomic) id <CropAvatarControllerDelegate> delegate;
@property (strong, nonatomic) UIImage * originImage;

- (id)initWithImage:(UIImage*)image delegate:(id)delegate;

@end
