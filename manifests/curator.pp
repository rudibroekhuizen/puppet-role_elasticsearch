# == Class: role_elasticsearch::curator
#
class role_elasticsearch::curator {

  # Install curator
  class { 'curator':
    package_provider => pip,
  }
  
  #package { curator:
  #  provider => pip,
  #}
  
  # Create actions
  create_resources('curator::action', $role_elasticsearch::curator_action_hash)

  # Schedle curator
  cron { "curator_run":
    ensure  => 'present',
    command => '/usr/local/bin/curator --config /root/.curator/curator.yml /root/.curator/actions.yml >/dev/null',
    hour    => 1,
    minute  => 10,
    weekday => '*',
  }



# Configure .yml file using https://github.com/cataphract/puppet-yaml_settings module
#  yaml_settings { '/.root/.curator/curator.yml':
#    values => $role_elasticsearch::curator_yml, 
#  }
  
#  yaml_settings { '/.root/.curator/actions.yml':
#    values => $role_elasticsearch::actions_yml,
#  }

  
}

# Wrapper for https://github.com/cristifalcas/puppet-curator
