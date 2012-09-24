#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
#include "ObjCCalls/ObjCCalls.h"
#endif


using namespace cocos2d;
using namespace CocosDenshion;

static HelloWorld * mytry = NULL;

CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    
    // return the scene
    return scene;
}

HelloWorld* HelloWorld::get_instance()
{
    return mytry;
}
// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    mytry = this;
    
    //////////////////////////////
    // 1. super init first
    if ( !CCLayer::init() )
    {
        return false;
    }

    /////////////////////////////
    // 2. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    CCMenuItemImage *pCloseItem = CCMenuItemImage::create(
                                        "CloseNormal.png",
                                        "CloseSelected.png",
                                        this,
                                        menu_selector(HelloWorld::menuCloseCallback) );
    pCloseItem->setPosition( ccp(CCDirector::sharedDirector()->getWinSize().width - 20, 20) );

    // create menu, it's an autorelease object
    CCMenu* pMenu = CCMenu::create(pCloseItem, NULL);
    pMenu->setPosition( CCPointZero );
    this->addChild(pMenu, 1);

    /////////////////////////////
    // 3. add your codes below...

    // add a label shows "Hello World"
    // create and initialize a label
    CCLabelTTF* pLabel = CCLabelTTF::create("Get Social", "Thonburi", 34);

    // ask director the window size
    CCSize size = CCDirector::sharedDirector()->getWinSize();

    // position the label on the center of the screen
    pLabel->setPosition( ccp(size.width / 2, size.height - 20) );

    // add the label as a child to this layer
    this->addChild(pLabel, 1);

    // create and initialize a label
    CCLabelTTF* scLabel = CCLabelTTF::create("Score:", "Thonburi", 34);
    
    // position the label on the center of the screen
    scLabel->setPosition( ccp(10 + scLabel->getContentSize().width/2, size.height - 20) );
    
    // add the label as a child to this layer
    this->addChild(scLabel, 1);
    
    // create and initialize a label
    sLabel = CCLabelTTF::create("123", "Thonburi", 34);
    
    // position the label on the center of the screen
    sLabel->setPosition( ccp(scLabel->getPositionX() + scLabel->getContentSize().width - 10, size.height - 20) );
    
    // add the label as a child to this layer
    this->addChild(sLabel, 1);
    
    mLabel = CCLabelTTF::create("", "Thonburi", 20);
    mLabel->setPosition(ccp(size.width/2, 20));
    this->addChild(mLabel);

    
    //Main Menu With Font
    CCLabelTTF *sendMailButtonLabel = CCLabelTTF::create("Send an email", "Thonburi", 24);
	CCMenuItemLabel *sendMailButton = CCMenuItemLabel::create(sendMailButtonLabel, this, menu_selector(HelloWorld::trySendAnEmail));
    
    CCLabelTTF *sendTweetButtonLabel = CCLabelTTF::create("Send a tweet", "Thonburi", 24);
	CCMenuItemLabel *sendTweetButton = CCMenuItemLabel::create(sendTweetButtonLabel, this, menu_selector(HelloWorld::trySendATweet));
    
    CCLabelTTF *postOnFBButtonLabel = CCLabelTTF::create("Post on FB", "Thonburi", 24);
	CCMenuItemLabel *postOnFBButton = CCMenuItemLabel::create(postOnFBButtonLabel, this, menu_selector(HelloWorld::tryPostOnFB));
    
	CCMenu *mainMenu = CCMenu::create(sendMailButton, sendTweetButton, postOnFBButton, NULL);
        
	mainMenu->alignItemsVerticallyWithPadding(size.height * 0.06f);
	mainMenu->setPosition(ccp(size.width/2, size.height/2));
    
    this->addChild(mainMenu, 1);

    return true;
}

void HelloWorld::trySendAnEmail(CCObject* pSender)
{
	CCLOG("HelloWorld: try to send an email");
    //ObjCCalls::trySendAnEMail();
}

void HelloWorld::trySendATweet(CCObject* pSender)
{
	CCLOG("HelloWorld: try to send a tweet");
    //ObjCCalls::trySendATweet();
}

void HelloWorld::tweetCallback(int statusCode)
{
    switch (statusCode) {
        case -1:
            updateMessageLabel("Oops. Something went wrong.");
            break;
        case 0:
            updateMessageLabel("Tweet cancelled by the user.");
            break;
        case 1:
            updateMessageLabel("Tweet sent.");
            break;
        default:
            updateMessageLabel("Something wrong with the status code?");
            break;
    }
}

void HelloWorld::tryPostOnFB(CCObject* pSender){
    CCLOG("HelloWorld: try to post on Facebook");
    //int score = atoi (sLabel->getString());
   // ObjCCalls::tryPostOnFB(score);
}

void HelloWorld::updateMessageLabel(const char *text)
{
    CCLog(text);
    mLabel->setString(text);
}

void HelloWorld::menuCloseCallback(CCObject* pSender)
{
    CCDirector::sharedDirector()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
