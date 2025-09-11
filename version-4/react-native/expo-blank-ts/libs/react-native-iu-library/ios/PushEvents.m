#import "PushEvents.h"

@implementation PushEvents

NSDictionary* clickedNotif;
NSDictionary* pushToken;
NSDictionary* pushPermission;


+ (PushEvents *) sharedInstance {
  static dispatch_once_t token = 0;
  static id _sharedInstance = nil;
  dispatch_once(&token, ^{
    _sharedInstance = [[PushEvents alloc] init];
  });
  return _sharedInstance;
}

- (void) beginObserving {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didBeginObserving) name:@"bridgeSet" object:nil];
}

- (void)sendEvent:(NSString *)eventName withBody:(NSDictionary *)body {
  [RNDigitalReefSDK sendEventWithName:eventName withBody:body];
}

- (void)setClickDict:(NSDictionary *) result {
  clickedNotif = result;
}

- (void)setTokenDict:(NSDictionary *) result {
  pushToken = result;
}

- (void)setPermissionDict:(NSDictionary *) result {
  pushPermission = result;
}


- (void) didBeginObserving {
  // To continue supporting deprecated initialization methods (which create a new RCTOneSignal instance),
  // we will only access the didStartObserving property of the shared instance to avoid issues
  PushEvents.sharedInstance.didStartObserving = true;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    if (clickedNotif) {
      [self sendEvent:@"pushClickedCallback" withBody:clickedNotif];
      clickedNotif = nil;
    }
    if (pushToken) {
      [self sendEvent:@"pushTokenCallback" withBody:pushToken];
      pushToken = nil;
    }
    if (pushPermission) {
      [self sendEvent:@"pushPermissionCallback" withBody:pushPermission];
      pushPermission = nil;
    }
  });
}

@end
