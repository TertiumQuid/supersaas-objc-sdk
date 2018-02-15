#import "SSSClient.h"
#import "SSSAppointments.h"

NSString * const API_VERSION = @"1";

@interface SSSClient()

- (NSURLSessionDataTask *)request:(NSString *)httpMethod
                              path:(NSString *)path
                      parameters:(NSDictionary *)parameters
                            query:(NSDictionary *)query
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

- (NSURL *)urlFromPath:(NSString *)path andQuery:(NSDictionary *)query;
- (NSError *)httpResponseError:(NSError *)underlyingError url:(NSURL *)url data:(NSData *)data code:(NSInteger)code;
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
    return [self request:@"GET" path:URLString parameters:parameters query:query success:success failure:failure];
}
    
- (NSURLSessionDataTask *)post:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                         query:(NSDictionary *)query
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
    return [self request:@"POST" path:URLString parameters:parameters query:query success:success failure:failure];
}
    
- (NSURLSessionDataTask *)put:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        query:(NSDictionary *)query
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure {
    return [self request:@"PUT" path:URLString parameters:parameters query:query success:success failure:failure];
}
    
- (NSURLSessionDataTask *)delete:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           query:(NSDictionary *)query
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure {
    return [self request:@"DELETE" path:URLString parameters:parameters query:query success:success failure:failure];
}

- (NSURLSessionDataTask *)request:(NSString *)httpMethod
                              path:(NSString *)path
                       parameters:(NSDictionary *)parameters
                            query:(NSDictionary *)query
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURL *url = [self urlFromPath:path andQuery:query];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = httpMethod;
    [request addValue:[self authCredentials] forHTTPHeaderField:@"Authorization"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSError *parametersError;
    NSData *json = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&parametersError];
    if (parametersError != nil) {
        failure([self httpResponseError:parametersError url:url data:nil code:0]);
        return [[NSURLSessionDataTask alloc] init];
    }
    request.HTTPBody = json;
    
    self.lastRequest = request;
    if (self.test) {
        success(nil);
        return [[NSURLSessionDataTask alloc] init];
    }
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                            NSError *sdkError;
                                            NSDictionary *jsonResponse = @{};
        if (error != nil || httpResponse.statusCode > 299) {
            sdkError = [self httpResponseError:error url:url data:data code:httpResponse.statusCode];
            failure(sdkError);
        } else {
            
            if (data.length > 0) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError != nil) {
                    sdkError = [self httpResponseError:error url:url data:data code:httpResponse.statusCode];
                    failure(sdkError);
                } else {
                    success(jsonResponse);
                }
            } else {
                success(jsonResponse);
            }
        }
    }];
    [task resume];
    return task;
}

- (NSError *)httpResponseError:(NSError *)underlyingError url:(NSURL *)url data:(NSData *)data code:(NSInteger)code {
    NSString *errorMessage = underlyingError.localizedDescription;
    if (data != nil && data.length > 0) {
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
        } else {
            errorMessage = [json valueForKey:@"errors"];
        }
    }
    NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : errorMessage,
                                       NSUnderlyingErrorKey : underlyingError,
                                       NSFilePathErrorKey : url.absoluteString };
    return [[NSError alloc] initWithDomain:@"com.supersaas.error"
                                      code:code
                                  userInfo:errorDictionary];
}
    
- (NSURL *)urlFromPath:(NSString *)path andQuery:(NSDictionary *)query {
    NSCharacterSet *characters = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *url = [NSString stringWithFormat:@"%@%@", self.host, path];
    NSString *param;
    NSString *queryKey;
    NSString *queryValue;
    if (query.count > 0) {
        url = [url stringByAppendingString:@"?"];
        for (NSString *key in query) {
            queryKey = [key stringByAddingPercentEncodingWithAllowedCharacters:characters];
            queryValue = [[query valueForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:characters];
            param = [NSString stringWithFormat:@"%@=%@&", queryKey, queryValue];
            url = [url stringByAppendingString:param];
        }
        url = [url substringToIndex:[url length] - 1];
    }
    url = [url stringByAppendingString:@".json"];
    return [NSURL URLWithString:url];
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

- (NSString *)urlEscapeString:(NSString *)string {
    NSCharacterSet *characters = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:characters];
}

@end
