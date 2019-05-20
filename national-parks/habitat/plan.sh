pkg_name=national-parks
pkg_description="A sample JavaEE Web app deployed in the Tomcat8 package"
pkg_origin=weissbier
pkg_version=6.6.6
pkg_maintainer="Bill Meyer <b@chef.io>"
pkg_license=('Apache-2.0')
pkg_deps=(core/tomcat8 core/jre8 core/mongo-tools)
pkg_build_deps=(core/jdk8/8u131 core/maven)
pkg_svc_user="root"
pkg_binds=(
  [database]="port"
)
pkg_exports=(
  [port]=server.port
)
pkg_exposes=(port)

do_prepare()
{
    export JAVA_HOME=$(hab pkg path core/jdk8)
}

do_build()
{
    cp -r $PLAN_CONTEXT/../ $HAB_CACHE_SRC_PATH/$pkg_dirname
    cd ${HAB_CACHE_SRC_PATH}/${pkg_dirname}
    mvn package
}

do_install()
{
    cp ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/target/${pkg_name}.war ${PREFIX}/
    cp -v ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/data/national-parks.json ${PREFIX}/
}
###########
#pkg_name=national-parks
#pkg_origin=weissbier
#pkg_version="0.1.0"
#pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
#pkg_license=("Apache-2.0")
#pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"
###########
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
# pkg_shasum="TODO"
# pkg_deps=(core/glibc)
# pkg_build_deps=(core/make core/gcc)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
# pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [database]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"

