//PrinceMessage.mm (.mm means its objective-c++?  Which means you can access it in c++?  This file can combine c++ and objective c?)
#include "ObjCCalls.h" 
#include "ObjCCalls_objc.h" 
#import "../cocos2dx/platform/ios/EAGLView.h" 

void ObjCCalls::OpenURL(const char *url)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithCString:url encoding:NSUTF8StringEncoding]]];
}


void ObjCCalls::trySendATweet()
{
    [ObjCCalls_Objc trySendATweet];
}

void ObjCCalls::trySendAEMail()
{
    [ObjCCalls_Objc trySendAEMail];
}

bool ObjCCalls::IsGameCenterAPIAvailable()
{
    // Check for presence of GKLocalPlayer class.
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
 
    // The device must be running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
 
    return (localPlayerClassAvailable && osVersionSupported);
}

const char *ObjCCalls::MakeDateTimeString()
{
    NSDate *m_nowStart;

	m_nowStart = [[NSDate alloc] init];
        
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd"];
	NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH:mm:ss"];
    
    NSString *theDateS = [dateFormat stringFromDate:m_nowStart];
    NSString *theTimeS = [timeFormat stringFromDate:m_nowStart];
    
    
	NSMutableString *reportdata = [[NSMutableString alloc] initWithString:@""];		
    
    [reportdata appendString:theDateS];
    [reportdata appendString:@","];
    [reportdata appendString:theTimeS];
    
    NSString *nsstr = reportdata;

    
    [dateFormat release];
    [timeFormat release];
    [m_nowStart release];
 
    return [nsstr UTF8String];
}

