# == Class: role_elasticsearch::curator
#
class role_elasticsearch::curator {

  # Install curator
  package { curator:
    provider => pip,
  }

  # Configure curator.yml file using https://github.com/cataphract/puppet-yaml_settings module
  #yaml_settings { '/root/.curator/curator.yml':
  #  values => $role_elasticsearch::curator_yml, 
  #}
  
  # Configure actions.yml file using https://github.com/cataphract/puppet-yaml_settings module
  yaml_settings { '/root/.curator/actions.yml':
    values => $role_elasticsearch::actions_yml,
  }
  
  # Schedule curator
  cron { "curator_run":
    ensure  => 'present',
    command => '/usr/local/bin/curator --config /root/.curator/curator.yml /root/.curator/actions.yml >/dev/null',
    hour    => 1,
    minute  => 10,
    weekday => '*',
  }
  
}
