#import "SSSUsers.h"
#import "SSSClient.h"

@implementation SSSUsers

- (NSURLSessionDataTask *)get:(NSInteger)userId
                      success:(void (^)(SSSUser *user))success
                      failure:(void (^)(NSError *error))failure {
    NSString *path = [self formatIntString:userId];
    return [self.client get:path
                 parameters:NULL
                      query:NULL
                    success:success
                    failure:failure];
}

- (NSURLSessionDataTask *)list:(void (^)(NSArray<SSSUser *> *data))success
                       failure:(void (^)(NSError *error))failure {
    return [self list:false limit:0 offset:0 success:success failure:failure];
}

- (NSURLSessionDataTask *)list:(bool)form
                         limit:(NSInteger)limit
                        offset:(NSInteger)offset
                       success:(void (^)(NSArray<SSSUser *> *data))success
                       failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (form) {
        [params setObject:@"true" forKey:@"form"];
    }
    if (limit > 0) {
        NSString *limitParam = [self formatIntString:limit];
        [params setObject:@"limit" forKey:limitParam];
    }
    if (offset > 0) {
        NSString *offsetParam = [self formatIntString:offset];
        [params setObject:@"offset" forKey:offsetParam];
    }
    return [self.client get:@"/users" parameters:params query:NULL success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self create:attributes userId:nil webhook:false success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self create:attributes userId:nil webhook:webhook success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSDictionary *)attributes
                          userId:(NSString *)userId
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure {
    NSString *path = @"/users";
    if (userId != nil) {
        path = [NSString stringWithFormat:@"%@/%@", path, userId];
    }
    NSDictionary *query = webhook ? @{ @"webhook" : @"true"} : nil;
    NSDictionary *params = @{@"user" : attributes};
    return [self.client post:path
                  parameters:params
                       query:query
                     success:success
                     failure:failure];
}

- (NSURLSessionDataTask *)update:(NSInteger)userId
                      attributes:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self update:userId attributes :attributes  webhook:false success:success failure:failure];
}

- (NSURLSessionDataTask *)update:(NSInteger)userId
                      attributes:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:userId];
    NSString *path = [NSString stringWithFormat:@"/users/%@", idParam];
    
    NSDictionary *query = webhook ? @{ @"webhook" : @"true"} : nil;
    NSDictionary *params = @{@"user" : attributes};
    return [self.client put:path parameters:params query:query success:success failure:failure];
}

- (NSURLSessionDataTask *)delete:(NSInteger)userId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:userId];
    NSString *path = [NSString stringWithFormat:@"/users/%@", idParam];
    return [self.client delete:path parameters:NULL query:NULL success:success failure:failure];
}

@end
