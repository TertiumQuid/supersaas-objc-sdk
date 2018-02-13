#import "SSSBaseApi.h"
#import "SSSForm.h"

@interface SSSForms : SSSBaseApi
- (NSURLSessionDataTask *)get:(NSInteger)formId
                      success:(void (^)(SSSForm *form))success
                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(NSInteger)templateFormId
                       success:(void (^)(NSArray<SSSForm *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(NSInteger)templateFormId
                      fromTime:(NSDate *)fromTime
                       success:(void (^)(NSArray<SSSForm *> *data))success
                       failure:(void (^)(NSError *error))failure;
@end
