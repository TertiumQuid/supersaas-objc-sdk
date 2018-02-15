#import "SSSAppointments.h"
#import "SSSClient.h"
#import "SSSAppointment.h"
#import "SSSSlot.h"

@interface SSSAppointments()

- (NSURLSessionDataTask *)agenda:(NSInteger)scheduleId
                          userId:(NSInteger)userId
                        fromTime:(NSDate *)fromTime
                           slot:(bool)slot
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)changes:(NSInteger)scheduleId
                         fromTime:(NSDate *)fromTime
                             slot:(bool)slot
                          success:(void (^)(NSArray<SSSAppointment *> *data))success
                          failure:(void (^)(NSError *error))failure;

@end

@implementation SSSAppointments

- (NSURLSessionDataTask *)agenda:(NSInteger)scheduleId
                          userId:(NSInteger)userId
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self agenda:scheduleId userId:userId fromTime:nil slot:false success:success failure:failure];
}

- (NSURLSessionDataTask *)agenda:(NSInteger)scheduleId
                          userId:(NSInteger)userId
                        fromTime:(NSDate *)fromTime
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self agenda:scheduleId userId:userId fromTime:fromTime slot:false success:success failure:failure];
}

- (NSURLSessionDataTask *)agendaSlots:(NSInteger)scheduleId
                               userId:(NSInteger)userId
                              success:(void (^)(NSArray<SSSSlot *> *data))success
                              failure:(void (^)(NSError *error))failure {
    return [self agenda:scheduleId userId:userId fromTime:nil slot:true success:success failure:failure];
}

- (NSURLSessionDataTask *)agendaSlots:(NSInteger)scheduleId
                               userId:(NSInteger)userId
                             fromTime:(NSDate *)fromTime
                              success:(void (^)(NSArray<SSSAppointment *> *data))success
                              failure:(void (^)(NSError *error))failure {
    return [self agenda:scheduleId userId:userId fromTime:fromTime slot:true success:success failure:failure];
}

- (NSURLSessionDataTask *)agenda:(NSInteger)scheduleId
                          userId:(NSInteger)userId
                        fromTime:(NSDate *)fromTime
                           slot:(bool)slot
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    NSString *userParam = [self formatIntString:userId];
    NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userParam, @"user", nil];
    if (slot) {
        [query setObject:@"true" forKey:@"slot"];
    }
    if (fromTime) {
        NSString *dateParam = [self formatDateString:fromTime];
        [query setObject:dateParam forKey:@"from"];
    }
    NSString *scheduleParam = [self formatIntString:scheduleId];
    NSString *path = [NSString stringWithFormat:@"/agenda/%@", scheduleParam];
    return [self.client get:path
                 parameters:nil
                      query:query
                    success:success
                    failure:failure];
}

- (NSURLSessionDataTask *)available:(NSInteger)scheduleId
                           fromTime:(NSDate *)fromTime
                            success:(void (^)(NSArray<SSSAppointment *> *data))success
                            failure:(void (^)(NSError *error))failure {
    return [self available:scheduleId fromTime:fromTime lengthMinutes:0 resource:nil full:false limit:0 success:success failure:failure];
}

- (NSURLSessionDataTask *)available:(NSInteger)scheduleId
                           fromTime:(NSDate *)fromTime
                           resource:(NSString *)resource
                            success:(void (^)(NSArray<SSSAppointment *> *data))success
                            failure:(void (^)(NSError *error))failure {
    return [self available:scheduleId fromTime:fromTime lengthMinutes:0 resource:resource full:false limit:0 success:success failure:failure];
}

- (NSURLSessionDataTask *)available:(NSInteger)scheduleId
                           fromTime:(NSDate *)fromTime
                      lengthMinutes:(NSInteger)lengthMinutes
                           resource:(NSString *)resource
                               full:(bool)full
                              limit:(NSInteger)limit
                            success:(void (^)(NSArray<SSSAppointment *> *data))success
                            failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    NSString *dateParam = [self formatDateString:fromTime];
    [query setObject:dateParam forKey:@"from"];
    
    if (full) {
        [query setObject:@"true" forKey:@"full"];
    }
    if (limit > 0) {
        NSString *limitParam = [self formatIntString:limit];
        [query setObject:limitParam forKey:@"limit"];
    }
    if (lengthMinutes > 0) {
        NSString *lengthParam = [self formatIntString:lengthMinutes];
        [query setObject:lengthParam forKey:@"length"];
    }
    if (resource != nil) {
        [query setObject:resource forKey:@"resource"];
    }
    NSString *idParam = [self formatIntString:scheduleId];
    NSString *path = [NSString stringWithFormat:@"/available/%@", idParam];
    return [self.client get:path parameters:nil query:query success:success failure:failure];
}

- (NSURLSessionDataTask *)list:(NSInteger)scheduleId
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure {
    return [self list:scheduleId form:false startTime:nil limit:0 success:success failure:failure];
}

- (NSURLSessionDataTask *)list:(NSInteger)scheduleId
                     startTime:(NSDate *)startTime
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure {
    return [self list:scheduleId form:false startTime:startTime limit:0 success:success failure:failure];
}

- (NSURLSessionDataTask *)list:(NSInteger)scheduleId
                          form:(bool)form
                     startTime:(NSDate *)startTime
                         limit:(NSInteger)limit
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    NSString *scheduleParam = [self formatIntString:scheduleId];
    [query setObject:scheduleParam forKey:@"schedule_id"];
    
    if (startTime != nil) {
        NSString *dateParam = [self formatDateString:startTime];
        [query setObject:dateParam forKey:@"start"];
    }
    if (form) {
        [query setObject:@"true" forKey:@"form"];
    }
    if (limit > 0) {
        NSString *limitParam = [self formatIntString:limit];
        [query setObject:limitParam forKey:@"limit"];
    }
    return [self.client get:@"/bookings" parameters:nil query:query success:success failure:failure];
}

- (NSURLSessionDataTask *)get:(NSInteger)appointmentId
                      success:(void (^)(SSSAppointment *form))success
                      failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:appointmentId];
    NSString *path = [NSString stringWithFormat:@"/bookings/%@", idParam];
    return [self.client get:path parameters:NULL query:NULL success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self create:scheduleId userId:userId attributes:attributes form:false webhook:false success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self create:scheduleId userId:userId attributes:attributes form:false webhook:webhook success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self create:scheduleId userId:userId attributes:attributes form:form webhook:false success:success failure:failure];
}

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    
    NSString *path = @"/bookings";
    NSDictionary *query = webhook ? @{ @"webhook" : @"true"} : nil;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:attributes forKey:@"booking"];
    [params setValue:userId forKey:@"user_id"];
    [params setValue:[self formatIntString:scheduleId] forKey:@"schedule_id"];
    if (form) {
        [params setObject:@"true" forKey:@"form"];
    }
    return [self.client post:path parameters:params query:query success:success failure:failure];
}

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self update:scheduleId appointmentId:appointmentId attributes:attributes form:false webhook:false success:success failure:failure];
}

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self update:scheduleId appointmentId:appointmentId attributes:attributes form:false webhook:webhook success:success failure:failure];
}

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    return [self update:scheduleId appointmentId:appointmentId attributes:attributes form:form webhook:false success:success failure:failure];
}

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:appointmentId];
    NSString *path = [NSString stringWithFormat:@"/bookings/%@", idParam];
    NSDictionary *query = webhook ? @{ @"webhook" : @"true"} : nil;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:attributes forKey:@"booking"];
    [params setValue:[self formatIntString:scheduleId] forKey:@"schedule_id"];
    if (form) {
        [params setObject:@"true" forKey:@"form"];
    }
    return [self.client post:path parameters:params query:query success:success failure:failure];
}

- (NSURLSessionDataTask *)delete:(NSInteger)appointmentId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure {
    NSString *idParam = [self formatIntString:appointmentId];
    NSString *path = [NSString stringWithFormat:@"users/%@", idParam];
    return [self.client delete:path
                    parameters:NULL
                         query:NULL
                       success:success
                       failure:failure];
}

- (NSURLSessionDataTask *)changes:(NSInteger)scheduleId
                         fromTime:(NSDate *)fromTime
                          success:(void (^)(NSArray<SSSAppointment *> *data))success
                          failure:(void (^)(NSError *error))failure {
    return [self changes:scheduleId fromTime:fromTime slot:false success:success failure:failure];
}

- (NSURLSessionDataTask *)changesSlots:(NSInteger)scheduleId
                              fromTime:(NSDate *)fromTime
                               success:(void (^)(NSArray<SSSSlot *> *data))success
                               failure:(void (^)(NSError *error))failure {
    return [self changes:scheduleId fromTime:fromTime slot:true success:success failure:failure];
}

- (NSURLSessionDataTask *)changes:(NSInteger)scheduleId
                         fromTime:(NSDate *)fromTime
                             slot:(bool)slot
                          success:(void (^)(NSArray<SSSAppointment *> *data))success
                          failure:(void (^)(NSError *error))failure {
    NSString *dateParam = [self formatDateString:fromTime];
    NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithObjectsAndKeys:dateParam, @"from", nil];
    if (slot) {
        [query setObject:@"true" forKey:@"slot"];
    }
    NSString *scheduleParam = [self formatIntString:scheduleId];
    NSString *path = [NSString stringWithFormat:@"/changes/%@", scheduleParam];
    return [self.client get:path parameters:nil query:query success:success failure:failure];
}

@end
