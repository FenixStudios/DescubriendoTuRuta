#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#define DEBUG 1
#include <stdarg.h>
#include <monotouch/monotouch.h>
#include <objc/objc.h>
#include <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


id native_to_managed_trampoline_1 (id self, SEL _cmd, MonoMethod **managed_method_ptr, const char *r0, const char *r1)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [0];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		managed_method = get_method_direct(r0, r1, 0, NULL)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	void * retval = mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	id res;
	if (!retval) {
		res = NULL;
	} else {
		id retobj;
		mono_field_get_value ((MonoObject *) retval, monotouch_nsobject_handle_field, (void **) &retobj);
		monotouch_framework_peer_lock ();
		[retobj retain];
		monotouch_framework_peer_unlock ();
		[retobj autorelease];
		mt_dummy_use (retval);
		res = retobj;
	}

	return res;
}


void native_to_managed_trampoline_2 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, const char *r0, const char *r1, const char *r2)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [1];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[1] = { r0 };
		managed_method = get_method_direct(r1, r2, 1, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


bool native_to_managed_trampoline_3 (id self, SEL _cmd, MonoMethod **managed_method_ptr, void * p0, const char *r0, const char *r1, const char *r2)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [1];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[1] = { r0 };
		managed_method = get_method_direct(r1, r2, 1, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	void * a0 = p0;
	arg_ptrs [0] = &a0;

	void * retval = mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	bool res;
	res = *(bool *) mono_object_unbox (retval);

	return res;
}


id native_to_managed_trampoline_4 (id self, SEL _cmd, MonoMethod **managed_method_ptr, const char *r0, const char *r1)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [0];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	if (monotouch_try_get_nsobject (self))
		return self;
	if (!managed_method) {
		managed_method = get_method_direct(r0, r1, 0, NULL)->method;
		*managed_method_ptr = managed_method;
	}
	mthis = mono_object_new (mono_domain_get (), mono_method_get_class (managed_method));
	uint8_t flags = 2;
	mono_field_set_value (mthis, monotouch_nsobject_handle_field, &self);
	mono_field_set_value (mthis, monotouch_nsobject_flags_field, &flags);
	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);
	monotouch_create_managed_ref (self, mthis, true);

	return self;
}


int native_to_managed_trampoline_5 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, int p1, const char *r0, const char *r1, const char *r2, const char *r3)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [2];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[2] = { r0, r1 };
		managed_method = get_method_direct(r2, r3, 2, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	arg_ptrs [1] = &p1;

	void * retval = mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	int res;
	res = *(int *) mono_object_unbox (retval);

	return res;
}


id native_to_managed_trampoline_6 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, id p1, const char *r0, const char *r1, const char *r2, const char *r3)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [2];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[2] = { r0, r1 };
		managed_method = get_method_direct(r2, r3, 2, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	NSObject *nsobj1 = (NSObject *) p1;
	MonoObject *mobj1 = NULL;
	bool created1 = false;
	if (nsobj1) {
		MonoType *paramtype1 = monotouch_get_parameter_type (managed_method, 1);
		mobj1 = get_nsobject_with_type_for_ptr_created (nsobj1, false, paramtype1, &created1);
		monotouch_verify_parameter (mobj1, _cmd, self, nsobj1, 1, mono_class_from_mono_type (paramtype1), managed_method);
	}
	arg_ptrs [1] = mobj1;

	void * retval = mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	id res;
	if (!retval) {
		res = NULL;
	} else {
		id retobj;
		mono_field_get_value ((MonoObject *) retval, monotouch_nsobject_handle_field, (void **) &retobj);
		monotouch_framework_peer_lock ();
		[retobj retain];
		monotouch_framework_peer_unlock ();
		[retobj autorelease];
		mt_dummy_use (retval);
		res = retobj;
	}

	return res;
}


void native_to_managed_trampoline_7 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, id p1, const char *r0, const char *r1, const char *r2, const char *r3)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [2];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[2] = { r0, r1 };
		managed_method = get_method_direct(r2, r3, 2, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	NSObject *nsobj1 = (NSObject *) p1;
	MonoObject *mobj1 = NULL;
	bool created1 = false;
	if (nsobj1) {
		MonoType *paramtype1 = monotouch_get_parameter_type (managed_method, 1);
		mobj1 = get_nsobject_with_type_for_ptr_created (nsobj1, false, paramtype1, &created1);
		monotouch_verify_parameter (mobj1, _cmd, self, nsobj1, 1, mono_class_from_mono_type (paramtype1), managed_method);
	}
	arg_ptrs [1] = mobj1;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


void native_to_managed_trampoline_8 (id self, SEL _cmd, MonoMethod **managed_method_ptr, const char *r0, const char *r1)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [0];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		managed_method = get_method_direct(r0, r1, 0, NULL)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


void native_to_managed_trampoline_9 (id self, SEL _cmd, MonoMethod **managed_method_ptr, bool p0, const char *r0, const char *r1, const char *r2)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [1];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[1] = { r0 };
		managed_method = get_method_direct(r1, r2, 1, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	arg_ptrs [0] = &p0;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


bool native_to_managed_trampoline_10 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, NSString * p1, const char *r0, const char *r1, const char *r2, const char *r3)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [2];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[2] = { r0, r1 };
		managed_method = get_method_direct(r2, r3, 2, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	arg_ptrs [1] = p1 ? mono_string_new (mono_domain_get (), [p1 UTF8String]) : NULL;

	void * retval = mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	bool res;
	res = *(bool *) mono_object_unbox (retval);

	return res;
}


void native_to_managed_trampoline_11 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, int p1, const char *r0, const char *r1, const char *r2, const char *r3)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [2];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[2] = { r0, r1 };
		managed_method = get_method_direct(r2, r3, 2, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	arg_ptrs [1] = &p1;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


void native_to_managed_trampoline_12 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, int p1, id p2, const char *r0, const char *r1, const char *r2, const char *r3, const char *r4)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [3];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[3] = { r0, r1, r2 };
		managed_method = get_method_direct(r3, r4, 3, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	arg_ptrs [1] = &p1;
	NSObject *nsobj2 = (NSObject *) p2;
	MonoObject *mobj2 = NULL;
	bool created2 = false;
	if (nsobj2) {
		MonoType *paramtype2 = monotouch_get_parameter_type (managed_method, 2);
		mobj2 = get_nsobject_with_type_for_ptr_created (nsobj2, false, paramtype2, &created2);
		monotouch_verify_parameter (mobj2, _cmd, self, nsobj2, 2, mono_class_from_mono_type (paramtype2), managed_method);
	}
	arg_ptrs [2] = mobj2;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


void native_to_managed_trampoline_13 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, NSArray * p1, id p2, const char *r0, const char *r1, const char *r2, const char *r3, const char *r4)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [3];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[3] = { r0, r1, r2 };
		managed_method = get_method_direct(r3, r4, 3, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	if (p1) {
		NSArray *arr = (NSArray *) p1;
		monotouch_check_objc_type (p1, [NSArray class], _cmd, self, 1, managed_method);
		MonoClass *e_class;
		MonoArray *marr;
		MonoType *p;
		int j;
		p = monotouch_get_parameter_type (managed_method, 1);
		e_class = mono_class_get_element_class (mono_class_from_mono_type (p));
		marr = mono_array_new (mono_domain_get (), e_class, [arr count]);
		for (j = 0; j < [arr count]; j++) {
			NSObject *nobj = [arr objectAtIndex: j];
			MonoObject *mobj1 = NULL;
			if (nobj) {
				mobj1 = get_managed_object_for_ptr_fast (nobj, false);
				monotouch_verify_parameter (mobj1, _cmd, self, nobj, 1, e_class, managed_method);
			}
			mono_array_set (marr, MonoObject *, j, mobj1);
		}
		arg_ptrs [1] = marr;
	} else {
		arg_ptrs [1] = NULL;
	}
	NSObject *nsobj2 = (NSObject *) p2;
	MonoObject *mobj2 = NULL;
	bool created2 = false;
	if (nsobj2) {
		MonoType *paramtype2 = monotouch_get_parameter_type (managed_method, 2);
		mobj2 = get_nsobject_with_type_for_ptr_created (nsobj2, false, paramtype2, &created2);
		monotouch_verify_parameter (mobj2, _cmd, self, nsobj2, 2, mono_class_from_mono_type (paramtype2), managed_method);
	}
	arg_ptrs [2] = mobj2;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


void native_to_managed_trampoline_14 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, NSArray * p1, const char *r0, const char *r1, const char *r2, const char *r3)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [2];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[2] = { r0, r1 };
		managed_method = get_method_direct(r2, r3, 2, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	if (p1) {
		NSArray *arr = (NSArray *) p1;
		monotouch_check_objc_type (p1, [NSArray class], _cmd, self, 1, managed_method);
		MonoClass *e_class;
		MonoArray *marr;
		MonoType *p;
		int j;
		p = monotouch_get_parameter_type (managed_method, 1);
		e_class = mono_class_get_element_class (mono_class_from_mono_type (p));
		marr = mono_array_new (mono_domain_get (), e_class, [arr count]);
		for (j = 0; j < [arr count]; j++) {
			NSObject *nobj = [arr objectAtIndex: j];
			MonoObject *mobj1 = NULL;
			if (nobj) {
				mobj1 = get_managed_object_for_ptr_fast (nobj, false);
				monotouch_verify_parameter (mobj1, _cmd, self, nobj, 1, e_class, managed_method);
			}
			mono_array_set (marr, MonoObject *, j, mobj1);
		}
		arg_ptrs [1] = marr;
	} else {
		arg_ptrs [1] = NULL;
	}

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


void native_to_managed_trampoline_15 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, id p1, id p2, const char *r0, const char *r1, const char *r2, const char *r3, const char *r4)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [3];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[3] = { r0, r1, r2 };
		managed_method = get_method_direct(r3, r4, 3, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;
	NSObject *nsobj1 = (NSObject *) p1;
	MonoObject *mobj1 = NULL;
	bool created1 = false;
	if (nsobj1) {
		MonoType *paramtype1 = monotouch_get_parameter_type (managed_method, 1);
		mobj1 = get_nsobject_with_type_for_ptr_created (nsobj1, false, paramtype1, &created1);
		monotouch_verify_parameter (mobj1, _cmd, self, nsobj1, 1, mono_class_from_mono_type (paramtype1), managed_method);
	}
	arg_ptrs [1] = mobj1;
	NSObject *nsobj2 = (NSObject *) p2;
	MonoObject *mobj2 = NULL;
	bool created2 = false;
	if (nsobj2) {
		MonoType *paramtype2 = monotouch_get_parameter_type (managed_method, 2);
		mobj2 = get_nsobject_with_type_for_ptr_created (nsobj2, false, paramtype2, &created2);
		monotouch_verify_parameter (mobj2, _cmd, self, nsobj2, 2, mono_class_from_mono_type (paramtype2), managed_method);
	}
	arg_ptrs [2] = mobj2;

	mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	return;
}


bool native_to_managed_trampoline_16 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, const char *r0, const char *r1, const char *r2)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [1];
	MonoObject *mthis;
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	mthis = NULL;
	if (self) {
		mthis = get_managed_object_for_ptr_fast (self, false);
	}
	if (!managed_method) {
		const char *paramptr[1] = { r0 };
		managed_method = get_method_direct(r1, r2, 1, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	check_for_gced_object (mthis, _cmd, self, managed_method);
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;

	void * retval = mono_runtime_invoke (managed_method, mthis, arg_ptrs, NULL);

	bool res;
	res = *(bool *) mono_object_unbox (retval);

	return res;
}


void native_to_managed_trampoline_17 (id self, SEL _cmd, MonoMethod **managed_method_ptr, id p0, const char *r0, const char *r1, const char *r2)
{
	MonoMethod *managed_method = *managed_method_ptr;
	void *arg_ptrs [1];
	if (mono_domain_get () == NULL)
		mono_jit_thread_attach (NULL);
	if (!managed_method) {
		const char *paramptr[1] = { r0 };
		managed_method = get_method_direct(r1, r2, 1, paramptr)->method;
		*managed_method_ptr = managed_method;
	}
	NSObject *nsobj0 = (NSObject *) p0;
	MonoObject *mobj0 = NULL;
	bool created0 = false;
	if (nsobj0) {
		MonoType *paramtype0 = monotouch_get_parameter_type (managed_method, 0);
		mobj0 = get_nsobject_with_type_for_ptr_created (nsobj0, false, paramtype0, &created0);
		monotouch_verify_parameter (mobj0, _cmd, self, nsobj0, 0, mono_class_from_mono_type (paramtype0), managed_method);
	}
	arg_ptrs [0] = mobj0;

	mono_runtime_invoke (managed_method, NULL, arg_ptrs, NULL);

	return;
}



@interface AppDelegate : NSObject/*<UIApplicationDelegate>*/ {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(id) window;
	-(void) setWindow:(id)p0;
	-(void) applicationWillResignActive:(id)p0;
	-(void) applicationDidEnterBackground:(id)p0;
	-(void) applicationWillEnterForeground:(id)p0;
	-(void) applicationWillTerminate:(id)p0;
	-(bool) conformsToProtocol:(void *)p0;
	-(id) init;
@end
@implementation AppDelegate { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(id) window
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_1 (self, _cmd, &managed_method, "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "get_Window");
	}

	-(void) setWindow:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.UIKit.UIWindow, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "set_Window");
	}

	-(void) applicationWillResignActive:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.UIKit.UIApplication, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "OnResignActivation");
	}

	-(void) applicationDidEnterBackground:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.UIKit.UIApplication, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "DidEnterBackground");
	}

	-(void) applicationWillEnterForeground:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.UIKit.UIApplication, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "WillEnterForeground");
	}

	-(void) applicationWillTerminate:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.UIKit.UIApplication, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "WillTerminate");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}

	-(id) init
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_4 (self, _cmd, &managed_method, "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", ".ctor");
	}
@end

@interface UITableViewSource : NSObject/*<UIScrollViewDelegate>*/ {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(bool) conformsToProtocol:(void *)p0;
	-(id) init;
@end
@implementation UITableViewSource { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}

	-(id) init
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_4 (self, _cmd, &managed_method, "MonoTouch.UIKit.UITableViewSource, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", ".ctor");
	}
@end

@interface Mappir_SearchSource : UITableViewSource {
}
	-(int) tableView:(id)p0 numberOfRowsInSection:(int)p1;
	-(id) tableView:(id)p0 cellForRowAtIndexPath:(id)p1;
	-(void) tableView:(id)p0 didSelectRowAtIndexPath:(id)p1;
@end
@implementation Mappir_SearchSource { } 

	-(int) tableView:(id)p0 numberOfRowsInSection:(int)p1
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_5 (self, _cmd, &managed_method, p0, p1, "MonoTouch.UIKit.UITableView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "System.Int32, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "Mappir.SearchSource, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "RowsInSection");
	}

	-(id) tableView:(id)p0 cellForRowAtIndexPath:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_6 (self, _cmd, &managed_method, p0, p1, "MonoTouch.UIKit.UITableView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSIndexPath, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.SearchSource, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "GetCell");
	}

	-(void) tableView:(id)p0 didSelectRowAtIndexPath:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.UIKit.UITableView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSIndexPath, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.SearchSource, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "RowSelected");
	}
@end

@interface MappirViewController : UIViewController {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(void) loadView;
	-(void) didReceiveMemoryWarning;
	-(void) viewDidLoad;
	-(void) viewWillAppear:(bool)p0;
	-(void) viewDidAppear:(bool)p0;
	-(void) viewWillDisappear:(bool)p0;
	-(void) viewDidDisappear:(bool)p0;
	-(bool) conformsToProtocol:(void *)p0;
@end
@implementation MappirViewController { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(void) loadView
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_8 (self, _cmd, &managed_method, "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "LoadView");
	}

	-(void) didReceiveMemoryWarning
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_8 (self, _cmd, &managed_method, "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "DidReceiveMemoryWarning");
	}

	-(void) viewDidLoad
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_8 (self, _cmd, &managed_method, "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "ViewDidLoad");
	}

	-(void) viewWillAppear:(bool)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_9 (self, _cmd, &managed_method, p0, "System.Boolean, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "ViewWillAppear");
	}

	-(void) viewDidAppear:(bool)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_9 (self, _cmd, &managed_method, p0, "System.Boolean, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "ViewDidAppear");
	}

	-(void) viewWillDisappear:(bool)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_9 (self, _cmd, &managed_method, p0, "System.Boolean, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "ViewWillDisappear");
	}

	-(void) viewDidDisappear:(bool)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_9 (self, _cmd, &managed_method, p0, "System.Boolean, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "ViewDidDisappear");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}
@end

@interface Mappir_CustomMapDelegate : NSObject/*<MKMapViewDelegate>*/ {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(id) mapView:(id)p0 viewForAnnotation:(id)p1;
	-(bool) conformsToProtocol:(void *)p0;
@end
@implementation Mappir_CustomMapDelegate { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(id) mapView:(id)p0 viewForAnnotation:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_6 (self, _cmd, &managed_method, p0, p1, "MonoTouch.MapKit.MKMapView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Mappir.CustomMapDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "GetViewForAnnotation");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}
@end

@interface Mappir_SearchDelegate : NSObject/*<UISearchDisplayDelegate>*/ {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(bool) searchDisplayController:(id)p0 shouldReloadTableForSearchString:(NSString *)p1;
	-(bool) conformsToProtocol:(void *)p0;
@end
@implementation Mappir_SearchDelegate { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(bool) searchDisplayController:(id)p0 shouldReloadTableForSearchString:(NSString *)p1
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_10 (self, _cmd, &managed_method, p0, p1, "MonoTouch.UIKit.UISearchDisplayController, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "System.String, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "Mappir.SearchDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", "ShouldReloadForSearchString");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}
@end

@interface MonoTouch_UIKit_UIControlEventProxy : NSObject {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(void) BridgeSelector;
	-(bool) conformsToProtocol:(void *)p0;
@end
@implementation MonoTouch_UIKit_UIControlEventProxy { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(void) BridgeSelector
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_8 (self, _cmd, &managed_method, "MonoTouch.UIKit.UIControlEventProxy, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Activated");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}
@end

@interface MonoTouch_CoreLocation_CLLocationManager__CLLocationManagerDelegate : NSObject/*<CLLocationManagerDelegate>*/ {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	-(void) locationManager:(id)p0 didChangeAuthorizationStatus:(int)p1;
	-(void) locationManager:(id)p0 didFinishDeferredUpdatesWithError:(id)p1;
	-(void) locationManager:(id)p0 didDetermineState:(int)p1 forRegion:(id)p2;
	-(void) locationManager:(id)p0 didRangeBeacons:(NSArray *)p1 inRegion:(id)p2;
	-(void) locationManager:(id)p0 didStartMonitoringForRegion:(id)p1;
	-(void) locationManager:(id)p0 didVisit:(id)p1;
	-(void) locationManager:(id)p0 didFailWithError:(id)p1;
	-(void) locationManager:(id)p0 didUpdateLocations:(NSArray *)p1;
	-(void) locationManagerDidPauseLocationUpdates:(id)p0;
	-(void) locationManagerDidResumeLocationUpdates:(id)p0;
	-(void) locationManager:(id)p0 monitoringDidFailForRegion:(id)p1 withError:(id)p2;
	-(void) locationManager:(id)p0 rangingBeaconsDidFailForRegion:(id)p1 withError:(id)p2;
	-(void) locationManager:(id)p0 didEnterRegion:(id)p1;
	-(void) locationManager:(id)p0 didExitRegion:(id)p1;
	-(bool) locationManagerShouldDisplayHeadingCalibration:(id)p0;
	-(void) locationManager:(id)p0 didUpdateHeading:(id)p1;
	-(void) locationManager:(id)p0 didUpdateToLocation:(id)p1 fromLocation:(id)p2;
	-(bool) conformsToProtocol:(void *)p0;
	-(id) init;
@end
@implementation MonoTouch_CoreLocation_CLLocationManager__CLLocationManagerDelegate { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	-(void) locationManager:(id)p0 didChangeAuthorizationStatus:(int)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_11 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLAuthorizationStatus, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "AuthorizationChanged");
	}

	-(void) locationManager:(id)p0 didFinishDeferredUpdatesWithError:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSError, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "DeferredUpdatesFinished");
	}

	-(void) locationManager:(id)p0 didDetermineState:(int)p1 forRegion:(id)p2
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_12 (self, _cmd, &managed_method, p0, p1, p2, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLRegionState, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "DidDetermineState");
	}

	-(void) locationManager:(id)p0 didRangeBeacons:(NSArray *)p1 inRegion:(id)p2
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_13 (self, _cmd, &managed_method, p0, p1, p2, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLBeacon[], monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLBeaconRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "DidRangeBeacons");
	}

	-(void) locationManager:(id)p0 didStartMonitoringForRegion:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "DidStartMonitoringForRegion");
	}

	-(void) locationManager:(id)p0 didVisit:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLVisit, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "DidVisit");
	}

	-(void) locationManager:(id)p0 didFailWithError:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSError, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Failed");
	}

	-(void) locationManager:(id)p0 didUpdateLocations:(NSArray *)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_14 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocation[], monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "LocationsUpdated");
	}

	-(void) locationManagerDidPauseLocationUpdates:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "LocationUpdatesPaused");
	}

	-(void) locationManagerDidResumeLocationUpdates:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_2 (self, _cmd, &managed_method, p0, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "LocationUpdatesResumed");
	}

	-(void) locationManager:(id)p0 monitoringDidFailForRegion:(id)p1 withError:(id)p2
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_15 (self, _cmd, &managed_method, p0, p1, p2, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSError, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonitoringFailed");
	}

	-(void) locationManager:(id)p0 rangingBeaconsDidFailForRegion:(id)p1 withError:(id)p2
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_15 (self, _cmd, &managed_method, p0, p1, p2, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLBeaconRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSError, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "RangingBeaconsDidFailForRegion");
	}

	-(void) locationManager:(id)p0 didEnterRegion:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "RegionEntered");
	}

	-(void) locationManager:(id)p0 didExitRegion:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "RegionLeft");
	}

	-(bool) locationManagerShouldDisplayHeadingCalibration:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_16 (self, _cmd, &managed_method, p0, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "ShouldDisplayHeadingCalibration");
	}

	-(void) locationManager:(id)p0 didUpdateHeading:(id)p1
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_7 (self, _cmd, &managed_method, p0, p1, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLHeading, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "UpdatedHeading");
	}

	-(void) locationManager:(id)p0 didUpdateToLocation:(id)p1 fromLocation:(id)p2
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_15 (self, _cmd, &managed_method, p0, p1, p2, "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocation, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocation, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "UpdatedLocation");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}

	-(id) init
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_4 (self, _cmd, &managed_method, "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", ".ctor");
	}
@end

@interface __NSObject_Disposer : NSObject {
	void *__monoObjectGCHandle;
}
	-(void) release;
	-(id) retain;
	-(void) dealloc;
	+(void) drain:(id)p0;
	-(bool) conformsToProtocol:(void *)p0;
	-(id) init;
@end
@implementation __NSObject_Disposer { } 
	-(void) release
	{
		monotouch_release_trampoline (self, _cmd);
	}

	-(id) retain
	{
		return monotouch_retain_trampoline (self, _cmd);
	}

	-(void) dealloc
	{
		int gchandle = monotouch_get_gchandle (self);
		monotouch_unregister_object (self, mono_gchandle_get_target (gchandle));
		monotouch_free_gchandle (self, gchandle);
		mono_thread_detach_if_exiting ();
		[super dealloc];
	}

	+(void) drain:(id)p0
	{
		static MonoMethod *managed_method = NULL;
		native_to_managed_trampoline_17 (self, _cmd, &managed_method, p0, "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "MonoTouch.Foundation.NSObject+NSObject_Disposer, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "Drain");
	}

	-(bool) conformsToProtocol:(void *)p0
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_3 (self, _cmd, &managed_method, p0, "System.IntPtr, mscorlib, Version=2.0.5.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", "InvokeConformsToProtocol");
	}

	-(id) init
	{
		static MonoMethod *managed_method = NULL;
		return native_to_managed_trampoline_4 (self, _cmd, &managed_method, "MonoTouch.Foundation.NSObject+NSObject_Disposer, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", ".ctor");
	}
@end

	static MTClassMap __monotouch_class_map [] = {
		{"NSObject", "MonoTouch.Foundation.NSObject, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"AppDelegate", "Mappir.AppDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", NULL },
		{"UITableViewSource", "MonoTouch.UIKit.UITableViewSource, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"Mappir_SearchSource", "Mappir.SearchSource, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", NULL },
		{"UIResponder", "MonoTouch.UIKit.UIResponder, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIViewController", "MonoTouch.UIKit.UIViewController, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MappirViewController", "Mappir.MappirViewController, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", NULL },
		{"Mappir_CustomMapDelegate", "Mappir.CustomMapDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", NULL },
		{"Mappir_SearchDelegate", "Mappir.SearchDelegate, Mappir, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null", NULL },
		{"CLRegion", "MonoTouch.CoreLocation.CLRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLBeaconRegion", "MonoTouch.CoreLocation.CLBeaconRegion, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLLocation", "MonoTouch.CoreLocation.CLLocation, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"NSArray", "MonoTouch.Foundation.NSArray, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"NSIndexPath", "MonoTouch.Foundation.NSIndexPath, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"NSString", "MonoTouch.Foundation.NSString, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLHeading", "MonoTouch.CoreLocation.CLHeading, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLPlacemark", "MonoTouch.CoreLocation.CLPlacemark, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"NSAutoreleasePool", "MonoTouch.Foundation.NSAutoreleasePool, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"NSError", "MonoTouch.Foundation.NSError, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKMapItem", "MonoTouch.MapKit.MKMapItem, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIView", "MonoTouch.UIKit.UIView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKMapView", "MonoTouch.MapKit.MKMapView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIApplication", "MonoTouch.UIKit.UIApplication, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIControl", "MonoTouch.UIKit.UIControl, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIButton", "MonoTouch.UIKit.UIButton, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIColor", "MonoTouch.UIKit.UIColor, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MonoTouch_UIKit_UIControlEventProxy", "MonoTouch.UIKit.UIControlEventProxy, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIDevice", "MonoTouch.UIKit.UIDevice, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIImage", "MonoTouch.UIKit.UIImage, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIScreen", "MonoTouch.UIKit.UIScreen, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UISearchBar", "MonoTouch.UIKit.UISearchBar, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UISearchDisplayController", "MonoTouch.UIKit.UISearchDisplayController, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIScrollView", "MonoTouch.UIKit.UIScrollView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UITableView", "MonoTouch.UIKit.UITableView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UITableViewCell", "MonoTouch.UIKit.UITableViewCell, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIWindow", "MonoTouch.UIKit.UIWindow, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UILabel", "MonoTouch.UIKit.UILabel, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UIImageView", "MonoTouch.UIKit.UIImageView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"UITraitCollection", "MonoTouch.UIKit.UITraitCollection, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKAnnotationView", "MonoTouch.MapKit.MKAnnotationView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKPinAnnotationView", "MonoTouch.MapKit.MKPinAnnotationView, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKPlacemark", "MonoTouch.MapKit.MKPlacemark, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKShape", "MonoTouch.MapKit.MKShape, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKPointAnnotation", "MonoTouch.MapKit.MKPointAnnotation, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MKUserLocation", "MonoTouch.MapKit.MKUserLocation, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLBeacon", "MonoTouch.CoreLocation.CLBeacon, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLVisit", "MonoTouch.CoreLocation.CLVisit, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"NSException", "MonoTouch.Foundation.NSException, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"MonoTouch_CoreLocation_CLLocationManager__CLLocationManagerDelegate", "MonoTouch.CoreLocation.CLLocationManager+_CLLocationManagerDelegate, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"CLLocationManager", "MonoTouch.CoreLocation.CLLocationManager, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{"__NSObject_Disposer", "MonoTouch.Foundation.NSObject+NSObject_Disposer, monotouch, Version=0.0.0.0, Culture=neutral, PublicKeyToken=84e04ff9cfb79065", NULL },
		{ NULL, NULL, NULL },
	};


void monotouch_create_classes () {
	__monotouch_class_map [0].handle = objc_getClass ("NSObject");
	__monotouch_class_map [1].handle = [AppDelegate class];
	__monotouch_class_map [2].handle = objc_getClass ("UITableViewSource");
	__monotouch_class_map [3].handle = [Mappir_SearchSource class];
	__monotouch_class_map [4].handle = objc_getClass ("UIResponder");
	__monotouch_class_map [5].handle = objc_getClass ("UIViewController");
	__monotouch_class_map [6].handle = [MappirViewController class];
	__monotouch_class_map [7].handle = [Mappir_CustomMapDelegate class];
	__monotouch_class_map [8].handle = [Mappir_SearchDelegate class];
	__monotouch_class_map [9].handle = objc_getClass ("CLRegion");
	__monotouch_class_map [10].handle = objc_getClass ("CLBeaconRegion");
	__monotouch_class_map [11].handle = objc_getClass ("CLLocation");
	__monotouch_class_map [12].handle = objc_getClass ("NSArray");
	__monotouch_class_map [13].handle = objc_getClass ("NSIndexPath");
	__monotouch_class_map [14].handle = objc_getClass ("NSString");
	__monotouch_class_map [15].handle = objc_getClass ("CLHeading");
	__monotouch_class_map [16].handle = objc_getClass ("CLPlacemark");
	__monotouch_class_map [17].handle = objc_getClass ("NSAutoreleasePool");
	__monotouch_class_map [18].handle = objc_getClass ("NSError");
	__monotouch_class_map [19].handle = objc_getClass ("MKMapItem");
	__monotouch_class_map [20].handle = objc_getClass ("UIView");
	__monotouch_class_map [21].handle = objc_getClass ("MKMapView");
	__monotouch_class_map [22].handle = objc_getClass ("UIApplication");
	__monotouch_class_map [23].handle = objc_getClass ("UIControl");
	__monotouch_class_map [24].handle = objc_getClass ("UIButton");
	__monotouch_class_map [25].handle = objc_getClass ("UIColor");
	__monotouch_class_map [26].handle = objc_getClass ("MonoTouch_UIKit_UIControlEventProxy");
	__monotouch_class_map [27].handle = objc_getClass ("UIDevice");
	__monotouch_class_map [28].handle = objc_getClass ("UIImage");
	__monotouch_class_map [29].handle = objc_getClass ("UIScreen");
	__monotouch_class_map [30].handle = objc_getClass ("UISearchBar");
	__monotouch_class_map [31].handle = objc_getClass ("UISearchDisplayController");
	__monotouch_class_map [32].handle = objc_getClass ("UIScrollView");
	__monotouch_class_map [33].handle = objc_getClass ("UITableView");
	__monotouch_class_map [34].handle = objc_getClass ("UITableViewCell");
	__monotouch_class_map [35].handle = objc_getClass ("UIWindow");
	__monotouch_class_map [36].handle = objc_getClass ("UILabel");
	__monotouch_class_map [37].handle = objc_getClass ("UIImageView");
	__monotouch_class_map [38].handle = objc_getClass ("UITraitCollection");
	__monotouch_class_map [39].handle = objc_getClass ("MKAnnotationView");
	__monotouch_class_map [40].handle = objc_getClass ("MKPinAnnotationView");
	__monotouch_class_map [41].handle = objc_getClass ("MKPlacemark");
	__monotouch_class_map [42].handle = objc_getClass ("MKShape");
	__monotouch_class_map [43].handle = objc_getClass ("MKPointAnnotation");
	__monotouch_class_map [44].handle = objc_getClass ("MKUserLocation");
	__monotouch_class_map [45].handle = objc_getClass ("CLBeacon");
	__monotouch_class_map [46].handle = objc_getClass ("CLVisit");
	__monotouch_class_map [47].handle = objc_getClass ("NSException");
	__monotouch_class_map [48].handle = objc_getClass ("MonoTouch_CoreLocation_CLLocationManager__CLLocationManagerDelegate");
	__monotouch_class_map [49].handle = objc_getClass ("CLLocationManager");
	__monotouch_class_map [50].handle = objc_getClass ("__NSObject_Disposer");
	monotouch_setup_classmap (__monotouch_class_map, 51);
}

