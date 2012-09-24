//
//  MailSender.h
//  GetSocial
//
//  Created by Mikel Eizagirre on 14/09/12.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MailSender : UIViewController <MFMailComposeViewControllerDelegate>

- (void)openMail;

@end
