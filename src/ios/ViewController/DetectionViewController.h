//
//  DetectionViewController.h
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"

@protocol DetectControllerDelegate;

@interface DetectionViewController : FaceBaseViewController

@property (nonatomic, weak) id <DetectControllerDelegate> delegate;

@end

@protocol DetectControllerDelegate <NSObject>

- (void)detectCallback:(NSString *)image;

@end
