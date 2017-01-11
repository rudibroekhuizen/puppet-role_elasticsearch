# == Class: role_elasticsearch
#
#
class role_elasticsearch (
  $package_url = 'https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.deb',
  $clustername = 'cluster-01',
  $replicas    = '0',
  $shards      = '1',
) {

  # Install Java
  include oracle_java

  class { 'elasticsearch':
    package_url  => $package_url,
    config       => { 'cluster.name'             => $clustername,
                      'index.number_of_shards'   => $shards,
                      'index.number_of_replicas' => $replicas,
                    },
  }

  # Create instance
  elasticsearch::instance { 'es-01':
  }

  # Install kopf plugin
  elasticsearch::plugin { 'lmenezes/elasticsearch-kopf':
    instances  => 'es-01'
  }

}
