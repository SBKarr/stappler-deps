
COCOS2D_STAPPLER_SRCS_DIRS := \
	$(COCOS2D_ROOT)/cocos/base \
	$(COCOS2D_ROOT)/cocos/math \
	$(COCOS2D_ROOT)/cocos/2d \
	$(COCOS2D_ROOT)/cocos/renderer


COCOS2D_STAPPLER_SRCS_OBJS := \
	$(COCOS2D_ROOT)/external/unzip/ioapi.cpp \
	$(COCOS2D_ROOT)/external/unzip/ioapi_mem.cpp \
	$(COCOS2D_ROOT)/external/unzip/unzip.cpp \
	$(COCOS2D_ROOT)/cocos/platform/CCGLView.cpp \
	$(COCOS2D_ROOT)/cocos/platform/CCFileUtils.cpp \
	$(COCOS2D_ROOT)/cocos/platform/CCThread.cpp \
	$(COCOS2D_ROOT)/cocos/platform/CCImage.cpp \
	$(COCOS2D_ROOT)/cocos/cocos2d.cpp \
	$(COCOS2D_ROOT)/external/xxhash/xxhash.c

COCOS2D_STAPPLER_INCLUDES_OBJS := \
	$(COCOS2D_ROOT)/cocos \
	$(COCOS2D_ROOT)/cocos/platform \
	$(COCOS2D_ROOT)/external \
	$(COCOS2D_ROOT)/external/tinyxml2 \
	$(COCOS2D_ROOT)/external/ConvertUTF \
	$(COCOS2D_ROOT)/external/unzip \
	$(COCOS2D_ROOT)/external/xxhash


COCOS2D_CLI_SRCS_DIRS := \
	$(COCOS2D_ROOT)/cocos/math

COCOS2D_CLI_SRCS_OBJS := \
	$(COCOS2D_ROOT)/cocos/base/ccCArray.cpp \
	$(COCOS2D_ROOT)/cocos/base/ccTypes.cpp \
	$(COCOS2D_ROOT)/cocos/base/CCAutoreleasePool.cpp \
	$(COCOS2D_ROOT)/cocos/base/CCScheduler.cpp \
	$(COCOS2D_ROOT)/cocos/base/CCRef.cpp \
	$(COCOS2D_ROOT)/cocos/base/CCData.cpp \
	$(COCOS2D_ROOT)/cocos/base/ccUtils.cpp \
	$(COCOS2D_ROOT)/cocos/base/ZipUtils.cpp \
	$(COCOS2D_ROOT)/cocos/platform/CCFileUtils.cpp \
	$(COCOS2D_ROOT)/cocos/platform/linux/CCFileUtils-linux.cpp \
	$(COCOS2D_ROOT)/cocos/platform/win32/CCFileUtils-win32.cpp \
	$(COCOS2D_ROOT)/external/unzip/ioapi.cpp \
	$(COCOS2D_ROOT)/external/unzip/ioapi_mem.cpp \
	$(COCOS2D_ROOT)/external/unzip/unzip.cpp

COCOS2D_CLI_INCLUDES_OBJS := \
	$(COCOS2D_ROOT)/cocos \
	$(COCOS2D_ROOT)/cocos/platform/desktop \
	$(COCOS2D_ROOT)/cocos/platform/linux \
	$(COCOS2D_ROOT)/cocos/platform/windows \
	$(COCOS2D_ROOT)/external/json \
	$(COCOS2D_ROOT)/external/tinyxml2 \
	$(COCOS2D_ROOT)/external/ConvertUTF \
	$(COCOS2D_ROOT)/external/unzip

ifdef ANDROID_ARCH

COCOS2D_STAPPLER_SRCS_DIRS += $(COCOS2D_ROOT)/cocos/platform/android
COCOS2D_STAPPLER_INCLUDES_OBJS += $(COCOS2D_ROOT)/cocos/platform/android

else ifdef IOS_ARCH

COCOS2D_STAPPLER_SRCS_DIRS += $(COCOS2D_ROOT)/cocos/platform/ios $(COCOS2D_ROOT)/cocos/platform/apple
COCOS2D_STAPPLER_INCLUDES_OBJS += $(COCOS2D_ROOT)/cocos/platform/ios $(COCOS2D_ROOT)/cocos/platform/apple

else

COCOS2D_STAPPLER_SRCS_DIRS += $(COCOS2D_ROOT)/cocos/platform/desktop

COCOS2D_STAPPLER_INCLUDES_OBJS += \
	$(COCOS2D_ROOT)/cocos/platform/desktop \
	$(COCOS2D_ROOT)/cocos/platform/linux \
	$(COCOS2D_ROOT)/cocos/platform/win32

endif