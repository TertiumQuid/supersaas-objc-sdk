#import "SSSClient.h"
#import "SSSAppointments.h"

NSString * const API_VERSION = @"1";

@interface SSSClient()

- (NSURLSessionDataTask *)request:(NSString *)httpMethod
                              path:(NSString *)path
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

- (NSURL *)urlFromPath:(NSString *)path;
- (NSString *)userAgent;
- (NSString *)authCredentials;
@end

@implementation SSSClient

- (id)init {
    if (self = [super init] )
    {
        self.appointments = [[SSSAppointments alloc] initWithClient:self];
        self.forms = [[SSSForms alloc] initWithClient:self];
        self.users = [[SSSUsers alloc] initWithClient:self];
    }
    return self;
}
    
- (NSURLSessionDataTask *)get:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        query:(NSDictionary *)query
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure {
    return [self request:@"GET" path:URLString parameters:parameters success:success failure:failure];
}
    
- (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                         query:(NSDictionary *)query
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
    return [self request:@"POST" path:URLString parameters:parameters success:success failure:failure];
}
    
- (NSURLSessionDataTask *)put:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        query:(NSDictionary *)query
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure {
    return [self request:@"PUT" path:URLString parameters:parameters success:success failure:failure];
}
    
- (NSURLSessionDataTask *)delete:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           query:(NSDictionary *)query
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure {
    return [self request:@"DELETE" path:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)request:(NSString *)httpMethod
                              path:(NSString *)path
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    NSURL *url = [self urlFromPath:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = httpMethod;
    [request addValue:[self authCredentials] forHTTPHeaderField:@"Authorization"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                            
        if (error != nil) {
            failure(error);
        } else if (httpResponse.statusCode > 299) {
        } else {
            NSError *jsonError;
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        }
    }];
    [task resume];
    return task;
}
    
- (NSURL *)urlFromPath:(NSString *)path {
    NSString *url = [NSString stringWithFormat:@"%@%@.json", self.host, path];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:set];
    return [NSURL URLWithString:encodedUrl];
}
    
- (NSString *)userAgent {
    NSString *systemName = [[UIDevice currentDevice] systemName];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"SSS/%@ OBJC/%@/%@ API/%@", version, systemName, systemVersion, API_VERSION];
}

- (NSString *)authCredentials {
    NSString *credentials = [NSString stringWithFormat:@"%@:%@", self.accountName, self.password];
    NSData *data = [credentials dataUsingEncoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"Basic %@",[data base64EncodedStringWithOptions:0]];
}

@end
