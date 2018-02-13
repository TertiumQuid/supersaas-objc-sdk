#import "SSSBaseModel.h"
#import "SSSAppointment.h"

@interface SSSSlot : SSSBaseModel

- (id)initWithAttributes:(NSDictionary *)attributes;

@property NSInteger count;
@property NSString *description;
@property NSDate *finish;
@property NSInteger id;
@property NSString *location;
@property NSString *name;
@property NSDate *start;
@property NSString *title;
@property NSArray<SSSAppointment *> *bookings;

@end
