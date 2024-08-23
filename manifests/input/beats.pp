# @summary
#   Defines a (old-style) Beats input.
#
# This is the Beats input from Graylog 2.x, still available in Graylog 3.x as
# 'Beats (deprecated)'. For the new Beats input introduced in Graylog 3.0, see
# graylog_api::input::beats2
#
# @param ensure
#   Whether this input should exist.
#
# @param bind_address
#   The IP address to listen on.
#
# @param override_source
#   The source is a hostname derived from the received packet by default. Set
#   this if you want to override it with a custom string.
#
# @param port
#   The port to listen on.
#
# @param recv_buffer_size
#   The size in bytes of the recvBufferSize for network connections to this
#   input. Defaults to 1 MB.
#
# @param scope
#   Whether this input is defined on all nodes ('global') or just this node
#   ('local').
#
# @param static_fields
#   Static fields to assign to this input.
#
# @param tcp_keepalive
#   Whether to enable TCP keepalive packets.
#
# @param tls_cert_file
#   The path to the server certificate to use when securing the connection with
#   TLS. Has no effect unless tls_enable is true.
#
#   Note that this must be the entire certificate chain, and that Graylog is
#   sensitive to exact formatting of PEM certificates, e.g. there must be a
#   trailing newline.
#
# @param tls_client_auth
#   Whether to use TLS to authenticate clients. Can be 'disabled', 'optional',
#   or 'required'.
#
# @param tls_client_auth_cert_file
#   The path to the file (or directory) which stores the certificates of
#   trusted clients. Has no effect if tls_client_auth is 'disabled' or
#   tls_enable is false.
#
# @param tls_enable
#   Whether to enable TLS for securing the input.
#
# @param tls_key_file
#   The path to the private key which corresponds to the tls_cert_file. Has no
#   effect if tls_enable is false. 
#   
#   Note that for PEM private keys, Graylog is sensitive to exact formatting,
#   e.g. there must be a trailing newline.
#
# @param tls_key_password
#   The password to decrypt to private key specified in tls_key_file. Leave
#   blank if not using TLS, or if the key is not encrypted.
define graylog_api::input::beats (
  Enum['present','absent']  $ensure                    = 'present',
  String                    $bind_address              = '0.0.0.0',
  Optional[String]          $override_source           = undef,
  Stdlib::Port              $port                      = 5044,
  Integer                   $recv_buffer_size          = '1 MB'.to_bytes,
  Enum['global','local']    $scope                     = 'global',
  Optional[Hash]            $static_fields             = undef,
  Boolean                   $tcp_keepalive             = false,
  Optional[String]          $tls_cert_file             = undef,
  String                    $tls_client_auth           = 'disabled',
  Optional[String]          $tls_client_auth_cert_file = undef,
  Boolean                   $tls_enable                = false,
  Optional[String]          $tls_key_file              = undef,
  Optional[String]          $tls_key_password          = undef,
) {
  graylog_input { $name:
    ensure        => $ensure,
    type          => 'org.graylog.plugins.beats.BeatsInput',
    scope         => $scope,
    static_fields => $static_fields,
    configuration => {
      bind_address              => $bind_address,
      recv_buffer_size          => $recv_buffer_size,
      override_source           => $override_source,
      port                      => $port,
      tcp_keepalive             => $tcp_keepalive,
      tls_cert_file             => $tls_cert_file,
      tls_client_auth           => $tls_client_auth,
      tls_client_auth_cert_file => $tls_client_auth_cert_file,
      tls_enable                => $tls_enable,
      tls_key_file              => $tls_key_file,
      tls_key_password          => $tls_key_password,
    },
  }
}
