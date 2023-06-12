# Private class
class ca_cert::params {
  case $facts['os']['family'] {
    'Debian': {
      $trusted_cert_dir  = '/usr/local/share/ca-certificates'
      $update_cmd        = 'update-ca-certificates'
      $cert_dir_group    = 'staff'
      $ca_file_group     = 'root'
      $ca_file_mode      = '0444'
      $ca_file_extension = 'crt'
      $package_name      = 'ca-certificates'
      case $facts['os']['name'] {
        'Ubuntu': {
          $cert_dir_mode     = '0755'
        }
        'Debian': {
          $cert_dir_mode     = '2665'
        }
        default: {
          fail("Unsupported operatingsystem (${facts['os']['name']})")
        }
      }
    }
    'RedHat': {
      $trusted_cert_dir    = '/etc/pki/ca-trust/source/anchors'
      $distrusted_cert_dir = '/etc/pki/ca-trust/source/blacklist'
      $update_cmd          = 'update-ca-trust extract'
      $cert_dir_group      = 'root'
      $cert_dir_mode       = '0755'
      $ca_file_group       = 'root'
      $ca_file_mode        = '0644'
      $ca_file_extension   = 'crt'
      $package_name        = 'ca-certificates'
    }
    'Archlinux': {
      $trusted_cert_dir    = '/etc/ca-certificates/trust-source/anchors/'
      $distrusted_cert_dir = '/etc/ca-certificates/trust-source/blacklist'
      $update_cmd          = 'trust extract-compat'
      $cert_dir_group      = 'root'
      $cert_dir_mode       = '0755'
      $ca_file_group       = 'root'
      $ca_file_mode        = '0644'
      $ca_file_extension   = 'crt'
      $package_name        = 'ca-certificates'
    }
    'Suse': {
      if $facts['os']['release']['major'] =~ /(10|11)/  {
        $trusted_cert_dir  = '/etc/ssl/certs'
        $update_cmd        = 'c_rehash'
        $ca_file_extension = 'pem'
        $package_name      = 'openssl-certs'
      }
      elsif versioncmp($facts['os']['release']['major'], '12') >= 0 {
        $trusted_cert_dir    = '/etc/pki/trust/anchors'
        $distrusted_cert_dir = '/etc/pki/trust/blacklist'
        $update_cmd          = 'update-ca-certificates'
        $ca_file_extension   = 'crt'
        $package_name        = 'ca-certificates'
      }
      $cert_dir_group        = 'root'
      $cert_dir_mode         = '0755'
      $ca_file_group         = 'root'
      $ca_file_mode          = '0644'
    }
    'AIX': {
      $trusted_cert_dir    = '/var/ssl/certs'
      $update_cmd          = '/usr/bin/c_rehash'
      $cert_dir_group      = 'system'
      $cert_dir_mode       = '0755'
      $ca_file_group       = 'system'
      $ca_file_mode        = '0644'
      $ca_file_extension   = 'crt'
      $package_name        = 'ca-certificates'
    }
    'Solaris': {
      if versioncmp($facts['os']['release']['major'], '11') >= 0  {
        $trusted_cert_dir    = '/etc/certs/CA/'
        $update_cmd          = '/usr/sbin/svcadm restart /system/ca-certificates'
        $cert_dir_group      = 'sys'
        $cert_dir_mode       = '0755'
        $ca_file_group       = 'root'
        $ca_file_mode        = '0444'
        $ca_file_extension   = 'pem'
        $package_name        = 'ca-certificates'
      }
      else {
        fail("Unsupported OS Major release (${facts['os']['release']['major']})")
      }
    }
    default: {
      fail("Unsupported osfamily (${facts['os']['family']})")
    }
  }
}
