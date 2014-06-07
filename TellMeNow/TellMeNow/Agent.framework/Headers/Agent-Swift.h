// Generated by Swift version 1.0 (swift-600.0.34.4.5)

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif

#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Foundation;
#endif


SWIFT_CLASS("_TtC5Agent5Agent")
@interface Agent : NSObject

/// Members
@property (nonatomic) NSMutableURLRequest * request;
@property (nonatomic) NSHTTPURLResponse * response;
@property (nonatomic) NSMutableData * data;
@property (nonatomic) void (^ done)(NSError *, NSHTTPURLResponse *, id);

/// Initialize
- (instancetype)initWithMethod:(NSString *)method url:(NSString *)url headers:(NSDictionary *)headers OBJC_DESIGNATED_INITIALIZER;

/// GET
+ (Agent *)get:(NSString *)url;
+ (Agent *)get:(NSString *)url headers:(NSDictionary *)headers;
+ (Agent *)get:(NSString *)url done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;
+ (Agent *)get:(NSString *)url headers:(NSDictionary *)headers done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;

/// POST
+ (Agent *)post:(NSString *)url;
+ (Agent *)post:(NSString *)url headers:(NSDictionary *)headers;
+ (Agent *)post:(NSString *)url done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;
+ (Agent *)post:(NSString *)url headers:(NSDictionary *)headers data:(NSDictionary *)data;
+ (Agent *)post:(NSString *)url data:(NSDictionary *)data;
+ (Agent *)post:(NSString *)url data:(NSDictionary *)data done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;
+ (Agent *)post:(NSString *)url headers:(NSDictionary *)headers data:(NSDictionary *)data done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;

/// PUT
+ (Agent *)put:(NSString *)url;
+ (Agent *)put:(NSString *)url headers:(NSDictionary *)headers;
+ (Agent *)put:(NSString *)url done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;
+ (Agent *)put:(NSString *)url headers:(NSDictionary *)headers data:(NSDictionary *)data;
+ (Agent *)put:(NSString *)url data:(NSDictionary *)data;
+ (Agent *)put:(NSString *)url data:(NSDictionary *)data done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;
+ (Agent *)put:(NSString *)url headers:(NSDictionary *)headers data:(NSDictionary *)data done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;

/// DELETE
+ (Agent *)delete:(NSString *)url;
+ (Agent *)delete:(NSString *)url headers:(NSDictionary *)headers;
+ (Agent *)delete:(NSString *)url done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;
+ (Agent *)delete:(NSString *)url headers:(NSDictionary *)headers done:(void (^)(NSError *, NSHTTPURLResponse *, id))done;

/// Methods
- (Agent *)send:(NSDictionary *)data;
- (Agent *)set:(NSString *)header value:(NSString *)value;
- (Agent *)end:(void (^)(NSError *, NSHTTPURLResponse *, id))done;

/// Delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
@end

