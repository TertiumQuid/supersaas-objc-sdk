#import "SSSBaseApi.h"
#import "SSSClient.h"

NSString * const API_DATE_FORMAT = @"YYYY-MM-dd HH:mm:ss";

@implementation SSSBaseApi

- (id)initWithClient:(SSSClient*)client {
    if (self = [super init] )
    {
        self.client = client;
    }
    return self;
}

- (NSString *)formatIntString:(NSInteger)integer {
    return [NSString stringWithFormat:@"%ld", (long)integer ];
}
    
- (NSString *)formatDateString:(NSDate *)date {
    if (date == nil) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:API_DATE_FORMAT];
        return [dateFormat stringFromDate:date];
    } else {
        return nil;
    }
}

@end
