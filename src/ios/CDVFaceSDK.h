#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>


@interface CDVFaceSDK : CDVPlugin

@property (copy) NSString* callbackId;

-(void)FaceLivenessExp:(CDVInvokedUrlCommand*)command;
-(void)FaceDetectExp:(CDVInvokedUrlCommand*)command;

@end
