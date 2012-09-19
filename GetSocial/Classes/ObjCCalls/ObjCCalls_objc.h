#import <MessageUI/MFMailComposeViewController.h>
#import "../cocos2dx/platform/ios/EAGLView.h"

#import <UIKit/UIKit.h>


@interface ObjCCalls_Objc: UIViewController <MFMailComposeViewControllerDelegate>
{
//    ObjCCalls_Objc();
    
//    UIViewController *m_myViewController;
//    NSString *m_locale;
}

+ (void) trySendATweet;
+ (void) trySendAEMail;

@end

