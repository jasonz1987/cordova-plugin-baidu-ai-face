#import "CDVFaceSDK.h"
#import "IDLFaceSDK/IDLFaceSDK.h"
#import "FaceParameterConfig.h"
#import "LivenessViewController.h"
#import "DetectionViewController.h"
#import "LivingConfigModel.h"

@interface CDVFaceSDK ()<DetectControllerDelegate,LivenessControllerDelegate>
@end

@implementation CDVFaceSDK

	- (void)pluginInitialize {
		NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
	    NSAssert([[NSFileManager defaultManager ] fileExistsAtPath:licensePath], @"license文件路径不对，请仔细查看文档");
	    [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
	    NSLog(@"canWork = %d",[[FaceSDKManager sharedInstance] canWork]);
	}

	- (void)FaceDetectExp:(CDVInvokedUrlCommand*)command {
		if ([[FaceSDKManager sharedInstance] canWork]) {
	        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
	        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
	    }
        
        self.callbackId = command.callbackId;
	    
	    DetectionViewController* dvc = [[DetectionViewController alloc] init];
        dvc.delegate = self;
        [self.viewController showViewController:dvc sender:nil];

//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:dvc];
//        navi.navigationBarHidden = true;
//        [self presentViewController:navi animated:YES completion:nil];
	}

	- (void)FaceLivenessExp:(CDVInvokedUrlCommand*)command {
		if ([[FaceSDKManager sharedInstance] canWork]) {
        	NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        	[[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    	}
        
        self.callbackId = command.callbackId;

	    LivenessViewController* lvc = [[LivenessViewController alloc] init];
	    LivingConfigModel* model = [LivingConfigModel sharedInstance];
	    [lvc livenesswithList:model.liveActionArray order:model.isByOrder numberOfLiveness:model.numOfLiveness];
        
        lvc.delegate = self;
        
        [self.viewController showViewController:lvc sender:nil];
	}

#pragma mark - DetectControllerDelegate

-(void)detectCallback:(NSString*)image {

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:image];
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];

}

#pragma mark - LivenessControllerDelegate

-(void)livenessCallback:(NSString*)image {
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:image];
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    
}

@end
	
