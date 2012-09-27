#include "InterfaceJNI.h"
#include "platform/android/jni/JniHelper.h"
#include <jni.h>
#include <android/log.h>

using namespace cocos2d;

static JavaVM *gJavaVM;
static jmethodID mid;
static jclass mClass;

void InterfaceJNI::postMessageToFB()
{
	int status;
	JNIEnv *env;
	bool isAttached = false;

	CCLog("Static postMessageToFB");

	// Get Status
	status = gJavaVM->GetEnv((void **) &env, /*JNI_VERSION_1_6*/JNI_VERSION_1_4);
	CCLog("Status: %d", status);

	if(status < 0)
	{
		//LOGE("callback_handler: failed to get JNI environment, " // "assuming native thread");
		status = gJavaVM->AttachCurrentThread(&env, NULL);
		CCLog("Status 2: %d", status);
		if(status < 0)
		{
			// LOGE("callback_handler: failed to attach " // "current thread");
			return;
		}
		isAttached = true;
		CCLog("Status isAttached: %d", isAttached);
	}
	//-----------------------------------------------------------

	mid = env->GetStaticMethodID(mClass, "postMessageToFBJava", "()V");
	CCLog("mID: %d", mid);

	if (mid!=0)
		env->CallStaticVoidMethod(mClass, mid);
			//-----------------------------------------------------------
	CCLog("Finish");
	if(isAttached)
		gJavaVM->DetachCurrentThread();

	return;
}
