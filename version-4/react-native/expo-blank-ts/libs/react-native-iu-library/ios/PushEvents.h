#import <Foundation/Foundation.h>
#import "RNDigitalReefSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushEvents : NSObject

@property (nonatomic) BOOL didStartObserving;

+ (PushEvents *) sharedInstance;
- (void)sendEvent:(NSString *)eventName withBody:(NSDictionary *)body;
- (void)setClickDict:(NSDictionary *) result;
- (void)setTokenDict:(NSDictionary *) result;
- (void)setPermissionDict:(NSDictionary *) result;
- (void) beginObserving;

@end

NS_ASSUME_NONNULL_END
