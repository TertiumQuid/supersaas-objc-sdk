#import <Foundation/Foundation.h>

@class SSSClient;

@interface SSSBaseApi : NSObject

- (id)initWithClient:(SSSClient*)client;
- (NSString *)formatDateString:(NSDate *)date;
- (NSString *)formatIntString:(NSInteger)integer;

@property SSSClient *client;

@end
