# ------------------------------------------------------------------------------
# Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------

# Manages WSO2 Bussiness Rule Server deployment
class wso2brs (
  # wso2brs specific configuration data
  $is_datasource          = $wso2brs::params::is_datasource,

  $packages               = $wso2brs::params::packages,
  $template_list          = $wso2brs::params::template_list,
  $file_list              = $wso2brs::params::file_list,
  $patch_list             = $wso2brs::params::patch_list,
  $cert_list              = $wso2brs::params::cert_list,
  $system_file_list       = $wso2brs::params::system_file_list,
  $directory_list         = $wso2brs::params::directory_list,
  $hosts_mapping          = $wso2brs::params::hosts_mapping,
  $java_home              = $wso2brs::params::java_home,
  $java_prefs_system_root = $wso2brs::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2brs::params::java_prefs_user_root,
  $vm_type                = $wso2brs::params::vm_type,
  $wso2_user              = $wso2brs::params::wso2_user,
  $wso2_group             = $wso2brs::params::wso2_group,
  $product_name           = $wso2brs::params::product_name,
  $product_version        = $wso2brs::params::product_version,
  $platform_version       = $wso2brs::params::platform_version,
  $carbon_home_symlink    = $wso2brs::params::carbon_home_symlink,
  $remote_file_url        = $wso2brs::params::remote_file_url,
  $maintenance_mode       = $wso2brs::params::maintenance_mode,
  $install_mode           = $wso2brs::params::install_mode,
  $install_dir            = $wso2brs::params::install_dir,
  $pack_dir               = $wso2brs::params::pack_dir,
  $pack_filename          = $wso2brs::params::pack_filename,
  $pack_extracted_dir     = $wso2brs::params::pack_extracted_dir,
  $patches_dir            = $wso2brs::params::patches_dir,
  $service_name           = $wso2brs::params::service_name,
  $service_template       = $wso2brs::params::service_template,
  $ipaddress              = $wso2brs::params::ipaddress,
  $enable_secure_vault    = $wso2brs::params::enable_secure_vault,
  $secure_vault_configs   = $wso2brs::params::secure_vault_configs,
  $key_stores             = $wso2brs::params::key_stores,
  $carbon_home            = $wso2brs::params::carbon_home,
  $pack_file_abs_path     = $wso2brs::params::pack_file_abs_path,

  # Templated configuration parameters
  $master_datasources     = $wso2brs::params::master_datasources,
  $registry_mounts        = $wso2brs::params::registry_mounts,
  $hostname               = $wso2brs::params::hostname,
  $mgt_hostname           = $wso2brs::params::mgt_hostname,
  $worker_node            = $wso2brs::params::worker_node,
  $usermgt_datasource     = $wso2brs::params::usermgt_datasource,
  $local_reg_datasource   = $wso2brs::params::local_reg_datasource,
  $clustering             = $wso2brs::params::clustering,
  $dep_sync               = $wso2brs::params::dep_sync,
  $ports                  = $wso2brs::params::ports,
  $jvm                    = $wso2brs::params::jvm,
  $fqdn                   = $wso2brs::params::fqdn,
  $sso_authentication     = $wso2brs::params::sso_authentication,
  $user_management        = $wso2brs::params::user_management
) inherits wso2brs::params {

  validate_string($is_datasource)

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
    patch_list             => $patch_list,
    cert_list              => $cert_list,
    system_file_list       => $system_file_list,
    directory_list         => $directory_list,
    hosts_mapping          => $hosts_mapping,
    java_home              => $java_home,
    java_prefs_system_root => $java_prefs_system_root,
    java_prefs_user_root   => $java_prefs_user_root,
    vm_type                => $vm_type,
    wso2_user              => $wso2_user,
    wso2_group             => $wso2_group,
    product_name           => $product_name,
    product_version        => $product_version,
    platform_version       => $platform_version,
    carbon_home_symlink    => $carbon_home_symlink,
    remote_file_url        => $remote_file_url,
    maintenance_mode       => $maintenance_mode,
    install_mode           => $install_mode,
    install_dir            => $install_dir,
    pack_dir               => $pack_dir,
    pack_filename          => $pack_filename,
    pack_extracted_dir     => $pack_extracted_dir,
    patches_dir            => $patches_dir,
    service_name           => $service_name,
    service_template       => $service_template,
    ipaddress              => $ipaddress,
    enable_secure_vault    => $enable_secure_vault,
    secure_vault_configs   => $secure_vault_configs,
    key_stores             => $key_stores,
    carbon_home            => $carbon_home,
    pack_file_abs_path     => $pack_file_abs_path
  }

  contain wso2base
  contain wso2base::system
  contain wso2base::clean
  contain wso2base::install
  contain wso2base::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2base::configure'] ~> Class['::wso2base::service']
}