#import "FBConnect.h"
#define kFBAccessTokenKey  @"FBAccessTokenKey"
#define kFBExpirationDateKey  @"FBExpirationDateKey"

@interface Facebook (Singleton) <FBSessionDelegate, FBDialogDelegate>
- (void)authorize;
-(void) postOnFB:(int)score;
+ (Facebook *)shared;
@end