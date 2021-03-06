LOCAL_PATH := $(call my-dir)/..

include $(CLEAR_VARS)
LOCAL_MODULE := cpuinfo
LOCAL_SRC_FILES := $(LOCAL_PATH)/src/init.c \
    $(LOCAL_PATH)/src/cache.c \
    $(LOCAL_PATH)/src/log.c \
    $(LOCAL_PATH)/src/linux/cpuset.c
ifeq ($(TARGET_ARCH_ABI),$(filter $(TARGET_ARCH_ABI),armeabi armeabi-v7a arm64-v8a))
LOCAL_SRC_FILES += \
	$(LOCAL_PATH)/src/arm/uarch.c \
	$(LOCAL_PATH)/src/arm/cache.c \
	$(LOCAL_PATH)/src/arm/linux/init.c \
	$(LOCAL_PATH)/src/arm/linux/cpuinfo.c
ifeq ($(TARGET_ARCH_ABI),armeabi)
LOCAL_SRC_FILES += $(LOCAL_PATH)/src/arm/linux/arm32-isa.c.arm
endif # armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_SRC_FILES += $(LOCAL_PATH)/src/arm/linux/arm32-isa.c
endif # armeabi-v7a
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += $(LOCAL_PATH)/src/arm/linux/arm64-isa.c
endif # arm64-v8a
endif # armeabi, armeabi-v7a, or arm64-v8a
ifeq ($(TARGET_ARCH_ABI),$(filter $(TARGET_ARCH_ABI),x86 x86_64))
LOCAL_SRC_FILES += \
    $(LOCAL_PATH)/src/x86/init.c \
    $(LOCAL_PATH)/src/x86/info.c \
    $(LOCAL_PATH)/src/x86/isa.c \
    $(LOCAL_PATH)/src/x86/vendor.c \
    $(LOCAL_PATH)/src/x86/uarch.c \
    $(LOCAL_PATH)/src/x86/topology.c \
    $(LOCAL_PATH)/src/x86/cache/init.c \
    $(LOCAL_PATH)/src/x86/cache/descriptor.c \
    $(LOCAL_PATH)/src/x86/cache/deterministic.c \
    $(LOCAL_PATH)/src/x86/linux/init.c
endif # x86 or x86_64
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_C_INCLUDES := $(LOCAL_EXPORT_C_INCLUDES) $(LOCAL_PATH)/src
LOCAL_CFLAGS := -std=gnu99 -D_GNU_SOURCE=1
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := cpu-info
LOCAL_SRC_FILES := $(LOCAL_PATH)/tools/cpu-info.c
LOCAL_STATIC_LIBRARIES := cpuinfo
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := isa-info
LOCAL_SRC_FILES := $(LOCAL_PATH)/tools/isa-info.c
LOCAL_STATIC_LIBRARIES := cpuinfo
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := cache-info
LOCAL_SRC_FILES := $(LOCAL_PATH)/tools/cache-info.c
LOCAL_STATIC_LIBRARIES := cpuinfo
include $(BUILD_EXECUTABLE)
