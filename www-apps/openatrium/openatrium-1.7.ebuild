# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit webapp

MY_P="${PN}-6.x-${PV}"

DESCRIPTION="A team collaboration tool "
HOMEPAGE="http://openatrium.com/"
SRC_URI="http://ftp.drupal.org/files/projects/${MY_P}-core.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE="+mysql postgres"

#
# note need_httpd_cgi from webapp.eclass is b0rked
#
DEPEND=""
RDEPEND="
	virtual/httpd-php
	|| ( virtual/httpd-cgi virtual/httpd-fastcgi )
	dev-lang/php[gd,pdo,postgres?,xml]
	dev-php/pecl-apc
	dev-php/pecl-uploadprogress
	mysql? ( || ( 
				dev-lang/php[mysql]
				dev-lang/php[mysqli]
				dev-lang/php[mysqlnd]
			) )
"

REQUIRED_USE="|| ( mysql postgres )"

DOCS=( MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt INSTALL.mysql.txt INSTALL.pgsql.txt INSTALL.sqlite.txt UPGRADE.txt )

src_install() {
	webapp_src_preinst

	cp sites/default/{default.settings.php,settings.php}
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	dodir "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/files
	webapp_serverowned "${MY_HTDOCSDIR}"/sites/default
	webapp_serverowned "${MY_HTDOCSDIR}"/sites/default/settings.php

	webapp_configfile "${MY_HTDOCSDIR}"/sites/default/settings.php
	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}

pkg_postinst() {
	einfo
	einfo "\033[1;32m**************************************************\033[00m"
	einfo
	einfo "To see the post install instructions, do"
	einfo
	einfo "    webapp-config --show-postinst ${PN} ${PVR}"
	einfo
	einfo "\033[1;32m**************************************************\033[00m"
	einfo
}
