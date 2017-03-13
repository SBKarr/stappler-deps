LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dx_static

LOCAL_MODULE_FILENAME := libcocos2dx

LOCAL_SRC_FILES := \
		$(shell find $(LOCAL_PATH)/2d -name "*.cpp") \
		$(shell find $(LOCAL_PATH)/3d -name "*.cpp") \
		$(shell find $(LOCAL_PATH)/base -name "*.cpp") \
		$(shell find $(LOCAL_PATH)/math -name "*.cpp") \
		$(shell find $(LOCAL_PATH)/renderer -name "*.cpp") \
		$(LOCAL_PATH)/cocos2d.cpp \
		$(LOCAL_PATH)/platform/CCGLView.cpp \
		$(LOCAL_PATH)/platform/CCFileUtils.cpp \
		$(LOCAL_PATH)/platform/CCSAXParser.cpp \
		$(LOCAL_PATH)/platform/CCThread.cpp \
		$(LOCAL_PATH)/platform/CCImage.cpp \
		$(LOCAL_PATH)/../external/tinyxml2/tinyxml2.cpp \
		$(LOCAL_PATH)/../external/unzip/ioapi_mem.cpp \
		$(LOCAL_PATH)/../external/unzip/ioapi.cpp \
		$(LOCAL_PATH)/../external/unzip/unzip.cpp \
		$(LOCAL_PATH)/../external/edtaa3func/edtaa3func.cpp \
		$(LOCAL_PATH)/../external/xxhash/xxhash.c


LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH) \
                    $(LOCAL_PATH)/. \
                    $(LOCAL_PATH)/.. \
                    $(LOCAL_PATH)/platform \
                    $(LOCAL_PATH)/base \
                    $(LOCAL_PATH)/../external \
                    $(LOCAL_PATH)/../external/tinyxml2 \
                    $(LOCAL_PATH)/../external/unzip \
                    $(LOCAL_PATH)/../external/xxhash \
                    $(LOCAL_PATH)/../external/nslog

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
                    $(LOCAL_PATH)/. \
                    $(LOCAL_PATH)/platform \
                    $(LOCAL_PATH)/../external \
                    $(LOCAL_PATH)/../external/tinyxml2 \
                    $(LOCAL_PATH)/../external/unzip \
                    $(LOCAL_PATH)/../external/edtaa3func \
                    $(LOCAL_PATH)/../external/xxhash \
                    $(LOCAL_PATH)/../external/nslog

LOCAL_EXPORT_LDLIBS := -lGLESv2 \
                       -llog \
                       -lz \
                       -landroid

LOCAL_STATIC_LIBRARIES := cocos_freetype2_static
LOCAL_STATIC_LIBRARIES += cocos_png_static
LOCAL_STATIC_LIBRARIES += cocos_jpeg_static
LOCAL_STATIC_LIBRARIES += cpufeatures
LOCAL_STATIC_LIBRARIES += layout_static

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dxandroid_static

# define the macro to compile through support/zip_support/ioapi.c
LOCAL_CFLAGS   :=  -DUSE_FILE32API
LOCAL_CPPFLAGS := -Wno-deprecated-declarations
LOCAL_EXPORT_CFLAGS   := -DUSE_FILE32API
LOCAL_EXPORT_CPPFLAGS := -Wno-deprecated-declarations

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON  := true
endif

include $(BUILD_STATIC_LIBRARY)

$(call import-module,platform/android)
$(call import-module,libs)
$(call import-module,layout)
$(call import-module,android/cpufeatures)
