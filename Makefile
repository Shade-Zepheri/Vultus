export TARGET = iphone:11.2:9.0

INSTALL_TARGET_PROCESSES = Preferences

ifneq ($(RESPRING),0)
	INSTALL_TARGET_PROCESSES += SpringBoard
endif

export ADDITIONAL_CFLAGS = -DTHEOS_LEAN_AND_MEAN -fobjc-arc

include $(THEOS)/makefiles/common.mk

# the main stuff
SUBPROJECTS = Vultus SpringBoard
# side stuff
SUBPROJECTS += Settings Flipswitch

include $(THEOS_MAKE_PATH)/aggregate.mk
