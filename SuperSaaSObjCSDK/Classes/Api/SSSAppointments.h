#import "SSSBaseApi.h"

@class SSSAppointment;
@class SSSSlot;

@interface SSSAppointments : SSSBaseApi

- (NSURLSessionDataTask *)agenda:(NSInteger)scheduleId
                          userId:(NSInteger)userId
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)agenda:(NSInteger)scheduleId
                          userId:(NSInteger)userId
                        fromTime:(NSDate *)fromTime
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)agendaSlots:(NSInteger)scheduleId
                               userId:(NSInteger)userId
                              success:(void (^)(NSArray<SSSSlot *> *data))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)agendaSlots:(NSInteger)scheduleId
                               userId:(NSInteger)userId
                             fromTime:(NSDate *)fromTime
                              success:(void (^)(NSArray<SSSAppointment *> *data))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)available:(NSInteger)scheduleId
                             fromTime:(NSDate *)fromTime
                              success:(void (^)(NSArray<SSSAppointment *> *data))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)available:(NSInteger)scheduleId
                           fromTime:(NSDate *)fromTime
                           resource:(NSString *)resource
                            success:(void (^)(NSArray<SSSAppointment *> *data))success
                            failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)available:(NSInteger)scheduleId
                           fromTime:(NSDate *)fromTime
                      lengthMinutes:(NSInteger)lengthMinutes
                           resource:(NSString *)resource
                               full:(bool)full
                              limit:(NSInteger)limit
                            success:(void (^)(NSArray<SSSAppointment *> *data))success
                            failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(NSInteger)scheduleId
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(NSInteger)scheduleId
                     startTime:(NSDate *)startTime
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)list:(NSInteger)scheduleId
                          form:(bool)form
                     startTime:(NSDate *)startTime
                         limit:(NSInteger)limit
                       success:(void (^)(NSArray<SSSAppointment *> *data))success
                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)get:(NSInteger)appointmentId
                      success:(void (^)(SSSAppointment *form))success
                      failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)create:(NSInteger)scheduleId
                          userId:(NSString *)userId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)update:(NSInteger)scheduleId
                   appointmentId:(NSInteger)appointmentId
                      attributes:(NSDictionary *)attributes
                            form:(bool)form
                         webhook:(bool)webhook
                         success:(void (^)(NSArray<SSSAppointment *> *data))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)delete:(NSInteger)appointmentId
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)changes:(NSInteger)scheduleId
                         fromTime:(NSDate *)fromTime
                          success:(void (^)(NSArray<SSSAppointment *> *data))success
                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)changesSlots:(NSInteger)scheduleId
                              fromTime:(NSDate *)fromTime
                               success:(void (^)(NSArray<SSSSlot *> *data))success
                               failure:(void (^)(NSError *error))failure;

@end
