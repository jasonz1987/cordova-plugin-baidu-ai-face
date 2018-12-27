//
//  LivenessViewController.h
//  IDLFaceSDKDemoOC
//
//  Created by 阿凡树 on 2017/5/23.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import "FaceBaseViewController.h"

@protocol LivenessControllerDelegate;

@interface LivenessViewController : FaceBaseViewController

- (void)livenesswithList:(NSArray *)livenessArray order:(BOOL)order numberOfLiveness:(NSInteger)numberOfLiveness;

@property (nonatomic, weak) id <LivenessControllerDelegate> delegate;

@end

@protocol LivenessControllerDelegate <NSObject>

- (void)livenessCallback:(NSString *)image;

@end

