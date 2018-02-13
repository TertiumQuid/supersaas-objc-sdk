//
//  SSSForms.m
//  SuperSaaSObjCSDK
//
//  Created by Monty Cantsin on 11/02/2018.
//

#import "SSSForms.h"

@implementation SSSForms

- (NSURLSessionDataTask *)get:(NSInteger)formId
                      success:(void (^)(SSSForm *form))success
                      failure:(void (^)(NSError *error))failure {
    
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
    
}

@end
