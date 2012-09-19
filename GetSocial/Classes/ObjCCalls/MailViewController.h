#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MailViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)openMail:(id)sender;

@end
