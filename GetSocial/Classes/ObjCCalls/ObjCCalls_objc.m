#import "ObjCCalls_objc.h" 
#import <Twitter/Twitter.h>

@implementation ObjCCalls_Objc

/**
 * Try to send a tweet using iOS 5 automatically
 */
+(void) trySendATweet
{
    NSLog(@"Try Send a Tweet");
    
    // Twitter on iOS 5, already is connected to user
    
    // Tweet sheet:
    
    // Create the view controller
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    UIViewController *myViewController = [[UIViewController alloc] init];
    EAGLView *view = [EAGLView sharedEGLView];
    [view addSubview:(myViewController.view)];
    
    
    // Optional: set an image, url and initial text
    [twitter addImage:[UIImage imageNamed:@"Nito Logo.png"]];
    [twitter setInitialText:@"Tweet from NITO."];
    
    // Show the controller
    [myViewController presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result)
    {
        NSString *title = @"Tweet Status";
        NSString *msg;
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"Tweet canceled";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweet send";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [myViewController dismissModalViewControllerAnimated:YES];
    };
}

/**
 *  Try to send a e-mail if it is possible
 */
+ (void)trySendAEMail
{
    NSLog(@"Trying to send a e-mail");
    
    // Try to send a email
    if ([MFMailComposeViewController canSendMail])
    {
        UIViewController *myViewController = [[UIViewController alloc] init];
        EAGLView *view = [EAGLView sharedEGLView];
        [view addSubview:(myViewController.view)];
        
        // Create and show composer
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;//<- very important step if you want feedbacks on what the user did with your email sheet
        NSString * emailSubject = [[NSString alloc] initWithFormat:@"iPhone Subject Test"];
        [picker setSubject:emailSubject];
        
        
        NSString * content = [[NSString alloc] initWithFormat:@"iPhone Email Content"];
        
        // Fill out the email body text
        NSString *pageLink = @"http://www.obi.com/NITO"; // replace it with yours
        NSString *iTunesLink = @"http://NITO-app"; // replate it with yours
        NSString *emailBody =
        [NSString stringWithFormat:@"%@\n\n<h3>Sent from <a href = '%@'>NITO</a> on iPhone. <a href = '%@'>Download</a> yours from AppStore now!</h3>", content, pageLink, iTunesLink];
        
        [picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
        
        picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
        
        [myViewController presentModalViewController:picker animated:YES];
    }
    else
    {
        // Show some error message here; NO EMAIL ACOUNT
        NSLog(@"Your device cannot send a email, account logged?");
    }
}

/*
 * Callback to send the email
 * Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result
 * of the operation.
 *
 */
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            NSLog(@"MFMailComposeResultCancelled");
            break;
        }
        case MFMailComposeResultSaved:
        {
            NSLog(@"MFMailComposeResultSaved");
            break;
        }
        case MFMailComposeResultSent:
        {
            NSLog(@"MFMailComposeResultSent");
            break;
        }
        case MFMailComposeResultFailed:
        {
            NSLog(@"MFMailComposeResultFailed");
            break;
        }
        default:
        {
            UIAlertView *emailalert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [emailalert show];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end