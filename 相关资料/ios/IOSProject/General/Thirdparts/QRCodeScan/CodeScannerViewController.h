//
//  CodeScannerViewController.h
//  ZXingDemo
//
//  Created by Kiwi on 14-5-5.
//  Copyright (c) 2014年 Kiwi Private. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, ScannerCodeType) {
    ScannerCodeTypeQRCode = 1 << 0,
    ScannerCodeTypeBarCode = 1 << 1
};



@protocol CodeScannerViewControllerDelegate <NSObject>
@optional

- (void)codeScannerDidFinishScan:(id)sender result:(NSString*)result;

@end



@interface CodeScannerViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (unsafe_unretained, nonatomic) id <CodeScannerViewControllerDelegate> delegate;
@property (assign, nonatomic) ScannerCodeType codeType;

/*
 * return a BarcodeViewController object with Type Button
 *
 * @para delegate
 */
+ (id)controllerWithDelegate:(id)delegate codeType:(ScannerCodeType)codeType;

/*
 * return a BarcodeViewController object
 *
 * @para delegate
 * @para typable
 */
+ (id)controllerWithDelegate:(id)delegate codeType:(ScannerCodeType)codeType typeButton:(BOOL)typeButton;

@end
