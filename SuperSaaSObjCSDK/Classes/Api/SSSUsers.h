#import "SSSBaseApi.h"
#import "SSSUser.h"

@interface SSSUsers : SSSBaseApi

- (NSURLSessionDataTask *)get:(NSInteger)userId
                      success:(void (^)(SSSUser *form))success
                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(void (^)(NSArray<SSSUser *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(bool)form
                         limit:(NSInteger)limit
                        offset:(NSInteger)offset
                       success:(void (^)(NSArray<SSSUser *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSDictionary *)attributes
                          userId:(NSString *)userId
                         webhook:(bool)webhook
                       success:(void (^)(NSArray<SSSUser *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)update:(NSInteger)userId
                      attributes:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)update:(NSInteger)userId
                      attributes:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSUser *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)delete:(NSInteger)userId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

@end
