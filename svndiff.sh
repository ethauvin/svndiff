#!/bin/sh

# svndiff -- svn diff with vimdiff.
# http://erik.thauvin.net/blog/posts/1024/subversion-diff-with-vim
#
# Written by Erik C. Thauvin (erik@thauvin.net)
# May 11, 2006
#
# Copyright (C) 2006-2011 Erik C. Thauvin. All rights reserved.
#
# This software is provided "as is" without express or implied warranties.
#
# Permission is granted to use, copy, modify and distribute this software,
# provided this disclaimer and copyright are preserved on all copies. This
# software may not, however, be sold or distributed for profit, or included
# with other software which is sold or distributed for profit, without the
# permission of the author. 
#
# Modified by felix021 (felix021@gmail.com) 
# Aug 3, 2010
#
# Fixed the -r flag processing.
# Added support for files in directories (Francesc)
# Added a trap to make sure the temp file is removed regardless of how the
# script exits (Balbir Singh, http://www.dbacorner.com/)
# Jan 18, 2011
#
# $Id$

PROGNAME=`basename $0`

if [ $# -lt 1 ]; then
    echo "Usage: $PROGNAME <file> [-r rev]"
    exit;
fi

filename=$1
pid=$$
TEMP=/tmp/tmp.$pid.`basename $filename`
pv=

trap 'rm -f $TEMP' 0 1 2 15

if [ $# -eq 3 -a $2 = "-r" ]; then
    pv="-r $3"
fi
svn cat $filename $pv > $TEMP
vimdiff $TEMP $filename