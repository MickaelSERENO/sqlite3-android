LOCAL_PATH:= $(call my-dir)

# We need to build this for both the device (as a shared library)
# and the host (as a static library for tools to use).

common_SRC_FILES := shell.c sqlite3.c

common_CFLAGS := \
    -Wall \
    -Wmissing-prototypes -Wstrict-prototypes \
    -Wno-unused-parameter -Wno-missing-field-initializers \
    -fexceptions \
    -DHAVE_EXPAT_CONFIG_H

common_C_INCLUDES += \
	$(LOCAL_PATH)/lib

# For the device
# =====================================================

# Device static library
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH),arm)
    LOCAL_SDK_VERSION := 8
else
    LOCAL_SDK_VERSION := 9
endif

LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)

LOCAL_MODULE:= libsqlite3_static
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
LOCAL_MODULE_TAGS := optional
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/lib

include $(BUILD_STATIC_LIBRARY)

# Device shared library
include $(CLEAR_VARS)

ifeq ($(TARGET_ARCH),arm)
    LOCAL_SDK_VERSION := 8
else
    LOCAL_SDK_VERSION := 9
endif

LOCAL_SYSTEM_SHARED_LIBRARIES := libc
LOCAL_SRC_FILES := $(common_SRC_FILES)
LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_C_INCLUDES += $(common_C_INCLUDES)

LOCAL_MODULE:= libsqlite3
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk
LOCAL_MODULE_TAGS := optional
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/lib

include $(BUILD_SHARED_LIBRARY)
