# -*- Mode: perl; indent-tabs-mode: nil -*-
#
# The contents of this file are subject to the Mozilla Public
# License Version 1.1 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Original Code is the GroupsIndirect Bugzilla Extension.
#
# The Initial Developer of the Original Code is Ali Ustek
# Portions created by the Initial Developer are Copyright (C) 2011 the
# Initial Developer. All Rights Reserved.
#
# Contributor(s):
#   Ali Ustek <aliustek@gmail.com>

package Bugzilla::Extension::GroupsIndirect;
use strict;
use base qw(Bugzilla::Extension);

use Bugzilla::Error;

use Bugzilla::Extension::GroupsIndirect::Util;

our $VERSION = '0.01';

sub add_group_action {
    my ($self, $args) = @_;
    #action='indirect' -> lists the groups which are granted access to other groups
    if ($args eq 'indirect') {
        my $indirect = Bugzilla->dbh->selectall_arrayref(
                                "SELECT g.id,g.name,r.id,r.name FROM ".
                                "group_group_map m, groups g,groups r WHERE ".
                                "m.grant_type = 0 AND ".
                                "m.grantor_id NOT IN (93,1) AND ".
                                "m.member_id NOT IN (1,11,12,13) AND ".
                                "m.member_id = g.id AND m.grantor_id=r.id");
        my $vars = {};                        
        $vars->{'indirect'} = $indirect;

        print Bugzilla->cgi->header();
        my $template = Bugzilla->template;
        $template->process("groupsindirect/indirect-groups.html.tmpl", $vars)
          || ThrowTemplateError($template->error());

        exit;
    }
}

__PACKAGE__->NAME;