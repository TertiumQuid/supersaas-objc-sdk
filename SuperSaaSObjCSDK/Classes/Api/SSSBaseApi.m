#import "SSSBaseApi.h"
#import "SSSClient.h"

@implementation SSSBaseApi

- (id)initWithClient:(SSSClient*)client {
    if (self = [super init] )
    {
        self.client = client;
    }
    return self;
}

@end
