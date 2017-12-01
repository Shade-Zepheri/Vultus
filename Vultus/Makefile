include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = Vultus
Vultus_FILES = $(wildcard *.mm) $(wildcard *.m)
Vultus_PUBLIC_HEADERS = VLTFaceRecognizerDelegateProtocol.h VLTDelegateManager.h
Vultus_FRAMEWORKS = AVFoundation CoreGraphics CoreMedia CoreVideo UIKit QuartzCore
Vultus_EXTRA_FRAMEWORKS = opencv2
Vultus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/framework.mk
