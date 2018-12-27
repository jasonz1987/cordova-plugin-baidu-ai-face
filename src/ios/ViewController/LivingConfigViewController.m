//
//  LivingConfigViewController.m
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "LivingConfigViewController.h"
#import "LivingConfigModel.h"
#import "IDLFaceSDK/IDLFaceSDK.h"

@interface LivingConfigViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *numTextField;
@end

@implementation LivingConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LivingConfigModel.sharedInstance resetState];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSString* str = self.numTextField.text;
    if (![str isEqualToString:@""]) {
        LivingConfigModel.sharedInstance.numOfLiveness = [str integerValue];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.numTextField resignFirstResponder];
}

- (IBAction)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)liveEyeAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveEye)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLiveEye)];
    }
}

- (IBAction)liveMouthAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveMouth)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLiveMouth)];
    }
}

- (IBAction)liveHeadRightAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveYawRight)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLiveYawRight)];
    }
}

- (IBAction)liveHeadLeftAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveYawLeft)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLiveYawLeft)];
    }
}

- (IBAction)liveHeadUpAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLivePitchUp)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLivePitchUp)];
    }
}

- (IBAction)liveHeadDownAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLivePitchDown)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLivePitchDown)];
    }
}

- (IBAction)liveYawAction:(UIButton *)sender {
    sender.selected ^= 1;
    if (sender.selected) {
        [LivingConfigModel.sharedInstance.liveActionArray addObject:@(FaceLivenessActionTypeLiveYaw)];
    } else {
        [LivingConfigModel.sharedInstance.liveActionArray removeObject:@(FaceLivenessActionTypeLiveYaw)];
    }
}

- (IBAction)isByOrderAction:(UIButton *)sender {
    sender.selected ^= 1;
    LivingConfigModel.sharedInstance.isByOrder = sender.selected;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString* str = self.numTextField.text;
    if ([str integerValue] > 6) {
        str = [NSString stringWithFormat:@"3"];
        self.numTextField.text = str;
    }
    if (![str isEqualToString:@""]) {
        LivingConfigModel.sharedInstance.numOfLiveness = [str integerValue];
    }
}


@end
