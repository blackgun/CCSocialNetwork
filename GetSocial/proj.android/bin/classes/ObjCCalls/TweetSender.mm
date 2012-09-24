//
//  TweetSender.m
//  GetSocial
//
//  Created by Mikel Eizagirre on 14/09/12.
//
//

#import "TweetSender.h"
#import <Twitter/Twitter.h>
#import "../cocos2dx/platform/ios/EAGLView.h"
#import "../HelloWorldScene.h"

@implementation TweetSender



/**
 * Try to send a tweet using iOS 5 automatically
 */
+(void) trySendATweet
{
    NSLog(@"Try Send a Tweet");
    
    // Twitter on iOS 5, already is connected to user
        
    // Create the view controller
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    UIViewController *myViewController = [[UIViewController alloc] init];
    EAGLView *view = [EAGLView sharedEGLView];
    [view addSubview:(myViewController.view)];
    
    // Optional: set an image, url and initial text
    [twitter setInitialText:@"This is the initial text of the tweet"];
    
    // Show the controller
    [myViewController presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result)
    {
        //NSString *title = @"Tweet Status";
        //NSString *msg;
        
        int status = -1;
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            status = 0;
        else if (result == TWTweetComposeViewControllerResultDone)
            status = 1;
        
        HelloWorld::get_instance()->tweetCallback(status);
        
        /*
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        */
        
        // Dismiss the controller
        [myViewController dismissModalViewControllerAnimated:YES];
    };
}

@end
