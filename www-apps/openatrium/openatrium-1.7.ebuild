# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A team collaboration tool "
HOMEPAGE="http://openatrium.com/"
SRC_URI="http://ftp.drupal.org/files/projects/${PN}-6.x-${PV}-core.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+mysql postgres"

REQUIRED_USE="|| ( mysql postgres )"

DEPEND=""
RDEPEND="
	virtual/httpd-php
	dev-lang/php[gd,pdo,postgres?,xml]
	dev-php/pecl-apc
	dev-php/pecl-uploadprogress
	mysql? ( || ( 
				dev-lang/php[mysql]
				dev-lang/php[mysqli]
				dev-lang/php[mysqlnd]
			) )
"



