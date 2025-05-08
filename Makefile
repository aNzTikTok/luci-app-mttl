# Define the package information
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mttl
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=dotycat <support@dotycat.com>
PKG_LICENSE:=GPL-3.0

LUCI_TITLE:=TTL Changer
LUCI_DESCRIPTION:=This LuCI app allows you to change the TTL (Time to Live) value.
LUCI_DEPENDS:=+luci +nftables

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=$(LUCI_TITLE)
	PKGARCH:=all
	DEPENDS:=$(LUCI_DEPENDS)
endef

define Package/$(PKG_NAME)/description
	$(LUCI_DESCRIPTION)
endef

define Build/Compile
endef

# Files to install
define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_BIN) ./luasrc/controller/controller_ttlchanger.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_BIN) ./luasrc/model/cbi/model_ttlchanger.lua $(1)/usr/lib/lua/luci/model/cbi/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/ttlchanger $(1)/etc/config/
endef

# Build the package
$(eval $(call BuildPackage,$(PKG_NAME)))
