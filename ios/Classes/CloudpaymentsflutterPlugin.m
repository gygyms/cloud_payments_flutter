#import "CloudpaymentsflutterPlugin.h"
#if __has_include(<cloudpaymentsflutter/cloudpaymentsflutter-Swift.h>)
#import <cloudpaymentsflutter/cloudpaymentsflutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cloudpaymentsflutter-Swift.h"
#endif

@implementation CloudpaymentsflutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [CloudpaymentsflutterPlugin registerWithRegistrar:registrar];
}
@end
