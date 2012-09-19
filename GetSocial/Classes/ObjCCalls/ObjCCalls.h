//PrintMessage.h
#ifndef __PRINTMESSAGE_H__
#define __PRINTMESSAGE_H__

#include <stddef.h>

class ObjCCalls
{
public:
    static void OpenURL(const char *url);
    static void trySendATweet();
    static void trySendAEMail();
    static bool IsGameCenterAPIAvailable();
    static const char *MakeDateTimeString();
};

#endif//__PRINTMESSAGE_H__