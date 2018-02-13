#import "SSSBaseModel.h"
#import "SSSForm.h"

@interface SSSAppointment : SSSBaseModel

- (id)initWithAttributes:(NSDictionary *)attributes;

@property NSString *address;
@property NSString *country;
@property NSString *createdBy;
@property NSDate *createdOn;
@property bool deleted;
@property NSString *description;
@property NSString *email;
@property NSString *field1;
@property NSString *filed2;
@property NSString *field1R;
@property NSString *filed2R;
@property NSString *fk;
@property NSDate *finish;
@property NSInteger id;
@property NSString *mobile;
@property NSString *phone;
@property NSInteger price;
@property NSString *resName;
@property NSInteger resourceId;
@property NSInteger scheduleId;
@property NSString *scheduleName;
@property NSInteger serviceId;
@property NSString *serviceName;
@property NSInteger slotId;
@property NSDate *start;
@property NSString *status;
@property NSString *superField;
@property NSString *updatedBy;
@property NSDate *updatedOn;
@property NSInteger userId;
@property bool waitlisted;
@property SSSForm *form;

@end
