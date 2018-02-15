#import "SSSForms.h"
#import "SSSClient.h"

@implementation SSSForms

- (NSURLSessionDataTask *)get:(NSInteger)formId
                      success:(void (^)(SSSForm *form))success
                      failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:formId];
    return [self.client get:@"/forms"
                 parameters:NULL
                      query:@{ @"id" : idParam }
                    success:success
                    failure:failure];
}

- (NSURLSessionDataTask *)list:(NSInteger)templateFormId
                       success:(void (^)(NSArray<SSSForm *> *data))success
                       failure:(void (^)(NSError *error))failure {
    return [self list:templateFormId fromTime:NULL success:success failure:failure];
}

- (NSURLSessionDataTask *)list:(NSInteger)templateFormId
                      fromTime:(NSDate *)fromTime
                       success:(void (^)(NSArray<SSSForm *> *data))success
                       failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:templateFormId];
    NSString *dateParam = [self formatDateString:fromTime];
    
    return [self.client get:@"/forms"
                 parameters:NULL
                      query:@{ @"form_id" : idParam, @"from" : dateParam ? dateParam : [NSNull null] }
                    success:success
                    failure:failure];
}

@end
