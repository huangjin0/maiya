//
//  CodeScannerViewController.m
//  ZXingDemo
//
//  Created by Kiwi on 14-5-5.
//  Copyright (c) 2014年 Kiwi Private. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CodeScannerViewController.h"

const static CGFloat _scanViewMarginLeft = 40;
static SystemSoundID soundScanningSuccess;

@interface CodeScannerView : UIView {
    UIImageView * _lightBar;
}
@property (nonatomic, retain) NSTimer * repeatTimer;

- (void)startAnimations;
- (void)stopAnimations;

@end

@implementation CodeScannerView
@synthesize repeatTimer;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _lightBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 33)];
        _lightBar.image = [[UIImage imageNamed:@"CodeScan_light"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        _lightBar.alpha = 0;
        [self addSubview:_lightBar];
        
        UIImageView * frameView = [[UIImageView alloc] initWithFrame:self.bounds];
        frameView.image = [UIImage imageNamed:@"CodeScan_frame"];
        [self addSubview:frameView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        _lightBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 33)];
        _lightBar.image = [[UIImage imageNamed:@"CodeScan_light"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        _lightBar.alpha = 0;
        [self addSubview:_lightBar];
        
        UIImageView * frameView = [[UIImageView alloc] initWithFrame:self.bounds];
        frameView.image = [UIImage imageNamed:@"CodeScan_frame"];
        [self addSubview:frameView];
    }
    return self;
}

- (void)startAnimations {
    [self animationRepeatHandler:nil];
}

- (void)stopAnimations {
    _lightBar.alpha = 0;
    if ([repeatTimer isValid]) {
        [repeatTimer invalidate];
        self.repeatTimer = nil;
    }
}

- (void)animationRepeatHandler:(NSTimer*)sender {
    _lightBar.alpha = 1;
    CGRect frame = _lightBar.frame;
    frame.origin.y = -frame.size.height;
    _lightBar.frame = frame;
    [UIView animateWithDuration:1.75
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        CGRect frame = _lightBar.frame;
        frame.origin.y = self.frame.size.height;
        _lightBar.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animationRepeatHandler:) userInfo:nil repeats:NO];
        }
    }];
}

/*
- (void)drawRect:(CGRect)rect {
    UIImage * bkg = [UIImage imageNamed:@"CodeScan_frame"];
    [bkg drawInRect:rect];
}*/

@end

@interface CodeScannerViewController () {
    CodeScannerView * _scanView;
    UIButton * _btnLEDLightOn;
    UIButton * _btnLEDLightOff;
    BOOL _showTypeButton;
}

@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession * session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;
@property (strong, nonatomic) UIAlertView * alertView;

@end

@implementation CodeScannerViewController
@synthesize delegate;

+ (id)controllerWithDelegate:(id)delegate codeType:(ScannerCodeType)codeType {
    return [CodeScannerViewController controllerWithDelegate:delegate codeType:codeType typeButton:NO];
}

+ (id)controllerWithDelegate:(id)delegate codeType:(ScannerCodeType)codeType typeButton:(BOOL)typeButton {
    CodeScannerViewController * con = [[CodeScannerViewController alloc] initWithCodeType:codeType typeButton:typeButton];
    con.delegate = delegate;
    return con;
}

- (id)initWithCodeType:(ScannerCodeType)codeType typeButton:(BOOL)typeButton {
    if (self = [super init]) {
        // Custom initialization
        _showTypeButton = typeButton;
        _codeType = codeType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat width = self.view.width - _scanViewMarginLeft * 2;
    CGRect frame = CGRectMake(_scanViewMarginLeft, (self.view.height - width) / 2, width, width);
    CodeScannerView * scanView = [[CodeScannerView alloc] initWithFrame:frame];
    [self.view addSubview:scanView];
    _scanView = scanView;
    
    [self setupComponents];
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep-beep" ofType:@"caf"]], &soundScanningSuccess);
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_scanView startAnimations];
    [self addDescriptions];
    [self setupCamera];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scanView stopAnimations];
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)btnCancelPressed:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)btnLEDLightPressed:(id)sender {
    if ([self setLEDLightON:YES]) {
        _btnLEDLightOn.hidden = YES;
        _btnLEDLightOff.hidden = NO;
    }
}
- (void)btnLEDLightOffPressed:(id)sender {
    if ([self setLEDLightON:NO]) {
        _btnLEDLightOn.hidden = NO;
        _btnLEDLightOff.hidden = YES;
    }
}
- (void)btnTypePressed:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:String(@"CodeScan_enter_code") message:nil delegate:self cancelButtonTitle:String(@"Cancel") otherButtonTitles:String(@"OK"), nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [alert show];
}

#define btnMarginTop 40

- (void)setupComponents {
    UIButton * btn = [self buttonWithImage:@"CodeScan_btnCancel" title:String(@"Back")];
    btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btn addTarget:self action:@selector(btnCancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, btnMarginTop, 80, 36);
    [self.view addSubview:btn];
    
    btn = [self buttonWithImage:@"CodeScan_btnLight" title:String(@"CodeScan_light_on")];
    btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btn addTarget:self action:@selector(btnLEDLightPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(self.view.frame.size.width - 100, btnMarginTop, 80, 36);
    [self.view addSubview:btn];
    _btnLEDLightOn = btn;
    
    btn = [self buttonWithImage:@"CodeScan_btnLight" title:String(@"CodeScan_light_off")];
    btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [btn addTarget:self action:@selector(btnLEDLightOffPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(self.view.frame.size.width - 100, btnMarginTop, 80, 36);
    [self.view addSubview:btn];
    btn.hidden = YES;
    _btnLEDLightOff = btn;
    
    if (_showTypeButton) {
        btn = [self buttonWithImage:nil title:String(@"CodeScan_enter_code_manually")];
        btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [btn addTarget:self action:@selector(btnTypePressed:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(80, self.view.frame.size.height - 56, 160, 36);
        [self.view addSubview:btn];
    }
}

- (void)addDescriptions {
    CGFloat pointY = _scanView.frame.origin.y + _scanView.frame.size.height + 20;
    CGFloat width = self.view.frame.size.width;
    
    NSMutableArray * supportedTypes = [NSMutableArray array];
    if (_codeType & ScannerCodeTypeQRCode) {
        [supportedTypes addObject:String(@"CodeScan_type_QRCode")];
    }
    if (_codeType & ScannerCodeTypeBarCode) {
        [supportedTypes addObject:String(@"CodeScan_type_BarCode")];
    }
    NSString * text = [NSString stringWithFormat:String(@"CodeScan_put_in_frame"), [supportedTypes componentsJoinedByString:@"、"]];
    UIFont * font = [UIFont systemFontOfSize:16];
    CGSize size = TextSize_MutiLine(text, font, CGSizeMake(width - 40, 100));
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake((width - size.width) / 2, pointY, size.width, size.height)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    lab.textColor = RGBCOLOR(255, 255, 255);
    lab.text = text;
    lab.layer.shadowColor = RGBCOLOR(0, 0, 0).CGColor;
    lab.layer.shadowOpacity = 0.5;
    lab.layer.shadowOffset = CGSizeZero;
    [self.view addSubview:lab];
}

- (void)setupCamera {
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (self.device == nil) return;
    
    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    NSMutableArray * supportedTypes = [NSMutableArray array];
    if (_codeType & ScannerCodeTypeQRCode) {
        [supportedTypes addObject:AVMetadataObjectTypeQRCode];
    }
    if (_codeType & ScannerCodeTypeBarCode) {
        [supportedTypes addObject:AVMetadataObjectTypeEAN13Code];
    }
    self.output.metadataObjectTypes = supportedTypes;
    
    // Preview
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [self.session startRunning];
}

- (BOOL)setLEDLightON:(BOOL)bl {
    AVCaptureDevice * device = self.device;
    BOOL res = [device hasTorch];
    if (res) {
        [device lockForConfiguration:nil];
        [device setTorchMode:bl ? AVCaptureTorchModeOn : AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
    return res;
}

- (UIButton*)buttonWithImage:(NSString*)imgName title:(NSString*)title {
//    UIImage * btnBkg = [[UIImage imageNamed:@"CodeScan_btn_roundRect_white"] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 21, 17, 21)];
    UIImage * btnBkg = [UIImage imageWithColor:RGBACOLOR(255, 255, 255, 0.9) cornerRadius:17];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 17;
    btn.layer.borderColor = RGBCOLOR(99, 99, 99).CGColor;
    btn.layer.borderWidth = 1;
    if ([imgName isKindOfClass:[NSString class]] && imgName.length > 0) btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    else btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [btn setBackgroundImage:btnBkg forState:UIControlStateNormal];
    if ([imgName isKindOfClass:[NSString class]] && imgName.length > 0) [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    return btn;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [_scanView stopAnimations];
    NSString * stringValue;
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    AudioServicesPlaySystemSound(soundScanningSuccess);
    
    if (self.navigationController) {
        if ([delegate respondsToSelector:@selector(codeScannerDidFinishScan:result:)]) {
            [delegate codeScannerDidFinishScan:self result:stringValue];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
            if (stringValue) {
                if ([delegate respondsToSelector:@selector(codeScannerDidFinishScan:result:)]) {
                    [delegate codeScannerDidFinishScan:self result:stringValue];
                }
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:String(@"Sorry") message:String(@"CodeScan_scan_failed") delegate:nil cancelButtonTitle:String(@"OK") otherButtonTitles:nil, nil];
                self.alertView = alert;
                [alert show];
            }
        }];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)sender didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.alertView = nil;
    if (buttonIndex == 0) {
        return;
    }
    NSString * stringValue = [sender textFieldAtIndex:0].text;
    if ([stringValue isKindOfClass:[NSString class]] && stringValue.length > 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            if ([delegate respondsToSelector:@selector(codeScannerDidFinishScan:result:)]) {
                [delegate codeScannerDidFinishScan:self result:stringValue];
            }
        }];
    }
}

@end


