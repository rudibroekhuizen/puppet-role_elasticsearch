# == Class: role_elasticsearch::curator
#
class role_elasticsearch::curator {

  class { 'curator': }
  
}

# Wrapper for https://github.com/cristifalcas/puppet-curator
