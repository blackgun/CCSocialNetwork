#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
//android part code here
#elif (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)


//PrintMessage.h
#ifndef __PRINTMESSAGE_H__
#define __PRINTMESSAGE_H__

#include <stddef.h>

class ObjCCalls
{
public:
    static void trySendATweet();
    static void trySendAnEMail();
    static void tryPostOnFB(int score);
    static void tweetCallback(int statusCode);
};

#endif//__PRINTMESSAGE_H__


#endif


