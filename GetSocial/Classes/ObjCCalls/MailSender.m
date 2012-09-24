//
//  MailSender.m
//  GetSocial
//
//  Created by Mikel Eizagirre on 14/09/12.
//
//

#import "MailSender.h"
#import "../cocos2dx/platform/ios/EAGLView.h"

@implementation MailSender

- (void)openMail
{
    EAGLView *view = [EAGLView sharedEGLView];
    
    // If these three lines are commented, the mail dialogue window will be shown incorrectly (rotated 90º)
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.1, 0.8);
    [view setTransform:rotate];
    
    [view addSubview:self.view];

    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Test mail :D"];
        
        NSString *emailBody = @"This is a test message!!!";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}

#pragma mark - MFMailComposeController delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

@end
