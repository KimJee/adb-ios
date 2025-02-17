//
//  ViewController.m
//  adb-ios
//
//  Created by Li Zonghai on 9/28/15.
//  Copyright (c) 2015 Li Zonghai. All rights reserved.
//

#import "ViewController.h"
#import "adb/AdbClient.h"


#define IP  "192.168.43.129:26101"

@interface ViewController ()
@property(strong) AdbClient *adb;

@end

@implementation ViewController
@synthesize adb = _adb;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _adb = [[AdbClient alloc] initWithVerbose:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) list:(id)sender
{
    [_adb devices:^(BOOL succ, NSString *result1) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result1 waitUntilDone:YES];
    }];
}


-(IBAction)connectBtn:(id)sender
{
    [_adb connect:@IP didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];

    }];
}

// Installs the APK to the target device
-(IBAction)installApkBtn:(id)sender
{
    NSString *apkPath = [[NSBundle mainBundle] pathForResource:@"Term" ofType:@"apk"];
    [_adb installApk:apkPath flags:ADBInstallFlag_Replace didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}

// Uninstalls the APK
-(IBAction)uninstallApkBtn:(id)sender
{
    [_adb uninstallApk:@"jackpal.androidterm" didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


-(IBAction)startApk:(id)sender
{
    [_adb shell:@"am start jackpal.androidterm/.Term" didResponse:^(BOOL succ, NSString *result) {
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}

// Disconnects the socket
-(IBAction)disconnect:(id)sender
{
    [_adb disconnect:@IP didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}


// An example of a shell command via this library
-(IBAction)ps:(id)sender
{
    [_adb shell:@"pm list packages" didResponse:^(BOOL succ, NSString *result) {
        
        [self.textview performSelectorOnMainThread:@selector(setText:) withObject:result waitUntilDone:YES];
    }];
}




@end
