# SuperSaaS Objective-C SDK

Online bookings/appointments/calendars in Ruby using the SuperSaaS scheduling platform - https://supersaas.com

The SuperSaaS API provides services that can be used to add online booking and scheduling functionality to an existing
website or CRM software.

## Prerequisites

1. [Register for a (free) SuperSaaS account](https://www.supersaas.com/accounts/new), and
2. get your account name and password.

##### Dependencies

iOs 7 or greater, or else OSX 10.8 or greater.

No external libraries. Only the native `NSJSONSerialization` and `NSURLRequest` standard libs are used.

## Installation

SuperSaaSObjCSDK is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile and run `pod install`:

    pod 'SuperSaaSObjCSDK'

## Configuration

Initialize the `SSSClient` and set the authorization credentials:

    SSSClient *client = [[SSSClient alloc] init];
    client.accountName = @"accnt";
    client.config.password = @"pwd";
    client.userName = @"usr";
    client.test = false

## API Methods

Details of the data structures, parameters, and values can be found on the developer documentation site:

https://www.supersaas.com/info/dev

#### Create User

#### Update User

#### Delete User

#### Get User

#### List Users

#### Create Appointment/Booking

#### Update Appointment/Booking

#### Delete Appointment/Booking

#### Get Appointment/Booking

#### List Appointments/Bookings

#### Get Agenda

#### Get Agenda Slots

#### Get Available Appointments/Bookings

#### Get Recent Changes

#### Get Recent Changes Slots

#### List Template Forms

#### Get Form

## Examples

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Testing

The HTTP requests can be stubbed by configuring the client with the `test` option, e.g.

    SSSClient.test = true;

Note, stubbed requests always return an empty `NSURLSessionDataTask`.

The `Client` also provides a `lastRequest` attribute containing the `NSURLRequest` object from the last performed request, e.g.

    SSSClient.lastRequest //=> <Net::HTTP::Get>

The headers, body, path, etc. of the last request can be inspected for assertion in tests, or for troubleshooting failed API requests.

## Additional Information

+ [SuperSaaS Registration](https://www.supersaas.com/accounts/new)
+ [Product Documentation](https://www.supersaas.com/info/support)
+ [Developer Documentation](https://www.supersaas.com/info/dev)
+ [Python SDK](https://github.com/TertiumQuid/supersaas-python-sdk)
+ [PHP SDK](https://github.com/TertiumQuid/supersaas-php-sdk)
+ [NodeJS SDK](https://github.com/TertiumQuid/supersaas-nodejs-sdk)
+ [C# SDK](https://github.com/TertiumQuid/supersaas-csharp-sdk)
+ [Ruby SDK](https://github.com/TertiumQuid/supersaas-ruby-sdk)

Contact: [support@supersaas.com](mailto:support@supersaas.com)

## License

SuperSaaS Objective-C SDK is available under the MIT license. See the LICENSE file for more info.
