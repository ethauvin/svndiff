#!/bin/sh

# svndiff -- svn diff with vimdiff.
#
# Written by Erik C. Thauvin (erik@thauvin.net)
# May 11, 2006
#
# Copyright (C) 2006 Erik C. Thauvin. All rights reserved.
#
# This software is provided "as is" without express or implied warranties.
#
# Permission is granted to use, copy, modify and distribute this software,
# provided this disclaimer and copyright are preserved on all copies. This
# software may not, however, be sold or distributed for profit, or included
# with other software which is sold or distributed for profit, without the
# permission of the author.
#
# $Id$
#
# Modified by felix021 (felix021@gmail.com) 
# Aug 3, 2010

PROGNAME=`basename $0`

if [ $# -lt 1 ]; then
    echo "Usage: $PROGNAME <file>"
    exit;
fi

filename=$1
pid=$$
TEMP=/tmp/tmp.$pid.$filename
pv=

if [ $# -gt 3 -a $2 = "-r" ]; then
    pv="-r $3"
fi
svn cat $filename $pv > $TEMP
vimdiff $TEMP $filename
rm -f $TEMP