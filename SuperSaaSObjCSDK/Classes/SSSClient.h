#import <Foundation/Foundation.h>
#import "SSSAppointments.h"
#import "SSSForms.h"
#import "SSSUsers.h"

@interface SSSClient : NSObject

- (NSURLSessionDataTask *)get:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        query:(NSDictionary *)query
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                         query:(NSDictionary *)query
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)put:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        query:(NSDictionary *)query
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)delete:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           query:(NSDictionary *)query
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

@property SSSAppointments *appointments;
@property SSSForms *forms;
@property SSSUsers *users;

@property NSString *accountName;
@property NSString *password;
@property NSString *userName;
@property NSString *host;
@property bool test;

@end
