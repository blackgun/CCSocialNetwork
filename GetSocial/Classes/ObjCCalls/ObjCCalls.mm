#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
//android part code here
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)


#include "ObjCCalls.h" 
#import "../cocos2dx/platform/ios/EAGLView.h" 
#import "TweetSender.h"
#import "MailSender.h"
#include "Facebook+Singleton.h"
#import "../HelloWorldScene.h"


void ObjCCalls::trySendATweet()
{
    [TweetSender trySendATweet];
}

void ObjCCalls::trySendAnEMail()
{
    MailSender *mailSender = [MailSender alloc];
    [mailSender openMail];
}

void ObjCCalls::tryPostOnFB(int score)
{
    NSLog(@"ObjCCalls::tryPostOnFB");
    [[Facebook shared] postOnFB:(int) score];
}

void ObjCCalls::tweetCallback(int statusCode)
{
    /*
    switch (statusCode) {
        case -1:
            NSLog(@"Oops. Something went wrong.");
            break;
        case 0:
            NSLog(@"Tweet cancelled by the user.");
            break;
        case 1:
            NSLog(@"Tweet sent.");
            break;
        default:
            NSLog(@"Something wrong with the status code?");
            break;
    }*/
}

#endif

