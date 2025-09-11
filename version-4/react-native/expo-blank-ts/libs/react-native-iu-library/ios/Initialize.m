#import "Initialize.h"
#import "PushEvents.h"
#import <DigitalReefSDK/DigitalReefSDK.h>

@implementation Initialize

static NSDictionary* launchOptions = nil;

+(void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(didFinishLauching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                            object:nil];
}

+(void) didFinishLauching:(NSNotification*)notification {

    PushEvents *fs = [PushEvents sharedInstance];
    [fs beginObserving];
    
    DigitalReef *digitalReef = DigitalReef.shared;

    launchOptions = notification.userInfo;
      if (launchOptions == nil) {
        //launchOptions is nil when not start because of notification or url open
        launchOptions = [NSDictionary dictionary];
      }
    
    //     [PushNotificationDR initializePushWithLaunchOptions:launchOptions actionBlock:^(NSDictionary * _Nonnull result) {
//         NSLog(@"Callback from DRSDK: %@", result);
//         NSString *pushToken = [result objectForKey:@"push_token"];
//         NSNumber *pushPermission = [result objectForKey:@"push_permission"];
//         NSDictionary *pushReceived = [result objectForKey:@"push_received"];
//         NSDictionary *pushClicked = [result objectForKey:@"push_clicked"];

//         if (pushClicked != nil) {
//           if (!PushEvents.sharedInstance.didStartObserving) [fs setClickDict:result];
//           else [fs sendEvent:@"pushClickedCallback" withBody:result];
//         }
//         if (pushReceived != nil) {
//           [fs sendEvent:@"pushReceivedCallback" withBody:result];
//         }

//         if (pushToken != nil) {
//           if (!PushEvents.sharedInstance.didStartObserving) [fs setTokenDict:result];
//           else [fs sendEvent:@"pushTokenCallback" withBody:result];
//         }

//         if (pushPermission != nil) {
//           if (!PushEvents.sharedInstance.didStartObserving) [fs setPermissionDict:result];
//           else [fs sendEvent:@"pushPermissionCallback" withBody:result];
//         }
//     }];
}

@end
