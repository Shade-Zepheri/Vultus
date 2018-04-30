include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Vultus
Vultus_FILES = $(wildcard *.x) $(wildcard *.m)
Vultus_CFLAGS = -I../Headers -I ../ -fobjc-arc
Vultus_FRAMEWORKS = UIKit
Vultus_PRIVATE_FRAMEWORKS = SpringBoardUI
Vultus_EXTRA_FRAMEWORKS = Cephei Vultus
Vultus_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/tweak.mk
