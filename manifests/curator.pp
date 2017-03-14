# == Class: role_elasticsearch::curator
#
class role_elasticsearch::curator {

  #class { 'curator': }
  create_resources('curator::action', $role_elasticsearch::curator_action_hash)

  # Schedle curator
  cron { "curator_run":
    ensure  => 'present',
    command => '/bin/curator /root/.curator/actions.yml >/dev/null',
    hour    => 1,
    minute  => 10,
    weekday => '*',
  }
  
}

# Wrapper for https://github.com/cristifalcas/puppet-curator
