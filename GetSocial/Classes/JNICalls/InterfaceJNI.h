#ifndef __INTERFACE_JNI_H__
#define __INTERFACE_JNI_H__

#include "cocos2d.h"

class InterfaceJNI
{
public:
	static void postMessageToFB();
	static void postMessageEMail();
	static void postMessageToTweet();
    
protected:

};

#endif // __INTERFACE_JNI_H__
