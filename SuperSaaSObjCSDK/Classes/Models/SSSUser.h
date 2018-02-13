#import "SSSBaseModel.h"
#import "SSSForm.h"

@interface SSSUser : SSSBaseModel

- (id)initWithAttributes:(NSDictionary *)attributes;

@property NSString *address;
@property NSString *country;
@property NSDate *createdOn;
@property NSInteger credit;
@property NSString *email;
@property NSString *field1;
@property NSString *filed2;
@property NSString *fk;
@property NSInteger id;
@property NSString *mobile;
@property NSString *phone;
@property NSInteger role;
@property NSString *superField;
@property SSSForm *form;

@end
