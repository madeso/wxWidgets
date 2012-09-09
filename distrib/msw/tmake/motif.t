#!#############################################################################
#! File:    motif.t
#! Purpose: tmake template file from which src/motif/files.lst containing the
#!          list of files for wxMotif library is generated by tmake
#! Author:  Vadim Zeitlin
#! Created: 28.01.00
#! Version: $Id$
#!#############################################################################
#${
    use lib './lib';
    use wxFileList qw(:default make_arrays);

    #! include the code which parses filelist.txt file and initializes
    #! %wxCommon, %wxGeneric, %wxHtml, %wxUNIX, %wxMOTIF, %wxMOTIF and
    #! %wxOS2PM hashes.
    IncludeTemplate("filelist.t");

    make_arrays( 'wxGeneric', 'wxCommon', 'wxMotif',
                 'wxUnix', 'wxHtml',
                 'wxWxInclude', 'wxMotifInclude', 'wxGenericInclude',
                 'wxUnixInclude', 'wxHtmlInclude', 'wxProtocolInclude' );

    #! find all our sources
    $project{"GUIOBJS"} .= "xmcombo.o ";

    my @generic = grep_not_fileflag 'NotX', @wxGeneric;
    my @common  = grep_not_fileflag 'NotX', @wxCommon;
    my @motif   = ( @wxMotif,
                    grep_source( grep_fileflag 'Motif', @wxALL ) );

    foreach my $file ( @generic ) {
        $project{"GENERICOBJS"} .= $file->object_file . " ";
    }

    foreach my $file ( @common ) {
        $project{"COMMONOBJS"} .= $file->object_file . " ";
    }

    foreach my $file ( @motif ) {
        $project{"GUIOBJS"} .= $file->object_file . " ";
    }

    foreach my $file ( @wxUnix ) {
        $project{"UNIXOBJS"} .= $file->object_file . " ";
    }

    foreach my $file ( @wxHtml ) {
        $project{"HTMLOBJS"} .= $file->object_file . " ";
    }

    foreach my $file ( @generic, @common, @motif,
                       @wxUnix, @wxHtml ) {
        $project{"MOTIF_SOURCES"} .= $file->source_file . " ";
    }

    #! find all our headers
    foreach my $file ( grep_not_fileflag( 'NotX', @wxWxInclude ),
                       @wxMotifInclude, @wxGenericInclude, @wxUnixInclude,
                       @wxHtmlInclude, @wxProtocolInclude,
                       grep_header( grep_fileflag( 'Motif', @wxALL ) ) ) {
        $project{MOTIF_HEADERS} .= $file->source_file . " ";
    }
#$}
# This file was automatically generated by tmake 
# DO NOT CHANGE THIS FILE, YOUR CHANGES WILL BE LOST! CHANGE MOTIF.T!
ALL_SOURCES = \
		#$ ExpandList("MOTIF_SOURCES");

ALL_HEADERS = \
		#$ ExpandList("MOTIF_HEADERS");

COMMONOBJS = \
		#$ ExpandList("COMMONOBJS");

GENERICOBJS = \
		#$ ExpandList("GENERICOBJS");

GUIOBJS = \
		#$ ExpandList("GUIOBJS");

UNIXOBJS = \
		#$ ExpandList("UNIXOBJS");

HTMLOBJS = \
		#$ ExpandList("HTMLOBJS");
