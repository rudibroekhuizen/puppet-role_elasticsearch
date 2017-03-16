# == Class: role_elasticsearch
#
class role_elasticsearch (
  $package_url         = 'https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.0.deb',
  $clustername         = 'cluster-01',
  $curator_action_hash = undef,
) {

  # Install Java
  package { 'openjdk-8-jdk': }

  class { 'elasticsearch':
    package_url  => $package_url,
    config       => { 'cluster.name' => $clustername,
                      'network.host' => '0.0.0.0',
                    },
  }

  # Create instance
  elasticsearch::instance { 'es-01':
  }

  # Delete old data using curator
  class { 'role_elasticsearch::curator': }

  # Install kopf plugin
  #elasticsearch::plugin { 'lmenezes/elasticsearch-kopf':
  #  instances  => 'es-01'
  #}

}
