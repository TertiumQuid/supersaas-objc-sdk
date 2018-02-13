#import <Foundation/Foundation.h>

@class SSSClient;

@interface SSSBaseApi : NSObject
    - (id)initWithClient:(SSSClient*)client;
    
    @property SSSClient *client;
@end
