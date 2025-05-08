include $(TOPDIR)/rules.mk

# Package information
LUCI_TITLE := TTL Changer
PKG_NAME := luci-app-mttl
PKG_VERSION := 1.0
PKG_RELEASE := 1

# Maintainer info
PKG_MAINTAINER := dotycat <support@dotycat.com>

# Dependencies
LUCI_DEPENDS := +luci +nftables

# Define architecture (optional)
LUCI_PKGARCH := all

# Include necessary makefiles
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/luci.mk

# Installation process
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
