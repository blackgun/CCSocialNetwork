#import "FBConnect.h"
#define kFBAccessTokenKey  @"FBAccessTokenKey"
#define kFBExpirationDateKey  @"FBExpirationDateKey"

@interface Facebook (Singleton) <FBSessionDelegate>
- (void)authorize;
+ (Facebook *)shared;
@end