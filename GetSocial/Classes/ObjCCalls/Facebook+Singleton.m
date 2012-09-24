#import "Facebook+Singleton.h"

@implementation Facebook (Singleton)

- (id)init {
    if (!(self = [self initWithAppId:@"317764948310799" andDelegate:self])) {
        NSLog(@"call to authorize");
        [self authorize];
    }
    return self;
}

- (void)authorize {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:kFBAccessTokenKey] && [defaults objectForKey:kFBExpirationDateKey]) {
        self.accessToken = [defaults objectForKey:kFBAccessTokenKey];
        self.expirationDate = [defaults objectForKey:kFBExpirationDateKey];
    }

    if (![self isSessionValid]) {
        NSArray *permissions =  [NSArray arrayWithObjects:@"email", @"user_about_me", nil];
        [self authorize:permissions];
    }
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self accessToken] forKey:kFBAccessTokenKey];
    [defaults setObject:[self expirationDate] forKey:kFBExpirationDateKey];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FBDidLogin" object:self];
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLoginCancelled" object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FBLoginFailed" object:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FBDidNotLogin" object:self];
}

- (void)fbDidLogout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kFBAccessTokenKey];
    [defaults removeObjectForKey:kFBExpirationDateKey];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FBDidLogout" object:self];
}

-(void) postOnFB:(int) score {
    
    NSLog(@"postOnFB %d score", score);
        
    NSString *customMessage = [NSString stringWithFormat:@"I just got a score of %d, an iPhone/iPod Touch game by me!", score];

        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"http://nyan.cat/", @"link",
                                       @"http://wizard.gamebanana.com/img/ico/sprays/_707-.jpg", @"picture",
                                       @"Test name", @"name",
                                       @"Test caption", @"caption",
                                       customMessage, @"description",
                                       @"Facebook Dialogs are so easy!",  @"message",
                                       nil];
        
        [self dialog:@"feed"
                andParams:params
              andDelegate:self];
}

static Facebook *shared = nil;

+ (Facebook *)shared {
    @synchronized(self) {
        if(shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

@end
