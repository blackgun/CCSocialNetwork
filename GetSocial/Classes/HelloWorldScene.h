#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"

class HelloWorld : public cocos2d::CCLayer
{
public:
    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
    virtual bool init();  

    // there's no 'id' in cpp, so we recommand to return the exactly class pointer
    static cocos2d::CCScene* scene();
        
    cocos2d::CCLabelTTF* sLabel;
    
    static HelloWorld *instance;
    
    // test
    void testCallFromJava();
    void testCallToJava();

    // a selector callback
    void menuCloseCallback(CCObject* pSender);
    
    void trySendAnEmail(CCObject* pSender);
    void trySendATweet(CCObject* pSender);
    void tweetCallback(int statusCode);
    void tryPostOnFB(CCObject* pSender);
    void updateMessageLabel(const char *status);
    
    static HelloWorld * get_instance();
    
    // implement the "static node()" method manually
    CREATE_FUNC(HelloWorld);
    
protected:
    // Label to display different messages
    cocos2d::CCLabelTTF *mLabel;
};

#endif // __HELLOWORLD_SCENE_H__
